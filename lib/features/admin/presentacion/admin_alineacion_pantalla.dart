import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import 'admin_comun.dart';

/// Todo lo que necesita el editor: partido, alineación guardada y plantillas.
class _DatosEditor {
  const _DatosEditor({
    required this.partido,
    required this.alineacion,
    required this.plantillaLocal,
    required this.plantillaVisita,
  });

  final PartidoDetalle partido;
  final Alineacion alineacion;
  final List<PlantillaLiga> plantillaLocal;
  final List<PlantillaLiga> plantillaVisita;
}

/// (temporadaId, partidoId)
final _editorProvider = FutureProvider.autoDispose.family<_DatosEditor, (int, int)>((ref, clave) async {
  final repo = ref.watch(ligaRepositorioProvider);
  final partido = await repo.partido(clave.$2);
  final r = await Future.wait([
    repo.alineacion(clave.$2),
    repo.plantilla(clave.$1, partido.equipoLocal.id),
    repo.plantilla(clave.$1, partido.equipoVisita.id),
  ]);
  return _DatosEditor(
    partido: partido,
    alineacion: r[0] as Alineacion,
    plantillaLocal: r[1] as List<PlantillaLiga>,
    plantillaVisita: r[2] as List<PlantillaLiga>,
  );
});

/// Editor de la alineación de un partido: lanzador inicial, orden de bateo
/// (9 turnos con posición) y banca de cada equipo. Se puede guardar incompleta
/// (el partido sigue "Programado"); publicarla la muestra a los aficionados.
/// Completa solo se exige para iniciar el partido.
class AdminAlineacionPantalla extends ConsumerWidget {
  const AdminAlineacionPantalla({super.key, required this.idTemporada, required this.idPartido});

  final int idTemporada;
  final int idPartido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clave = (idTemporada, idPartido);
    return Scaffold(
      appBar: AppBar(title: const Text('Alineación')),
      body: VistaAsync<_DatosEditor>(
        valor: ref.watch(_editorProvider(clave)),
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(_editorProvider(clave)),
        datos: (d) => _Editor(datos: d),
      ),
    );
  }
}

/// Alineación editable de un equipo.
class EquipoEditable {
  EquipoEditable();

  /// Copia lo guardado, descartando jugadores que ya no están en la plantilla.
  factory EquipoEditable.desde(EquipoAlineacion? a, List<PlantillaLiga> plantilla) {
    final ids = plantilla.map((p) => p.jugador.id).toSet();
    final e = EquipoEditable();
    if (a == null) return e;
    final lanzador = a.lanzadorInicial?.id;
    e.lanzador = ids.contains(lanzador) ? lanzador : null;
    for (final b in a.bateo) {
      if (b.orden >= 1 && b.orden <= 9 && ids.contains(b.jugador.id)) {
        e.jugadores[b.orden - 1] = b.jugador.id;
        e.posiciones[b.orden - 1] = b.posicion;
      }
    }
    e.banca.addAll(a.banca.map((j) => j.id).where(ids.contains));
    return e;
  }

  int? lanzador;
  final jugadores = List<int?>.filled(9, null);
  final posiciones = List<String?>.filled(9, null);
  final banca = <int>{};

  /// Jugadores que ya están en el orden de bateo o como lanzador inicial.
  Set<int> get titulares => {...jugadores.whereType<int>(), ?lanzador};

  /// Quita de la banca a quien pase a ser titular.
  void limpiarBanca() => banca.removeAll(titulares);

  DatosAlineacionEquipo datos() => DatosAlineacionEquipo(
        lanzadorInicial: lanzador,
        bateo: [
          for (var i = 0; i < 9; i++)
            if (jugadores[i] != null && posiciones[i] != null)
              (orden: i + 1, jugadorId: jugadores[i]!, posicion: posiciones[i]!),
        ],
        banca: banca.toList(),
      );

  /// Las mismas reglas que valida la API, para avisar antes de enviar.
  List<String> errores({required bool publicar, required String equipo, required Map<int, String> nombres}) {
    final e = <String>[];
    final vistos = <int>{};
    for (var i = 0; i < 9; i++) {
      final j = jugadores[i];
      final p = posiciones[i];
      if ((j == null) != (p == null)) {
        e.add('$equipo, turno ${i + 1}: ${j == null ? 'falta el jugador' : 'falta la posición'}.');
      }
      if (j != null && !vistos.add(j)) e.add('$equipo: ${nombres[j]} está dos veces en el orden de bateo.');
      if (p == 'P' && j != null && j != lanzador) {
        e.add('$equipo, turno ${i + 1}: la posición P solo puede ser del lanzador inicial.');
      }
      if (j != null && j == lanzador && p != null && p != 'P') {
        e.add('$equipo: el lanzador inicial solo puede batear como P.');
      }
    }
    if (publicar) {
      if (jugadores.any((j) => j == null)) e.add('$equipo: faltan bateadores (deben ser 9).');
      if (lanzador == null) e.add('$equipo: falta el lanzador inicial.');
    }
    return e;
  }
}

class _Editor extends ConsumerStatefulWidget {
  const _Editor({required this.datos});

  final _DatosEditor datos;

  @override
  ConsumerState<_Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<_Editor> {
  late final _local = EquipoEditable.desde(widget.datos.alineacion.local, widget.datos.plantillaLocal);
  late final _visita = EquipoEditable.desde(widget.datos.alineacion.visita, widget.datos.plantillaVisita);
  bool _guardando = false;

  PartidoDetalle get _partido => widget.datos.partido;

  bool get _editable =>
      _partido.estado == EstadoPartidoLiga.programado || _partido.estado == EstadoPartidoLiga.alineacionPublicada;

  Map<int, String> get _nombres => {
        for (final p in [...widget.datos.plantillaLocal, ...widget.datos.plantillaVisita])
          p.jugador.id: '${p.jugador.nombres} ${p.jugador.apellidos}',
      };

  Future<void> _guardar({required bool publicar}) async {
    final errores = [
      ..._visita.errores(publicar: publicar, equipo: _partido.equipoVisita.nombre, nombres: _nombres),
      ..._local.errores(publicar: publicar, equipo: _partido.equipoLocal.nombre, nombres: _nombres),
    ];
    if (errores.isNotEmpty) {
      await showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(publicar ? 'Para publicarla falta completar la alineación' : 'Revisa la alineación'),
          content: Text(errores.map((e) => '• $e').join('\n')),
          actions: [FilledButton(onPressed: () => Navigator.pop(c), child: const Text('Entendido'))],
        ),
      );
      return;
    }
    setState(() => _guardando = true);
    await ejecutarAccion(
      context,
      ref,
      () => ref
          .read(ligaRepositorioProvider)
          .guardarAlineacion(_partido.id, publicar: publicar, local: _local.datos(), visita: _visita.datos()),
      exito: publicar ? 'Alineación publicada' : 'Alineación guardada',
    );
    if (mounted) setState(() => _guardando = false);
  }

  @override
  Widget build(BuildContext context) {
    final publicada = _partido.estado == EstadoPartidoLiga.alineacionPublicada;
    // Visitante primero: batea en la alta, como en el marcador.
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Material(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: TabBar(tabs: [
              Tab(text: _partido.equipoVisita.nombre),
              Tab(text: _partido.equipoLocal.nombre),
            ]),
          ),
          if (!_editable)
            MaterialBanner(
              content: const Text('El partido ya empezó: la alineación ya no se puede cambiar.'),
              leading: const Icon(Icons.lock_outline_rounded),
              actions: [const SizedBox.shrink()],
            ),
          Expanded(
            child: TabBarView(children: [
              _PestanaEquipo(
                equipo: _partido.equipoVisita,
                lado: 'Visitante',
                editable: _editable,
                estado: _visita,
                plantilla: widget.datos.plantillaVisita,
                alCambiar: () => setState(_visita.limpiarBanca),
              ),
              _PestanaEquipo(
                equipo: _partido.equipoLocal,
                lado: 'Local',
                editable: _editable,
                estado: _local,
                plantilla: widget.datos.plantillaLocal,
                alCambiar: () => setState(_local.limpiarBanca),
              ),
            ]),
          ),
          if (_editable)
            Material(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              elevation: 6,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: AnchoMaximo(
                    ancho: 760,
                    child: Row(children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _guardando ? null : () => _guardar(publicar: false),
                          child: const Text('Guardar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _guardando ? null : () => _guardar(publicar: true),
                          icon: _guardando
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.campaign_rounded),
                          label: Text(publicada ? 'Republicar' : 'Publicar alineación'),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PestanaEquipo extends StatelessWidget {
  const _PestanaEquipo({
    required this.equipo,
    required this.lado,
    required this.editable,
    required this.estado,
    required this.plantilla,
    required this.alCambiar,
  });

  final EquipoRefLiga equipo;
  final String lado;
  final bool editable;
  final EquipoEditable estado;
  final List<PlantillaLiga> plantilla;
  final VoidCallback alCambiar;

  String _nombre(PlantillaLiga p) =>
      '${p.jugador.apellidos}, ${p.jugador.nombres}${p.numero == null ? '' : ' · #${p.numero}'}';

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    if (plantilla.isEmpty) {
      return EstadoVacio(
        mensaje: '${equipo.nombre} no tiene jugadores inscritos en esta temporada.\n'
            'Inscríbelos en Plantillas para armar su alineación.',
        icono: Icons.groups_outlined,
      );
    }
    final ordenados = [...plantilla]
      ..sort((a, b) => a.jugador.apellidos.toLowerCase().compareTo(b.jugador.apellidos.toLowerCase()));
    final lanzadores = ordenados.where((p) => p.jugador.esLanzador).toList();
    final titulares = estado.titulares;
    final bancaPosible = ordenados.where((p) => !titulares.contains(p.jugador.id)).toList();
    final cambio = editable ? alCambiar : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        AnchoMaximo(
          ancho: 760,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(children: [
                  EscudoLiga(equipo: equipo, tamano: 44),
                  const SizedBox(width: 12),
                  Expanded(child: Text(equipo.nombre, style: tema.textTheme.headlineSmall)),
                  Text(lado.toUpperCase(), style: estiloEtiqueta(tema.textTheme.labelSmall)),
                ]),
              ),
              const EncabezadoSeccion('Lanzador inicial'),
              _Selector<int>(
                etiqueta: 'Lanzador inicial',
                valor: estado.lanzador,
                ayuda: lanzadores.isEmpty ? 'Ningún jugador de la plantilla tiene lado de lanzamiento.' : null,
                opciones: [for (final p in lanzadores) (p.jugador.id, _nombre(p))],
                alCambiar: cambio == null
                    ? null
                    : (v) {
                        estado.lanzador = v;
                        cambio();
                      },
              ),
              const EncabezadoSeccion('Orden de bateo'),
              for (var i = 0; i < 9; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColoresMarca.verdeNoche,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: estiloMarcador(tema.textTheme.titleMedium)
                            ?.copyWith(color: ColoresMarca.amarillo, fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _Selector<int>(
                        etiqueta: 'Bateador',
                        valor: estado.jugadores[i],
                        opciones: [for (final p in ordenados) (p.jugador.id, _nombre(p))],
                        alCambiar: cambio == null
                            ? null
                            : (v) {
                                estado.jugadores[i] = v;
                                cambio();
                              },
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 92,
                      child: _Selector<String>(
                        etiqueta: 'Pos.',
                        valor: estado.posiciones[i],
                        opciones: [for (final p in posicionesLiga) (p, p)],
                        alCambiar: cambio == null
                            ? null
                            : (v) {
                                estado.posiciones[i] = v;
                                cambio();
                              },
                      ),
                    ),
                  ]),
                ),
              Text(
                'El lanzador inicial normalmente no batea (se usa DH). Si batea, ponlo en el orden con posición P.',
                style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
              ),
              const EncabezadoSeccion('Banca'),
              if (bancaPosible.isEmpty)
                Text('Todos los jugadores inscritos son titulares.', style: tema.textTheme.bodyMedium)
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in bancaPosible)
                      FilterChip(
                        label: Text('${p.jugador.nombres} ${p.jugador.apellidos}'),
                        avatar: p.jugador.esLanzador ? const Icon(Icons.sports_baseball_outlined, size: 16) : null,
                        selected: estado.banca.contains(p.jugador.id),
                        onSelected: cambio == null
                            ? null
                            : (s) {
                                s ? estado.banca.add(p.jugador.id) : estado.banca.remove(p.jugador.id);
                                cambio();
                              },
                      ),
                  ],
                ),
              const SizedBox(height: 6),
              Text(
                'Los jugadores de la banca con lado de lanzamiento (icono de pelota) quedan como relevistas.',
                style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Desplegable controlado con aspecto de campo; permite dejarlo vacío.
class _Selector<T> extends StatelessWidget {
  const _Selector({
    required this.etiqueta,
    required this.valor,
    required this.opciones,
    required this.alCambiar,
    this.ayuda,
  });

  final String etiqueta;
  final T? valor;
  final List<(T, String)> opciones;
  final ValueChanged<T?>? alCambiar;
  final String? ayuda;

  @override
  Widget build(BuildContext context) {
    final existe = opciones.any((o) => o.$1 == valor);
    return InputDecorator(
      decoration: InputDecoration(
        labelText: etiqueta,
        helperText: ayuda,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
        enabled: alCambiar != null,
      ),
      isEmpty: !existe,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T?>(
          value: existe ? valor : null,
          isExpanded: true,
          isDense: true,
          items: [
            DropdownMenuItem<T?>(value: null, child: Text('—', style: TextStyle(color: Theme.of(context).hintColor))),
            for (final o in opciones)
              DropdownMenuItem<T?>(value: o.$1, child: Text(o.$2, overflow: TextOverflow.ellipsis)),
          ],
          onChanged: alCambiar,
        ),
      ),
    );
  }
}
