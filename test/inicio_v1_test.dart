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
import 'package:lbc_app/features/jugadores/presentacion/lideres_pantalla.dart';
import 'package:lbc_app/features/temporadas/presentacion/inicio_pantalla.dart';
import 'package:lbc_app/liga/datos/liga_repositorio.dart';
import 'package:lbc_app/liga/presentacion/equipo_liga_pantalla.dart';

/// API simulada con las respuestas del contrato v1.
class _Api implements HttpClientAdapter {
  _Api(this.rutas);

  final Map<String, Object> rutas;

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
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

/// La temporada que creó el panel en producción: "En curso" y sin partidos.
const _temporada = {
  'id': 1,
  'nombre': 'Temporada',
  'anio': 2026,
  'estado': 'ACTIVE',
  'fechaInicio': '2027-01-01',
  'fechaFin': '2027-12-31',
};

Map<String, dynamic> _eq(int id, String n, String a, String c) =>
    {'id': id, 'nombre': n, 'abreviatura': a, 'color': c};

Map<String, dynamic> _partido(int id, String estado, int l, int v, {int dia = 7}) => {
      'id': id,
      'temporadaId': 1,
      'fechaHora': '2026-02-${dia.toString().padLeft(2, '0')}T15:00',
      'estado': estado,
      'equipoLocal': _eq(4, 'Pelícanos de Bocagrande', 'PEL', 'azul'),
      'equipoVisita': _eq(5, 'Corsarios de Turbaco', 'COR', 'verde'),
      'marcador': {'local': l, 'visita': v},
      'ganadorId': estado == 'FINISHED' ? (l > v ? 4 : 5) : null,
    };

final _conDatos = <String, Object>{
  '/temporadas': [_temporada],
  '/temporadas/1/partidos': [
    _partido(1, 'FINISHED', 8, 6, dia: 1),
    _partido(2, 'FINISHED', 2, 5, dia: 3),
    _partido(3, 'FINISHED', 4, 1, dia: 5),
    _partido(4, 'SCHEDULED', 0, 0, dia: 9),
  ],
  '/temporadas/1/posiciones': [
    {'equipo': _eq(4, 'Pelícanos de Bocagrande', 'PEL', 'azul'), 'juegos': 3, 'ganados': 2, 'perdidos': 1,
     'pct': 0.667, 'carrerasFavor': 17, 'carrerasContra': 12},
    {'equipo': _eq(5, 'Corsarios de Turbaco', 'COR', 'verde'), 'juegos': 3, 'ganados': 1, 'perdidos': 2,
     'pct': 0.333, 'carrerasFavor': 12, 'carrerasContra': 17},
  ],
  '/equipos/4': {..._eq(4, 'Pelícanos de Bocagrande', 'PEL', 'azul'), 'ciudad': 'Cartagena'},
  '/temporadas/1/equipos/4/plantilla': [
    {'id': 40, 'jugador': {'id': 17, 'nombres': 'Luis', 'apellidos': 'Calvo', 'batea': 'D'}, 'numero': 7,
     'posicion': 'SS'},
  ],
};

Widget _app(Widget pantalla, Map<String, Object> rutas, ThemeData tema) {
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = _Api(rutas);
  return ProviderScope(
    overrides: [
      clienteApiProvider.overrideWithValue(ClienteApi(dio)),
      ligaRepositorioProvider.overrideWithValue(LigaRepositorio(ClienteApi(dio))),
    ],
    child: MaterialApp(
      theme: tema,
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: pantalla,
    ),
  );
}

Future<void> _pintar(WidgetTester t, Widget pantalla, Map<String, Object> rutas, ThemeData tema) async {
  t.view.physicalSize = const Size(375, 812);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  await t.pumpWidget(_app(pantalla, rutas, tema));
  await t.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  testWidgets('Inicio con la temporada recién creada (sin partidos) no falla y cuenta sus equipos', (t) async {
    await _pintar(t, const InicioPantalla(), {
      '/temporadas': [_temporada],
      '/temporadas/1/partidos': <Object>[],
      '/temporadas/1/posiciones': <Object>[],
      // Un equipo inscrito, sin partidos todavía (como New York Yankees en la app).
      '/temporadas/1/equipos': [_eq(4, 'New York Yankees', 'NYY', 'azul')],
    }, TemaLbc.oscuro());
    expect(t.takeException(), isNull);
    expect(find.text('Algo salió mal'), findsNothing);
    expect(find.text('Temporada'), findsOneWidget);
    // La cifra de Equipos es la única "1" en pantalla (las demás están en 0).
    expect(find.text('Equipos'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Esta temporada todavía no tiene partidos.'), findsOneWidget);
  });

  for (final (nombre, tema) in [('claro', TemaLbc.claro()), ('oscuro', TemaLbc.oscuro())]) {
    testWidgets('Inicio con partidos y posiciones · $nombre', (t) async {
      await _pintar(t, const InicioPantalla(), _conDatos, tema);
      expect(t.takeException(), isNull);
      expect(find.text('3 de 4 partidos'), findsOneWidget);
      // El líder destacado viene de las posiciones.
      expect(find.text('Pelícanos de Bocagrande'), findsWidgets);
      await t.scrollUntilVisible(find.text('Últimos resultados'), 400);
      expect(find.text('Próximos'), findsOneWidget);
    });

    testWidgets('equipo en la temporada · $nombre', (t) async {
      await _pintar(t, const EquipoLigaPantalla(idTemporada: 1, idEquipo: 4), _conDatos, tema);
      expect(t.takeException(), isNull);
      expect(find.text('1º · 2-1 · ,667'), findsOneWidget);
      expect(find.text('Luis Calvo'), findsOneWidget);
    });
  }

  testWidgets('Líderes: el líder de jonrones y el mínimo de turnos para el promedio', (t) async {
    Map<String, dynamic> bateo(int pa, int ab, int h, int hr, double avg) => {
          'juegos': 1, 'pa': pa, 'ab': ab, 'h': h, 'hr': hr, 'avg': avg, 'obp': avg, 'slg': avg, 'ops': avg * 2,
        };
    await _pintar(t, const LideresPantalla(), {
      ..._conDatos,
      '/temporadas/1/estadisticas/bateo': [
        {'jugador': {'id': 17, 'nombres': 'Luis', 'apellidos': 'Calvo'}, 'equipo': _eq(4, 'Pelícanos de Bocagrande', 'PEL', 'azul'), 'bateo': bateo(8, 7, 3, 2, 0.429)},
        {'jugador': {'id': 18, 'nombres': 'Ana', 'apellidos': 'Ruiz'}, 'bateo': bateo(1, 1, 1, 0, 1.0)},
      ],
      '/temporadas/1/estadisticas/pitcheo': <Object>[],
    }, TemaLbc.claro());
    expect(t.takeException(), isNull);
    // AVG: Ana (1 de 1) no llega al mínimo de turnos (la mitad de 8).
    expect(find.text('Promedio · Mínimo 4 apariciones al plato'), findsOneWidget);
    expect(find.text('Luis Calvo'), findsOneWidget);
    expect(find.text('Ana Ruiz'), findsNothing);
    expect(find.text(',429'), findsOneWidget);
    await t.tap(find.text('HR'));
    await t.pumpAndSettle();
    expect(find.text('Ana Ruiz'), findsOneWidget);
    expect(find.text('Agente libre'), findsOneWidget);
    await t.tap(find.text('Pitcheo'));
    await t.pumpAndSettle();
    expect(find.textContaining('Todavía no hay estadísticas'), findsOneWidget);
  });
}
