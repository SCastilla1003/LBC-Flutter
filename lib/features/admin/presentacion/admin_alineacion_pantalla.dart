import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/red/fallo_api.dart';
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

/// Editor de la alineación de un partido: lanzador inicial, orden de bateo con posición
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

/// Alineación editable de un equipo. Quien no está en los 9 ni es el lanzador inicial queda
/// solo en la banca (jugadores de campo) o en los relevos (lanzadores).
class EquipoEditable {
  EquipoEditable([this.plantilla = const []]);

  /// Copia lo guardado, descartando jugadores que ya no están en la plantilla.
  factory EquipoEditable.desde(EquipoAlineacion? a, List<PlantillaLiga> plantilla) {
    final e = EquipoEditable(plantilla);
    if (a == null) return e;
    final ids = e._ids;
    final lanzador = a.lanzadorInicial?.id;
    e.lanzador = ids.contains(lanzador) ? lanzador : null;
    for (final b in a.bateo) {
      if (b.orden >= 1 && b.orden <= 9 && ids.contains(b.jugador.id)) {
        e.jugadores[b.orden - 1] = b.jugador.id;
        e.posiciones[b.orden - 1] = b.posicion;
      }
    }
    e._ajustarListas();
    return e;
  }

  final List<PlantillaLiga> plantilla;
  int? lanzador;
  final jugadores = List<int?>.filled(9, null);
  final posiciones = List<String?>.filled(9, null);

  /// En cada turno, si se elige entre los lanzadores (para que uno batee, como Ohtani) en vez de
  /// entre los jugadores de campo.
  final verLanzadores = List<bool>.filled(9, false);

  Set<int> get _ids => {for (final p in plantilla) p.jugador.id};

  PlantillaLiga? inscrito(int? id) => plantilla.where((p) => p.jugador.id == id).firstOrNull;

  bool esLanzador(int? id) => inscrito(id)?.jugador.esLanzador ?? false;

  /// Jugadores que ya están en el orden de bateo o como lanzador inicial.
  Set<int> get titulares => {...jugadores.whereType<int>(), ?lanzador};

  /// Jugadores de campo que no juegan de inicio.
  List<PlantillaLiga> get banca =>
      [for (final p in plantilla) if (!titulares.contains(p.jugador.id) && !p.jugador.esLanzador) p];

  /// Lanzadores que no abren el partido.
  List<PlantillaLiga> get relevos =>
      [for (final p in plantilla) if (!titulares.contains(p.jugador.id) && p.jugador.esLanzador) p];

  /// Turno (0..8) que ya tiene la posición [pos], sin contar [excepto].
  int? turnoCon(String pos, {int? excepto}) {
    for (var i = 0; i < 9; i++) {
      if (i != excepto && posiciones[i] == pos) return i;
    }
    return null;
  }

  /// Posición que le toca a [id] en el turno [i]: la de su inscripción si está libre. El lanzador
  /// inicial batea como DH (o como P si el DH ya está ocupado); otro lanzador, como DH.
  String? posicionSugerida(int i, int id) {
    bool libre(String p) => turnoCon(p, excepto: i) == null;
    if (id == lanzador) return libre('DH') ? 'DH' : (libre('P') ? 'P' : null);
    final registrada = inscrito(id)?.posicion;
    if (registrada != null && registrada != 'P' && libre(registrada)) return registrada;
    if (esLanzador(id) && libre('DH')) return 'DH';
    return null;
  }

  /// Pone a [id] en el turno [i] con su posición. Si su posición ya la tiene otro, devuelve un
  /// aviso y deja la posición vacía para elegirla.
  String? ponerBateador(int i, int? id, {Map<int, String> nombres = const {}}) {
    jugadores[i] = id;
    if (id == null) {
      posiciones[i] = null;
      return null;
    }
    posiciones[i] = posicionSugerida(i, id);
    final registrada = inscrito(id)?.posicion;
    if (posiciones[i] == null && registrada != null && registrada != 'P') {
      final otro = turnoCon(registrada, excepto: i);
      if (otro != null) {
        return '$registrada ya la tiene ${nombres[jugadores[otro]] ?? 'el turno ${otro + 1}'}: '
            'elige otra posición para ${nombres[id] ?? 'él'}.';
      }
    }
    return null;
  }

  /// Copia el orden de bateo de otra alineación (la del partido anterior). El lanzador inicial
  /// no se copia: los abridores rotan. Quien bateaba como P se deja vacío.
  void copiar(EquipoAlineacion otra) {
    final ids = _ids;
    for (var i = 0; i < 9; i++) {
      jugadores[i] = null;
      posiciones[i] = null;
    }
    for (final b in otra.bateo) {
      if (b.orden < 1 || b.orden > 9 || !ids.contains(b.jugador.id) || b.posicion == 'P') continue;
      if (b.jugador.id == lanzador) continue;
      jugadores[b.orden - 1] = b.jugador.id;
      posiciones[b.orden - 1] = b.posicion;
    }
    _ajustarListas();
  }

  void _ajustarListas() {
    for (var i = 0; i < 9; i++) {
      verLanzadores[i] = jugadores[i] != null && esLanzador(jugadores[i]);
    }
  }

  DatosAlineacionEquipo datos() => DatosAlineacionEquipo(
        lanzadorInicial: lanzador,
        bateo: [
          for (var i = 0; i < 9; i++)
            if (jugadores[i] != null && posiciones[i] != null)
              (orden: i + 1, jugadorId: jugadores[i]!, posicion: posiciones[i]!),
        ],
        banca: [for (final p in [...banca, ...relevos]) p.jugador.id],
      );

  /// Las mismas reglas que valida la API, para avisar antes de enviar.
  List<String> errores({required bool publicar, required String equipo, required Map<int, String> nombres}) {
    final e = <String>[];
    final vistos = <int>{};
    final usadas = <String, int>{};
    for (var i = 0; i < 9; i++) {
      final j = jugadores[i];
      final p = posiciones[i];
      if ((j == null) != (p == null)) {
        e.add('$equipo, turno ${i + 1}: ${j == null ? 'falta el jugador' : 'falta la posición'}.');
      }
      if (j != null && !vistos.add(j)) e.add('$equipo: ${nombres[j]} está dos veces en el orden de bateo.');
      if (p != null) {
        final otro = usadas.putIfAbsent(p, () => i);
        if (otro != i) e.add('$equipo: la posición $p está en los turnos ${otro + 1} y ${i + 1}.');
      }
      if (p == 'P' && j != null && j != lanzador) {
        e.add('$equipo, turno ${i + 1}: la posición P solo puede ser del lanzador inicial.');
      }
      if (j != null && j == lanzador && p != null && p != 'P' && p != 'DH') {
        e.add('$equipo: si el lanzador inicial batea, va como P o como DH.');
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
  bool _buscando = false;

  PartidoDetalle get _partido => widget.datos.partido;

  bool get _editable =>
      _partido.estado == EstadoPartidoLiga.programado || _partido.estado == EstadoPartidoLiga.alineacionPublicada;

  Map<int, String> get _nombres => {
        for (final p in [...widget.datos.plantillaLocal, ...widget.datos.plantillaVisita])
          p.jugador.id: '${p.jugador.nombres} ${p.jugador.apellidos}',
      };

  /// Pone en los campos el orden de bateo del último partido de [equipo] que tenga alineación.
  /// No guarda ni publica nada.
  Future<void> _repetir(EquipoRefLiga equipo, EquipoEditable estado) async {
    final mensajero = ScaffoldMessenger.of(context);
    if (estado.jugadores.any((j) => j != null)) {
      final ok = await confirmar(
        context,
        titulo: 'Repetir la alineación anterior',
        mensaje: 'Se reemplaza el orden de bateo que tienes ahora de ${equipo.nombre}. '
            'No se guarda ni se publica hasta que tú lo hagas.',
        accion: 'Repetir',
      );
      if (!ok || !mounted) return;
    }
    setState(() => _buscando = true);
    try {
      final repo = ref.read(ligaRepositorioProvider);
      final anteriores = (await repo.partidos(_partido.temporadaId, equipoId: equipo.id))
          .where((p) => p.id != _partido.id && p.fechaHora.isBefore(_partido.fechaHora))
          .toList()
        ..sort((a, b) => b.fechaHora.compareTo(a.fechaHora));
      for (final p in anteriores.take(8)) {
        final a = await repo.alineacion(p.id);
        final suya = a.local?.equipo.id == equipo.id ? a.local : (a.visita?.equipo.id == equipo.id ? a.visita : null);
        if (suya == null || suya.bateo.isEmpty) continue;
        if (!mounted) return;
        setState(() => estado.copiar(suya));
        final rival = p.equipoLocal.id == equipo.id ? p.equipoVisita : p.equipoLocal;
        mensajero.showSnackBar(SnackBar(
          content: Text('Se copió la alineación del ${DateFormat("d 'de' MMMM", 'es').format(p.fechaHora)} '
              'contra ${rival.nombre}. Elige el lanzador inicial y revísala antes de guardar.'),
        ));
        return;
      }
      mensajero.showSnackBar(
        SnackBar(content: Text('${equipo.nombre} no tiene un partido anterior con alineación en esta temporada.')),
      );
    } catch (e) {
      mensajero.showSnackBar(SnackBar(
        content: Text(FalloApi.desde(e).mensaje),
        backgroundColor: ColoresMarca.rojo,
      ));
    } finally {
      if (mounted) setState(() => _buscando = false);
    }
  }

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
          if (_buscando) const LinearProgressIndicator(minHeight: 3),
          Expanded(
            child: TabBarView(children: [
              for (final (equipo, lado, estado) in [
                (_partido.equipoVisita, 'Visitante', _visita),
                (_partido.equipoLocal, 'Local', _local),
              ])
                _PestanaEquipo(
                  equipo: equipo,
                  lado: lado,
                  editable: _editable,
                  estado: estado,
                  nombres: _nombres,
                  alCambiar: () => setState(() {}),
                  alRepetir: _buscando ? null : () => _repetir(equipo, estado),
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
    required this.nombres,
    required this.alCambiar,
    required this.alRepetir,
  });

  final EquipoRefLiga equipo;
  final String lado;
  final bool editable;
  final EquipoEditable estado;
  final Map<int, String> nombres;
  final VoidCallback alCambiar;
  final VoidCallback? alRepetir;

  String _nombre(PlantillaLiga p) =>
      '${p.jugador.apellidos}, ${p.jugador.nombres}${p.numero == null ? '' : ' · #${p.numero}'}';

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final plantilla = estado.plantilla;
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
    final deCampo = ordenados.where((p) => !p.jugador.esLanzador).toList();
    final cambio = editable ? alCambiar : null;
    final gris = tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant);

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
              if (editable) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: alRepetir,
                  icon: const Icon(Icons.history_rounded),
                  label: const Text('Repetir la alineación del partido anterior'),
                ),
              ],
              const EncabezadoSeccion('Lanzador inicial'),
              _Selector<int>(
                etiqueta: 'Lanzador inicial',
                valor: estado.lanzador,
                ayuda: lanzadores.isEmpty ? 'Ningún jugador de la plantilla está marcado como lanzador.' : null,
                opciones: [for (final p in lanzadores) (p.jugador.id, _nombre(p))],
                alCambiar: cambio == null
                    ? null
                    : (v) {
                        estado.lanzador = v;
                        cambio();
                      },
              ),
              const EncabezadoSeccion('Orden de bateo'),
              for (var i = 0; i < 9; i++) _turno(context, i, deCampo, lanzadores, cambio),
              Text(
                'Cada bateador toma la posición con la que está inscrito; puedes cambiarla a mano. '
                'Para que batee un lanzador (como DH, igual que Ohtani) toca la pelota del turno.',
                style: gris,
              ),
              const EncabezadoSeccion('Banca'),
              _ListaReserva(jugadores: estado.banca, vacio: 'Todos los jugadores de campo son titulares.'),
              const EncabezadoSeccion('Relevos'),
              _ListaReserva(
                jugadores: estado.relevos,
                vacio: 'No quedan lanzadores para el relevo.',
                lanzadores: true,
              ),
              const SizedBox(height: 6),
              Text('Quien no está en los 9 ni es el lanzador inicial pasa solo a la banca o a los relevos.',
                  style: gris),
            ],
          ),
        ),
      ],
    );
  }

  Widget _turno(
    BuildContext context,
    int i,
    List<PlantillaLiga> deCampo,
    List<PlantillaLiga> lanzadores,
    VoidCallback? cambio,
  ) {
    final tema = Theme.of(context);
    final verLanzadores = estado.verLanzadores[i];
    final enOtros = {for (var j = 0; j < 9; j++) if (j != i) ?estado.jugadores[j]};
    final lista = verLanzadores ? lanzadores : deCampo;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: ColoresMarca.verdeNoche, borderRadius: BorderRadius.circular(7)),
          child: Text(
            '${i + 1}',
            style: estiloMarcador(tema.textTheme.titleMedium)?.copyWith(color: ColoresMarca.amarillo, fontSize: 18),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _Selector<int>(
            etiqueta: verLanzadores ? 'Lanzador al bate' : 'Bateador',
            valor: estado.jugadores[i],
            opciones: [
              for (final p in lista)
                if (!enOtros.contains(p.jugador.id))
                  (p.jugador.id, '${_nombre(p)}${p.posicion == null || verLanzadores ? '' : ' · ${p.posicion}'}'),
            ],
            alCambiar: cambio == null
                ? null
                : (v) {
                    final aviso = estado.ponerBateador(i, v, nombres: nombres);
                    cambio();
                    if (aviso != null) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text(aviso)));
                    }
                  },
          ),
        ),
        IconButton(
          tooltip: verLanzadores ? 'Elegir entre jugadores de campo' : 'Elegir entre lanzadores (DH como Ohtani)',
          isSelected: verLanzadores,
          visualDensity: VisualDensity.compact,
          onPressed: cambio == null
              ? null
              : () {
                  estado.verLanzadores[i] = !verLanzadores;
                  // Si quien estaba no es del grupo nuevo, el turno queda libre.
                  if (estado.jugadores[i] != null && estado.esLanzador(estado.jugadores[i]) == verLanzadores) {
                    estado.ponerBateador(i, null);
                  }
                  cambio();
                },
          icon: const Icon(Icons.sports_baseball_outlined),
          selectedIcon: Icon(Icons.sports_baseball_rounded, color: tema.colorScheme.primary),
        ),
        SizedBox(
          width: 84,
          child: _Selector<String>(
            etiqueta: 'Pos.',
            valor: estado.posiciones[i],
            opciones: [
              for (final p in posicionesLiga)
                (p, estado.turnoCon(p, excepto: i) == null ? p : '$p · ${estado.turnoCon(p, excepto: i)! + 1}º'),
            ],
            deshabilitadas: {for (final p in posicionesLiga) if (estado.turnoCon(p, excepto: i) != null) p},
            alCambiar: cambio == null
                ? null
                : (v) {
                    estado.posiciones[i] = v;
                    cambio();
                  },
          ),
        ),
      ]),
    );
  }
}

/// Jugadores que no abren el partido (banca o relevos), con su número y posición.
class _ListaReserva extends StatelessWidget {
  const _ListaReserva({required this.jugadores, required this.vacio, this.lanzadores = false});

  final List<PlantillaLiga> jugadores;
  final String vacio;
  final bool lanzadores;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    if (jugadores.isEmpty) return Text(vacio, style: tema.textTheme.bodyMedium);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final p in jugadores)
          Chip(
            avatar: Icon(lanzadores ? Icons.sports_baseball_outlined : Icons.person_outline_rounded, size: 16),
            label: Text([
              '${p.jugador.nombres} ${p.jugador.apellidos}',
              if (p.numero != null) '#${p.numero}',
              if (!lanzadores && p.posicion != null) p.posicion!,
            ].join(' · ')),
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
    this.deshabilitadas = const {},
  });

  final String etiqueta;
  final T? valor;
  final List<(T, String)> opciones;
  final ValueChanged<T?>? alCambiar;
  final String? ayuda;

  /// Opciones que se ven pero no se pueden elegir (por ejemplo, posiciones ya ocupadas).
  final Set<T> deshabilitadas;

  @override
  Widget build(BuildContext context) {
    final existe = opciones.any((o) => o.$1 == valor);
    final gris = Theme.of(context).disabledColor;
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
          selectedItemBuilder: (_) => [
            const SizedBox.shrink(),
            for (final o in opciones) Text(o.$2.split(' · ').first, overflow: TextOverflow.ellipsis),
          ],
          items: [
            DropdownMenuItem<T?>(value: null, child: Text('—', style: TextStyle(color: Theme.of(context).hintColor))),
            for (final o in opciones)
              DropdownMenuItem<T?>(
                value: o.$1,
                enabled: o.$1 == valor || !deshabilitadas.contains(o.$1),
                child: Text(
                  o.$2,
                  overflow: TextOverflow.ellipsis,
                  style: o.$1 != valor && deshabilitadas.contains(o.$1) ? TextStyle(color: gris) : null,
                ),
              ),
          ],
          onChanged: alCambiar,
        ),
      ),
    );
  }
}
