import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentacion/admin_alineacion_pantalla.dart';
import '../../features/admin/presentacion/admin_equipos_pantalla.dart';
import '../../features/admin/presentacion/admin_estadios_pantalla.dart';
import '../../features/admin/presentacion/admin_inscripcion_pantalla.dart';
import '../../features/admin/presentacion/admin_jugadores_pantalla.dart';
import '../../features/admin/presentacion/admin_panel_pantalla.dart';
import '../../features/admin/presentacion/admin_partidos_pantalla.dart';
import '../../features/admin/presentacion/admin_plantilla_pantalla.dart';
import '../../features/admin/presentacion/admin_temporadas_pantalla.dart';
import '../../features/admin/presentacion/admin_usuarios_pantalla.dart';
import '../../features/anotador/presentacion/anotador_inicio_pantalla.dart';
import '../../features/anotador/presentacion/anotador_pantalla.dart';
import '../../features/anotador/presentacion/partido_control_pantalla.dart';
import '../../features/auth/presentacion/cuenta_pantalla.dart';
import '../../features/auth/presentacion/login_pantalla.dart';
import '../../features/auth/presentacion/registro_pantalla.dart';
import '../../features/comparador/presentacion/comparador_pantalla.dart';
import '../../features/jugadores/presentacion/lideres_pantalla.dart';
import '../../features/prediccion/presentacion/prediccion_pantalla.dart';
import '../../features/temporadas/presentacion/inicio_pantalla.dart';
import '../../liga/presentacion/alineacion_liga_pantalla.dart';
import '../../liga/presentacion/equipo_liga_pantalla.dart';
import '../../liga/presentacion/jugador_liga_pantalla.dart';
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
  if (ruta.startsWith('/anotador')) {
    if (!sesion.autenticado) {
      return Uri(path: '/login', queryParameters: {'destino': destino.toString()}).toString();
    }
    if (!sesion.puedeAnotar) return '/cuenta';
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
                    // Cara a cara entre dos jugadores: tipo = bateo | pitcheo.
                    GoRoute(
                        path: 'comparar/:tipo',
                        builder: (_, s) => ComparadorPantalla(
                              idTemporada: int.parse(s.pathParameters['t']!),
                              pitcheo: s.pathParameters['tipo'] == 'pitcheo',
                              a: int.tryParse(s.uri.queryParameters['a'] ?? '') ?? 0,
                              b: int.tryParse(s.uri.queryParameters['b'] ?? '') ?? 0,
                            )),
                    GoRoute(
                        path: 'equipos/:e',
                        builder: (_, s) => EquipoLigaPantalla(
                            idTemporada: int.parse(s.pathParameters['t']!),
                            idEquipo: int.parse(s.pathParameters['e']!))),
                    GoRoute(
                        // ?e=<equipo> para mostrar número y posición; sin e = agente libre.
                        path: 'jugadores/:j',
                        builder: (_, s) => JugadorLigaPantalla(
                            idTemporada: int.parse(s.pathParameters['t']!),
                            idJugador: int.parse(s.pathParameters['j']!),
                            idEquipo: int.tryParse(s.uri.queryParameters['e'] ?? ''))),
                  ],
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/lideres', builder: (_, _) => const LideresPantalla()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/prediccion',
                // ?b=<bateador>&l=<lanzador> abre el duelo ya elegido (desde el partido en vivo).
                builder: (_, s) => PrediccionPantalla(
                    bateador: int.tryParse(s.uri.queryParameters['b'] ?? ''),
                    lanzador: int.tryParse(s.uri.queryParameters['l'] ?? ''))),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/cuenta', builder: (_, _) => const CuentaPantalla()),
          ]),
        ],
      ),
      GoRoute(path: '/login', builder: (_, s) => LoginPantalla(destino: s.uri.queryParameters['destino'])),
      GoRoute(path: '/registro', builder: (_, s) => RegistroPantalla(destino: s.uri.queryParameters['destino'])),
      // Anotador en vivo (rol anotador o admin).
      GoRoute(
        path: '/anotador',
        builder: (_, _) => const AnotadorInicioPantalla(),
        routes: [
          GoRoute(
            path: 't/:t/p/:p',
            builder: (_, s) => PartidoControlPantalla(
                idTemporada: int.parse(s.pathParameters['t']!), idPartido: int.parse(s.pathParameters['p']!)),
            routes: [
              GoRoute(
                  path: 'alineacion',
                  builder: (_, s) => AdminAlineacionPantalla(
                      idTemporada: int.parse(s.pathParameters['t']!),
                      idPartido: int.parse(s.pathParameters['p']!))),
              GoRoute(
                  path: 'juego',
                  builder: (_, s) => AnotadorPantalla(idPartido: int.parse(s.pathParameters['p']!))),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/admin',
        builder: (_, _) => const AdminPanelPantalla(),
        routes: [
          GoRoute(path: 'temporadas', builder: (_, _) => const AdminTemporadasPantalla()),
          GoRoute(path: 'equipos', builder: (_, _) => const AdminEquiposPantalla()),
          GoRoute(path: 'jugadores', builder: (_, _) => const AdminJugadoresPantalla()),
          GoRoute(path: 'estadios', builder: (_, _) => const AdminEstadiosPantalla()),
          GoRoute(path: 'usuarios', builder: (_, _) => const AdminUsuariosPantalla()),
          GoRoute(
              path: 't/:t/plantilla',
              builder: (_, s) => AdminPlantillasPantalla(idTemporada: int.parse(s.pathParameters['t']!))),
          GoRoute(
              path: 't/:t/plantilla/:e',
              builder: (_, s) => AdminPlantillaEquipoPantalla(
                  idTemporada: int.parse(s.pathParameters['t']!), idEquipo: int.parse(s.pathParameters['e']!)),
              routes: [
                GoRoute(
                    path: 'inscribir',
                    builder: (_, s) => AdminInscripcionPantalla(
                        idTemporada: int.parse(s.pathParameters['t']!), idEquipo: int.parse(s.pathParameters['e']!))),
              ]),
          GoRoute(
              path: 't/:t/agentes-libres',
              builder: (_, s) =>
                  AdminPlantillaEquipoPantalla(idTemporada: int.parse(s.pathParameters['t']!), idEquipo: null),
              routes: [
                GoRoute(
                    path: 'inscribir',
                    builder: (_, s) =>
                        AdminInscripcionPantalla(idTemporada: int.parse(s.pathParameters['t']!), idEquipo: null)),
              ]),
          GoRoute(
              path: 't/:t/partidos',
              builder: (_, s) => AdminPartidosPantalla(idTemporada: int.parse(s.pathParameters['t']!)),
              routes: [
                GoRoute(
                    path: ':p/alineacion',
                    builder: (_, s) => AdminAlineacionPantalla(
                        idTemporada: int.parse(s.pathParameters['t']!),
                        idPartido: int.parse(s.pathParameters['p']!))),
              ]),
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
