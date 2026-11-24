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
  '/jugadores/17': {..._jug(17, 'Luis', 'Calvo', foto: '/api/v1/jugadores/17/foto?v=1'), 'edad': 25},
  'POST /jugadores/17/foto': _jug(17, 'Luis', 'Calvo', foto: '/api/v1/jugadores/17/foto?v=2'),
};

(LigaRepositorio, _Api) _repo() {
  final api = _Api(_rutas);
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

  testWidgets('inscribir varios: agente libre por PUT, sin inscribir por POST; los de otros equipos no se eligen',
      (t) async {
    t.view.physicalSize = const Size(375, 812);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    final (repo, api) = _repo();
    await t.pumpWidget(_app(repo, const AdminInscripcionPantalla(idTemporada: 1, idEquipo: 4)));
    await t.tap(find.text('abrir'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);

    // Juan ya está en este equipo: no aparece. Pedro está en Corsarios: aparece bloqueado.
    expect(find.text('Juan Díaz'), findsNothing);
    expect(find.text('Ya juega en Corsarios de Turbaco'), findsOneWidget);
    expect(find.text('Agente libre'), findsOneWidget);

    await t.tap(find.text('Pedro Ruiz'));
    await t.tap(find.text('Luis Calvo'));
    await t.tap(find.text('Ana Mora'));
    await t.pump();
    expect(find.text('2 seleccionados'), findsOneWidget);

    // Número de Luis (el primer campo habilitado: está primero en la lista).
    await t.enterText(find.byType(TextField).at(1), '27');
    await t.tap(find.text('Inscribir 2'));
    await t.pumpAndSettle();

    final post = api.escrituras.firstWhere((e) => e.$1 == 'POST');
    expect(post.$2, '/temporadas/1/plantilla');
    expect(post.$3, {'jugadorId': 17, 'equipoId': 4, 'numero': 27, 'posicion': null});
    final put = api.escrituras.firstWhere((e) => e.$1 == 'PUT');
    expect(put.$2, '/temporadas/1/plantilla/50');
    // Ana conserva el número y la posición que tenía como agente libre.
    expect(put.$3, {'equipoId': 4, 'numero': 9, 'posicion': 'CF'});
    expect(api.escrituras.where((e) => e.$3 is Map && (e.$3! as Map)['jugadorId'] == 19), isEmpty);
    expect(find.text('2 jugadores inscritos'), findsOneWidget);
  });

  testWidgets('perfil del jugador con su foto, número y posición', (t) async {
    final (repo, _) = _repo();
    final rutas = _rutas
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
