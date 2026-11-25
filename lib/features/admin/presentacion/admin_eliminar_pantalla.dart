import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/red/fallo_api.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import '../datos/auditoria_repositorio.dart';
import 'admin_comun.dart';

/// Zona de borrado: elimina por completo jugadores o partidos con todo lo que depende de ellos
/// (inscripciones, alineaciones, jugadas, lanzamientos...). Antes muestra qué se va a borrar y
/// pide escribir ELIMINAR. No se puede deshacer; queda en el registro de auditoría.
class AdminEliminarPantalla extends ConsumerStatefulWidget {
  const AdminEliminarPantalla({super.key, this.idTemporada});

  /// Temporada de la que se listan los partidos.
  final int? idTemporada;

  @override
  ConsumerState<AdminEliminarPantalla> createState() => _AdminEliminarPantallaState();
}

class _AdminEliminarPantallaState extends ConsumerState<AdminEliminarPantalla> with SingleTickerProviderStateMixin {
  late final _pestanas = TabController(length: 2, vsync: this)..addListener(() => setState(() {}));
  final _jugadores = <int, String>{};
  final _partidos = <int, String>{};
  String _busqueda = '';
  bool _borrando = false;

  bool get _enJugadores => _pestanas.index == 0;
  Map<int, String> get _elegidos => _enJugadores ? _jugadores : _partidos;

  @override
  void dispose() {
    _pestanas.dispose();
    super.dispose();
  }

  Future<void> _eliminar() async {
    final elegidos = Map<int, String>.of(_elegidos);
    final deJugadores = _enJugadores;
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => _DialogoEliminar(jugadores: deJugadores, elegidos: elegidos),
    );
    if (ok != true || !mounted) return;
    setState(() => _borrando = true);
    final repo = ref.read(auditoriaRepositorioProvider);
    final fallos = <String>[];
    var borrados = 0;
    for (final MapEntry(key: id, value: nombre) in elegidos.entries) {
      try {
        await (deJugadores ? repo.eliminarJugadorPorCompleto(id) : repo.eliminarPartidoPorCompleto(id));
        borrados++;
        (deJugadores ? _jugadores : _partidos).remove(id);
      } catch (e) {
        fallos.add('$nombre: ${FalloApi.desde(e).mensaje}');
      }
    }
    if (!mounted) return;
    refrescarLiga(ref);
    setState(() => _borrando = false);
    final que = deJugadores ? (borrados == 1 ? 'jugador' : 'jugadores') : (borrados == 1 ? 'partido' : 'partidos');
    await showDialog<void>(
      context: context,
      builder: (c) => AlertDialog(
        icon: Icon(fallos.isEmpty ? Icons.check_circle_rounded : Icons.warning_amber_rounded),
        title: Text(borrados == 0
            ? 'No se eliminó nada'
            : (borrados == 1 ? 'Se eliminó 1 $que' : 'Se eliminaron $borrados $que')),
        content: fallos.isEmpty ? null : Text(['No se pudieron eliminar:', ...fallos.map((f) => '• $f')].join('\n')),
        actions: [FilledButton(onPressed: () => Navigator.pop(c), child: const Text('Listo'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final n = _elegidos.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar por completo'),
        bottom: TabBar(controller: _pestanas, tabs: [
          Tab(text: 'Jugadores${_jugadores.isEmpty ? '' : ' (${_jugadores.length})'}'),
          Tab(text: 'Partidos${_partidos.isEmpty ? '' : ' (${_partidos.length})'}'),
        ]),
      ),
      body: Column(children: [
        MaterialBanner(
          backgroundColor: tema.colorScheme.errorContainer,
          leading: Icon(Icons.delete_forever_rounded, color: tema.colorScheme.onErrorContainer),
          content: Text(
            'Borra también todo lo que depende de lo que elijas. No se puede deshacer, pero queda '
            'anotado en el registro de auditoría.',
            style: TextStyle(color: tema.colorScheme.onErrorContainer),
          ),
          actions: const [SizedBox.shrink()],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: AnchoMaximo(
            ancho: 760,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: _enJugadores ? 'Buscar jugador' : 'Buscar por equipo',
              ),
              onChanged: (v) => setState(() => _busqueda = v.trim().toLowerCase()),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(controller: _pestanas, children: [
            _ListaJugadores(
              busqueda: _busqueda,
              elegidos: _jugadores,
              alCambiar: (id, nombre) => setState(() => _jugadores.containsKey(id)
                  ? _jugadores.remove(id)
                  : _jugadores[id] = nombre),
            ),
            widget.idTemporada == null
                ? const EstadoVacio(mensaje: 'Crea o elige una temporada para ver sus partidos.')
                : _ListaPartidos(
                    idTemporada: widget.idTemporada!,
                    busqueda: _busqueda,
                    elegidos: _partidos,
                    alCambiar: (id, nombre) => setState(() => _partidos.containsKey(id)
                        ? _partidos.remove(id)
                        : _partidos[id] = nombre),
                  ),
          ]),
        ),
        Material(
          elevation: 6,
          color: tema.colorScheme.surfaceContainerLowest,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: AnchoMaximo(
                ancho: 760,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: tema.colorScheme.error,
                    foregroundColor: tema.colorScheme.onError,
                  ),
                  onPressed: n == 0 || _borrando ? null : _eliminar,
                  icon: _borrando
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.delete_forever_rounded),
                  label: Text(n == 0
                      ? 'Elige qué eliminar'
                      : 'Eliminar $n ${_enJugadores ? (n == 1 ? 'jugador' : 'jugadores') : (n == 1 ? 'partido' : 'partidos')}'),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _ListaJugadores extends ConsumerWidget {
  const _ListaJugadores({required this.busqueda, required this.elegidos, required this.alCambiar});

  final String busqueda;
  final Map<int, String> elegidos;
  final void Function(int id, String nombre) alCambiar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VistaAsync<List<JugadorLiga>>(
      valor: ref.watch(jugadoresLigaProvider),
      onReintentar: () => ref.invalidate(jugadoresLigaProvider),
      datos: (todos) {
        final lista = [
          for (final j in todos)
            if ('${j.nombres} ${j.apellidos}'.toLowerCase().contains(busqueda)) j,
        ]..sort((a, b) => a.apellidos.toLowerCase().compareTo(b.apellidos.toLowerCase()));
        if (lista.isEmpty) return const EstadoVacio(mensaje: 'No hay jugadores con ese nombre.');
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          itemCount: lista.length,
          itemBuilder: (_, i) {
            final j = lista[i];
            final nombre = '${j.nombres} ${j.apellidos}';
            return AnchoMaximo(
              ancho: 760,
              child: CheckboxListTile(
                value: elegidos.containsKey(j.id),
                onChanged: (_) => alCambiar(j.id, nombre),
                secondary: ImagenApi(urlFoto: j.fotoUrl, nombre: nombre, tamano: 40),
                title: Text(nombre),
                subtitle: j.esLanzador ? const Text('Lanzador') : null,
              ),
            );
          },
        );
      },
    );
  }
}

class _ListaPartidos extends ConsumerWidget {
  const _ListaPartidos({
    required this.idTemporada,
    required this.busqueda,
    required this.elegidos,
    required this.alCambiar,
  });

  final int idTemporada;
  final String busqueda;
  final Map<int, String> elegidos;
  final void Function(int id, String nombre) alCambiar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VistaAsync<List<PartidoResumen>>(
      valor: ref.watch(partidosLigaProvider(idTemporada)),
      onReintentar: () => ref.invalidate(partidosLigaProvider(idTemporada)),
      datos: (todos) {
        final lista = [
          for (final p in todos)
            if ('${p.equipoVisita.nombre} ${p.equipoLocal.nombre} ${p.equipoVisita.abreviatura} '
                    '${p.equipoLocal.abreviatura}'
                .toLowerCase()
                .contains(busqueda))
              p,
        ]..sort((a, b) => b.fechaHora.compareTo(a.fechaHora));
        if (lista.isEmpty) return const EstadoVacio(mensaje: 'No hay partidos con ese filtro en esta temporada.');
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          itemCount: lista.length,
          itemBuilder: (_, i) {
            final p = lista[i];
            final fecha = DateFormat("d MMM y · h:mm a", 'es').format(p.fechaHora);
            final nombre = '${p.equipoVisita.abreviatura} @ ${p.equipoLocal.abreviatura} ($fecha)';
            final jugado = p.estado != EstadoPartidoLiga.programado && p.estado != EstadoPartidoLiga.alineacionPublicada;
            return AnchoMaximo(
              ancho: 760,
              child: CheckboxListTile(
                value: elegidos.containsKey(p.id),
                onChanged: (_) => alCambiar(p.id, nombre),
                title: Text(
                  '${p.equipoVisita.abreviatura} ${jugado ? '${p.marcador.visita} – ${p.marcador.local} ' : '@ '}'
                  '${p.equipoLocal.abreviatura}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(fecha),
                secondary: ChipEstadoPartido(estado: p.estado, motivo: p.motivo),
              ),
            );
          },
        );
      },
    );
  }
}

/// Muestra lo que se va a borrar (consultado a la API) y pide escribir ELIMINAR.
class _DialogoEliminar extends ConsumerStatefulWidget {
  const _DialogoEliminar({required this.jugadores, required this.elegidos});

  final bool jugadores;
  final Map<int, String> elegidos;

  @override
  ConsumerState<_DialogoEliminar> createState() => _DialogoEliminarState();
}

class _DialogoEliminarState extends ConsumerState<_DialogoEliminar> {
  late final Future<List<Impacto>> _impactos = Future.wait([
    for (final id in widget.elegidos.keys)
      widget.jugadores
          ? ref.read(auditoriaRepositorioProvider).impactoJugador(id)
          : ref.read(auditoriaRepositorioProvider).impactoPartido(id),
  ]);
  final _confirmacion = TextEditingController();

  @override
  void dispose() {
    _confirmacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final n = widget.elegidos.length;
    return AlertDialog(
      icon: Icon(Icons.delete_forever_rounded, color: tema.colorScheme.error),
      title: Text('¿Eliminar por completo $n ${widget.jugadores ? (n == 1 ? 'jugador' : 'jugadores') : (n == 1 ? 'partido' : 'partidos')}?'),
      content: SizedBox(
        width: 460,
        child: FutureBuilder<List<Impacto>>(
          future: _impactos,
          builder: (context, s) {
            if (s.hasError) return Text(FalloApi.desde(s.error!).mensaje);
            if (!s.hasData) {
              return const SizedBox(height: 80, child: Center(child: CircularProgressIndicator()));
            }
            final im = s.data!;
            int suma(int Function(Impacto) f) => im.fold(0, (a, b) => a + f(b));
            final bloqueados = [for (final i in im) if (i.enJuego) i.nombre];
            final lineas = <String>[
              if (widget.jugadores && suma((i) => i.inscripciones) > 0)
                '${suma((i) => i.inscripciones)} inscripciones en rosters',
              if (suma((i) => i.alineaciones) > 0) '${suma((i) => i.alineaciones)} puestos en alineaciones',
              if (suma((i) => i.jugadas) > 0) '${suma((i) => i.jugadas)} jugadas',
              if (suma((i) => i.lanzamientos) > 0) '${suma((i) => i.lanzamientos)} lanzamientos',
              if (suma((i) => i.cambios) > 0) '${suma((i) => i.cambios)} cambios de jugadores',
            ];
            return SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(im.map((i) => i.nombre).join(', '), style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Text(lineas.isEmpty ? 'No tiene nada más relacionado.' : 'También se borran:'),
                for (final l in lineas) Text('• $l'),
                if (widget.jugadores && suma((i) => i.jugadas) > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Sus jugadas desaparecen de las estadísticas y del jugada a jugada; el marcador final de '
                    'esos partidos no cambia.',
                    style: tema.textTheme.bodySmall,
                  ),
                ],
                if (bloqueados.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.jugadores
                        ? 'No se puede con ${bloqueados.join(', ')}: está en un partido en juego. Termínalo antes.'
                        : 'Ojo: ${bloqueados.join(', ')} está en vivo ahora mismo.',
                    style: TextStyle(color: tema.colorScheme.error, fontWeight: FontWeight.w600),
                  ),
                ],
                const SizedBox(height: 14),
                Text('Esto no se puede deshacer. Escribe ELIMINAR para confirmar:', style: tema.textTheme.bodyMedium),
                const SizedBox(height: 6),
                TextField(
                  controller: _confirmacion,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(hintText: 'ELIMINAR'),
                  onChanged: (_) => setState(() {}),
                ),
              ]),
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: tema.colorScheme.error, foregroundColor: tema.colorScheme.onError),
          onPressed: _confirmacion.text.trim().toUpperCase() == 'ELIMINAR' ? () => Navigator.pop(context, true) : null,
          child: const Text('Eliminar por completo'),
        ),
      ],
    );
  }
}

