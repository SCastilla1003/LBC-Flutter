import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/sesion/sesion.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/features/admin/datos/usuarios_repositorio.dart';
import 'package:lbc_app/features/admin/presentacion/admin_usuarios_pantalla.dart';

/// Servidor simulado con tres cuentas; guarda las peticiones y aplica los cambios de rol.
class _Servidor implements HttpClientAdapter {
  final peticiones = <(String, String, Object?)>[];
  final usuarios = <Map<String, Object?>>[
    {
      'id': 3,
      'username': 'ana.perez@gmail.com',
      'email': 'ana.perez@gmail.com',
      'rol': 'FAN',
      'proveedor': 'google',
      'activa': true,
      'creadoEn': '2026-11-20T09:30:00',
    },
    {
      'id': 2,
      'username': 'luis',
      'email': null,
      'rol': 'ANOTADOR',
      'proveedor': 'local',
      'activa': true,
      'creadoEn': '2026-10-02T18:00:00',
    },
    {
      'id': 1,
      'username': 'admin',
      'email': null,
      'rol': 'ADMIN',
      'proveedor': 'local',
      'activa': true,
      'creadoEn': '2026-01-01T00:00:00',
    },
  ];

  @override
  Future<ResponseBody> fetch(
    RequestOptions o,
    Stream<Uint8List>? cuerpo,
    Future<void>? cancelar,
  ) async {
    final datos = o.data is String ? jsonDecode(o.data as String) : o.data;
    peticiones.add((o.method, o.path, datos));
    Object? r = usuarios;
    final m = RegExp(r'^/usuarios/(\d+)/rol$').firstMatch(o.path);
    if (o.method == 'PUT' && m != null) {
      final u = usuarios.firstWhere((u) => u['id'] == int.parse(m.group(1)!));
      u['rol'] = (datos as Map)['rol'];
      r = u;
    }
    return ResponseBody.fromString(
      jsonEncode(r),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Future<_Servidor> _pintar(WidgetTester t, ThemeData tema) async {
  t.view.physicalSize = const Size(375, 812);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final servidor = _Servidor();
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))
    ..httpClientAdapter = servidor;
  await t.pumpWidget(
    ProviderScope(
      overrides: [
        usuariosRepositorioProvider.overrideWithValue(
          UsuariosRepositorio(ClienteApi(dio)),
        ),
        sesionInicialProvider.overrideWithValue(
          EstadoSesion(
            token: 't',
            usuario: const Usuario(username: 'admin', roles: ['ADMIN']),
            expiraEn: DateTime.now().add(const Duration(hours: 1)),
          ),
        ),
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
        home: const AdminUsuariosPantalla(),
      ),
    ),
  );
  await t.pumpAndSettle();
  return servidor;
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  for (final (nombre, tema) in [
    ('claro', TemaLbc.claro()),
    ('oscuro', TemaLbc.oscuro()),
  ]) {
    testWidgets(
      'lista cuentas locales y de Google, con buscador y filtro · $nombre',
      (t) async {
        await _pintar(t, tema);
        expect(t.takeException(), isNull);
        expect(find.text('ana.perez@gmail.com'), findsOneWidget);
        expect(find.text('Aficionado · Google'), findsOneWidget);
        expect(find.text('Anotador · Usuario y contraseña'), findsOneWidget);
        expect(
          find.text('Administrador · Usuario y contraseña · Tu cuenta'),
          findsOneWidget,
        );

        await t.enterText(find.byType(TextField), 'GMAIL');
        await t.pump();
        expect(find.text('ana.perez@gmail.com'), findsOneWidget);
        expect(find.text('luis'), findsNothing);

        await t.enterText(find.byType(TextField), '');
        await t.tap(find.text('Anotadores · 1'));
        await t.pump();
        expect(find.text('luis'), findsOneWidget);
        expect(find.text('admin'), findsNothing);
      },
    );
  }

  testWidgets('cambiar el rol de una cuenta de Google a anotador', (t) async {
    final s = await _pintar(t, TemaLbc.claro());
    await t.tap(find.text('ana.perez@gmail.com'));
    await t.pumpAndSettle();
    expect(find.text('Cuenta de Google · desde 20 nov 2026'), findsOneWidget);
    await t.tap(find.text('Anotador'));
    await t.pump();
    await t.tap(find.text('Guardar rol'));
    await t.pumpAndSettle();

    final (_, ruta, cuerpo) = s.peticiones.where((p) => p.$1 == 'PUT').single;
    expect(ruta, '/usuarios/3/rol');
    expect(cuerpo, {'rol': 'ANOTADOR'});
    expect(find.text('Anotador · Google'), findsOneWidget);
    expect(find.text('ana.perez@gmail.com ahora es anotador'), findsOneWidget);
  });

  testWidgets('no deja cambiar el rol de la propia cuenta', (t) async {
    final s = await _pintar(t, TemaLbc.claro());
    await t.tap(find.text('admin'));
    await t.pumpAndSettle();
    expect(find.textContaining('Es tu cuenta'), findsOneWidget);
    await t.tap(find.text('Aficionado'));
    await t.pump();
    final guardar = t.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Guardar rol'),
    );
    expect(guardar.onPressed, isNull);
    expect(s.peticiones.where((p) => p.$1 == 'PUT'), isEmpty);
  });
}
