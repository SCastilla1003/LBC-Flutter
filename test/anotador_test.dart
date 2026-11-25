import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/router/router.dart';
import 'package:lbc_app/core/sesion/sesion.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/features/anotador/presentacion/anotador_pantalla.dart';
import 'package:lbc_app/features/anotador/presentacion/partido_control_pantalla.dart';
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
  int carrerasLocal = 0,
  String? motivo,
  String? finalEspecial,
}) =>
    {
      'partido': {
        'motivo': motivo,
        'finalEspecial': finalEspecial,
        'id': 9,
        'temporadaId': 1,
        'fechaHora': '2026-12-05T15:00',
        'estado': estado,
        'equipoLocal': _local,
        'equipoVisita': _visita,
        'marcador': {'local': carrerasLocal, 'visita': 1},
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

class _Servidor implements HttpClientAdapter {
  _Servidor(this.respuesta);

  Map<String, dynamic> Function(RequestOptions o) respuesta;
  final peticiones = <(String, String, Map<String, dynamic>?)>[];

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    final datos = o.data is String ? jsonDecode(o.data as String) : o.data;
    peticiones.add((o.method, o.path, datos as Map<String, dynamic>?));
    return ResponseBody.fromString(jsonEncode(respuesta(o)), 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

Future<_Servidor> _pintar(WidgetTester t, Widget pantalla, Map<String, dynamic> Function(RequestOptions) r,
    {ThemeData? tema, EstadoSesion? sesion}) async {
  t.view.physicalSize = const Size(375, 812);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final servidor = _Servidor(r);
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = servidor;
  await t.pumpWidget(ProviderScope(
    overrides: [
      juegoRepositorioProvider.overrideWithValue(JuegoRepositorio(ClienteApi(dio))),
      if (sesion != null) sesionInicialProvider.overrideWithValue(sesion),
    ],
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
  return servidor;
}

EstadoSesion _sesion(List<String> roles) => EstadoSesion(
      token: 'jwt',
      usuario: Usuario(username: 'u', roles: roles),
      expiraEn: DateTime.now().add(const Duration(hours: 1)),
    );

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  test('el anotador entra a /anotador pero no al panel; el aficionado a ninguno', () {
    expect(redireccionPorSesion(_sesion(['ANOTADOR']), Uri.parse('/anotador/t/1/p/9/juego')), isNull);
    expect(redireccionPorSesion(_sesion(['ADMIN']), Uri.parse('/anotador')), isNull);
    expect(redireccionPorSesion(_sesion(['ANOTADOR']), Uri.parse('/admin')), '/cuenta');
    expect(redireccionPorSesion(_sesion(['FAN']), Uri.parse('/anotador')), '/cuenta');
    expect(redireccionPorSesion(const EstadoSesion.visitante(), Uri.parse('/anotador')), startsWith('/login'));
  });

  test('avance típico de corredores (igual que en la API)', () {
    expect(movimientosPorDefecto([null, 1, null, null], ResultadoJugada.sencillo), [
      (desde: 0, hasta: 1),
      (desde: 1, hasta: 2),
    ]);
    // Base por bolas con corredor en segunda: no está forzado.
    expect(movimientosPorDefecto([null, null, 2, null], ResultadoJugada.basePorBolas), [(desde: 0, hasta: 1)]);
    expect(movimientosPorDefecto([null, 1, null, 3], ResultadoJugada.doblePlay), [
      (desde: 0, hasta: null),
      (desde: 1, hasta: null),
    ]);
    expect(movimientosPorDefecto([null, null, 2, null], ResultadoJugada.baseRobada), [(desde: 2, hasta: 3)]);
    expect(nuevoCommandId(), matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$')));
  });

  testWidgets('partido programado sin alineaciones: se ve en la app y no deja iniciar todavía', (t) async {
    await _pintar(
      t,
      const PartidoControlPantalla(idTemporada: 1, idPartido: 9),
      (_) => _estado(estado: 'SCHEDULED', completo: false),
    );
    expect(t.takeException(), isNull);
    expect(find.textContaining('ya se ve en la app como "Programado"'), findsOneWidget);
    expect(find.text('Todavía incompletas'), findsOneWidget);
    expect(find.text('• Corsarios de Turbaco: 5 de 9 bateadores'), findsOneWidget);
    expect(find.text('Editar alineaciones'), findsOneWidget);
    final iniciar = t.widget<FilledButton>(find.ancestor(of: find.text('Iniciar partido'), matching: find.byWidgetPredicate((w) => w is FilledButton)));
    expect(iniciar.onPressed, isNull);
  });

  testWidgets('con alineaciones completas se puede iniciar', (t) async {
    await _pintar(
      t,
      const PartidoControlPantalla(idTemporada: 1, idPartido: 9),
      (_) => _estado(estado: 'SCHEDULED'),
    );
    expect(find.text('Completas: 9 bateadores y lanzador por equipo'), findsOneWidget);
    final iniciar = t.widget<FilledButton>(find.ancestor(of: find.text('Iniciar partido'), matching: find.byWidgetPredicate((w) => w is FilledButton)));
    expect(iniciar.onPressed, isNotNull);
  });

  for (final (nombre, tema) in [('claro', TemaLbc.claro()), ('oscuro', TemaLbc.oscuro())]) {
    testWidgets('anotador en vivo: una bola actualiza el conteo · $nombre', (t) async {
      var bolas = 0;
      final s = await _pintar(t, const AnotadorPantalla(idPartido: 9), (o) {
        if (o.path.endsWith('/lanzamiento')) bolas++;
        return _estado(bolas: bolas);
      }, tema: tema);
      expect(t.takeException(), isNull);
      expect(find.text('COR @ PEL'), findsOneWidget);
      expect(find.text('Alta del 2'), findsOneWidget);
      expect(find.text('Jugador 102'), findsWidgets);
      expect(find.text('PEL · 12 lanz.'), findsOneWidget);

      await t.tap(find.text('Bola'));
      await t.pumpAndSettle();
      final (_, ruta, cuerpo) = s.peticiones.lastWhere((p) => p.$1 == 'POST');
      expect(ruta, '/partidos/9/juego/lanzamiento');
      expect(s.peticiones.last.$1, 'POST', reason: 'no vuelve a pedir el estado: ya viene en la respuesta');
      expect(cuerpo!['tipo'], 'BALL');
      expect(cuerpo['commandId'], isA<String>());
      expect(bolas, 1);
      expect(t.takeException(), isNull);
    });
  }

  testWidgets('sencillo con corredor en primera: se indica a dónde llega cada uno', (t) async {
    final s = await _pintar(t, const AnotadorPantalla(idPartido: 9), (_) => _estado(corredorEnPrimera: true));
    await t.scrollUntilVisible(find.text('Sencillo'), 200);
    await t.ensureVisible(find.text('Sencillo'));
    await t.pumpAndSettle();
    await t.tap(find.text('Sencillo'));
    await t.pumpAndSettle();
    expect(find.text('¿A dónde llega cada uno?'), findsOneWidget);
    // El corredor de primera anota en vez de quedarse en segunda.
    await t.tap(find.widgetWithText(ChoiceChip, 'Anota').first);
    await t.pump();
    await t.tap(find.text('Anotar'));
    await t.pumpAndSettle();
    final (_, ruta, cuerpo) = s.peticiones.last;
    expect(ruta, '/partidos/9/juego/jugada');
    expect(cuerpo!['resultado'], 'SINGLE');
    expect(cuerpo['movimientos'], containsAll([
      {'desde': 1, 'hasta': 4},
      {'desde': 0, 'hasta': 1},
    ]));
  });

  testWidgets('deshacer llama a la API', (t) async {
    final s = await _pintar(t, const AnotadorPantalla(idPartido: 9), (_) => _estado());
    await t.tap(find.byTooltip('Deshacer la última acción'));
    await t.pumpAndSettle();
    expect(s.peticiones.last.$2, '/partidos/9/juego/deshacer');
  });

  testWidgets('bateador emergente: sale el que está al bate y entra un suplente', (t) async {
    final s = await _pintar(t, const AnotadorPantalla(idPartido: 9), (_) => _estado());
    await t.ensureVisible(find.text('Cambios de jugadores'));
    await t.pumpAndSettle();
    await t.tap(find.text('Cambios de jugadores'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
    expect(find.text('Cambio de jugadores'), findsOneWidget);
    // Por defecto: bateador emergente del equipo al bate, sale Jugador 102.
    expect(find.text('Jugador 102'), findsWidgets);
    await t.tap(find.text('Entra'));
    await t.pumpAndSettle();
    await t.tap(find.text('Suplente 150').last);
    await t.pumpAndSettle();
    await t.tap(find.text('Hacer cambio'));
    await t.pumpAndSettle();
    final (_, ruta, cuerpo) = s.peticiones.last;
    expect(ruta, '/partidos/9/juego/cambio');
    expect(cuerpo, containsPair('tipo', 'PINCH_HITTER'));
    expect(cuerpo, containsPair('local', false));
    expect(cuerpo, containsPair('saleId', 102));
    expect(cuerpo, containsPair('entraId', 150));
  });

  testWidgets('finalizar empatado: no hay empates, pide el motivo y detiene el partido', (t) async {
    final s = await _pintar(t, const AnotadorPantalla(idPartido: 9), (o) {
      if (o.path.endsWith('/suspender')) return _estado(estado: 'SUSPENDED', carrerasLocal: 1, motivo: 'POSPUESTO');
      return _estado(carrerasLocal: 1);
    });
    await t.tap(find.byTooltip('Más acciones'));
    await t.pumpAndSettle();
    await t.tap(find.text('Finalizar partido'));
    await t.pumpAndSettle();
    expect(find.text('En el béisbol no hay empates'), findsOneWidget);
    expect(find.text('Retrasado'), findsOneWidget);
    expect(find.text('Cancelado'), findsOneWidget);
    await t.tap(find.text('Pospuesto'));
    await t.pumpAndSettle();
    final (_, ruta, cuerpo) = s.peticiones.last;
    expect(ruta, '/partidos/9/juego/suspender');
    expect(cuerpo!['motivo'], 'POSPUESTO');
    expect(find.textContaining('El administrador decidirá'), findsOneWidget);
    expect(find.text('Reanudar partido'), findsNothing);
    expect(find.text('Continuar el partido'), findsNothing);
  });

  testWidgets('partido detenido: el administrador lo continúa o lo deja así', (t) async {
    final s = await _pintar(
      t,
      const AnotadorPantalla(idPartido: 9),
      (o) => o.path.endsWith('/decidir')
          ? _estado(estado: 'FINISHED', carrerasLocal: 1, motivo: 'CANCELADO')
          : _estado(estado: 'SUSPENDED', carrerasLocal: 1, motivo: 'CANCELADO'),
      sesion: _sesion(['ADMIN']),
    );
    expect(find.textContaining('¿Continúa el partido o se deja así?'), findsOneWidget);
    expect(find.text('Continuar el partido'), findsOneWidget);
    await t.tap(find.text('Dejarlo así'));
    await t.pumpAndSettle();
    expect(find.textContaining('no cuenta en la tabla de posiciones'), findsOneWidget);
    await t.tap(find.text('Dejar así'));
    await t.pumpAndSettle();
    final (_, ruta, cuerpo) = s.peticiones.last;
    expect(ruta, '/partidos/9/juego/decidir');
    expect(cuerpo!['continuar'], false);
    expect(find.textContaining('el administrador lo dejó así'), findsOneWidget);
  });

  testWidgets('walk off: el anotador ve el letrero al final', (t) async {
    await _pintar(t, const AnotadorPantalla(idPartido: 9),
        (_) => _estado(estado: 'FINISHED', carrerasLocal: 5, finalEspecial: 'WALK_OFF_GRAND_SLAM'));
    expect(find.text('WALK OFF GRAND SLAM'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
}
