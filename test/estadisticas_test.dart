import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lbc_app/core/charts/medidor.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
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

Future<_Api> _pintar(WidgetTester t, Widget pantalla, Map<String, Object> rutas, {ThemeData? tema}) async {
  t.view.physicalSize = const Size(375, 1600);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final api = _Api(rutas);
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = api;
  await t.pumpWidget(ProviderScope(
    overrides: [clienteApiProvider.overrideWithValue(ClienteApi(dio))],
    child: MaterialApp(
      theme: tema ?? TemaLbc.claro(),
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: pantalla,
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
}
