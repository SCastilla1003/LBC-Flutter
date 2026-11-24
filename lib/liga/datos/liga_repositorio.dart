import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/red/cliente_api.dart';
import 'modelos_liga.dart';

/// Lecturas del contrato v1 de la API (IDs numéricos). Las escrituras se añaden por fases.
class LigaRepositorio {
  LigaRepositorio(this._api);

  final ClienteApi _api;

  Future<List<TemporadaLiga>> temporadas() => _lista('/temporadas', TemporadaLiga.fromJson);

  Future<TemporadaLiga> temporadaActual() async =>
      TemporadaLiga.fromJson(await _api.get('/temporadas/actual') as Map<String, dynamic>);

  Future<TemporadaLiga> temporada(int id) async =>
      TemporadaLiga.fromJson(await _api.get('/temporadas/$id') as Map<String, dynamic>);

  Future<List<EquipoRefLiga>> equiposDeTemporada(int temporadaId) =>
      _lista('/temporadas/$temporadaId/equipos', EquipoRefLiga.fromJson);

  Future<List<PartidoResumen>> partidos(
    int temporadaId, {
    EstadoPartidoLiga? estado,
    int? equipoId,
    DateTime? desde,
    DateTime? hasta,
  }) =>
      _lista(
        '/temporadas/$temporadaId/partidos',
        PartidoResumen.fromJson,
        query: {
          'estado': ?_valorEstadoOpcional(estado),
          'equipoId': ?equipoId,
          'desde': ?_fechaOpcional(desde),
          'hasta': ?_fechaOpcional(hasta),
        },
      );

  Future<PartidoDetalle> partido(int id) async =>
      PartidoDetalle.fromJson(await _api.get('/partidos/$id') as Map<String, dynamic>);

  Future<List<PosicionLiga>> posiciones(int temporadaId) =>
      _lista('/temporadas/$temporadaId/posiciones', PosicionLiga.fromJson);

  Future<Alineacion> alineacion(int partidoId) async =>
      Alineacion.fromJson(await _api.get('/partidos/$partidoId/alineacion') as Map<String, dynamic>);

  Future<Pitcheo> pitcheo(int partidoId) async =>
      Pitcheo.fromJson(await _api.get('/partidos/$partidoId/alineacion/pitcheo') as Map<String, dynamic>);

  Future<List<EstadioLiga>> estadios() => _lista('/estadios', EstadioLiga.fromJson);

  Future<List<EquipoLiga>> equipos() => _lista('/equipos', EquipoLiga.fromJson);

  Future<EquipoLiga> equipo(int id) async =>
      EquipoLiga.fromJson(await _api.get('/equipos/$id') as Map<String, dynamic>);

  Future<List<PlantillaLiga>> plantilla(int temporadaId, int equipoId) =>
      _lista('/temporadas/$temporadaId/equipos/$equipoId/plantilla', PlantillaLiga.fromJson);

  Future<List<PlantillaLiga>> agentesLibres(int temporadaId) =>
      _lista('/temporadas/$temporadaId/agentes-libres', PlantillaLiga.fromJson);

  Future<List<JugadorLiga>> jugadores() => _lista('/jugadores', JugadorLiga.fromJson);

  Future<JugadorLiga> jugador(int id) async =>
      JugadorLiga.fromJson(await _api.get('/jugadores/$id') as Map<String, dynamic>);

  // ── Escrituras (solo ADMIN) ───────────────────────────────────────────────
  // Los cuerpos siguen los *Request del backend (docs/CONTRATO_API.md).

  Future<TemporadaLiga> crearTemporada(DatosTemporada d) async =>
      TemporadaLiga.fromJson(await _api.post('/temporadas', d.json()) as Map<String, dynamic>);

  Future<TemporadaLiga> actualizarTemporada(int id, DatosTemporada d) async =>
      TemporadaLiga.fromJson(await _api.put('/temporadas/$id', d.json()) as Map<String, dynamic>);

  Future<void> eliminarTemporada(int id) => _api.delete('/temporadas/$id');

  Future<EquipoLiga> crearEquipo(DatosEquipo d) async =>
      EquipoLiga.fromJson(await _api.post('/equipos', d.json()) as Map<String, dynamic>);

  Future<EquipoLiga> actualizarEquipo(int id, DatosEquipo d) async =>
      EquipoLiga.fromJson(await _api.put('/equipos/$id', d.json()) as Map<String, dynamic>);

  Future<void> eliminarEquipo(int id) => _api.delete('/equipos/$id');

  /// Inscribe un equipo en la temporada, aunque todavía no tenga jugadores.
  Future<EquipoRefLiga> inscribirEquipo(int temporadaId, int equipoId) async => EquipoRefLiga.fromJson(
      await _api.post('/temporadas/$temporadaId/equipos', {'equipoId': equipoId}) as Map<String, dynamic>);

  /// Quita el equipo de la temporada (la API lo impide si tiene jugadores o partidos).
  Future<void> desinscribirEquipo(int temporadaId, int equipoId) =>
      _api.delete('/temporadas/$temporadaId/equipos/$equipoId');

  /// Roster más reciente del equipo en otra temporada (la última, por año, en la que
  /// tuvo jugadores). null si nunca ha tenido jugadores.
  Future<({TemporadaLiga temporada, List<PlantillaLiga> plantilla})?> rosterAnterior(int temporadaId, int equipoId) async {
    final otras = (await temporadas()).where((t) => t.id != temporadaId).toList()
      ..sort((a, b) => b.anio != a.anio ? b.anio.compareTo(a.anio) : b.id.compareTo(a.id));
    for (final t in otras) {
      final p = await plantilla(t.id, equipoId);
      if (p.isNotEmpty) return (temporada: t, plantilla: p);
    }
    return null;
  }

  Future<EstadioLiga> crearEstadio({required String nombre, String? ubicacion}) async => EstadioLiga.fromJson(
      await _api.post('/estadios', {'nombre': nombre, 'ubicacion': ubicacion}) as Map<String, dynamic>);

  Future<EstadioLiga> actualizarEstadio(int id, {required String nombre, String? ubicacion}) async =>
      EstadioLiga.fromJson(
          await _api.put('/estadios/$id', {'nombre': nombre, 'ubicacion': ubicacion}) as Map<String, dynamic>);

  Future<void> eliminarEstadio(int id) => _api.delete('/estadios/$id');

  Future<JugadorLiga> crearJugador(DatosJugador d) async =>
      JugadorLiga.fromJson(await _api.post('/jugadores', d.json()) as Map<String, dynamic>);

  Future<JugadorLiga> actualizarJugador(int id, DatosJugador d) async =>
      JugadorLiga.fromJson(await _api.put('/jugadores/$id', d.json()) as Map<String, dynamic>);

  Future<void> eliminarJugador(int id) => _api.delete('/jugadores/$id');

  // Fotos y escudos: se guardan en el bucket de Railway y la API los sirve.

  Future<JugadorLiga> subirFotoJugador(int id, List<int> bytes, String nombreArchivo) async => JugadorLiga.fromJson(
      await _api.subirArchivo('/jugadores/$id/foto', bytes, nombreArchivo, post: true) as Map<String, dynamic>);

  Future<void> borrarFotoJugador(int id) => _api.delete('/jugadores/$id/foto');

  Future<EquipoLiga> subirEscudo(int id, List<int> bytes, String nombreArchivo) async => EquipoLiga.fromJson(
      await _api.subirArchivo('/equipos/$id/escudo', bytes, nombreArchivo, post: true) as Map<String, dynamic>);

  Future<void> borrarEscudo(int id) => _api.delete('/equipos/$id/escudo');

  /// Inscribe un jugador en la temporada. [equipoId] nulo = agente libre.
  Future<PlantillaLiga> inscribir(int temporadaId,
          {required int jugadorId, int? equipoId, int? numero, String? posicion}) async =>
      PlantillaLiga.fromJson(await _api.post('/temporadas/$temporadaId/plantilla', {
        'jugadorId': jugadorId,
        'equipoId': equipoId,
        'numero': numero,
        'posicion': posicion,
      }) as Map<String, dynamic>);

  /// Cambia equipo (traspaso o agente libre), número o posición de una inscripción.
  Future<PlantillaLiga> actualizarInscripcion(int temporadaId, int entradaId,
          {int? equipoId, int? numero, String? posicion}) async =>
      PlantillaLiga.fromJson(await _api.put('/temporadas/$temporadaId/plantilla/$entradaId', {
        'equipoId': equipoId,
        'numero': numero,
        'posicion': posicion,
      }) as Map<String, dynamic>);

  Future<void> quitarDeTemporada(int temporadaId, int entradaId) =>
      _api.delete('/temporadas/$temporadaId/plantilla/$entradaId');

  Future<PartidoResumen> crearPartido(int temporadaId,
          {required int equipoLocalId,
          required int equipoVisitaId,
          required DateTime fechaHora,
          int? estadioId,
          int? entradasProgramadas}) async =>
      PartidoResumen.fromJson(await _api.post('/temporadas/$temporadaId/partidos', {
        'equipoLocalId': equipoLocalId,
        'equipoVisitaId': equipoVisitaId,
        'fechaHora': fechaHoraApi(fechaHora),
        'estadioId': estadioId,
        'entradasProgramadas': entradasProgramadas,
      }) as Map<String, dynamic>);

  /// Solo cambia fecha, estadio y entradas (el resto lo lleva el anotador).
  Future<void> actualizarPartido(int id,
          {required DateTime fechaHora, int? estadioId, int? entradasProgramadas}) =>
      _api.put('/partidos/$id', {
        'fechaHora': fechaHoraApi(fechaHora),
        'estadioId': estadioId,
        'entradasProgramadas': entradasProgramadas,
      });

  /// Solo se puede borrar un partido programado.
  Future<void> eliminarPartido(int id) => _api.delete('/partidos/$id');

  /// Guarda la alineación de los dos equipos. Con [publicar] el partido pasa a
  /// "Alineación lista" y la API exige que esté completa.
  Future<Alineacion> guardarAlineacion(int partidoId,
          {required bool publicar, required DatosAlineacionEquipo local, required DatosAlineacionEquipo visita}) async =>
      Alineacion.fromJson(await _api.put('/partidos/$partidoId/alineacion', {
        'publicar': publicar,
        'local': local.json(),
        'visita': visita.json(),
      }) as Map<String, dynamic>);

  Future<List<T>> _lista<T>(String ruta, T Function(Map<String, dynamic>) desde,
      {Map<String, dynamic>? query}) async {
    final datos = await _api.get(ruta, query: query) as List;
    return datos.map((e) => desde(e as Map<String, dynamic>)).toList();
  }

  static String _valorEstado(EstadoPartidoLiga e) => switch (e) {
        EstadoPartidoLiga.programado => 'SCHEDULED',
        EstadoPartidoLiga.alineacionPublicada => 'LINEUP_PUBLISHED',
        EstadoPartidoLiga.enJuego => 'LIVE',
        EstadoPartidoLiga.finalizado => 'FINISHED',
        EstadoPartidoLiga.suspendido => 'SUSPENDED',
      };

  static String? _valorEstadoOpcional(EstadoPartidoLiga? e) => e == null ? null : _valorEstado(e);

  static String? _fechaOpcional(DateTime? d) => d == null
      ? null
      : '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

final ligaRepositorioProvider = Provider<LigaRepositorio>((ref) => LigaRepositorio(ref.watch(clienteApiProvider)));

final temporadasLigaProvider =
    FutureProvider<List<TemporadaLiga>>((ref) => ref.watch(ligaRepositorioProvider).temporadas());

final temporadaActualLigaProvider =
    FutureProvider<TemporadaLiga>((ref) => ref.watch(ligaRepositorioProvider).temporadaActual());

final temporadaLigaProvider = FutureProvider.autoDispose
    .family<TemporadaLiga, int>((ref, id) => ref.watch(ligaRepositorioProvider).temporada(id));

final equiposTemporadaLigaProvider = FutureProvider.autoDispose
    .family<List<EquipoRefLiga>, int>((ref, id) => ref.watch(ligaRepositorioProvider).equiposDeTemporada(id));

final partidosLigaProvider = FutureProvider.autoDispose
    .family<List<PartidoResumen>, int>((ref, temporadaId) => ref.watch(ligaRepositorioProvider).partidos(temporadaId));

final partidoDetalleLigaProvider = FutureProvider.autoDispose
    .family<PartidoDetalle, int>((ref, id) => ref.watch(ligaRepositorioProvider).partido(id));

final posicionesLigaProvider = FutureProvider.autoDispose
    .family<List<PosicionLiga>, int>((ref, temporadaId) => ref.watch(ligaRepositorioProvider).posiciones(temporadaId));

final alineacionLigaProvider = FutureProvider.autoDispose
    .family<Alineacion, int>((ref, partidoId) => ref.watch(ligaRepositorioProvider).alineacion(partidoId));

final pitcheoLigaProvider = FutureProvider.autoDispose
    .family<Pitcheo, int>((ref, partidoId) => ref.watch(ligaRepositorioProvider).pitcheo(partidoId));

final equiposLigaProvider =
    FutureProvider.autoDispose<List<EquipoLiga>>((ref) => ref.watch(ligaRepositorioProvider).equipos());

final estadiosLigaProvider =
    FutureProvider.autoDispose<List<EstadioLiga>>((ref) => ref.watch(ligaRepositorioProvider).estadios());

final jugadoresLigaProvider =
    FutureProvider.autoDispose<List<JugadorLiga>>((ref) => ref.watch(ligaRepositorioProvider).jugadores());

/// Plantilla de un equipo en una temporada: (temporadaId, equipoId).
final plantillaLigaProvider = FutureProvider.autoDispose.family<List<PlantillaLiga>, (int, int)>(
    (ref, clave) => ref.watch(ligaRepositorioProvider).plantilla(clave.$1, clave.$2));

final agentesLibresLigaProvider = FutureProvider.autoDispose
    .family<List<PlantillaLiga>, int>((ref, temporadaId) => ref.watch(ligaRepositorioProvider).agentesLibres(temporadaId));

// ── Cuerpos de escritura ────────────────────────────────────────────────────

/// `TemporadaRequest`: nombre y año obligatorios; estado DRAFT por defecto.
class DatosTemporada {
  const DatosTemporada({
    required this.nombre,
    required this.anio,
    this.estado = EstadoTemporadaLiga.borrador,
    this.fechaInicio,
    this.fechaFin,
  });

  final String nombre;
  final int anio;
  final EstadoTemporadaLiga estado;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;

  Map<String, dynamic> json() => {
        'nombre': nombre,
        'anio': anio,
        'estado': switch (estado) {
          EstadoTemporadaLiga.borrador => 'DRAFT',
          EstadoTemporadaLiga.activa => 'ACTIVE',
          EstadoTemporadaLiga.finalizada => 'FINISHED',
        },
        'fechaInicio': fechaApi(fechaInicio),
        'fechaFin': fechaApi(fechaFin),
      };
}

/// `EquipoRequest`: nombre y abreviatura (2–5 letras) obligatorios.
class DatosEquipo {
  const DatosEquipo({required this.nombre, required this.abreviatura, this.ciudad, this.color, this.escudoUrl});

  final String nombre;
  final String abreviatura;
  final String? ciudad;
  final String? color;
  final String? escudoUrl;

  Map<String, dynamic> json() => {
        'nombre': nombre,
        'abreviatura': abreviatura,
        'ciudad': ciudad,
        'color': color,
        'escudoUrl': escudoUrl,
      };
}

/// `JugadorRequest`: nombres y apellidos obligatorios.
class DatosJugador {
  const DatosJugador({
    required this.nombres,
    required this.apellidos,
    this.fechaNacimiento,
    this.batea,
    this.lanza,
    this.fotoUrl,
  });

  final String nombres;
  final String apellidos;
  final DateTime? fechaNacimiento;
  final LadoBateo? batea;
  final LadoLanzamiento? lanza;
  final String? fotoUrl;

  Map<String, dynamic> json() => {
        'nombres': nombres,
        'apellidos': apellidos,
        'fechaNacimiento': fechaApi(fechaNacimiento),
        'batea': switch (batea) {
          LadoBateo.derecho => 'D',
          LadoBateo.zurdo => 'Z',
          LadoBateo.ambidiestro => 'A',
          null => null,
        },
        'lanza': switch (lanza) {
          LadoLanzamiento.derecho => 'D',
          LadoLanzamiento.zurdo => 'Z',
          null => null,
        },
        'fotoUrl': fotoUrl,
      };
}

String _dos(int n) => n.toString().padLeft(2, '0');

/// Fecha para la API: `2026-02-07`.
String? fechaApi(DateTime? d) => d == null ? null : '${d.year.toString().padLeft(4, '0')}-${_dos(d.month)}-${_dos(d.day)}';

/// Fecha y hora local de Bogotá, sin zona: `2026-02-07T15:00`.
String fechaHoraApi(DateTime d) => '${fechaApi(d)}T${_dos(d.hour)}:${_dos(d.minute)}';

/// Posiciones admitidas por la API en plantilla y alineación.
const posicionesLiga = ['P', 'C', '1B', '2B', '3B', 'SS', 'LF', 'CF', 'RF', 'DH'];

/// Fila del orden de bateo para la API.
typedef TurnoBateo = ({int orden, int jugadorId, String posicion});

/// `EquipoAlineacionRequest`: lanzador inicial, orden de bateo y banca.
class DatosAlineacionEquipo {
  const DatosAlineacionEquipo({this.lanzadorInicial, this.bateo = const [], this.banca = const []});

  final int? lanzadorInicial;
  final List<TurnoBateo> bateo;
  final List<int> banca;

  Map<String, dynamic> json() => {
        'lanzadorInicial': lanzadorInicial,
        'bateo': [
          for (final b in bateo) {'orden': b.orden, 'jugadorId': b.jugadorId, 'posicion': b.posicion},
        ],
        'banca': banca,
      };
}

final equipoLigaProvider =
    FutureProvider.autoDispose.family<EquipoLiga, int>((ref, id) => ref.watch(ligaRepositorioProvider).equipo(id));

/// Partidos de un equipo en una temporada: (temporadaId, equipoId).
final partidosEquipoLigaProvider = FutureProvider.autoDispose.family<List<PartidoResumen>, (int, int)>(
    (ref, clave) => ref.watch(ligaRepositorioProvider).partidos(clave.$1, equipoId: clave.$2));

final jugadorLigaProvider =
    FutureProvider.autoDispose.family<JugadorLiga, int>((ref, id) => ref.watch(ligaRepositorioProvider).jugador(id));
