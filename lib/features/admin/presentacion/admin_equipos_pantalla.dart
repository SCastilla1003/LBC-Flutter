import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/tema/colores_equipo.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../equipos/datos/modelos_equipo.dart';
import 'admin_comun.dart';

class AdminEquiposPantalla extends ConsumerWidget {
  const AdminEquiposPantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipos = ref.watch(equiposProvider(idTemporada));
    return Scaffold(
      appBar: AppBar(title: const Text('Equipos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _formulario(context, null, equipos.value ?? const []),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nuevo equipo'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(equiposProvider(idTemporada).future),
        child: VistaAsync(
          valor: equipos,
          onReintentar: () => ref.invalidate(equiposProvider(idTemporada)),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin equipos',
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              for (final e in lista)
                AnchoMaximo(
                  ancho: 760,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        leading: ImagenApi(
                            urlFoto: e.urlFoto, nombre: e.nombre, tamano: 44, color: ColoresEquipo.de(context, e.color)),
                        title: Text(e.nombre),
                        subtitle: Text([
                          e.ciudad ?? 'Sin ciudad',
                          '${e.totalBateadores} bateadores',
                          '${e.totalLanzadores} lanzadores',
                          'Color: ${ColoresEquipo.nombres[e.color] ?? 'ninguno'}',
                        ].join(' · ')),
                        onTap: () => context.push('/admin/t/$idTemporada/equipos/${e.id}'),
                        trailing: PopupMenuButton<String>(
                          tooltip: 'Acciones',
                          onSelected: (accion) => _accion(context, ref, accion, e, lista),
                          itemBuilder: (_) => [
                            const PopupMenuItem(value: 'jugadores', child: Text('Jugadores')),
                            const PopupMenuItem(value: 'editar', child: Text('Editar')),
                            const PopupMenuItem(value: 'foto', child: Text('Cambiar foto')),
                            if (e.urlFoto != null) const PopupMenuItem(value: 'quitarFoto', child: Text('Quitar foto')),
                            const PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _accion(BuildContext context, WidgetRef ref, String accion, Equipo e, List<Equipo> todos) async {
    final repo = ref.read(equiposRepositorioProvider);
    switch (accion) {
      case 'jugadores':
        context.push('/admin/t/$idTemporada/equipos/${e.id}');
      case 'editar':
        await _formulario(context, e, todos);
      case 'foto':
        await elegirYSubirFoto(context, ref, (bytes, nombre) => repo.subirFoto(idTemporada, e.id, bytes, nombre));
      case 'quitarFoto':
        await ejecutarAccion(context, ref, () => repo.eliminarFoto(idTemporada, e.id), exito: 'Foto eliminada');
      case 'eliminar':
        final ok = await confirmar(context,
            titulo: 'Eliminar equipo',
            mensaje: 'Se eliminará "${e.nombre}" con sus jugadores y fotos. '
                'Si tiene partidos, primero debes eliminarlos.');
        if (ok && context.mounted) {
          await ejecutarAccion(context, ref, () => repo.eliminar(idTemporada, e.id), exito: 'Equipo eliminado');
        }
    }
  }

  Future<void> _formulario(BuildContext context, Equipo? equipo, List<Equipo> todos) => showDialog<void>(
        context: context,
        builder: (_) => _DialogoEquipo(
          idTemporada: idTemporada,
          equipo: equipo,
          coloresUsados: {for (final e in todos) if (e.id != equipo?.id && e.color != null) e.color!},
        ),
      );
}

class _DialogoEquipo extends ConsumerStatefulWidget {
  const _DialogoEquipo({required this.idTemporada, required this.equipo, required this.coloresUsados});

  final String idTemporada;
  final Equipo? equipo;
  final Set<String> coloresUsados;

  @override
  ConsumerState<_DialogoEquipo> createState() => _DialogoEquipoState();
}

class _DialogoEquipoState extends ConsumerState<_DialogoEquipo> {
  final _form = GlobalKey<FormState>();
  late final _nombre = TextEditingController(text: widget.equipo?.nombre);
  late final _ciudad = TextEditingController(text: widget.equipo?.ciudad);
  late String? _color = widget.equipo?.color;
  bool _guardando = false;

  @override
  void dispose() {
    _nombre.dispose();
    _ciudad.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _guardando = true);
    final repo = ref.read(equiposRepositorioProvider);
    final ciudad = _ciudad.text.trim().isEmpty ? null : _ciudad.text.trim();
    final e = widget.equipo;
    final ok = await ejecutarAccion(
      context,
      ref,
      () => e == null
          ? repo.crear(widget.idTemporada, nombre: _nombre.text.trim(), ciudad: ciudad, color: _color)
          : repo.actualizar(widget.idTemporada, e.id, nombre: _nombre.text.trim(), ciudad: ciudad, color: _color),
      exito: e == null ? 'Equipo creado' : 'Equipo actualizado',
    );
    if (!mounted) return;
    setState(() => _guardando = false);
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.equipo == null ? 'Nuevo equipo' : 'Editar equipo'),
      content: Form(
        key: _form,
        child: SizedBox(
          width: 440,
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              controller: _nombre,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Obligatorio' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(controller: _ciudad, decoration: const InputDecoration(labelText: 'Ciudad (opcional)')),
            const SizedBox(height: 16),
            Text('Color', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final clave in ColoresEquipo.paleta.keys)
                _MuestraColor(
                  clave: clave,
                  seleccionado: _color == clave,
                  usado: widget.coloresUsados.contains(clave),
                  onTap: () => setState(() => _color = clave),
                ),
            ]),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(onPressed: _guardando ? null : _guardar, child: const Text('Guardar')),
      ],
    );
  }
}

class _MuestraColor extends StatelessWidget {
  const _MuestraColor({required this.clave, required this.seleccionado, required this.usado, required this.onTap});

  final String clave;
  final bool seleccionado;
  final bool usado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = ColoresEquipo.de(context, clave);
    final nombre = ColoresEquipo.nombres[clave]!;
    return Tooltip(
      message: usado ? '$nombre (lo usa otro equipo)' : nombre,
      child: InkWell(
        onTap: usado ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: usado ? color.withValues(alpha: 0.25) : color,
            shape: BoxShape.circle,
            border: Border.all(
              color: seleccionado ? Theme.of(context).colorScheme.onSurface : Colors.transparent,
              width: 3,
            ),
          ),
          child: seleccionado
              ? const Icon(Icons.check_rounded, color: Colors.white)
              : (usado ? const Icon(Icons.block_rounded, size: 16) : null),
        ),
      ),
    );
  }
}
