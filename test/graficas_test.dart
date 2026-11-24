import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lbc_app/core/charts/anillo_registro.dart';
import 'package:lbc_app/core/charts/barras_apiladas.dart';
import 'package:lbc_app/core/charts/barras_enfrentadas.dart';
import 'package:lbc_app/core/charts/bump_posiciones.dart';
import 'package:lbc_app/core/charts/diamante_bases.dart';
import 'package:lbc_app/core/charts/grafica_carrera.dart';
import 'package:lbc_app/core/charts/medidor.dart';
import 'package:lbc_app/core/charts/mosaico_records.dart';
import 'package:lbc_app/core/charts/ranking_animado.dart';
import 'package:lbc_app/core/charts/versus_liga.dart';
import 'package:lbc_app/core/charts/waffle.dart';
import 'package:lbc_app/core/tema/tema_lbc.dart';

Widget _app(Widget hijo, {Brightness brillo = Brightness.light}) => MaterialApp(
  theme: brillo == Brightness.light ? TemaLbc.claro() : TemaLbc.oscuro(),
  home: Scaffold(
    body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(16), child: hijo),
    ),
  ),
);

void main() {
  group('identidad visual', () {
    test('el blanco es la base, verde y amarillo secundarios, rojo terciario', () {
      final tema = TemaLbc.claro();
      expect(ColoresMarca.primario, ColoresMarca.blanco);
      expect(tema.appBarTheme.backgroundColor, ColoresMarca.blanco);
      expect(tema.colorScheme.surfaceContainerLowest, ColoresMarca.blanco);
      expect(tema.scaffoldBackgroundColor.computeLuminance(), greaterThan(0.9));
      expect(tema.colorScheme.primary, ColoresMarca.verdeCampo);
      expect(tema.colorScheme.secondary, ColoresMarca.amarillo);
      expect(tema.colorScheme.tertiary, ColoresMarca.rojo);
      expect(ColoresMarca.franjaInstitucional.colors, [
        ColoresMarca.verdeCampo,
        ColoresMarca.verdeVivo,
        ColoresMarca.amarillo,
      ]);
    });
  });

  group('cálculos de las gráficas', () {
    test('juegos sobre .500 acumulados por equipo', () {
      final s = juegosSobre500([
        ('A', 'B', 5, 2), // A gana
        ('B', 'A', 4, 1), // B gana
        ('A', 'C', 3, 0), // A gana
        ('C', 'B', 2, 2), // empate
      ]);
      expect(s['A'], [1, 0, 1]);
      expect(s['B'], [-1, 0, 0]);
      expect(s['C'], [-1, -1]);
    });

    test('ventaja frente a la liga respeta "menos es mejor"', () {
      String f(double? v) => '$v';
      expect(
        const MetricaVersus(
          etiqueta: 'HR',
          valor: 12,
          referencia: 8,
          mayorEsMejor: true,
          formato: _f,
        ).ventaja,
        closeTo(0.5, 1e-9),
      );
      expect(
        const MetricaVersus(
          etiqueta: 'ERA',
          valor: 3,
          referencia: 4,
          mayorEsMejor: false,
          formato: _f,
        ).ventaja,
        closeTo(0.25, 1e-9),
      );
      expect(
        MetricaVersus(
          etiqueta: 'x',
          valor: null,
          referencia: 4,
          mayorEsMejor: true,
          formato: f,
        ).ventaja,
        isNull,
      );
    });

    test('ganador de cada duelo', () {
      expect(const Duelo(etiqueta: 'HR', a: 5, b: 3).ganador, -1);
      expect(
        const Duelo(etiqueta: 'ERA', a: 5, b: 3, menorEsMejor: true).ganador,
        1,
      );
      expect(const Duelo(etiqueta: 'K', a: 2, b: 2).ganador, 0);
      expect(const Duelo(etiqueta: 'K', a: null, b: 2).ganador, 0);
    });

    test('bump: el puesto cambia fecha a fecha', () {
      final carrera = calcularCarreraLiderato(
        equipos: const [
          ('a', 'Águilas', Colors.blue),
          ('b', 'Búhos', Colors.orange),
        ],
        partidos: [
          (DateTime(2026, 3, 1), 'a', 'b', 5, 2),
          (DateTime(2026, 3, 2), 'b', 'a', 4, 1),
          (DateTime(2026, 3, 3), 'b', 'a', 3, 0),
        ],
      );
      final aguilas = carrera.series.firstWhere((s) => s.id == 'a');
      final buhos = carrera.series.firstWhere((s) => s.id == 'b');
      expect(carrera.fechas, [
        DateTime(2026, 3, 1),
        DateTime(2026, 3, 2),
        DateTime(2026, 3, 3),
      ]);
      expect(aguilas.puestos, [1, 2, 2]);
      expect(buhos.puestos, [2, 1, 1]);
      expect(carrera.series.first.id, 'b'); // el líder actual queda primero
    });

    test('waffle: reparte 100 cuadros sin perder ninguno', () {
      expect(cuadrosWaffle([1, 1, 1]), [34, 33, 33]);
      expect(cuadrosWaffle([2, 1]), [67, 33]);
      expect(cuadrosWaffle([0, 0]), [0, 0]);
      expect(cuadrosWaffle([2, 1]).fold<int>(0, (s, v) => s + v), 100);
    });

    test('mosaico: récord y porcentaje con empates', () {
      const c = ColumnaMosaico(
        id: 'x',
        nombre: 'Faroleros',
        color: Colors.red,
        ganados: 7,
        perdidos: 2,
        empates: 1,
      );
      expect(c.total, 10);
      expect(c.record, '7-2-1');
      expect(c.porcentaje, closeTo(0.75, 1e-9));
    });
  });

  group('widgets de gráfica', () {
    testWidgets(
      'barras apiladas: nombres, cifras dentro de los segmentos y toque',
      (tester) async {
        String? tocado;
        await tester.pumpWidget(
          _app(
            BarrasApiladas(
              clave: 1,
              filas: [
                FilaApilada(
                  id: 'e1',
                  nombre: 'Faroleros',
                  valorFinal: ',875',
                  onTap: () => tocado = 'e1',
                  segmentos: const [
                    SegmentoBarra(valor: 7, color: Color(0xFF2A78D6)),
                    SegmentoBarra(valor: 1, color: Color(0xFFD6D4CE)),
                  ],
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Faroleros'), findsOneWidget);
        expect(find.text(',875'), findsOneWidget);
        expect(find.text('7'), findsOneWidget);
        await tester.tap(find.text('Faroleros'));
        expect(tocado, 'e1');
      },
    );

    testWidgets('carrera: leyenda con saldo actual y resaltado al tocar', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const GraficaCarrera(
            series: [
              SerieCarrera(
                id: 'a',
                nombre: 'Águilas',
                color: Color(0xFF2A78D6),
                valores: [1, 2, 1, 3],
              ),
              SerieCarrera(
                id: 'b',
                nombre: 'Búhos',
                color: Color(0xFFEB6834),
                valores: [-1, -2, -1, -3],
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Águilas +3'), findsOneWidget);
      expect(find.text('Búhos -3'), findsOneWidget);
      await tester.tap(find.text('Búhos -3'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('medidor: valor final y zona según la liga', (tester) async {
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => Medidor(
              valor: 2.1,
              minimo: 0,
              maximo: 10,
              etiqueta: 'ERA',
              formato: (v) => v.toStringAsFixed(2),
              zonas: zonasMenorEsMejor(
                context,
                minimo: 1.5,
                promedio: 4.5,
                maximo: 9,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('2.10'), findsOneWidget);
      expect(find.text('Élite'), findsOneWidget);
    });

    testWidgets('diamante: total de bases al terminar la animación', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const DiamanteBases(
            sencillos: 10,
            dobles: 3,
            triples: 1,
            jonrones: 2,
            totalBases: 27,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('27'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('2 jonrones')), findsOneWidget);
    });

    testWidgets('anillo de récord en modo oscuro', (tester) async {
      await tester.pumpWidget(
        _app(
          const AnilloRegistro(
            ganados: 7,
            perdidos: 1,
            centro: '7-1',
            subcentro: ',875',
          ),
          brillo: Brightness.dark,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('7-1'), findsOneWidget);
      expect(
        find.bySemanticsLabel(RegExp('7 ganados, 1 perdidos')),
        findsOneWidget,
      );
    });

    testWidgets(
      'ranking: medallas para el podio y toque para abrir el jugador',
      (tester) async {
        String? abierto;
        await tester.pumpWidget(
          _app(
            RankingAnimado(
              clave: 'hr',
              onTap: (id) => abierto = id,
              entradas: [
                for (var i = 0; i < 4; i++)
                  EntradaRanking(
                    id: 'j$i',
                    nombre: 'Jugador $i',
                    subtitulo: null,
                    valor: 10.0 - i,
                    texto: '${10 - i}',
                    avatar: const SizedBox(width: 30),
                    color: Colors.blue,
                  ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.emoji_events_rounded), findsNWidgets(3));
        expect(find.text('4'), findsOneWidget); // cuarto lugar sin medalla
        await tester.tap(find.text('Jugador 2'));
        expect(abierto, 'j2');
      },
    );

    testWidgets('cara a cara: resalta al ganador de cada duelo', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const BarrasEnfrentadas(
            clave: 'x',
            colorA: Colors.blue,
            colorB: Colors.orange,
            duelos: [Duelo(etiqueta: 'Jonrones', a: 5, b: 3)],
          ),
        ),
      );
      await tester.pumpAndSettle();
      final ganador = tester.widget<Text>(find.text('5'));
      final perdedor = tester.widget<Text>(find.text('3'));
      expect(ganador.style?.fontWeight, FontWeight.w900);
      expect(perdedor.style?.fontWeight, FontWeight.w400);
    });

    testWidgets('waffle: leyenda con el porcentaje de cada parte', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const GraficaWaffle(
            clave: 'hits',
            unidad: 'hits',
            partes: [
              ParteWaffle(
                etiqueta: 'Sencillos',
                valor: 60,
                color: Colors.amber,
              ),
              ParteWaffle(etiqueta: 'Jonrones', valor: 40, color: Colors.red),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Sencillos · 60 (60 %)'), findsOneWidget);
      expect(find.text('Jonrones · 40 (40 %)'), findsOneWidget);
      expect(
        find.text('Cada cuadro equivale al 1 % del total.'),
        findsOneWidget,
      );
    });

    testWidgets('mosaico: porcentaje y récord visible en cada columna', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          MosaicoRecords(
            columnas: [
              const ColumnaMosaico(
                id: 'a',
                nombre: 'Faroleros',
                color: Colors.red,
                ganados: 7,
                perdidos: 1,
              ),
              const ColumnaMosaico(
                id: 'b',
                nombre: 'Búhos',
                color: Colors.blue,
                ganados: 3,
                perdidos: 5,
              ),
            ],
            onTap: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('88%'), findsOneWidget);
      expect(find.text('38%'), findsOneWidget);
      expect(find.text('Ganados'), findsOneWidget);
      expect(find.text('Perdidos'), findsOneWidget);
    });

    testWidgets('bump: pinta la evolución y expone el líder actual', (
      tester,
    ) async {
      final carrera = calcularCarreraLiderato(
        equipos: const [
          ('a', 'Águilas', Colors.blue),
          ('b', 'Búhos', Colors.orange),
        ],
        partidos: [
          (DateTime(2026, 3, 1), 'a', 'b', 5, 2),
          (DateTime(2026, 3, 2), 'b', 'a', 4, 1),
        ],
      );
      await tester.pumpWidget(_app(GraficaBump(carrera: carrera)));
      await tester.pumpAndSettle();
      expect(find.text('Águilas · 2º'), findsOneWidget);
      expect(find.text('Búhos · 1º'), findsOneWidget);
      expect(
        find.bySemanticsLabel(RegExp('Líder actual: Búhos')),
        findsOneWidget,
      );
    });
  });
}

String _f(double? v) => '$v';
