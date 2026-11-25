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
import 'package:lbc_app/features/admin/datos/auditoria_repositorio.dart';
import 'package:lbc_app/features/admin/presentacion/admin_auditoria_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_eliminar_pantalla.dart';
import 'package:lbc_app/liga/datos/liga_repositorio.dart';

class _Servidor implements HttpClientAdapter {
  _Servidor(this.respuesta);

  final Object? Function(RequestOptions o) respuesta;
  final peticiones = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    peticiones.add(o);
    final r = respuesta(o);
    return ResponseBody.fromString(r == null ? '' : jsonEncode(r), r == null ? 204 : 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

Future<_Servidor> _pintar(WidgetTester t, Widget pantalla, Object? Function(RequestOptions) api) async {
  t.view.physicalSize = const Size(400, 900);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final servidor = _Servidor(api);
  final cliente = ClienteApi(Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = servidor);
  await t.pumpWidget(ProviderScope(
    overrides: [
      clienteApiProvider.overrideWithValue(cliente),
      ligaRepositorioProvider.overrideWithValue(LigaRepositorio(cliente)),
      auditoriaRepositorioProvider.overrideWithValue(AuditoriaRepositorio(cliente)),
    ],
    child: MaterialApp(
      theme: TemaLbc.claro(),
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

Map<String, dynamic> _registro(int id, String accion, String entidad, String descripcion,
        {String? antes, String? despues}) =>
    {
      'id': id,
      'fecha': '2026-11-25T10:${id.toString().padLeft(2, '0')}:00',
      'usuario': 'santiago',
      'accion': accion,
      'entidad': entidad,
      'entidadId': 27,
      'descripcion': descripcion,
      'antes': antes,
      'despues': despues,
    };

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  testWidgets('el registro muestra quién hizo qué, filtra por tipo y abre el antes y después', (t) async {
    final s = await _pintar(t, const AdminAuditoriaPantalla(), (o) {
      final soloJugadores = o.queryParameters['entidad'] == 'Jugador';
      return {
        'registros': [
          _registro(2, 'MOVER', 'Plantilla', 'Movió a Giancarlo Stanton de New York Yankees a Boston Red Sox',
              antes: '{"equipo":"NYY","numero":27}', despues: '{"equipo":"BOS","numero":27}'),
          if (!soloJugadores) _registro(1, 'ELIMINAR_COMPLETO', 'Partido', 'Eliminó por completo el partido BOS @ NYY'),
        ],
        'pagina': 0,
        'hayMas': false,
      };
    });
    expect(find.textContaining('Movió a Giancarlo Stanton'), findsOneWidget);
    expect(find.text('Eliminó por completo el partido BOS @ NYY'), findsOneWidget);
    expect(find.textContaining('santiago'), findsNWidgets(2));

    await t.tap(find.text('Jugadores'));
    await t.pumpAndSettle();
    expect(s.peticiones.last.queryParameters['entidad'], 'Jugador');
    expect(find.text('Eliminó por completo el partido BOS @ NYY'), findsNothing);

    await t.tap(find.textContaining('Movió a Giancarlo Stanton'));
    await t.pumpAndSettle();
    expect(find.text('QUÉ CAMBIÓ'), findsOneWidget);
    expect(find.text('equipo'), findsOneWidget);
    expect(find.text('numero'), findsNothing); // no cambió
    expect(t.takeException(), isNull);
  });

  testWidgets('eliminar por completo: muestra lo que se borra, pide escribir ELIMINAR y borra', (t) async {
    final s = await _pintar(t, const AdminEliminarPantalla(idTemporada: 1), (o) {
      if (o.method == 'DELETE') return null;
      if (o.path == '/jugadores') {
        return [
          {'id': 27, 'nombres': 'Giancarlo', 'apellidos': 'Stanton'},
          {'id': 28, 'nombres': 'Aaron', 'apellidos': 'Judge'},
        ];
      }
      if (o.path == '/jugadores/27/impacto') {
        return {
          'nombre': 'Giancarlo Stanton',
          'inscripciones': 1,
          'alineaciones': 2,
          'partidos': 2,
          'jugadas': 7,
          'lanzamientos': 20,
          'cambios': 0,
          'enJuego': false,
        };
      }
      return <Object>[];
    });
    expect(find.text('Elige qué eliminar'), findsOneWidget);
    await t.tap(find.text('Giancarlo Stanton'));
    await t.pump();
    await t.tap(find.text('Eliminar 1 jugador'));
    await t.pumpAndSettle();
    expect(find.text('• 7 jugadas'), findsOneWidget);
    expect(find.text('• 1 inscripciones en rosters'), findsOneWidget);
    FilledButton boton() => t.widget<FilledButton>(find.widgetWithText(FilledButton, 'Eliminar por completo'));
    expect(boton().onPressed, isNull);
    await t.enterText(find.byType(TextField).last, 'eliminar');
    await t.pump();
    expect(boton().onPressed, isNotNull);
    await t.tap(find.widgetWithText(FilledButton, 'Eliminar por completo'));
    await t.pumpAndSettle();

    final borrado = s.peticiones.where((p) => p.method == 'DELETE').single;
    expect(borrado.uri.path, endsWith('/jugadores/27'));
    expect(borrado.uri.queryParameters['completo'], 'true');
    expect(find.text('Se eliminó 1 jugador'), findsOneWidget);
  });
}
