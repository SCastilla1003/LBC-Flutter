import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/features/admin/presentacion/admin_alineacion_pantalla.dart';
import 'package:lbc_app/liga/datos/liga_repositorio.dart';

/// Servidor simulado que guarda las peticiones.
class _Servidor implements HttpClientAdapter {
  _Servidor(this.respuesta);

  final Object? Function(RequestOptions o) respuesta;
  final peticiones = <(String, String, Object?)>[];

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    final datos = o.data is String ? jsonDecode(o.data as String) : o.data;
    peticiones.add((o.method, o.path, datos));
    return ResponseBody.fromString(jsonEncode(respuesta(o)), 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

Map<String, dynamic> _eq(int id, String n, String a) => {'id': id, 'nombre': n, 'abreviatura': a};

/// Jugadores 100..109 del local y 200..209 de la visita; el primero de cada uno lanza.
Map<String, dynamic> _jug(int id) =>
    {'id': id, 'nombres': 'J$id', 'apellidos': 'A$id', 'batea': 'D', 'lanza': id % 100 == 0 ? 'D' : null};

List<Map<String, dynamic>> _plantilla(int base) => [
      for (var i = 0; i < 11; i++) {'id': base + i, 'jugador': _jug(base + i), 'numero': i + 1},
    ];

const _posiciones = ['C', '1B', '2B', '3B', 'SS', 'LF', 'CF', 'RF', 'DH'];

Map<String, dynamic> _equipoAlineacion(int base, {required bool completo}) => {
      'equipo': _eq(base ~/ 100, 'Equipo $base', 'E$base'),
      'lanzadorInicial': _jug(base),
      'bateo': [
        for (var i = 0; i < (completo ? 9 : 4); i++)
          {'orden': i + 1, 'posicion': _posiciones[i], 'jugador': _jug(base + 1 + i)},
      ],
      'banca': completo ? [_jug(base + 10)] : [],
    };

Object? Function(RequestOptions) _api({required bool completo, String estado = 'SCHEDULED'}) => (o) {
      if (o.path == '/partidos/9') {
        return {
          'id': 9,
          'temporadaId': 1,
          'fechaHora': '2026-02-07T15:00',
          'estado': estado,
          'equipoLocal': _eq(1, 'Pelícanos de Bocagrande', 'PEL'),
          'equipoVisita': _eq(2, 'Corsarios de Turbaco', 'COR'),
          'marcador': {'local': 0, 'visita': 0},
          'entradasProgramadas': 9,
          'entradaActual': 1,
          'lineScore': {'entradasProgramadas': 9, 'entradas': []},
        };
      }
      if (o.path == '/temporadas/1/equipos/1/plantilla') return _plantilla(100);
      if (o.path == '/temporadas/1/equipos/2/plantilla') return _plantilla(200);
      // GET y PUT de la alineación devuelven lo mismo.
      return {
        'publicada': false,
        'local': _equipoAlineacion(100, completo: completo),
        'visita': _equipoAlineacion(200, completo: completo),
      };
    };

(Widget, _Servidor) _app(Object? Function(RequestOptions) api, ThemeData tema) {
  final servidor = _Servidor(api);
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = servidor;
  return (
    ProviderScope(
      overrides: [ligaRepositorioProvider.overrideWithValue(LigaRepositorio(ClienteApi(dio)))],
      child: MaterialApp(
        theme: tema,
        locale: const Locale('es'),
        supportedLocales: const [Locale('es')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const AdminAlineacionPantalla(idTemporada: 1, idPartido: 9),
      ),
    ),
    servidor,
  );
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  group('reglas de la alineación', () {
    EquipoEditable completo() {
      final e = EquipoEditable()..lanzador = 1;
      for (var i = 0; i < 9; i++) {
        e.jugadores[i] = 10 + i;
        e.posiciones[i] = _posiciones[i];
      }
      return e;
    }

    test('una alineación completa no tiene errores y se envía con orden 1..9', () {
      final e = completo()..banca.add(30);
      expect(e.errores(publicar: true, equipo: 'X', nombres: {}), isEmpty);
      final json = e.datos().json();
      expect(json['lanzadorInicial'], 1);
      expect((json['bateo'] as List).map((b) => b['orden']), [1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(json['banca'], [30]);
    });

    test('para publicar faltan bateadores y lanzador; el borrador sí se puede guardar', () {
      final e = EquipoEditable()
        ..jugadores[0] = 10
        ..posiciones[0] = 'CF';
      expect(e.errores(publicar: false, equipo: 'X', nombres: {}), isEmpty);
      expect(
        e.errores(publicar: true, equipo: 'X', nombres: {}),
        containsAll(['X: faltan bateadores (deben ser 9).', 'X: falta el lanzador inicial.']),
      );
    });

    test('repetidos, turno a medias y P de alguien que no es el lanzador', () {
      final e = completo()
        ..jugadores[1] = 10 // repite al del turno 1
        ..posiciones[2] = null // turno 3 sin posición
        ..posiciones[3] = 'P'; // P sin ser el lanzador
      final errores = e.errores(publicar: false, equipo: 'X', nombres: {10: 'Luis Calvo'});
      expect(errores, contains('X: Luis Calvo está dos veces en el orden de bateo.'));
      expect(errores, contains('X, turno 3: falta la posición.'));
      expect(errores, contains('X, turno 4: la posición P solo puede ser del lanzador inicial.'));
    });

    test('quien pasa a titular sale de la banca', () {
      final e = completo()..banca.addAll([1, 10, 30]);
      e.limpiarBanca();
      expect(e.banca, {30});
    });
  });

  testWidgets('publicar una alineación completa envía los dos equipos', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (app, servidor) = _app(_api(completo: true), TemaLbc.claro());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Publicar alineación'));
    await tester.pumpAndSettle();

    final put = servidor.peticiones.where((p) => p.$1 == 'PUT').single;
    expect(put.$2, '/partidos/9/alineacion');
    final cuerpo = put.$3! as Map<String, dynamic>;
    expect(cuerpo['publicar'], isTrue);
    expect(cuerpo['local']['lanzadorInicial'], 100);
    expect(cuerpo['visita']['lanzadorInicial'], 200);
    expect((cuerpo['local']['bateo'] as List).length, 9);
    expect(cuerpo['local']['banca'], [110]);
    expect(find.text('Alineación publicada'), findsOneWidget);
  });

  testWidgets('una alineación incompleta no se publica: avisa qué falta', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (app, servidor) = _app(_api(completo: false), TemaLbc.oscuro());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Publicar alineación'));
    await tester.pumpAndSettle();
    expect(find.text('Para publicarla falta completar la alineación'), findsOneWidget);
    expect(servidor.peticiones.where((p) => p.$1 == 'PUT'), isEmpty);

    // El borrador sí se guarda.
    await tester.tap(find.text('Entendido'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    final put = servidor.peticiones.where((p) => p.$1 == 'PUT').single;
    expect((put.$3! as Map)['publicar'], isFalse);
  });

  testWidgets('con el partido en vivo la alineación es de solo lectura', (tester) async {
    final (app, _) = _app(_api(completo: true, estado: 'LIVE'), TemaLbc.claro());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    expect(find.text('El partido ya empezó: la alineación ya no se puede cambiar.'), findsOneWidget);
    expect(find.text('Publicar alineación'), findsNothing);
  });
}
