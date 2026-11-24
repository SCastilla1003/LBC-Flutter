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
import 'package:lbc_app/features/admin/presentacion/admin_equipos_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_estadios_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_jugadores_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_panel_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_partidos_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_plantilla_pantalla.dart';
import 'package:lbc_app/features/admin/presentacion/admin_temporadas_pantalla.dart';
import 'package:lbc_app/liga/datos/liga_repositorio.dart';
import 'package:lbc_app/liga/datos/modelos_liga.dart';

/// Servidor simulado: guarda cada petición y responde lo que devuelva [respuesta].
class _Servidor implements HttpClientAdapter {
  _Servidor(this.respuesta);

  final Object? Function(RequestOptions o) respuesta;
  final peticiones = <(String metodo, String ruta, Object? cuerpo)>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions o,
    Stream<Uint8List>? cuerpo,
    Future<void>? cancelar,
  ) async {
    final datos = o.data is String ? jsonDecode(o.data as String) : o.data;
    peticiones.add((o.method, o.path, datos));
    final r = respuesta(o);
    return ResponseBody.fromString(
      r == null ? '' : jsonEncode(r),
      r == null ? 204 : 200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _temporada = {
  'id': 1,
  'nombre': 'Temporada 2026',
  'anio': 2026,
  'estado': 'DRAFT',
};
const _equipo = {'id': 4, 'nombre': 'Pelícanos', 'abreviatura': 'PEL'};
const _jugador = {'id': 17, 'nombres': 'Luis', 'apellidos': 'Calvo'};
const _entrada = {
  'id': 40,
  'jugador': {'id': 17, 'nombres': 'Luis', 'apellidos': 'Calvo'},
  'numero': 7,
  'posicion': 'SS',
};
const _partido = {
  'id': 9,
  'temporadaId': 1,
  'fechaHora': '2026-02-07T15:00',
  'estado': 'SCHEDULED',
  'equipoLocal': {'id': 4, 'nombre': 'Pelícanos', 'abreviatura': 'PEL'},
  'equipoVisita': {'id': 5, 'nombre': 'Corsarios', 'abreviatura': 'COR'},
  'marcador': {'local': 0, 'visita': 0},
};

Object? _responder(RequestOptions o) {
  if (o.method == 'DELETE') return null;
  final ruta = o.path;
  if (ruta.contains('/plantilla')) return _entrada;
  if (ruta.contains('/partidos')) return _partido;
  if (ruta.startsWith('/equipos')) return _equipo;
  if (ruta.startsWith('/jugadores')) return _jugador;
  if (ruta.startsWith('/estadios')) return {'id': 2, 'nombre': 'El Laguito'};
  if (ruta == '/temporadas' && o.method == 'GET') return [];
  return _temporada;
}

/// Lecturas en lista para pintar las pantallas del panel.
Object? _listas(RequestOptions o) {
  final ruta = o.path;
  return switch (ruta) {
    '/temporadas' => [
      _temporada,
      {..._temporada, 'id': 2, 'anio': 2025, 'estado': 'ACTIVE'},
    ],
    '/equipos' => [
      _equipo,
      {
        ..._equipo,
        'id': 5,
        'nombre': 'Corsarios de Turbaco',
        'abreviatura': 'COR',
      },
    ],
    '/jugadores' => [
      _jugador,
      {..._jugador, 'id': 18, 'apellidos': 'Ruiz', 'lanza': 'Z', 'edad': 25},
    ],
    '/estadios' => [
      {
        'id': 2,
        'nombre': 'Parque de Pelota El Laguito',
        'ubicacion': 'Cartagena',
      },
    ],
    _ when ruta.endsWith('/equipos') => [_equipo],
    _ when ruta.endsWith('/partidos') => [
      _partido,
      {..._partido, 'id': 10, 'estado': 'FINISHED'},
    ],
    _ when ruta.endsWith('/plantilla') || ruta.endsWith('/agentes-libres') => [
      _entrada,
    ],
    _ => _responder(o),
  };
}

Widget _envolver(Widget pantalla, LigaRepositorio repo, ThemeData tema) =>
    ProviderScope(
      overrides: [ligaRepositorioProvider.overrideWithValue(repo)],
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

(LigaRepositorio, _Servidor) _repo([
  Object? Function(RequestOptions) responder = _responder,
]) {
  final servidor = _Servidor(responder);
  final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))
    ..httpClientAdapter = servidor;
  return (LigaRepositorio(ClienteApi(dio)), servidor);
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  group('escrituras del contrato v1', () {
    test('crear temporada envía "nombre" (no "nombreTemporada") y DRAFT por defecto', () async {
      final (repo, s) = _repo();
      await repo.crearTemporada(
        const DatosTemporada(nombre: 'Temporada 2026', anio: 2026),
      );
      final (metodo, ruta, cuerpo) = s.peticiones.single;
      expect((metodo, ruta), ('POST', '/temporadas'));
      expect(cuerpo, {
        'nombre': 'Temporada 2026',
        'anio': 2026,
        'estado': 'DRAFT',
        'fechaInicio': null,
        'fechaFin': null,
      });
    });

    test('editar temporada: estado ACTIVE y fechas yyyy-MM-dd', () async {
      final (repo, s) = _repo();
      await repo.actualizarTemporada(
        1,
        DatosTemporada(
          nombre: 'T',
          anio: 2026,
          estado: EstadoTemporadaLiga.activa,
          fechaInicio: DateTime(2026, 1, 10),
          fechaFin: DateTime(2026, 6, 30),
        ),
      );
      final (metodo, ruta, cuerpo) = s.peticiones.single;
      expect((metodo, ruta), ('PUT', '/temporadas/1'));
      expect(cuerpo, containsPair('estado', 'ACTIVE'));
      expect(cuerpo, containsPair('fechaInicio', '2026-01-10'));
      expect(cuerpo, containsPair('fechaFin', '2026-06-30'));
    });

    test('equipo y jugador usan los catálogos globales', () async {
      final (repo, s) = _repo();
      await repo.crearEquipo(
        const DatosEquipo(
          nombre: 'Pelícanos',
          abreviatura: 'PEL',
          color: 'azul',
        ),
      );
      await repo.crearJugador(
        DatosJugador(
          nombres: 'Luis',
          apellidos: 'Calvo',
          fechaNacimiento: DateTime(2001, 5, 14),
          batea: LadoBateo.zurdo,
          lanza: LadoLanzamiento.derecho,
          esLanzador: true,
        ),
      );
      expect(s.peticiones[0].$2, '/equipos');
      expect(s.peticiones[0].$3, containsPair('abreviatura', 'PEL'));
      expect(s.peticiones[1].$2, '/jugadores');
      expect(s.peticiones[1].$3, {
        'nombres': 'Luis',
        'apellidos': 'Calvo',
        'fechaNacimiento': '2001-05-14',
        'batea': 'Z',
        'lanza': 'D',
        'esLanzador': true,
        'fotoUrl': null,
      });
    });

    test('plantilla: inscribir, traspasar a agente libre y quitar', () async {
      final (repo, s) = _repo();
      await repo.inscribir(
        1,
        jugadorId: 17,
        equipoId: 4,
        numero: 7,
        posicion: 'SS',
      );
      await repo.actualizarInscripcion(
        1,
        40,
        equipoId: null,
        numero: 7,
        posicion: 'SS',
      );
      await repo.quitarDeTemporada(1, 40);
      expect(s.peticiones.map((p) => (p.$1, p.$2)), [
        ('POST', '/temporadas/1/plantilla'),
        ('PUT', '/temporadas/1/plantilla/40'),
        ('DELETE', '/temporadas/1/plantilla/40'),
      ]);
      expect(s.peticiones[0].$3, {
        'jugadorId': 17,
        'equipoId': 4,
        'numero': 7,
        'posicion': 'SS',
      });
      expect(s.peticiones[1].$3, containsPair('equipoId', null));
    });

    test('partido: fechaHora local sin zona y rutas del contrato', () async {
      final (repo, s) = _repo();
      await repo.crearPartido(
        1,
        equipoLocalId: 4,
        equipoVisitaId: 5,
        fechaHora: DateTime(2026, 2, 7, 15),
        estadioId: 2,
      );
      await repo.actualizarPartido(
        9,
        fechaHora: DateTime(2026, 2, 8, 9, 30),
        entradasProgramadas: 7,
      );
      await repo.eliminarPartido(9);
      expect(s.peticiones[0].$2, '/temporadas/1/partidos');
      expect(s.peticiones[0].$3, {
        'equipoLocalId': 4,
        'equipoVisitaId': 5,
        'fechaHora': '2026-02-07T15:00',
        'estadioId': 2,
        'entradasProgramadas': null,
      });
      expect((s.peticiones[1].$1, s.peticiones[1].$2), ('PUT', '/partidos/9'));
      expect(s.peticiones[1].$3, containsPair('fechaHora', '2026-02-08T09:30'));
      expect(
        (s.peticiones[2].$1, s.peticiones[2].$2),
        ('DELETE', '/partidos/9'),
      );
    });
  });

  testWidgets(
    'panel: crear una temporada desde el diálogo envía el nombre escrito',
    (tester) async {
      final (repo, servidor) = _repo();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [ligaRepositorioProvider.overrideWithValue(repo)],
          child: MaterialApp(
            theme: TemaLbc.oscuro(),
            locale: const Locale('es'),
            supportedLocales: const [Locale('es')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const AdminTemporadasPantalla(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Nueva temporada'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nombre'),
        'Temporada 2026',
      );
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();

      final post = servidor.peticiones.where((p) => p.$1 == 'POST').single;
      expect(post.$2, '/temporadas');
      expect(post.$3, containsPair('nombre', 'Temporada 2026'));
      expect(post.$3, containsPair('anio', DateTime.now().year));
      expect(find.text('Temporada creada'), findsOneWidget);
    },
  );

  for (final (nombreTema, tema) in [
    ('claro', TemaLbc.claro()),
    ('oscuro', TemaLbc.oscuro()),
  ]) {
    testWidgets('las pantallas del panel pintan con datos · $nombreTema', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      for (final pantalla in <Widget>[
        const AdminPanelPantalla(),
        const AdminTemporadasPantalla(),
        const AdminEquiposPantalla(),
        const AdminJugadoresPantalla(),
        const AdminEstadiosPantalla(),
        const AdminPlantillasPantalla(idTemporada: 1),
        const AdminPlantillaEquipoPantalla(idTemporada: 1, idEquipo: 4),
        const AdminPlantillaEquipoPantalla(idTemporada: 1, idEquipo: null),
        const AdminPartidosPantalla(idTemporada: 1),
      ]) {
        final (repo, _) = _repo(_listas);
        await tester.pumpWidget(_envolver(pantalla, repo, tema));
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '${pantalla.runtimeType}',
        );
        await tester.pumpWidget(const SizedBox());
      }
    });
  }
}
