import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/liga/datos/liga_repositorio.dart';
import 'package:lbc_app/liga/presentacion/partido_liga_pantalla.dart';
import 'package:lbc_app/liga/datos/juego_repositorio.dart';

Map<String, dynamic> _jugador(int id, String n, String a) => {'id': id, 'nombres': n, 'apellidos': a};

const _visita = {'id': 5, 'nombre': 'Corsarios de Turbaco', 'abreviatura': 'COR'};
const _local = {'id': 4, 'nombre': 'Pelícanos de Bocagrande', 'abreviatura': 'PEL'};

Map<String, dynamic> _equipo(Map<String, dynamic> eq, int base, {bool completo = true}) => {
      'equipo': eq,
      'orden': [
        for (var i = 1; i <= 9; i++)
          {
            'orden': i,
            'posicion': 'SS',
            'jugador': completo || i <= 5 ? _jugador(base + i, 'Jugador', '${base + i}') : null,
          },
      ],
      'proximo': 1,
      'lanzador': completo ? _jugador(base, 'Lanzador', '$base') : null,
      'lanzamientos': 12,
      'disponibles': [_jugador(base + 50, 'Suplente', '${base + 50}')],
    };

/// Estado del juego como lo devuelve la API.
Map<String, dynamic> _estado({
  String estado = 'LIVE',
  int bolas = 0,
  bool corredorEnPrimera = false,
  bool completo = true,
}) =>
    {
      'partido': {
        'id': 9,
        'temporadaId': 1,
        'fechaHora': '2026-12-05T15:00',
        'estado': estado,
        'equipoLocal': _local,
        'equipoVisita': _visita,
        'marcador': {'local': 0, 'visita': 1},
        'entradasProgramadas': 9,
        'entradaActual': 2,
        'mitad': 'TOP',
        'situacion': {
          'outs': 1,
          'bolas': bolas,
          'strikes': 1,
          'bateador': {'id': 102, 'nombre': 'Jugador 102'},
          'lanzador': {'id': 200, 'nombre': 'Lanzador 200'},
          'corredores': {'primera': corredorEnPrimera ? {'id': 101, 'nombre': 'Jugador 101'} : null},
        },
        'hits': {'local': 0, 'visita': 2},
        'errores': {'local': 0, 'visita': 0},
        'lineScore': {
          'entradasProgramadas': 9,
          'entradas': [
            {'numero': 1, 'local': 0, 'visita': 1},
          ],
        },
      },
      'visita': _equipo(_visita, 100, completo: completo),
      'local': _equipo(_local, 200),
      'alineacionCompleta': completo,
      'faltantes': completo ? <String>[] : ['Corsarios de Turbaco: 5 de 9 bateadores', 'Corsarios de Turbaco: falta el lanzador inicial'],
      'puedeDeshacer': estado != 'SCHEDULED',
      'jugadas': estado == 'SCHEDULED'
          ? <Object>[]
          : [
              {'id': 3, 'tipo': 'JUGADA', 'descripcion': 'Jugador 101: sencillo.', 'entrada': 2, 'mitad': 'TOP'},
            ],
    };


class _Api implements HttpClientAdapter {
  _Api(this.estado);

  Map<String, dynamic> estado;
  int pedidosJuego = 0;

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    if (o.path.endsWith('/juego')) pedidosJuego++;
    final r = o.path == '/enfrentamientos'
        ? {
            'bateador': _jugador(102, 'Jugador', '102'),
            'lanzador': _jugador(200, 'Lanzador', '200'),
            'historial': {'pa': 3, 'ab': 3, 'h': 1, 'hr': 1, 'avg': 0.333},
            'turnos': <Object>[],
            'pronostico': {'hit': 0.27, 'embasarse': 0.33, 'ponche': 0.2, 'turnosDirectos': 3, 'resumen': ''},
          }
        : o.path.endsWith('/juego')
            ? estado
            : estado['partido'];
    return ResponseBody.fromString(jsonEncode(r), 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

Future<_Api> _pintar(WidgetTester t, Map<String, dynamic> estado, {ThemeData? tema, double alto = 812, GoRouter? rutas}) async {
  t.view.physicalSize = Size(375, alto);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final api = _Api(estado);
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = api;
  final cliente = ClienteApi(dio);
  await t.pumpWidget(ProviderScope(
    overrides: [
      clienteApiProvider.overrideWithValue(cliente),
      ligaRepositorioProvider.overrideWithValue(LigaRepositorio(cliente)),
      juegoRepositorioProvider.overrideWithValue(JuegoRepositorio(cliente)),
    ],
    child: MaterialApp.router(
      theme: tema ?? TemaLbc.claro(),
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: rutas ??
          GoRouter(routes: [GoRoute(path: '/', builder: (_, _) => const PartidoLigaPantalla(idTemporada: 1, idPartido: 9))]),
    ),
  ));
  await t.pumpAndSettle();
  return api;
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  for (final (nombre, tema) in [('claro', TemaLbc.claro()), ('oscuro', TemaLbc.oscuro())]) {
    testWidgets('en vivo el aficionado ve entrada, conteo, el duelo y el jugada a jugada · $nombre', (t) async {
      final api = await _pintar(t, _estado(corredorEnPrimera: true, bolas: 2), tema: tema, alto: 1800);
      expect(t.takeException(), isNull);
      expect(find.text('Alta del 2'), findsOneWidget);
      expect(find.text('1 out'), findsOneWidget);
      expect(find.bySemanticsLabel('2 bolas, 1 strikes, 1 outs'), findsOneWidget);
      expect(find.text('AL BATE'), findsOneWidget);
      expect(find.text('LANZA'), findsOneWidget);
      expect(find.text('Jugador 102'), findsOneWidget);
      expect(find.text('Lanzador 200'), findsOneWidget);
      expect(find.text('PEL · 12 lanz.'), findsOneWidget);
      // Cara y nombre del corredor en primera y del próximo bateador.
      expect(find.text('Jugador 101'), findsOneWidget);
      expect(find.text('PRÓXIMO'), findsOneWidget);
      expect(find.text('Jugador 103'), findsOneWidget);
      expect(find.text('Jugada a jugada'), findsOneWidget);
      expect(find.text('Cara a cara: 1-3, 1 HR · Hit 27%'), findsOneWidget);
      expect(find.text('Jugador 101: sencillo.'), findsOneWidget);
      expect(api.pedidosJuego, 1);

      // Se refresca solo mientras está en vivo.
      await t.pump(const Duration(seconds: 7));
      await t.pumpAndSettle();
      expect(api.pedidosJuego, greaterThan(1));
      await t.pumpWidget(const SizedBox());
    });
  }

  double x(WidgetTester t, String texto) => t.getCenter(find.text(texto)).dx;

  testWidgets('el bateador sale en su caja: derecho a la izquierda, zurdo a la derecha', (t) async {
    final estado = _estado();
    await _pintar(t, estado, alto: 1800);
    expect(x(t, 'AL BATE'), lessThan(x(t, 'LANZA')));

    final orden = ((estado['visita'] as Map)['orden'] as List);
    (orden[1] as Map)['jugador'] = {..._jugador(102, 'Jugador', '102'), 'batea': 'Z'};
    await t.pumpWidget(const SizedBox());
    await _pintar(t, estado, alto: 1800);
    expect(x(t, 'AL BATE'), greaterThan(x(t, 'LANZA')));
    expect(find.bySemanticsLabel(RegExp('Batea a la zurda')), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });

  testWidgets('el próximo sale a la derecha si batea el visitante y a la izquierda si batea el local', (t) async {
    await _pintar(t, _estado(), alto: 1800);
    expect(x(t, 'PRÓXIMO'), greaterThan(x(t, 'LANZA')));
    await t.pumpWidget(const SizedBox());

    final abajo = _estado();
    (abajo['partido'] as Map)['mitad'] = 'BOTTOM';
    ((abajo['partido'] as Map)['situacion'] as Map)['bateador'] = {'id': 201, 'nombre': 'Jugador 201'};
    ((abajo['partido'] as Map)['situacion'] as Map)['lanzador'] = {'id': 100, 'nombre': 'Lanzador 100'};
    await _pintar(t, abajo, alto: 1800);
    expect(find.text('Jugador 202'), findsOneWidget);
    expect(x(t, 'PRÓXIMO'), lessThan(x(t, 'LANZA')));
    await t.pumpWidget(const SizedBox());
  });

  testWidgets('tocar la cara de un jugador en el campo abre su perfil', (t) async {
    await _pintar(t, _estado(corredorEnPrimera: true), alto: 1800, rutas: GoRouter(routes: [
      GoRoute(path: '/', builder: (_, _) => const PartidoLigaPantalla(idTemporada: 1, idPartido: 9)),
      GoRoute(
        path: '/temporadas/:t/jugadores/:j',
        builder: (_, s) => Text('Jugador ${s.pathParameters['j']} de ${s.uri.queryParameters['e']}'),
      ),
    ]));
    await t.tap(find.text('Jugador 101'));
    await t.pumpAndSettle();
    expect(find.text('Jugador 101 de 5'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });

  testWidgets('los lanzamientos se ven solo si se piden', (t) async {
    final estado = _estado();
    (estado['jugadas'] as List).insert(0, {'id': 4, 'tipo': 'LANZAMIENTO', 'descripcion': 'Bola a Jugador 102 (1-0)', 'entrada': 2, 'mitad': 'TOP'});
    await _pintar(t, estado, alto: 1800);
    expect(find.text('Bola a Jugador 102 (1-0)'), findsNothing);
    await t.tap(find.text('Lanzamientos'));
    await t.pumpAndSettle();
    expect(find.text('Bola a Jugador 102 (1-0)'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });

  testWidgets('tocar el escudo o el nombre de un equipo abre su página', (t) async {
    final rutas = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, _) => const PartidoLigaPantalla(idTemporada: 1, idPartido: 9)),
      GoRoute(
        path: '/temporadas/:t/equipos/:e',
        builder: (_, s) => Text('Equipo ${s.pathParameters['e']} de la temporada ${s.pathParameters['t']}'),
      ),
    ]);
    await _pintar(t, _estado(), alto: 1800, rutas: rutas);
    await t.tap(find.text('Corsarios de Turbaco').first);
    await t.pumpAndSettle();
    expect(find.text('Equipo 5 de la temporada 1'), findsOneWidget);

    rutas.pop();
    await t.pumpAndSettle();
    await t.tap(find.bySemanticsLabel('Ver Pelícanos de Bocagrande'));
    await t.pumpAndSettle();
    expect(find.text('Equipo 4 de la temporada 1'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });

  testWidgets('walk off: el aficionado ve el letrero; detenido: ve el motivo', (t) async {
    final fin = _estado(estado: 'FINISHED');
    (fin['partido'] as Map)
      ..['marcador'] = {'local': 5, 'visita': 1}
      ..['finalEspecial'] = 'WALK_OFF_GRAND_SLAM';
    await _pintar(t, fin, alto: 1800);
    expect(find.text('WALK OFF GRAND SLAM'), findsOneWidget);
    expect(find.text('¡Pelícanos de Bocagrande lo deja en el terreno!'), findsOneWidget);
    await t.pumpWidget(const SizedBox());

    final detenido = _estado(estado: 'SUSPENDED');
    (detenido['partido'] as Map)['motivo'] = 'POSPUESTO';
    await _pintar(t, detenido, alto: 1800);
    expect(find.text('POSPUESTO'), findsWidgets);
    expect(find.text('Partido pospuesto'), findsOneWidget);
    expect(find.textContaining('El administrador decidirá'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });

  testWidgets('programado: no pide el estado del juego ni muestra el duelo', (t) async {
    final api = await _pintar(t, _estado(estado: 'SCHEDULED'));
    expect(api.pedidosJuego, 0);
    expect(find.text('AL BATE'), findsNothing);
    expect(find.text('VS'), findsOneWidget);
  });
}
