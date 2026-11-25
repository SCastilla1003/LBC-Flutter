import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';
import 'package:lbc_app/core/widgets/animaciones.dart';
import 'package:lbc_app/liga/datos/juego_repositorio.dart';
import 'package:lbc_app/liga/datos/modelos_liga.dart';
import 'package:lbc_app/liga/presentacion/anuncios_juego.dart';
import 'package:lbc_app/liga/presentacion/campo_en_vivo.dart';

AccionJuego _accion(int id, String tipo, String descripcion) =>
    AccionJuego(id: id, tipo: tipo, descripcion: descripcion, entrada: 1, mitad: MitadEntrada.alta);

Map<String, dynamic> _j(int id) => {'id': id, 'nombres': 'Jugador', 'apellidos': '$id'};

/// Visita al bate (101..109) contra el lanzador 200 del local.
EstadoJuego _juego({
  required int bateador,
  Map<String, int> corredores = const {},
  int carreras = 0,
  List<AccionJuego> jugadas = const [],
}) =>
    EstadoJuego.fromJson({
      'partido': {
        'id': 9,
        'temporadaId': 1,
        'fechaHora': '2026-12-05T15:00',
        'estado': 'LIVE',
        'equipoLocal': {'id': 4, 'nombre': 'Pelícanos', 'abreviatura': 'PEL'},
        'equipoVisita': {'id': 5, 'nombre': 'Corsarios', 'abreviatura': 'COR'},
        'marcador': {'local': 0, 'visita': carreras},
        'entradasProgramadas': 9,
        'entradaActual': 1,
        'mitad': 'TOP',
        'situacion': {
          'outs': 0,
          'bateador': {'id': bateador, 'nombre': 'Jugador $bateador'},
          'lanzador': {'id': 200, 'nombre': 'Lanzador 200'},
          'corredores': {
            for (final MapEntry(key: base, value: id) in corredores.entries) base: {'id': id, 'nombre': 'Jugador $id'},
          },
        },
        'lineScore': {'entradasProgramadas': 9, 'entradas': []},
      },
      'visita': {
        'equipo': {'id': 5, 'nombre': 'Corsarios', 'abreviatura': 'COR'},
        'orden': [
          for (var i = 1; i <= 9; i++) {'orden': i, 'posicion': 'SS', 'jugador': _j(100 + i)},
        ],
        'proximo': bateador - 100,
      },
      'local': {
        'equipo': {'id': 4, 'nombre': 'Pelícanos', 'abreviatura': 'PEL'},
        'orden': [],
        'proximo': 1,
        'lanzador': _j(200),
      },
      'alineacionCompleta': true,
      'jugadas': [
        for (final a in jugadas) {'id': a.id, 'tipo': a.tipo, 'descripcion': a.descripcion, 'entrada': 1, 'mitad': 'TOP'},
      ],
    });

Future<void> _pintar(WidgetTester t, EstadoJuego juego) async {
  t.view.physicalSize = const Size(375, 900);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  await t.pumpWidget(MaterialApp(
    theme: TemaLbc.oscuro(),
    home: Scaffold(body: SingleChildScrollView(child: CampoEnVivo(juego: juego))),
  ));
}

void main() {
  group('qué se anuncia en cada jugada', () {
    test('lanzamientos', () {
      expect(anuncioDe(_accion(1, 'LANZAMIENTO', 'Bola a Jugador 102 (1-0)'))!.titulo, 'BOLA');
      expect(anuncioDe(_accion(1, 'LANZAMIENTO', 'Strike tirándole a Jugador 102 (0-1)'))!.titulo, '¡STRIKE!');
      expect(anuncioDe(_accion(1, 'LANZAMIENTO', 'Foul a Jugador 102 (0-2)'))!.vuelo, Vuelo.lanzamiento);
    });

    test('batazos, outs y carreras', () {
      final doble = anuncioDe(_accion(1, 'JUGADA', 'Jugador 102: doble. Anota Jugador 101.'))!;
      expect((doble.titulo, doble.detalle, doble.vuelo), ('¡DOBLE!', '¡CARRERA!', Vuelo.largo));
      final slam = anuncioDe(_accion(1, 'JUGADA', 'Jugador 104: ¡jonrón!. Anotan A, B, C, Jugador 104.'))!;
      expect((slam.titulo, slam.detalle), ('¡GRAND SLAM!', '¡4 CARRERAS!'));
      expect(anuncioDe(_accion(1, 'JUGADA', 'Jugador 102: doble play. Out: Jugador 101.'))!.titulo, 'DOBLE PLAY');
      expect(anuncioDe(_accion(1, 'JUGADA', 'Jugador 102: ponche. Fin de la alta del 1.'))!.titulo, '¡PONCHE!');
      expect(anuncioDe(_accion(1, 'JUGADA', 'Jugador 102: rolata para out.'))!.titulo, 'OUT');
      expect(anuncioDe(_accion(1, 'JUGADA', 'Jugador 102: elevado de sacrificio. Anota Jugador 103.'))!.detalle,
          '¡CARRERA!');
      expect(anuncioDe(_accion(1, 'JUGADA', 'Lanzamiento descontrolado: Jugador 103 a home. Anota Jugador 103.'))!
          .titulo, 'WILD PITCH');
      expect(anuncioDe(_accion(1, 'INICIO', '¡Empieza el partido!'))!.titulo, '¡PLAY BALL!');
      expect(anuncioDe(_accion(1, 'CAMBIO', 'COR: X entra por Y.')), isNull);
    });
  });

  testWidgets('lo que ya pasó no se anuncia; una jugada nueva sí, y el que anota corre a home', (t) async {
    final antes = _juego(
      bateador: 102,
      corredores: {'primera': 101},
      jugadas: [_accion(1, 'JUGADA', 'Jugador 101: sencillo.')],
    );
    await _pintar(t, antes);
    expect(find.byType(CartelAnuncio), findsNothing);
    expect(find.text('Jugador 101'), findsOneWidget);

    await _pintar(t, _juego(
      bateador: 103,
      corredores: {'segunda': 102},
      carreras: 1,
      jugadas: [_accion(2, 'JUGADA', 'Jugador 102: doble. Anota Jugador 101.'), ...antes.jugadas],
    ));
    await t.pump(const Duration(milliseconds: 700));
    expect(find.text('¡DOBLE!'), findsOneWidget);
    expect(find.text('¡CARRERA!'), findsOneWidget);
    expect(find.byType(PelotaEnVuelo), findsOneWidget);
    // El de primera sigue en el campo mientras corre a home.
    expect(find.text('Jugador 101'), findsOneWidget);

    await t.pumpAndSettle();
    expect(find.text('¡DOBLE!'), findsNothing);
    expect(find.text('Jugador 101'), findsNothing);
    expect(find.text('Jugador 102'), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('quien avanza dos bases pasa por la intermedia', (t) async {
    await _pintar(t, _juego(bateador: 102, corredores: {'primera': 101}, jugadas: [_accion(1, 'JUGADA', 'x')]));
    await t.pumpAndSettle(); // las caras terminan de aparecer
    final enPrimera = t.getCenter(find.text('Jugador 101'));
    await _pintar(t, _juego(
      bateador: 103,
      corredores: {'tercera': 101, 'primera': 102},
      jugadas: [_accion(2, 'JUGADA', 'Jugador 102: sencillo.'), _accion(1, 'JUGADA', 'x')],
    ));
    // A mitad de camino está cerca de segunda (arriba en el campo), no cruzando el cuadro.
    await t.pump(const Duration(milliseconds: 750));
    final aMitad = t.getCenter(find.text('Jugador 101'));
    expect(aMitad.dy, lessThan(enPrimera.dy - 60));
    await t.pumpAndSettle();
    final enTercera = t.getCenter(find.text('Jugador 101'));
    expect(enTercera.dx, lessThan(enPrimera.dx));
    expect((enTercera.dy - enPrimera.dy).abs(), lessThan(2));
  });

  testWidgets('al abrir la app sale el escudo y luego la app', (t) async {
    await t.pumpWidget(const MaterialApp(home: PresentacionLbc(child: Text('La app'))));
    await t.pump(const Duration(milliseconds: 400));
    expect(find.text('LIGA DE BÉISBOL DE CARTAGENA'), findsOneWidget);
    await t.pumpAndSettle();
    expect(find.text('LIGA DE BÉISBOL DE CARTAGENA'), findsNothing);
    expect(find.text('La app'), findsOneWidget);
  });
}
