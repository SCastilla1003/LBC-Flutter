import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/red/cliente_api.dart';
import 'modelos_liga.dart';

int _i(Object? v) => (v as num?)?.toInt() ?? 0;
double _d(Object? v) => (v as num?)?.toDouble() ?? 0;

/// Promedio estilo béisbol: ,256 (sin el cero inicial), o 1,000.
String promedio(double v) {
  final t = v.toStringAsFixed(3).replaceAll('.', ',');
  return t.startsWith('0') ? t.substring(1) : t;
}

/// Cifra con 2 decimales y coma: 3,45.
String dosDecimales(double v) => v.toStringAsFixed(2).replaceAll('.', ',');

class CifrasBateo {
  const CifrasBateo({
    this.juegos = 0,
    this.pa = 0,
    this.ab = 0,
    this.h = 0,
    this.dobles = 0,
    this.triples = 0,
    this.hr = 0,
    this.carreras = 0,
    this.rbi = 0,
    this.bb = 0,
    this.hbp = 0,
    this.so = 0,
    this.sb = 0,
    this.cs = 0,
    this.sf = 0,
    this.sh = 0,
    this.avg = 0,
    this.obp = 0,
    this.slg = 0,
    this.ops = 0,
  });

  factory CifrasBateo.fromJson(Map<String, dynamic> j) => CifrasBateo(
        juegos: _i(j['juegos']),
        pa: _i(j['pa']),
        ab: _i(j['ab']),
        h: _i(j['h']),
        dobles: _i(j['dobles']),
        triples: _i(j['triples']),
        hr: _i(j['hr']),
        carreras: _i(j['carreras']),
        rbi: _i(j['rbi']),
        bb: _i(j['bb']),
        hbp: _i(j['hbp']),
        so: _i(j['so']),
        sb: _i(j['sb']),
        cs: _i(j['cs']),
        sf: _i(j['sf']),
        sh: _i(j['sh']),
        avg: _d(j['avg']),
        obp: _d(j['obp']),
        slg: _d(j['slg']),
        ops: _d(j['ops']),
      );

  final int juegos, pa, ab, h, dobles, triples, hr, carreras, rbi, bb, hbp, so, sb, cs, sf, sh;
  final double avg, obp, slg, ops;
}

class CifrasPitcheo {
  const CifrasPitcheo({
    this.juegos = 0,
    this.iniciados = 0,
    this.ganados = 0,
    this.perdidos = 0,
    this.outs = 0,
    this.ip = '0.0',
    this.bateadores = 0,
    this.hits = 0,
    this.carreras = 0,
    this.limpias = 0,
    this.bb = 0,
    this.hbp = 0,
    this.so = 0,
    this.hr = 0,
    this.lanzamientos = 0,
    this.era = 0,
    this.whip = 0,
    this.k9 = 0,
    this.bb9 = 0,
    this.promedioContra = 0,
  });

  factory CifrasPitcheo.fromJson(Map<String, dynamic> j) => CifrasPitcheo(
        juegos: _i(j['juegos']),
        iniciados: _i(j['iniciados']),
        ganados: _i(j['ganados']),
        perdidos: _i(j['perdidos']),
        outs: _i(j['outs']),
        ip: j['ip'] as String? ?? '0.0',
        bateadores: _i(j['bateadores']),
        hits: _i(j['hits']),
        carreras: _i(j['carreras']),
        limpias: _i(j['limpias']),
        bb: _i(j['bb']),
        hbp: _i(j['hbp']),
        so: _i(j['so']),
        hr: _i(j['hr']),
        lanzamientos: _i(j['lanzamientos']),
        era: _d(j['era']),
        whip: _d(j['whip']),
        k9: _d(j['k9']),
        bb9: _d(j['bb9']),
        promedioContra: _d(j['promedioContra']),
      );

  final int juegos, iniciados, ganados, perdidos, outs, bateadores, hits, carreras, limpias, bb, hbp, so, hr;
  final int lanzamientos;

  /// Entradas lanzadas en formato de béisbol ("5.2" = 5 entradas y 2 outs).
  final String ip;
  final double era, whip, k9, bb9, promedioContra;
}

/// CifrasBateo y pitcheo de un periodo (null = no tiene datos de eso).
class BloqueEstadisticas {
  const BloqueEstadisticas({this.bateo, this.pitcheo});

  factory BloqueEstadisticas.fromJson(Map<String, dynamic>? j) => BloqueEstadisticas(
        bateo: j?['bateo'] == null ? null : CifrasBateo.fromJson(j!['bateo'] as Map<String, dynamic>),
        pitcheo: j?['pitcheo'] == null ? null : CifrasPitcheo.fromJson(j!['pitcheo'] as Map<String, dynamic>),
      );

  final CifrasBateo? bateo;
  final CifrasPitcheo? pitcheo;

  bool get vacio => bateo == null && pitcheo == null;
}

class EstadisticasJugador {
  const EstadisticasJugador({required this.temporada, required this.carrera});

  factory EstadisticasJugador.fromJson(Map<String, dynamic> j) => EstadisticasJugador(
        temporada: BloqueEstadisticas.fromJson(j['temporada'] as Map<String, dynamic>?),
        carrera: BloqueEstadisticas.fromJson(j['carrera'] as Map<String, dynamic>?),
      );

  final BloqueEstadisticas temporada;
  final BloqueEstadisticas carrera;
}

class FilaBateo {
  const FilaBateo({required this.jugador, this.equipo, required this.bateo});

  factory FilaBateo.fromJson(Map<String, dynamic> j) => FilaBateo(
        jugador: JugadorResumenLiga.fromJson(j['jugador'] as Map<String, dynamic>),
        equipo: j['equipo'] == null ? null : EquipoRefLiga.fromJson(j['equipo'] as Map<String, dynamic>),
        bateo: CifrasBateo.fromJson(j['bateo'] as Map<String, dynamic>),
      );

  final JugadorResumenLiga jugador;
  final EquipoRefLiga? equipo;
  final CifrasBateo bateo;
}

class FilaPitcheo {
  const FilaPitcheo({required this.jugador, this.equipo, required this.pitcheo});

  factory FilaPitcheo.fromJson(Map<String, dynamic> j) => FilaPitcheo(
        jugador: JugadorResumenLiga.fromJson(j['jugador'] as Map<String, dynamic>),
        equipo: j['equipo'] == null ? null : EquipoRefLiga.fromJson(j['equipo'] as Map<String, dynamic>),
        pitcheo: CifrasPitcheo.fromJson(j['pitcheo'] as Map<String, dynamic>),
      );

  final JugadorResumenLiga jugador;
  final EquipoRefLiga? equipo;
  final CifrasPitcheo pitcheo;
}

class TurnoHistorial {
  const TurnoHistorial({
    required this.fecha,
    required this.entrada,
    required this.mitad,
    required this.descripcion,
    required this.carreras,
  });

  factory TurnoHistorial.fromJson(Map<String, dynamic> j) => TurnoHistorial(
        fecha: DateTime.tryParse(j['fecha'] as String? ?? '') ?? DateTime(2000),
        entrada: _i(j['entrada']),
        mitad: j['mitad'] == 'BOTTOM' ? MitadEntrada.baja : MitadEntrada.alta,
        descripcion: j['descripcion'] as String? ?? '',
        carreras: _i(j['carreras']),
      );

  final DateTime fecha;
  final int entrada;
  final MitadEntrada mitad;
  final String descripcion;
  final int carreras;
}

/// Probabilidades 0..1 para el próximo turno.
class PronosticoTurno {
  const PronosticoTurno({
    required this.hit,
    required this.embasarse,
    required this.ponche,
    required this.turnosDirectos,
    required this.resumen,
  });

  factory PronosticoTurno.fromJson(Map<String, dynamic> j) => PronosticoTurno(
        hit: _d(j['hit']),
        embasarse: _d(j['embasarse']),
        ponche: _d(j['ponche']),
        turnosDirectos: _i(j['turnosDirectos']),
        resumen: j['resumen'] as String? ?? '',
      );

  final double hit, embasarse, ponche;
  final int turnosDirectos;
  final String resumen;
}

class Enfrentamiento {
  const Enfrentamiento({
    required this.bateador,
    required this.lanzador,
    this.historial,
    this.turnos = const [],
    required this.pronostico,
  });

  factory Enfrentamiento.fromJson(Map<String, dynamic> j) => Enfrentamiento(
        bateador: JugadorResumenLiga.fromJson(j['bateador'] as Map<String, dynamic>),
        lanzador: JugadorResumenLiga.fromJson(j['lanzador'] as Map<String, dynamic>),
        historial: j['historial'] == null ? null : CifrasBateo.fromJson(j['historial'] as Map<String, dynamic>),
        turnos: [for (final t in (j['turnos'] as List? ?? const [])) TurnoHistorial.fromJson(t as Map<String, dynamic>)],
        pronostico: PronosticoTurno.fromJson(j['pronostico'] as Map<String, dynamic>),
      );

  final JugadorResumenLiga bateador;
  final JugadorResumenLiga lanzador;

  /// null = nunca se han enfrentado.
  final CifrasBateo? historial;
  final List<TurnoHistorial> turnos;
  final PronosticoTurno pronostico;

  /// "1-3, 1 HR, 1 K" (o "Primer enfrentamiento").
  String get lineaHistorial {
    final h = historial;
    if (h == null || h.pa == 0) return 'Primer enfrentamiento';
    return [
      '${h.h}-${h.ab}',
      if (h.hr > 0) '${h.hr} HR',
      if (h.rbi > 0) '${h.rbi} RBI',
      if (h.bb > 0) '${h.bb} BB',
      if (h.so > 0) '${h.so} K',
    ].join(', ');
  }
}

class EstadisticasRepositorio {
  EstadisticasRepositorio(this._api);

  final ClienteApi _api;

  Future<EstadisticasJugador> deJugador(int temporada, int jugador) async => EstadisticasJugador.fromJson(
      await _api.get('/temporadas/$temporada/jugadores/$jugador/estadisticas') as Map<String, dynamic>);

  Future<List<FilaBateo>> bateo(int temporada) async => [
        for (final f in await _api.get('/temporadas/$temporada/estadisticas/bateo') as List)
          FilaBateo.fromJson(f as Map<String, dynamic>),
      ];

  Future<List<FilaPitcheo>> pitcheo(int temporada) async => [
        for (final f in await _api.get('/temporadas/$temporada/estadisticas/pitcheo') as List)
          FilaPitcheo.fromJson(f as Map<String, dynamic>),
      ];

  Future<Enfrentamiento> enfrentamiento(int bateador, int lanzador, {int? temporada}) async =>
      Enfrentamiento.fromJson(await _api.get('/enfrentamientos', query: {
        'bateadorId': bateador,
        'lanzadorId': lanzador,
        'temporadaId': ?temporada,
      }) as Map<String, dynamic>);
}

final estadisticasRepositorioProvider =
    Provider<EstadisticasRepositorio>((ref) => EstadisticasRepositorio(ref.watch(clienteApiProvider)));

/// (temporada, jugador)
final estadisticasJugadorProvider = FutureProvider.autoDispose.family<EstadisticasJugador, (int, int)>(
    (ref, c) => ref.watch(estadisticasRepositorioProvider).deJugador(c.$1, c.$2));

final bateoTemporadaProvider = FutureProvider.autoDispose
    .family<List<FilaBateo>, int>((ref, t) => ref.watch(estadisticasRepositorioProvider).bateo(t));

final pitcheoTemporadaProvider = FutureProvider.autoDispose
    .family<List<FilaPitcheo>, int>((ref, t) => ref.watch(estadisticasRepositorioProvider).pitcheo(t));

/// (bateador, lanzador, temporada)
final enfrentamientoProvider = FutureProvider.autoDispose.family<Enfrentamiento, (int, int, int?)>(
    (ref, c) => ref.watch(estadisticasRepositorioProvider).enfrentamiento(c.$1, c.$2, temporada: c.$3));
