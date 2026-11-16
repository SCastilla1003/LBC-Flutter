import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import 'base_graficas.dart';

/// El diamante de béisbol como gráfica: cada base muestra cuántas veces llegó el
/// bateador a ella con un hit (sencillo → 1.ª, doble → 2.ª, triple → 3.ª, jonrón → home).
/// El área de cada círculo es proporcional a la cantidad; en el centro, el total de bases.
class DiamanteBases extends StatelessWidget {
  const DiamanteBases({
    super.key,
    required this.sencillos,
    required this.dobles,
    required this.triples,
    required this.jonrones,
    required this.totalBases,
    this.tamano = 240,
  });

  final int sencillos;
  final int dobles;
  final int triples;
  final int jonrones;
  final int totalBases;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final colores = e.rampa(4);
    return Semantics(
      label: '$sencillos sencillos, $dobles dobles, $triples triples, $jonrones jonrones; $totalBases bases totales',
      child: Center(
        child: EntradaAnimada(
          clave: '$sencillos-$dobles-$triples-$jonrones',
          builder: (context, t) => SizedBox(
            width: tamano,
            height: tamano,
            child: CustomPaint(
              painter: _PintorDiamante(
                valores: [sencillos, dobles, triples, jonrones],
                colores: colores,
                linea: e.eje.withValues(alpha: 0.5),
                cesped: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.35),
                superficie: e.superficie,
                textoEtiqueta: e.etiquetaSuave,
                textoValor: e.valor,
                t: t,
              ),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('${(totalBases * t).round()}',
                      style: estiloCifra(Theme.of(context).textTheme.headlineMedium)?.copyWith(fontWeight: FontWeight.w800)),
                  Text('bases', style: e.etiquetaSuave),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PintorDiamante extends CustomPainter {
  _PintorDiamante({
    required this.valores,
    required this.colores,
    required this.linea,
    required this.cesped,
    required this.superficie,
    required this.textoEtiqueta,
    required this.textoValor,
    required this.t,
  });

  final List<int> valores;
  final List<Color> colores;
  final Color linea;
  final Color cesped;
  final Color superficie;
  final TextStyle textoEtiqueta;
  final TextStyle textoValor;
  final double t;

  static const _nombres = ['1B', '2B', '3B', 'HR'];

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width * 0.36;
    // home abajo, 1.ª derecha, 2.ª arriba, 3.ª izquierda
    final bases = [
      c + Offset(r, 0),
      c + Offset(0, -r),
      c + Offset(-r, 0),
      c + Offset(0, r),
    ];
    final cuadro = Path()..addPolygon([bases[3], bases[0], bases[1], bases[2]], true);
    canvas.drawPath(cuadro, Paint()..color = cesped);
    canvas.drawPath(
      cuadro,
      Paint()
        ..color = linea
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Recorrido coloreado: cada tramo tan grueso como los hits que lo recorren
    final recorridos = [
      valores[0] + valores[1] + valores[2] + valores[3], // home → 1.ª
      valores[1] + valores[2] + valores[3], // 1.ª → 2.ª
      valores[2] + valores[3], // 2.ª → 3.ª
      valores[3], // 3.ª → home
    ];
    final maxRecorrido = math.max(1, recorridos.first);
    final tramos = [(bases[3], bases[0]), (bases[0], bases[1]), (bases[1], bases[2]), (bases[2], bases[3])];
    for (var i = 0; i < 4; i++) {
      if (recorridos[i] == 0) continue;
      final (a, b) = tramos[i];
      final avance = (t * 4 - i).clamp(0.0, 1.0);
      if (avance == 0) continue;
      canvas.drawLine(
        a,
        Offset.lerp(a, b, avance)!,
        Paint()
          ..color = colores[i].withValues(alpha: 0.55)
          ..strokeWidth = 2 + 6 * recorridos[i] / maxRecorrido
          ..strokeCap = StrokeCap.round,
      );
    }

    // Círculos por base (área ∝ cantidad)
    final maxValor = math.max(1, valores.reduce(math.max));
    final radioMax = size.width * 0.13;
    for (var i = 0; i < 4; i++) {
      final vacio = valores[i] == 0;
      final radio = vacio ? 9.0 * t : math.max(10.0, radioMax * math.sqrt(valores[i] / maxValor)) * t;
      canvas.drawCircle(bases[i], radio + 2, Paint()..color = superficie);
      if (vacio) {
        canvas.drawCircle(
          bases[i],
          radio,
          Paint()
            ..color = linea
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );
      } else {
        canvas.drawCircle(bases[i], radio, Paint()..color = colores[i]);
        _texto(canvas, '${valores[i]}', bases[i], textoValor.copyWith(
          color: ThemeData.estimateBrightnessForColor(colores[i]) == Brightness.dark ? Colors.white : Colors.black87,
          fontSize: 13,
        ));
      }
      final desplazamiento = switch (i) {
        0 => Offset(radio + 16, 0),
        1 => Offset(0, -radio - 12),
        2 => Offset(-radio - 16, 0),
        _ => Offset(0, radio + 12),
      };
      _texto(canvas, _nombres[i], bases[i] + desplazamiento, textoEtiqueta);
    }
  }

  void _texto(Canvas canvas, String texto, Offset centro, TextStyle estilo) {
    final tp = TextPainter(text: TextSpan(text: texto, style: estilo), textDirection: ui.TextDirection.ltr)..layout();
    tp.paint(canvas, centro - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_PintorDiamante old) => old.t != t || old.valores != valores;
}
