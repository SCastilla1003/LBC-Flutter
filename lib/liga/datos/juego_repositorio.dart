import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/red/cliente_api.dart';
import 'modelos_liga.dart';

/// Resultado de una jugada, con su nombre en la API y cómo se muestra.
enum ResultadoJugada {
  sencillo('SINGLE', 'Sencillo', '1B'),
  doble('DOUBLE', 'Doble', '2B'),
  triple('TRIPLE', 'Triple', '3B'),
  jonron('HOME_RUN', 'Jonrón', 'HR'),
  basePorBolas('WALK', 'Base por bolas', 'BB'),
  golpeado('HIT_BY_PITCH', 'Golpeado', 'HBP'),
  ponche('STRIKEOUT', 'Ponche', 'K'),
  rolata('GROUND_OUT', 'Rolata', 'GO'),
  elevado('FLY_OUT', 'Elevado', 'FO'),
  linea('LINE_OUT', 'Línea', 'LO'),
  globo('POP_OUT', 'Globo', 'PO'),
  bolaOcupada('FIELDERS_CHOICE', 'Bola ocupada', 'FC'),
  error('REACHED_ON_ERROR', 'Error', 'E'),
  toqueSacrificio('SACRIFICE_BUNT', 'Toque de sacrificio', 'SH'),
  elevadoSacrificio('SACRIFICE_FLY', 'Elevado de sacrificio', 'SF'),
  doblePlay('DOUBLE_PLAY', 'Doble play', 'DP'),
  baseRobada('STOLEN_BASE', 'Base robada', 'SB'),
  atrapadoRobando('CAUGHT_STEALING', 'Atrapado robando', 'CS'),
  descontrolado('WILD_PITCH', 'Lanzamiento descontrolado', 'WP'),
  passedBall('PASSED_BALL', 'Passed ball', 'PB'),
  balk('BALK', 'Balk', 'BK');

  const ResultadoJugada(this.api, this.etiqueta, this.sigla);

  final String api;
  final String etiqueta;
  final String sigla;

  /// No cierran el turno del bateador: solo se mueven corredores.
  bool get deCorredores => const {baseRobada, atrapadoRobando, descontrolado, passedBall, balk}.contains(this);

  /// El bateador llega a base sí o sí.
  bool get bateadorASalvo =>
      const {sencillo, doble, triple, jonron, basePorBolas, golpeado, error, bolaOcupada}.contains(this);

  /// Base mínima del bateador cuando llega a salvo.
  int get baseMinima => switch (this) {
        doble => 2,
        triple => 3,
        jonron => 4,
        _ => 1,
      };
}

/// Lanzamiento que no cierra la jugada por sí solo.
enum TipoLanzamiento {
  bola('BALL', 'Bola'),
  strikeCantado('CALLED_STRIKE', 'Strike cantado'),
  strikeTirandole('SWINGING_STRIKE', 'Strike tirándole'),
  foul('FOUL', 'Foul');

  const TipoLanzamiento(this.api, this.etiqueta);

  final String api;
  final String etiqueta;
}

enum TipoCambio {
  emergente('PINCH_HITTER', 'Bateador emergente'),
  corredorEmergente('PINCH_RUNNER', 'Corredor emergente'),
  lanzador('PITCHER', 'Cambio de lanzador'),
  defensivo('DEFENSIVE', 'Cambio defensivo');

  const TipoCambio(this.api, this.etiqueta);

  final String api;
  final String etiqueta;
}

/// Qué pasó con un corredor (desde 0 = bateador). hasta: 1..3 base, 4 anota, null out.
typedef Movimiento = ({int desde, int? hasta});

/// Avance típico de cada jugada (la API usa la misma regla). [bases] índices 1..3.
List<Movimiento> movimientosPorDefecto(List<int?> bases, ResultadoJugada r) {
  final b = bases;
  final m = <Movimiento>[];
  void todosAvanzan(int n) {
    for (var base = 3; base >= 1; base--) {
      if (b[base] != null) m.add((desde: base, hasta: min(4, base + n)));
    }
  }

  int lider() {
    for (var base = 3; base >= 1; base--) {
      if (b[base] != null) return base;
    }
    return 0;
  }

  switch (r) {
    case ResultadoJugada.sencillo || ResultadoJugada.error:
      m.add((desde: 0, hasta: 1));
      todosAvanzan(1);
    case ResultadoJugada.doble:
      m.add((desde: 0, hasta: 2));
      todosAvanzan(2);
    case ResultadoJugada.triple:
      m.add((desde: 0, hasta: 3));
      todosAvanzan(3);
    case ResultadoJugada.jonron:
      m.add((desde: 0, hasta: 4));
      todosAvanzan(4);
    case ResultadoJugada.basePorBolas || ResultadoJugada.golpeado:
      m.add((desde: 0, hasta: 1));
      if (b[1] != null) {
        m.add((desde: 1, hasta: 2));
        if (b[2] != null) {
          m.add((desde: 2, hasta: 3));
          if (b[3] != null) m.add((desde: 3, hasta: 4));
        }
      }
    case ResultadoJugada.ponche ||
          ResultadoJugada.elevado ||
          ResultadoJugada.linea ||
          ResultadoJugada.globo ||
          ResultadoJugada.rolata:
      m.add((desde: 0, hasta: null));
    case ResultadoJugada.elevadoSacrificio:
      m.add((desde: 0, hasta: null));
      if (b[3] != null) m.add((desde: 3, hasta: 4));
    case ResultadoJugada.toqueSacrificio:
      m.add((desde: 0, hasta: null));
      todosAvanzan(1);
    case ResultadoJugada.bolaOcupada:
      m.add((desde: 0, hasta: 1));
      if (b[1] != null) {
        m.add((desde: 1, hasta: null));
        if (b[2] != null) {
          m.add((desde: 2, hasta: 3));
          if (b[3] != null) m.add((desde: 3, hasta: 4));
        }
      } else if (lider() > 0) {
        m.add((desde: lider(), hasta: null));
      }
    case ResultadoJugada.doblePlay:
      m.add((desde: 0, hasta: null));
      final primero = b[1] != null ? 1 : lider();
      if (primero > 0) m.add((desde: primero, hasta: null));
    case ResultadoJugada.baseRobada || ResultadoJugada.atrapadoRobando:
      final quien = b[2] != null && b[3] == null
          ? 2
          : b[1] != null && b[2] == null
              ? 1
              : lider();
      if (quien > 0) {
        m.add((desde: quien, hasta: r == ResultadoJugada.baseRobada ? quien + 1 : null));
      }
    case ResultadoJugada.descontrolado || ResultadoJugada.passedBall || ResultadoJugada.balk:
      todosAvanzan(1);
  }
  return m;
}

/// Turno del orden de bateo actual.
class TurnoJuego {
  const TurnoJuego({required this.orden, this.posicion, this.jugador});

  factory TurnoJuego.fromJson(Map<String, dynamic> j) => TurnoJuego(
        orden: (j['orden'] as num).toInt(),
        posicion: j['posicion'] as String?,
        jugador: j['jugador'] == null ? null : JugadorResumenLiga.fromJson(j['jugador'] as Map<String, dynamic>),
      );

  final int orden;
  final String? posicion;
  final JugadorResumenLiga? jugador;
}

class EquipoJuego {
  const EquipoJuego({
    required this.equipo,
    required this.orden,
    required this.proximo,
    this.lanzador,
    this.lanzamientos = 0,
    this.disponibles = const [],
  });

  factory EquipoJuego.fromJson(Map<String, dynamic> j) => EquipoJuego(
        equipo: EquipoRefLiga.fromJson(j['equipo'] as Map<String, dynamic>),
        orden: [for (final t in (j['orden'] as List? ?? const [])) TurnoJuego.fromJson(t as Map<String, dynamic>)],
        proximo: (j['proximo'] as num?)?.toInt() ?? 1,
        lanzador: j['lanzador'] == null ? null : JugadorResumenLiga.fromJson(j['lanzador'] as Map<String, dynamic>),
        lanzamientos: (j['lanzamientos'] as num?)?.toInt() ?? 0,
        disponibles: [
          for (final d in (j['disponibles'] as List? ?? const []))
            JugadorResumenLiga.fromJson(d as Map<String, dynamic>),
        ],
      );

  final EquipoRefLiga equipo;
  final List<TurnoJuego> orden;

  /// Turno (1..9) del próximo bateador de este equipo.
  final int proximo;
  final JugadorResumenLiga? lanzador;
  final int lanzamientos;

  /// Jugadores del roster que pueden entrar de cambio.
  final List<JugadorResumenLiga> disponibles;

  /// Jugadores en el terreno: el orden de bateo y el lanzador.
  List<JugadorResumenLiga> get enJuego => [
        for (final t in orden) ?t.jugador,
        if (lanzador != null && !orden.any((t) => t.jugador?.id == lanzador!.id)) lanzador!,
      ];
}

/// Una línea del jugada a jugada.
class AccionJuego {
  const AccionJuego({
    required this.id,
    required this.tipo,
    required this.descripcion,
    required this.entrada,
    required this.mitad,
  });

  factory AccionJuego.fromJson(Map<String, dynamic> j) => AccionJuego(
        id: (j['id'] as num).toInt(),
        tipo: j['tipo'] as String? ?? '',
        descripcion: j['descripcion'] as String? ?? '',
        entrada: (j['entrada'] as num?)?.toInt() ?? 1,
        mitad: j['mitad'] == 'BOTTOM' ? MitadEntrada.baja : MitadEntrada.alta,
      );

  final int id;
  final String tipo;
  final String descripcion;
  final int entrada;
  final MitadEntrada mitad;
}

/// Lo que devuelve `GET /partidos/{id}/juego` y cada acción del anotador.
class EstadoJuego {
  const EstadoJuego({
    required this.partido,
    required this.local,
    required this.visita,
    required this.alineacionCompleta,
    this.faltantes = const [],
    this.puedeDeshacer = false,
    this.jugadas = const [],
  });

  factory EstadoJuego.fromJson(Map<String, dynamic> j) => EstadoJuego(
        partido: PartidoDetalle.fromJson(j['partido'] as Map<String, dynamic>),
        local: EquipoJuego.fromJson(j['local'] as Map<String, dynamic>),
        visita: EquipoJuego.fromJson(j['visita'] as Map<String, dynamic>),
        alineacionCompleta: j['alineacionCompleta'] as bool? ?? false,
        faltantes: [for (final f in (j['faltantes'] as List? ?? const [])) f as String],
        puedeDeshacer: j['puedeDeshacer'] as bool? ?? false,
        jugadas: [for (final a in (j['jugadas'] as List? ?? const [])) AccionJuego.fromJson(a as Map<String, dynamic>)],
      );

  final PartidoDetalle partido;
  final EquipoJuego local;
  final EquipoJuego visita;
  final bool alineacionCompleta;
  final List<String> faltantes;
  final bool puedeDeshacer;
  final List<AccionJuego> jugadas;

  bool get bateaLocal => partido.mitad == MitadEntrada.baja;
  EquipoJuego get ofensiva => bateaLocal ? local : visita;
  EquipoJuego get defensa => bateaLocal ? visita : local;

  /// Corredores por base (índices 1..3).
  List<int?> get bases {
    final c = partido.situacion?.corredores;
    return [null, c?.primera?.id, c?.segunda?.id, c?.tercera?.id];
  }

  /// Nombre de un jugador del partido.
  String nombre(int? id) {
    if (id == null) return '';
    for (final e in [local, visita]) {
      for (final j in [...e.enJuego, ...e.disponibles]) {
        if (j.id == id) return '${j.nombres} ${j.apellidos}';
      }
    }
    final c = partido.situacion?.corredores;
    for (final r in [partido.situacion?.bateador, c?.primera, c?.segunda, c?.tercera]) {
      if (r?.id == id) return r!.nombre;
    }
    return '';
  }
}

/// UUID v4 para que un reintento no se aplique dos veces en la API.
String nuevoCommandId() {
  final r = Random.secure();
  final b = List<int>.generate(16, (_) => r.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40;
  b[8] = (b[8] & 0x3f) | 0x80;
  final h = b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
  return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
}

class JuegoRepositorio {
  JuegoRepositorio(this._api);

  final ClienteApi _api;

  Future<EstadoJuego> _leer(Future<dynamic> f) async => EstadoJuego.fromJson(await f as Map<String, dynamic>);

  Future<EstadoJuego> estado(int partido) => _leer(_api.get('/partidos/$partido/juego'));

  Future<EstadoJuego> _accion(int partido, String ruta, [Map<String, dynamic> datos = const {}]) =>
      _leer(_api.post('/partidos/$partido/juego/$ruta', {'commandId': nuevoCommandId(), ...datos}));

  Future<EstadoJuego> iniciar(int partido) => _accion(partido, 'iniciar');

  Future<EstadoJuego> lanzamiento(int partido, TipoLanzamiento tipo) =>
      _accion(partido, 'lanzamiento', {'tipo': tipo.api});

  /// [movimientos] null = avance típico.
  Future<EstadoJuego> jugada(int partido, ResultadoJugada r, {List<Movimiento>? movimientos, int errores = 0}) =>
      _accion(partido, 'jugada', {
        'resultado': r.api,
        'movimientos': movimientos == null ? null : [for (final m in movimientos) {'desde': m.desde, 'hasta': m.hasta}],
        'errores': errores,
      });

  Future<EstadoJuego> cambio(
    int partido, {
    required TipoCambio tipo,
    required bool local,
    required int saleId,
    required int entraId,
    String? posicion,
  }) =>
      _accion(partido, 'cambio', {
        'tipo': tipo.api,
        'local': local,
        'saleId': saleId,
        'entraId': entraId,
        'posicion': posicion,
      });

  Future<EstadoJuego> deshacer(int partido) => _leer(_api.post('/partidos/$partido/juego/deshacer'));

  Future<EstadoJuego> finalizar(int partido) => _accion(partido, 'finalizar');

  Future<EstadoJuego> suspender(int partido) => _accion(partido, 'suspender');

  Future<EstadoJuego> reanudar(int partido) => _accion(partido, 'reanudar');
}

final juegoRepositorioProvider = Provider<JuegoRepositorio>((ref) => JuegoRepositorio(ref.watch(clienteApiProvider)));

final estadoJuegoProvider =
    FutureProvider.autoDispose.family<EstadoJuego, int>((ref, id) => ref.watch(juegoRepositorioProvider).estado(id));
