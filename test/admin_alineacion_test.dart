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
import 'package:lbc_app/liga/datos/modelos_liga.dart';

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
/// El 0 y el 11 de cada equipo son lanzadores; el 10 es un SS de reserva.
Map<String, dynamic> _jug(int id) => {
      'id': id,
      'nombres': 'J$id',
      'apellidos': 'A$id',
      'batea': 'D',
      'lanza': 'D',
      'esLanzador': id % 100 == 0 || id % 100 == 11,
    };

const _posiciones = ['C', '1B', '2B', '3B', 'SS', 'LF', 'CF', 'RF', 'DH'];

List<Map<String, dynamic>> _plantilla(int base) => [
      for (var i = 0; i < 12; i++)
        {
          'id': base + i,
          'jugador': _jug(base + i),
          'numero': i + 1,
          'posicion': i == 0 || i == 11 ? 'P' : (i == 10 ? 'SS' : _posiciones[i - 1]),
        },
    ];

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
      // Partido anterior (8) de los Corsarios, que ese día fueron locales.
      if (o.path == '/temporadas/1/partidos') {
        return [
          {
            'id': 8,
            'temporadaId': 1,
            'fechaHora': '2026-02-01T15:00',
            'estado': 'FINISHED',
            'equipoLocal': _eq(2, 'Corsarios de Turbaco', 'COR'),
            'equipoVisita': _eq(3, 'Leones', 'LEO'),
            'marcador': {'local': 2, 'visita': 1},
          },
        ];
      }
      if (o.path == '/partidos/8/alineacion') {
        return {
          'publicada': true,
          'local': {
            ..._equipoAlineacion(200, completo: true),
            'bateo': [
              for (var i = 0; i < 9; i++)
                {'orden': i + 1, 'posicion': _posiciones[8 - i], 'jugador': _jug(209 - i)},
            ],
          },
          'visita': null,
        };
      }
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
    PlantillaLiga inscrito(int id, String posicion, {bool lanzador = false}) => PlantillaLiga(
          id: id,
          jugador: JugadorResumenLiga(id: id, nombres: 'J$id', apellidos: 'A$id', esLanzador: lanzador),
          posicion: posicion,
        );

    // 1 y 31 lanzan; 10..18 de campo con las posiciones C..DH; 30 es un SS de reserva.
    final plantilla = [
      inscrito(1, 'P', lanzador: true),
      for (var i = 0; i < 9; i++) inscrito(10 + i, _posiciones[i]),
      inscrito(30, 'SS'),
      inscrito(31, 'P', lanzador: true),
    ];

    EquipoEditable completo() {
      final e = EquipoEditable(plantilla)..lanzador = 1;
      for (var i = 0; i < 9; i++) {
        e.jugadores[i] = 10 + i;
        e.posiciones[i] = _posiciones[i];
      }
      return e;
    }

    test('una alineación completa no tiene errores; los demás van solos a la banca y a los relevos', () {
      final e = completo();
      expect(e.errores(publicar: true, equipo: 'X', nombres: {}), isEmpty);
      expect(e.banca.map((p) => p.jugador.id), [30]);
      expect(e.relevos.map((p) => p.jugador.id), [31]);
      final json = e.datos().json();
      expect(json['lanzadorInicial'], 1);
      expect((json['bateo'] as List).map((b) => b['orden']), [1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(json['banca'], [30, 31]);
    });

    test('para publicar faltan bateadores y lanzador; el borrador sí se puede guardar', () {
      final e = EquipoEditable(plantilla)
        ..jugadores[0] = 10
        ..posiciones[0] = 'CF';
      expect(e.errores(publicar: false, equipo: 'X', nombres: {}), isEmpty);
      expect(
        e.errores(publicar: true, equipo: 'X', nombres: {}),
        containsAll(['X: faltan bateadores (deben ser 9).', 'X: falta el lanzador inicial.']),
      );
    });

    test('repetidos, turno a medias, P de alguien que no es el lanzador y posición repetida', () {
      final e = completo()
        ..jugadores[1] = 10 // repite al del turno 1
        ..posiciones[2] = null // turno 3 sin posición
        ..posiciones[3] = 'P' // P sin ser el lanzador
        ..posiciones[5] = 'C'; // C otra vez
      final errores = e.errores(publicar: false, equipo: 'X', nombres: {10: 'Luis Calvo'});
      expect(errores, contains('X: Luis Calvo está dos veces en el orden de bateo.'));
      expect(errores, contains('X, turno 3: falta la posición.'));
      expect(errores, contains('X, turno 4: la posición P solo puede ser del lanzador inicial.'));
      expect(errores, contains('X: la posición C está en los turnos 1 y 6.'));
    });

    test('al poner a un jugador toma la posición con la que está inscrito si está libre', () {
      final e = EquipoEditable(plantilla);
      expect(e.ponerBateador(0, 13), isNull); // inscrito como 3B
      expect(e.posiciones[0], '3B');
      final aviso = e.ponerBateador(1, 30, nombres: {13: 'J13 A13', 30: 'J30 A30'}); // SS libre
      expect(aviso, isNull);
      expect(e.posiciones[1], 'SS');
      final repetida = e.ponerBateador(2, 14, nombres: {30: 'J30 A30', 14: 'J14 A14'}); // también SS
      expect(e.posiciones[2], isNull);
      expect(repetida, 'SS ya la tiene J30 A30: elige otra posición para J14 A14.');
      e.ponerBateador(0, null);
      expect((e.jugadores[0], e.posiciones[0]), (null, null));
    });

    test('regla Ohtani: el lanzador inicial batea como DH; con otra posición es un error', () {
      final e = EquipoEditable(plantilla)..lanzador = 1;
      e.ponerBateador(8, 1);
      expect(e.posiciones[8], 'DH');
      expect(e.errores(publicar: false, equipo: 'X', nombres: {}), isEmpty);
      e.posiciones[8] = 'SS';
      expect(e.errores(publicar: false, equipo: 'X', nombres: {}),
          contains('X: si el lanzador inicial batea, va como P o como DH.'));
    });

    test('copiar la alineación anterior trae el orden con sus posiciones, no al abridor', () {
      final e = EquipoEditable(plantilla)..lanzador = 31;
      e.copiar(EquipoAlineacion(
        equipo: const EquipoRefLiga(id: 1, nombre: 'X', abreviatura: 'X'),
        lanzadorInicial: plantilla.first.jugador,
        bateo: [
          for (var i = 0; i < 8; i++)
            BateadorAlineacion(orden: i + 1, posicion: _posiciones[i], jugador: plantilla[i + 1].jugador),
          BateadorAlineacion(orden: 9, posicion: 'P', jugador: plantilla.first.jugador),
        ],
      ));
      expect(e.jugadores.take(8), [10, 11, 12, 13, 14, 15, 16, 17]);
      expect(e.posiciones.take(8), _posiciones.take(8));
      expect((e.jugadores[8], e.lanzador), (null, 31)); // el que bateaba de P no se copia
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
    expect(cuerpo['local']['banca'], [110, 111]);
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

  List<int?> valores(WidgetTester t) =>
      [for (final d in t.widgetList<DropdownButton<int?>>(find.byType(DropdownButton<int?>))) d.value];

  testWidgets('repetir la alineación anterior llena los campos sin guardar ni publicar', (tester) async {
    tester.view.physicalSize = const Size(375, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (app, servidor) = _app(_api(completo: false), TemaLbc.claro());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    // Pestaña del visitante (Corsarios): ya tiene 4 bateadores, así que pide confirmar.
    await tester.tap(find.text('Repetir la alineación del partido anterior'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Repetir'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Se copió la alineación del 1 de febrero contra Leones'), findsOneWidget);
    // Lanzador inicial (se queda el suyo) y el orden anterior: 209 primero ... 201 noveno.
    expect(valores(tester), [200, 209, 208, 207, 206, 205, 204, 203, 202, 201]);
    final pos = [for (final d in tester.widgetList<DropdownButton<String?>>(find.byType(DropdownButton<String?>))) d.value];
    expect(pos, ['DH', 'RF', 'CF', 'LF', 'SS', '3B', '2B', '1B', 'C']);
    expect(servidor.peticiones.where((p) => p.$1 == 'PUT'), isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('los lanzadores no salen entre los bateadores salvo que se pidan', (tester) async {
    tester.view.physicalSize = const Size(375, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (app, _) = _app(_api(completo: false), TemaLbc.claro());
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    DropdownButton<int?> turno5() => tester.widgetList<DropdownButton<int?>>(find.byType(DropdownButton<int?>)).elementAt(5);
    // Turno 5 (vacío): solo jugadores de campo libres (205..210), sin los lanzadores 200 y 211.
    expect(turno5().items!.map((i) => i.value).whereType<int>(), [205, 206, 207, 208, 209, 210]);

    await tester.tap(find.byTooltip('Elegir entre lanzadores (DH como Ohtani)').at(4));
    await tester.pumpAndSettle();
    expect(find.text('Lanzador al bate'), findsOneWidget);
    expect(turno5().items!.map((i) => i.value).whereType<int>(), [200, 211]);
    turno5().onChanged!(211);
    await tester.pumpAndSettle();
    final pos = [for (final d in tester.widgetList<DropdownButton<String?>>(find.byType(DropdownButton<String?>))) d.value];
    expect(pos[4], 'DH');
    // Ya no está en los relevos.
    expect(find.textContaining('J211 A211'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
