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
import 'package:lbc_app/features/admin/presentacion/admin_inscripcion_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_plantilla_pantalla.dart';
import 'package:lbc_app/liga/datos/liga_repositorio.dart';
import 'package:lbc_app/liga/presentacion/jugador_liga_pantalla.dart';

/// API simulada: responde por ruta y guarda las escrituras.
class _Api implements HttpClientAdapter {
  _Api(this.rutas);

  final Map<String, Object> rutas;
  final escrituras = <(String, String, Object?)>[];

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    if (o.method != 'GET') {
      final datos = o.data is FormData
          ? (o.data as FormData).files.map((f) => f.key).toList()
          : (o.data is String ? jsonDecode(o.data as String) : o.data);
      escrituras.add((o.method, o.path, datos));
    }
    final r = rutas['${o.method} ${o.path}'] ?? rutas[o.path];
    return ResponseBody.fromString(jsonEncode(r ?? {}), 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

Map<String, dynamic> _jug(int id, String n, String a, {String? foto}) =>
    {'id': id, 'nombres': n, 'apellidos': a, 'batea': 'D', 'fotoUrl': foto};
Map<String, dynamic> _eq(int id, String n, String a) => {'id': id, 'nombre': n, 'abreviatura': a};

final _rutas = <String, Object>{
  '/jugadores': [
    _jug(17, 'Luis', 'Calvo'),
    _jug(18, 'Ana', 'Mora'),
    _jug(19, 'Pedro', 'Ruiz'),
    _jug(20, 'Juan', 'Díaz'),
  ],
  '/equipos': [_eq(4, 'Pelícanos de Bocagrande', 'PEL'), _eq(5, 'Corsarios de Turbaco', 'COR')],
  '/temporadas/1/agentes-libres': [
    {'id': 50, 'jugador': _jug(18, 'Ana', 'Mora'), 'numero': 9, 'posicion': 'CF'},
  ],
  '/temporadas/1/equipos': [_eq(4, 'Pelícanos de Bocagrande', 'PEL'), _eq(5, 'Corsarios de Turbaco', 'COR')],
  '/temporadas/1/equipos/4/plantilla': [
    {'id': 60, 'jugador': _jug(20, 'Juan', 'Díaz'), 'equipo': _eq(4, 'Pelícanos de Bocagrande', 'PEL'), 'numero': 2},
  ],
  '/temporadas/1/equipos/5/plantilla': [
    {'id': 61, 'jugador': _jug(19, 'Pedro', 'Ruiz'), 'equipo': _eq(5, 'Corsarios de Turbaco', 'COR')},
  ],
  'POST /temporadas/1/plantilla': {'id': 70, 'jugador': _jug(17, 'Luis', 'Calvo')},
  'PUT /temporadas/1/plantilla/50': {'id': 50, 'jugador': _jug(18, 'Ana', 'Mora')},
  'PUT /temporadas/1/plantilla/60': {'id': 60, 'jugador': _jug(20, 'Juan', 'Díaz')},
  // Temporadas: la 2026 (id 1) y la anterior, 2025 (id 9), con el roster previo de Pelícanos.
  '/temporadas': [
    {'id': 1, 'nombre': 'Temporada', 'anio': 2026, 'estado': 'ACTIVE'},
    {'id': 9, 'nombre': 'Temporada', 'anio': 2025, 'estado': 'FINISHED'},
  ],
  '/temporadas/9/equipos/4/plantilla': [
    {'id': 90, 'jugador': _jug(17, 'Luis', 'Calvo'), 'numero': 7, 'posicion': 'SS'},
    {'id': 91, 'jugador': _jug(19, 'Pedro', 'Ruiz'), 'numero': 4, 'posicion': '1B'},
  ],
  '/temporadas/9/equipos/5/plantilla': <Object>[],
  'POST /temporadas/1/equipos': _eq(4, 'Pelícanos de Bocagrande', 'PEL'),
  '/jugadores/17': {..._jug(17, 'Luis', 'Calvo', foto: '/api/v1/jugadores/17/foto?v=1'), 'edad': 25},
  'POST /jugadores/17/foto': _jug(17, 'Luis', 'Calvo', foto: '/api/v1/jugadores/17/foto?v=2'),
};

(LigaRepositorio, _Api) _repo() {
  final api = _Api({..._rutas});
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = api;
  return (LigaRepositorio(ClienteApi(dio)), api);
}

/// La pantalla se abre con push para que "Inscribir" pueda volver atrás.
Widget _app(LigaRepositorio repo, Widget pantalla) => ProviderScope(
      overrides: [ligaRepositorioProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: TemaLbc.claro(),
        locale: const Locale('es'),
        supportedLocales: const [Locale('es')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Builder(
          builder: (c) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => Navigator.of(c).push(MaterialPageRoute<void>(builder: (_) => pantalla)),
                child: const Text('abrir'),
              ),
            ),
          ),
        ),
      ),
    );

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  test('la foto del jugador se sube por POST multipart en el campo "archivo"', () async {
    final (repo, api) = _repo();
    final j = await repo.subirFotoJugador(17, [0xFF, 0xD8, 0xFF], 'foto.jpg');
    final (metodo, ruta, campos) = api.escrituras.single;
    expect((metodo, ruta), ('POST', '/jugadores/17/foto'));
    expect(campos, ['archivo']);
    expect(j.fotoUrl, '/api/v1/jugadores/17/foto?v=2');
    await repo.borrarEscudo(4);
    expect((api.escrituras.last.$1, api.escrituras.last.$2), ('DELETE', '/equipos/4/escudo'));
  });

  testWidgets('actualizar roster: marca el actual, avisa quién entra y quién sale, y lo aplica', (t) async {
    t.view.physicalSize = const Size(375, 812);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    final (repo, api) = _repo();
    await t.pumpWidget(_app(repo, const AdminInscripcionPantalla(idTemporada: 1, idEquipo: 4)));
    await t.tap(find.text('abrir'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);

    // Juan ya está en el roster (marcado); Pedro juega en Corsarios (no se puede elegir).
    expect(find.text('En el roster'), findsOneWidget);
    expect(find.text('1 en el roster'), findsOneWidget);
    expect(find.text('Ya juega en Corsarios de Turbaco'), findsOneWidget);
    expect(find.text('Roster 2025'), findsOneWidget);

    await t.tap(find.text('Pedro Ruiz')); // bloqueado: no cambia nada
    await t.tap(find.text('Juan Díaz')); // sale
    await t.tap(find.text('Luis Calvo')); // entra (sin inscribir)
    await t.tap(find.text('Ana Mora')); // entra (agente libre)
    await t.pump();
    expect(find.text('Sale del roster'), findsOneWidget);

    await t.tap(find.text('Revisar cambios (3)'));
    await t.pumpAndSettle();
    expect(find.text('Entran al roster (2)'), findsOneWidget);
    expect(find.text('Salen del roster (quedan como agentes libres) (1)'), findsOneWidget);
    expect(api.escrituras, isEmpty); // nada se envía antes de confirmar
    await t.tap(find.text('Confirmar'));
    await t.pumpAndSettle();

    Object? cuerpo(String metodo, String ruta) => api.escrituras.firstWhere((e) => e.$1 == metodo && e.$2 == ruta).$3;
    expect(cuerpo('POST', '/temporadas/1/plantilla'), {'jugadorId': 17, 'equipoId': 4, 'numero': null, 'posicion': null});
    // Ana conserva el número y la posición que tenía como agente libre.
    expect(cuerpo('PUT', '/temporadas/1/plantilla/50'), {'equipoId': 4, 'numero': 9, 'posicion': 'CF'});
    // Juan sale del equipo y queda como agente libre.
    expect(cuerpo('PUT', '/temporadas/1/plantilla/60'), {'equipoId': null, 'numero': 2, 'posicion': null});
    expect(find.text('Roster actualizado (3 cambios)'), findsOneWidget);
  });

  testWidgets('inscribir equipo: trae su roster de la temporada anterior y omite a quien juega en otro', (t) async {
    t.view.physicalSize = const Size(375, 812);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    final (repo, api) = _repo();
    // En la 2026 solo está Corsarios; Pelícanos está disponible para inscribir.
    api.rutas['/temporadas/1/equipos'] = [_eq(5, 'Corsarios de Turbaco', 'COR')];
    api.rutas['/temporadas/1/equipos/4/plantilla'] = <Object>[];
    await t.pumpWidget(_app(repo, const AdminPlantillasPantalla(idTemporada: 1)));
    await t.tap(find.text('abrir'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);

    await t.tap(find.text('Inscribir equipo'));
    await t.pumpAndSettle();
    await t.tap(find.text('Pelícanos de Bocagrande').last);
    await t.pumpAndSettle();

    expect(find.text('Inscribir Pelícanos de Bocagrande con su roster de Temporada 2025'), findsOneWidget);
    expect(find.text('• Luis Calvo · #7 · SS'), findsOneWidget);
    expect(find.text('• Pedro Ruiz (COR)'), findsOneWidget);
    await t.tap(find.text('Confirmar'));
    await t.pumpAndSettle();

    expect(api.escrituras.map((e) => (e.$1, e.$2)), [
      ('POST', '/temporadas/1/equipos'),
      ('POST', '/temporadas/1/plantilla'),
    ]);
    expect(api.escrituras.first.$3, {'equipoId': 4});
    expect(api.escrituras.last.$3, {'jugadorId': 17, 'equipoId': 4, 'numero': 7, 'posicion': 'SS'});
    expect(find.text('Pelícanos de Bocagrande inscrito con 1 jugadores'), findsOneWidget);
  });

  testWidgets('perfil del jugador con su foto, número y posición', (t) async {
    final (repo, api) = _repo();
    final rutas = api.rutas
      ..['/temporadas/1/equipos/4/plantilla'] = [
        {'id': 70, 'jugador': _jug(17, 'Luis', 'Calvo'), 'equipo': _eq(4, 'Pelícanos de Bocagrande', 'PEL'),
         'numero': 7, 'posicion': 'SS'},
      ];
    expect(rutas, isNotEmpty);
    await t.pumpWidget(_app(repo, const JugadorLigaPantalla(idTemporada: 1, idJugador: 17, idEquipo: 4)));
    await t.tap(find.text('abrir'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
    expect(find.text('Luis Calvo'), findsOneWidget);
    expect(find.text('#7'), findsOneWidget);
    expect(find.text('SS'), findsOneWidget);
    expect(find.text('Pelícanos de Bocagrande'), findsOneWidget);
  });
}
