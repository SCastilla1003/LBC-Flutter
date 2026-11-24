import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentacion/admin_equipos_pantalla.dart';
import '../../features/admin/presentacion/admin_estadios_pantalla.dart';
import '../../features/admin/presentacion/admin_jugadores_pantalla.dart';
import '../../features/admin/presentacion/admin_panel_pantalla.dart';
import '../../features/admin/presentacion/admin_partidos_pantalla.dart';
import '../../features/admin/presentacion/admin_temporadas_pantalla.dart';
import '../../features/auth/presentacion/cuenta_pantalla.dart';
import '../../features/auth/presentacion/login_pantalla.dart';
import '../../features/auth/presentacion/registro_pantalla.dart';
import '../../features/comparador/presentacion/comparador_pantalla.dart';
import '../../features/equipos/presentacion/equipo_detalle_pantalla.dart';
import '../../features/jugadores/presentacion/lideres_pantalla.dart';
import '../../features/jugadores/presentacion/perfil_bateador_pantalla.dart';
import '../../features/jugadores/presentacion/perfil_lanzador_pantalla.dart';
import '../../features/prediccion/presentacion/prediccion_pantalla.dart';
import '../../features/temporadas/presentacion/inicio_pantalla.dart';
import '../../liga/presentacion/alineacion_liga_pantalla.dart';
import '../../liga/presentacion/partido_liga_pantalla.dart';
import '../../liga/presentacion/temporada_liga_pantalla.dart';
import '../../liga/presentacion/temporadas_liga_pantalla.dart';
import '../sesion/sesion.dart';
import 'marco_navegacion.dart';

/// Decide adónde redirigir según la sesión. Pública para poder probarla.
String? redireccionPorSesion(EstadoSesion sesion, Uri destino) {
  final ruta = destino.path;
  if (ruta.startsWith('/admin')) {
    if (!sesion.autenticado) {
      return Uri(path: '/login', queryParameters: {'destino': destino.toString()}).toString();
    }
    if (!sesion.esAdmin) return '/cuenta';
  }
  if ((ruta == '/login' || ruta == '/registro') && sesion.autenticado) {
    return destino.queryParameters['destino'] ?? '/cuenta';
  }
  return null;
}

final routerProvider = Provider<GoRouter>((ref) {
  final cambiosSesion = ValueNotifier<int>(0);
  ref.listen(sesionProvider, (_, _) => cambiosSesion.value++);
  ref.onDispose(cambiosSesion.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: cambiosSesion,
    redirect: (context, state) => redireccionPorSesion(ref.read(sesionProvider), state.uri),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MarcoNavegacion(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/', builder: (_, _) => const InicioPantalla()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/temporadas',
              builder: (_, _) => const TemporadasLigaPantalla(),
              routes: [
                GoRoute(
                  path: ':t',
                  builder: (_, s) => TemporadaLigaPantalla(idTemporada: int.parse(s.pathParameters['t']!)),
                  routes: [
                    GoRoute(
                      path: 'partidos/:p',
                      builder: (_, s) => PartidoLigaPantalla(
                        idTemporada: int.parse(s.pathParameters['t']!),
                        idPartido: int.parse(s.pathParameters['p']!),
                      ),
                      routes: [
                        GoRoute(
                          path: 'alineacion',
                          builder: (_, s) => AlineacionLigaPantalla(
                            idTemporada: int.parse(s.pathParameters['t']!),
                            idPartido: int.parse(s.pathParameters['p']!),
                          ),
                        ),
                        GoRoute(
                          path: 'pitcheo',
                          builder: (_, s) => PitcheoLigaPantalla(
                            idTemporada: int.parse(s.pathParameters['t']!),
                            idPartido: int.parse(s.pathParameters['p']!),
                          ),
                        ),
                      ],
                    ),
                    // Estadísticas: se conservan tal cual y se adaptan después.
                    GoRoute(
                        path: 'comparar/:tipo',
                        builder: (_, s) => ComparadorPantalla(
                              idTemporada: s.pathParameters['t']!,
                              tipo: s.pathParameters['tipo']!,
                              a: s.uri.queryParameters['a'] ?? '',
                              b: s.uri.queryParameters['b'] ?? '',
                            )),
                    GoRoute(
                        path: 'equipos/:e',
                        builder: (_, s) => EquipoDetallePantalla(
                            idTemporada: s.pathParameters['t']!, idEquipo: s.pathParameters['e']!)),
                    GoRoute(
                        path: 'bateadores/:j',
                        builder: (_, s) => PerfilBateadorPantalla(
                            idTemporada: s.pathParameters['t']!, idJugador: s.pathParameters['j']!)),
                    GoRoute(
                        path: 'lanzadores/:j',
                        builder: (_, s) => PerfilLanzadorPantalla(
                            idTemporada: s.pathParameters['t']!, idJugador: s.pathParameters['j']!)),
                  ],
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/lideres', builder: (_, _) => const LideresPantalla()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/prediccion', builder: (_, _) => const PrediccionPantalla()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/cuenta', builder: (_, _) => const CuentaPantalla()),
          ]),
        ],
      ),
      GoRoute(path: '/login', builder: (_, s) => LoginPantalla(destino: s.uri.queryParameters['destino'])),
      GoRoute(path: '/registro', builder: (_, s) => RegistroPantalla(destino: s.uri.queryParameters['destino'])),
      GoRoute(
        path: '/admin',
        builder: (_, _) => const AdminPanelPantalla(),
        routes: [
          GoRoute(path: 'temporadas', builder: (_, _) => const AdminTemporadasPantalla()),
          GoRoute(
              path: 't/:t/equipos', builder: (_, s) => AdminEquiposPantalla(idTemporada: s.pathParameters['t']!)),
          GoRoute(
              path: 't/:t/equipos/:e',
              builder: (_, s) =>
                  AdminJugadoresPantalla(idTemporada: s.pathParameters['t']!, idEquipo: s.pathParameters['e']!)),
          GoRoute(
              path: 't/:t/agentes-libres',
              builder: (_, s) => AdminJugadoresPantalla(idTemporada: s.pathParameters['t']!, idEquipo: null)),
          GoRoute(
              path: 't/:t/partidos', builder: (_, s) => AdminPartidosPantalla(idTemporada: s.pathParameters['t']!)),
          GoRoute(
              path: 't/:t/estadios', builder: (_, s) => AdminEstadiosPantalla(idTemporada: s.pathParameters['t']!)),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Página no encontrada')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.explore_off_outlined, size: 48),
          const SizedBox(height: 12),
          Text('La ruta ${state.uri.path} no existe.'),
          const SizedBox(height: 16),
          FilledButton(onPressed: () => context.go('/'), child: const Text('Ir al inicio')),
        ]),
      ),
    ),
  );
});
