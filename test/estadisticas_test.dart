import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lbc_app/core/charts/barras_enfrentadas.dart';
import 'package:lbc_app/core/charts/diamante_bases.dart';
import 'package:lbc_app/core/charts/medidor.dart';
import 'package:lbc_app/core/charts/nube_liga.dart';
import 'package:lbc_app/core/charts/radar_comparativo.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/features/comparador/presentacion/comparador_pantalla.dart';
import 'package:lbc_app/features/prediccion/presentacion/enfrentamiento_pantalla.dart';
import 'package:lbc_app/liga/datos/estadisticas_repositorio.dart';
import 'package:lbc_app/liga/presentacion/jugador_liga_pantalla.dart';

class _Api implements HttpClientAdapter {
  _Api(this.rutas);

  final Map<String, Object> rutas;
  final pedidas = <Uri>[];

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    pedidas.add(o.uri);
    final datos = rutas[o.path];
    return ResponseBody.fromString(
      jsonEncode(datos ?? {'codigo': 'NO_ENCONTRADO', 'mensaje': 'No existe'}),
      datos == null ? 404 : 200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Future<_Api> _pintar(
  WidgetTester t,
  Widget pantalla,
  Map<String, Object> rutas, {
  ThemeData? tema,
  GoRouter? enrutador,
  double alto = 1600,
}) async {
  t.view.physicalSize = Size(375, alto);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final api = _Api(rutas);
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = api;
  await t.pumpWidget(ProviderScope(
    overrides: [clienteApiProvider.overrideWithValue(ClienteApi(dio))],
    child: MaterialApp.router(
      theme: tema ?? TemaLbc.claro(),
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: enrutador ?? GoRouter(routes: [GoRoute(path: '/', builder: (_, _) => pantalla)]),
    ),
  ));
  await t.pumpAndSettle();
  return api;
}

const _gray = {
  'id': 30,
  'nombres': 'Sonny',
  'apellidos': 'Gray',
  'fechaNacimiento': '1989-11-07',
  'edad': 37,
  'batea': 'D',
  'lanza': 'D',
  'esLanzador': true,
};
const _stanton = {'id': 27, 'nombres': 'Giancarlo', 'apellidos': 'Stanton', 'batea': 'D', 'lanza': 'D'};

const _pitcheo = {
  'juegos': 1, 'iniciados': 1, 'ganados': 1, 'perdidos': 0, 'outs': 17, 'ip': '5.2', 'hits': 4, 'carreras': 2,
  'limpias': 1, 'bb': 2, 'so': 7, 'hr': 1, 'lanzamientos': 88, 'era': 1.59, 'whip': 1.06, 'k9': 11.12,
  'bb9': 3.18, 'promedioContra': 0.2,
};
const _bateo = {
  'juegos': 1, 'pa': 4, 'ab': 3, 'h': 1, 'hr': 1, 'rbi': 2, 'sb': 0, 'bb': 1, 'so': 1, 'carreras': 1,
  'avg': 0.333, 'obp': 0.5, 'slg': 1.333, 'ops': 1.833,
};

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  test('promedios estilo béisbol', () {
    expect(promedio(0.256), ',256');
    expect(promedio(1), '1,000');
    expect(dosDecimales(3.456), '3,46');
  });

  for (final (nombre, tema) in [('claro', TemaLbc.claro()), ('oscuro', TemaLbc.oscuro())]) {
    testWidgets('perfil de un pitcher: rol, mano y estadísticas de temporada y carrera · $nombre', (t) async {
      await _pintar(t, const JugadorLigaPantalla(idTemporada: 1, idJugador: 30, idEquipo: 4), {
        '/jugadores/30': _gray,
        '/temporadas': [
          {'id': 1, 'nombre': 'Temporada', 'anio': 2026, 'estado': 'ACTIVE'},
        ],
        '/temporadas/1/equipos/4/plantilla': [
          {'id': 9, 'jugador': _gray, 'equipo': {'id': 4, 'nombre': 'Cincinnati Reds', 'abreviatura': 'CIN'}, 'numero': 54, 'posicion': 'P'},
        ],
        '/temporadas/1/jugadores/30/estadisticas': {
          'temporada': {'pitcheo': _pitcheo, 'bateo': null},
          'carrera': {'pitcheo': _pitcheo, 'bateo': null},
        },
      }, tema: tema);
      expect(t.takeException(), isNull);
      expect(find.text('Pitcher'), findsOneWidget);
      expect(find.text('Lanza (mano)'), findsOneWidget);
      expect(find.text('Lanzador · B/L: D/D · 37 años'), findsOneWidget);
      expect(find.text('7 nov 1989'), findsOneWidget);
      expect(find.text('Temporada 2026'), findsOneWidget);
      expect(find.text('1,59'), findsNWidgets(2)); // ERA de temporada y de carrera
      expect(find.text('5.2'), findsNWidgets(2));
      expect(find.text('1-0'), findsNWidgets(2));
      expect(find.text('BATEO'), findsNothing);
    });
  }

  testWidgets('jugador sin partidos anotados: lo explica', (t) async {
    await _pintar(t, const JugadorLigaPantalla(idTemporada: 1, idJugador: 27), {
      '/jugadores/27': _stanton,
      '/temporadas': <Object>[],
      '/temporadas/1/agentes-libres': <Object>[],
      '/temporadas/1/jugadores/27/estadisticas': {'temporada': {}, 'carrera': {}},
    });
    expect(find.textContaining('Todavía no tiene estadísticas'), findsOneWidget);
    expect(find.text('De posición'), findsOneWidget);
  });

  testWidgets('bateador vs lanzador: historial cara a cara y probabilidades', (t) async {
    final api = await _pintar(t, const Scaffold(body: PrediccionEnfrentamiento(bateador: 27, lanzador: 30)), {
      '/temporadas': [
        {'id': 1, 'nombre': 'Temporada', 'anio': 2026, 'estado': 'ACTIVE'},
      ],
      '/jugadores': [_stanton, _gray],
      '/enfrentamientos': {
        'bateador': _stanton,
        'lanzador': _gray,
        'historial': _bateo,
        'turnos': [
          {'fecha': '2026-11-28T08:00', 'entrada': 4, 'mitad': 'TOP', 'resultado': 'HOME_RUN', 'descripcion': '¡jonrón!', 'carreras': 2},
        ],
        'pronostico': {'hit': 0.274, 'embasarse': 0.351, 'ponche': 0.188, 'turnosDirectos': 4, 'resumen': 'Estimado con 4 apariciones.'},
      },
    });
    expect(t.takeException(), isNull);
    expect(find.text('Giancarlo Stanton'), findsOneWidget);
    expect(find.text('Sonny Gray'), findsOneWidget);
    expect(find.text('1-3, 1 HR, 2 RBI, 1 BB, 1 K'), findsOneWidget);
    expect(find.text('¡jonrón! (2 C)'), findsOneWidget);
    final medidores = t.widgetList<Medidor>(find.byType(Medidor)).toList();
    expect([for (final m in medidores) (m.etiqueta, m.valor!.round())], [('Hit', 27), ('Se embasa', 35), ('Ponche', 19)]);
    expect(find.text('Estimado con 4 apariciones.'), findsOneWidget);
    final pedida = api.pedidas.lastWhere((u) => u.path.endsWith('/enfrentamientos'));
    expect(pedida.queryParameters, {'bateadorId': '27', 'lanzadorId': '30', 'temporadaId': '1'});
  });

  Map<String, dynamic> filaBateo(Map<String, dynamic> j, Map<String, dynamic>? e, Map<String, Object> b) =>
      {'jugador': j, 'equipo': e, 'bateo': b};
  const yankees = {'id': 1, 'nombre': 'New York Yankees', 'abreviatura': 'NYY', 'color': 'azul'};
  const reds = {'id': 4, 'nombre': 'Cincinnati Reds', 'abreviatura': 'CIN', 'color': 'rojo'};
  final judge = {'id': 28, 'nombres': 'Aaron', 'apellidos': 'Judge', 'batea': 'D'};
  final votto = {'id': 29, 'nombres': 'Joey', 'apellidos': 'Votto', 'batea': 'Z'};
  final ligaBateo = [
    filaBateo(_stanton, yankees, _bateo),
    filaBateo(judge, yankees, {
      'juegos': 1, 'pa': 4, 'ab': 4, 'h': 2, 'dobles': 1, 'rbi': 1, 'so': 2, 'avg': 0.5, 'obp': 0.5, 'slg': 0.75,
      'ops': 1.25,
    }),
    filaBateo(votto, reds, {
      'juegos': 1, 'pa': 3, 'ab': 2, 'h': 0, 'bb': 1, 'so': 0, 'avg': 0.0, 'obp': 0.333, 'slg': 0.0, 'ops': 0.333,
    }),
  ];

  testWidgets('perfil de un bateador: radar, diamante, nube y comparar con otro', (t) async {
    final enrutador = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, _) => const JugadorLigaPantalla(idTemporada: 1, idJugador: 27, idEquipo: 1)),
      GoRoute(
        path: '/temporadas/:t/comparar/:tipo',
        builder: (_, s) =>
            Text('Comparar ${s.pathParameters['tipo']} ${s.uri.queryParameters['a']} vs ${s.uri.queryParameters['b']}'),
      ),
    ]);
    await _pintar(t, const SizedBox(), {
      '/jugadores/27': _stanton,
      '/temporadas': [
        {'id': 1, 'nombre': 'Temporada', 'anio': 2026, 'estado': 'ACTIVE'},
      ],
      '/temporadas/1/equipos/1/plantilla': [
        {'id': 3, 'jugador': _stanton, 'equipo': yankees, 'numero': 27, 'posicion': 'DH'},
      ],
      '/temporadas/1/jugadores/27/estadisticas': {
        'temporada': {'bateo': _bateo},
        'carrera': {'bateo': _bateo},
      },
      '/temporadas/1/estadisticas/bateo': ligaBateo,
    }, enrutador: enrutador, alto: 2600);
    expect(t.takeException(), isNull);
    expect(find.text('¿Dónde destaca?'), findsOneWidget);
    final radar = t.widget<RadarComparativo>(find.byType(RadarComparativo));
    expect(radar.ejes, ['AVG', 'OBP', 'SLG', 'HR', 'RBI', 'BB']);
    expect(radar.series.map((s) => s.nombre), ['Liga', 'Giancarlo']);
    expect(radar.series.last.valores[3], 1); // su jonrón
    final diamante = t.widget<DiamanteBases>(find.byType(DiamanteBases));
    expect((diamante.jonrones, diamante.totalBases), (1, 4));
    expect(t.widget<NubeLiga>(find.byType(NubeLiga)).puntos, hasLength(3));

    await t.tap(find.text('Comparar'));
    await t.pumpAndSettle();
    expect(find.text('Aaron Judge'), findsOneWidget);
    expect(find.text('Joey Votto'), findsOneWidget);
    await t.tap(find.text('Joey Votto'));
    await t.pumpAndSettle();
    expect(find.text('Comparar bateo 27 vs 29'), findsOneWidget);
  });

  for (final (nombre, tema) in [('claro', TemaLbc.claro()), ('oscuro', TemaLbc.oscuro())]) {
    testWidgets('cara a cara de dos bateadores con las estadísticas de la temporada · $nombre', (t) async {
      await _pintar(t, const ComparadorPantalla(idTemporada: 1, pitcheo: false, a: 27, b: 28), {
        '/temporadas/1/estadisticas/bateo': ligaBateo,
      }, tema: tema);
      expect(t.takeException(), isNull);
      expect(find.text('Giancarlo Stanton'), findsOneWidget);
      expect(find.text('Aaron Judge'), findsOneWidget);
      expect(t.widget<RadarComparativo>(find.byType(RadarComparativo)).series, hasLength(2));
      final duelos = t.widget<BarrasEnfrentadas>(find.byType(BarrasEnfrentadas)).duelos;
      expect(duelos.firstWhere((d) => d.etiqueta == 'Jonrones').ganador, -1);
      expect(duelos.firstWhere((d) => d.etiqueta == 'Promedio (AVG)').ganador, 1);
      expect(find.text(',333'), findsOneWidget);
    });
  }

  testWidgets('cara a cara de dos lanzadores', (t) async {
    await _pintar(t, const ComparadorPantalla(idTemporada: 1, pitcheo: true, a: 30, b: 31), {
      '/temporadas/1/estadisticas/pitcheo': [
        {'jugador': _gray, 'equipo': reds, 'pitcheo': _pitcheo},
        {
          'jugador': {'id': 31, 'nombres': 'Max', 'apellidos': 'Fried'},
          'equipo': yankees,
          'pitcheo': {..._pitcheo, 'outs': 3, 'ip': '1.0', 'era': 9.0, 'so': 2, 'ganados': 0},
        },
      ],
    });
    expect(t.takeException(), isNull);
    final duelos = t.widget<BarrasEnfrentadas>(find.byType(BarrasEnfrentadas)).duelos;
    expect(duelos.firstWhere((d) => d.etiqueta == 'Efectividad (ERA)').ganador, -1);
    expect(find.text('5.2'), findsOneWidget);
    expect(find.text('1.0'), findsOneWidget);
  });

  testWidgets('cara a cara sin estadísticas de uno de los dos: lo explica', (t) async {
    await _pintar(t, const ComparadorPantalla(idTemporada: 1, pitcheo: false, a: 27, b: 99), {
      '/temporadas/1/estadisticas/bateo': ligaBateo,
    });
    expect(find.textContaining('todavía no tiene estadísticas'), findsOneWidget);
  });
}
