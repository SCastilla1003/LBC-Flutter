import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../datos/auditoria_repositorio.dart';

/// Registro de auditoría: cada cambio hecho en la liga (crear, editar, mover, eliminar...),
/// quién lo hizo y cuándo. Se filtra por tipo y se busca por texto o usuario.
class AdminAuditoriaPantalla extends ConsumerStatefulWidget {
  const AdminAuditoriaPantalla({super.key});

  @override
  ConsumerState<AdminAuditoriaPantalla> createState() => _AdminAuditoriaPantallaState();
}

/// (valor de la API, etiqueta)
const _entidades = [
  (null, 'Todo'),
  ('Jugador', 'Jugadores'),
  ('Partido', 'Partidos'),
  ('Plantilla', 'Rosters'),
  ('Alineacion', 'Alineaciones'),
  ('Equipo', 'Equipos'),
  ('Temporada', 'Temporadas'),
  ('Estadio', 'Estadios'),
  ('Usuario', 'Usuarios'),
];

class _AdminAuditoriaPantallaState extends ConsumerState<AdminAuditoriaPantalla> {
  final _registros = <RegistroAuditoria>[];
  String? _entidad;
  String _texto = '';
  int _pagina = 0;
  bool _hayMas = false;
  bool _cargando = false;
  Object? _error;
  Timer? _espera;

  @override
  void initState() {
    super.initState();
    _cargar(reiniciar: true);
  }

  @override
  void dispose() {
    _espera?.cancel();
    super.dispose();
  }

  Future<void> _cargar({bool reiniciar = false}) async {
    if (_cargando && !reiniciar) return;
    final pagina = reiniciar ? 0 : _pagina + 1;
    setState(() {
      _cargando = true;
      _error = null;
    });
    try {
      final r = await ref
          .read(auditoriaRepositorioProvider)
          .listar(entidad: _entidad, texto: _texto, pagina: pagina);
      if (!mounted) return;
      setState(() {
        if (reiniciar) _registros.clear();
        _registros.addAll(r.registros);
        _pagina = pagina;
        _hayMas = r.hayMas;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  void _buscar(String texto) {
    _espera?.cancel();
    _espera = Timer(const Duration(milliseconds: 400), () {
      _texto = texto;
      _cargar(reiniciar: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de auditoría')),
      body: RefreshIndicator(
        onRefresh: () => _cargar(reiniciar: true),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            AnchoMaximo(
              ancho: 760,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Buscar por nombre o usuario',
                  ),
                  onChanged: _buscar,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    for (final (valor, etiqueta) in _entidades)
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          label: Text(etiqueta),
                          selected: _entidad == valor,
                          onSelected: (_) {
                            setState(() => _entidad = valor);
                            _cargar(reiniciar: true);
                          },
                        ),
                      ),
                  ]),
                ),
                const SizedBox(height: 12),
                if (_error != null && _registros.isEmpty)
                  EstadoError(error: _error!, onReintentar: () => _cargar(reiniciar: true))
                else if (_registros.isEmpty && !_cargando)
                  const EstadoVacio(
                    mensaje: 'Todavía no hay cambios registrados con ese filtro.',
                    icono: Icons.history_rounded,
                  ),
                for (final (i, r) in _registros.indexed) ...[
                  if (i == 0 || !_mismoDia(_registros[i - 1].fecha, r.fecha))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
                      child: Text(
                        DateFormat("EEEE d 'de' MMMM 'de' y", 'es').format(r.fecha).toUpperCase(),
                        style: estiloEtiqueta(tema.textTheme.labelSmall),
                      ),
                    ),
                  _FilaRegistro(registro: r),
                ],
                if (_cargando)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_hayMas)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: OutlinedButton.icon(
                      onPressed: _cargar,
                      icon: const Icon(Icons.expand_more_rounded),
                      label: const Text('Ver más'),
                    ),
                  ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  static bool _mismoDia(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Icono y color de cada acción.
(IconData, Color) estiloAccion(String accion, ColorScheme esquema) => switch (accion) {
      'CREAR' || 'INSCRIBIR' || 'PUBLICAR' => (Icons.add_circle_rounded, ColoresMarca.verdeVivo),
      'EDITAR' || 'GUARDAR' => (Icons.edit_rounded, esquema.primary),
      'MOVER' => (Icons.swap_horiz_rounded, ColoresMarca.doradoOscuro),
      'ELIMINAR' || 'QUITAR' || 'DESINSCRIBIR' => (Icons.delete_rounded, ColoresMarca.rojo),
      'ELIMINAR_COMPLETO' => (Icons.delete_forever_rounded, ColoresMarca.rojo),
      'CAMBIAR_ROL' => (Icons.manage_accounts_rounded, esquema.tertiary),
      'SUBIR_FOTO' || 'BORRAR_FOTO' => (Icons.photo_camera_rounded, esquema.secondary),
      'INICIAR' || 'REANUDAR' => (Icons.play_circle_rounded, ColoresMarca.verdeVivo),
      'FINALIZAR' => (Icons.flag_rounded, esquema.primary),
      'DETENER' || 'DECIDIR' => (Icons.pause_circle_rounded, ColoresMarca.doradoOscuro),
      'DESHACER' => (Icons.undo_rounded, esquema.onSurfaceVariant),
      _ => (Icons.history_rounded, esquema.onSurfaceVariant),
    };

class _FilaRegistro extends StatelessWidget {
  const _FilaRegistro({required this.registro});

  final RegistroAuditoria registro;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final r = registro;
    final (icono, color) = estiloAccion(r.accion, tema.colorScheme);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icono, color: color),
        ),
        title: Text(r.descripcion, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${r.usuario ?? 'Sistema'} · ${DateFormat('h:mm a', 'es').format(r.fecha)}'),
        trailing: r.antes != null || r.despues != null ? const Icon(Icons.chevron_right_rounded) : null,
        onTap: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (_) => _DetalleRegistro(registro: r),
        ),
      ),
    );
  }
}

/// Detalle de un cambio: qué campos cambiaron (antes → después) o los datos completos.
class _DetalleRegistro extends StatelessWidget {
  const _DetalleRegistro({required this.registro});

  final RegistroAuditoria registro;

  static Map<String, dynamic>? _leer(String? json) {
    if (json == null) return null;
    try {
      final v = jsonDecode(json);
      return v is Map<String, dynamic> ? v : {'valor': v};
    } catch (_) {
      return null;
    }
  }

  static String _texto(Object? v) => switch (v) {
        null => '—',
        Map() || List() => const JsonEncoder.withIndent('  ').convert(v),
        _ => '$v',
      };

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final r = registro;
    final antes = _leer(r.antes);
    final despues = _leer(r.despues);
    final campos = {...?antes?.keys, ...?despues?.keys}.toList();
    final cambiados = antes != null && despues != null
        ? [for (final k in campos) if (jsonEncode(antes[k]) != jsonEncode(despues[k])) k]
        : campos;
    final (icono, color) = estiloAccion(r.accion, tema.colorScheme);
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.92,
        builder: (context, scroll) => ListView(
          controller: scroll,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          children: [
            Row(children: [
              Icon(icono, color: color),
              const SizedBox(width: 10),
              Expanded(child: Text(r.descripcion, style: tema.textTheme.titleMedium)),
            ]),
            const SizedBox(height: 6),
            Text(
              '${r.usuario ?? 'Sistema'} · ${DateFormat("d MMM y, h:mm:ss a", 'es').format(r.fecha)} · '
              '${r.entidad}${r.entidadId == null ? '' : ' #${r.entidadId}'}',
              style: tema.textTheme.bodySmall,
            ),
            const Divider(height: 24),
            if (cambiados.isEmpty)
              Text('Sin datos guardados para este cambio.', style: tema.textTheme.bodyMedium)
            else ...[
              Text(
                antes != null && despues != null ? 'QUÉ CAMBIÓ' : (antes != null ? 'DATOS QUE TENÍA' : 'DATOS'),
                style: estiloEtiqueta(tema.textTheme.labelSmall),
              ),
              const SizedBox(height: 8),
              for (final k in cambiados)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(k, style: tema.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
                    if (antes != null && despues != null)
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: _texto(antes[k]),
                          style: TextStyle(
                            color: tema.colorScheme.error,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const TextSpan(text: '  →  '),
                        TextSpan(
                          text: _texto(despues[k]),
                          style: const TextStyle(color: ColoresMarca.verdeVivo, fontWeight: FontWeight.w600),
                        ),
                      ]))
                    else
                      Text(_texto((antes ?? despues)![k]), style: tema.textTheme.bodyMedium),
                  ]),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
