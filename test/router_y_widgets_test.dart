import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lbc_app/core/red/fallo_api.dart';
import 'package:lbc_app/core/router/router.dart';
import 'package:lbc_app/core/sesion/sesion.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/core/widgets/estados.dart';
import 'package:lbc_app/core/widgets/imagen_api.dart';
import 'package:lbc_app/core/widgets/vista_async.dart';
import 'package:lbc_app/main.dart';

EstadoSesion _sesion(List<String> roles) => EstadoSesion(
      token: 'jwt',
      usuario: Usuario(username: 'u', roles: roles),
      expiraEn: DateTime.now().add(const Duration(hours: 1)),
    );

Widget _envolver(Widget hijo) => MaterialApp(theme: TemaLbc.claro(), home: Scaffold(body: hijo));

void main() {
  group('guardia de rutas', () {
    test('visitante en /admin va al login con destino', () {
      final r = redireccionPorSesion(const EstadoSesion.visitante(), Uri.parse('/admin/t/1/equipos'));
      expect(r, '/login?destino=%2Fadmin%2Ft%2F1%2Fequipos');
    });

    test('usuario sin rol ADMIN no entra al panel', () {
      expect(redireccionPorSesion(_sesion(['USER']), Uri.parse('/admin')), '/cuenta');
    });

    test('ADMIN entra al panel', () {
      expect(redireccionPorSesion(_sesion(['ADMIN']), Uri.parse('/admin')), isNull);
    });

    test('sesión caducada cuenta como visitante', () {
      final caducada = EstadoSesion(
        token: 'jwt',
        usuario: const Usuario(username: 'u', roles: ['ADMIN']),
        expiraEn: DateTime.now().subtract(const Duration(minutes: 1)),
      );
      expect(redireccionPorSesion(caducada, Uri.parse('/admin')), startsWith('/login'));
    });

    test('con sesión, /login vuelve al destino', () {
      expect(redireccionPorSesion(_sesion(['ADMIN']), Uri.parse('/login?destino=/admin')), '/admin');
      expect(redireccionPorSesion(_sesion(['USER']), Uri.parse('/login')), '/cuenta');
    });

    test('las rutas públicas no se redirigen', () {
      expect(redireccionPorSesion(const EstadoSesion.visitante(), Uri.parse('/temporadas/1')), isNull);
    });
  });

  group('estados de pantalla', () {
    testWidgets('error muestra mensaje y botón Reintentar', (tester) async {
      var reintentos = 0;
      await tester.pumpWidget(_envolver(VistaAsync<int>(
        valor: const AsyncValue.error(FalloSinConexion(), StackTrace.empty),
        onReintentar: () => reintentos++,
        datos: (d) => Text('$d'),
      )));
      expect(find.text('Sin conexión'), findsOneWidget);
      await tester.tap(find.text('Reintentar'));
      expect(reintentos, 1);
    });

    testWidgets('un error no reintentable (404) no ofrece Reintentar', (tester) async {
      await tester.pumpWidget(_envolver(const EstadoError(error: FalloNoEncontrado('No existe'), onReintentar: _nada)));
      expect(find.text('No existe'), findsOneWidget);
      expect(find.text('Reintentar'), findsNothing);
    });

    testWidgets('vacío y datos', (tester) async {
      await tester.pumpWidget(_envolver(VistaAsync<List<int>>(
        valor: const AsyncValue.data([]),
        onReintentar: _nada,
        esVacio: (l) => l.isEmpty,
        mensajeVacio: 'Sin partidos',
        datos: (l) => Text('${l.length}'),
      )));
      expect(find.text('Sin partidos'), findsOneWidget);

      await tester.pumpWidget(_envolver(VistaAsync<List<int>>(
        valor: const AsyncValue.data([1, 2]),
        onReintentar: _nada,
        esVacio: (l) => l.isEmpty,
        datos: (l) => Text('${l.length} elementos'),
      )));
      expect(find.text('2 elementos'), findsOneWidget);
    });

    testWidgets('cargando muestra esqueleto', (tester) async {
      await tester.pumpWidget(_envolver(VistaAsync<int>(
        valor: const AsyncValue.loading(),
        onReintentar: _nada,
        datos: (d) => Text('$d'),
      )));
      expect(find.byType(EsqueletoLista), findsOneWidget);
    });

    testWidgets('los esqueletos caben dentro de una lista recargable', (tester) async {
      for (final cargando in const <Widget?>[null, EsqueletoDetalle()]) {
        await tester.pumpWidget(_envolver(RecargableSimple(
          onRefresh: () async {},
          child: VistaAsync<int>(
            valor: const AsyncValue.loading(),
            onReintentar: _nada,
            cargando: cargando,
            datos: (d) => Text('$d'),
          ),
        )));
        expect(tester.takeException(), isNull);
      }
    });
  });

  testWidgets('sin API_BASE_URL la app no muestra datos: pide configurarla', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: LbcApp()));
    await tester.pumpAndSettle();
    expect(find.text('Falta la URL de la API'), findsOneWidget);
    expect(find.textContaining('--dart-define=API_BASE_URL'), findsOneWidget);
  });

  test('iniciales ignoran artículos y preposiciones', () {
    expect(inicialesDe('Faroleros del Cabrero'), 'FC');
    expect(inicialesDe('Pelícanos de Bocagrande'), 'PB');
    expect(inicialesDe('Juan Carlos Pérez'), 'JP');
    expect(inicialesDe('Tigres'), 'T');
    expect(inicialesDe('  '), '?');
  });
}

void _nada() {}

