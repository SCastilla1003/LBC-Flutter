import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import 'base_graficas.dart';

/// Anillo de victorias / derrotas / empates con el récord en el centro.
class AnilloRegistro extends StatelessWidget {
  const AnilloRegistro({
    super.key,
    required this.ganados,
    required this.perdidos,
    this.empates = 0,
    required this.centro,
    this.subcentro,
    this.tamano = 132,
  });

  final int ganados;
  final int perdidos;
  final int empates;
  final String centro;
  final String? subcentro;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final tema = Theme.of(context);
    return Semantics(
      label: '$ganados ganados, $perdidos perdidos${empates > 0 ? ', $empates empates' : ''}',
      child: EntradaAnimada(
        clave: '$ganados-$perdidos-$empates',
        builder: (context, t) => SizedBox(
          width: tamano,
          height: tamano,
          child: CustomPaint(
            painter: _PintorAnillo(
              valores: [ganados.toDouble(), perdidos.toDouble(), empates.toDouble()],
              colores: [e.victoria, e.derrota, e.neutro],
              fondo: e.neutro.withValues(alpha: 0.4),
              superficie: e.superficie,
              t: t,
            ),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(centro,
                    style: estiloCifra(tema.textTheme.titleLarge)?.copyWith(fontWeight: FontWeight.w800)),
                if (subcentro != null) Text(subcentro!, style: e.etiquetaSuave),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _PintorAnillo extends CustomPainter {
  _PintorAnillo({required this.valores, required this.colores, required this.fondo, required this.superficie, required this.t});

  final List<double> valores;
  final List<Color> colores;
  final Color fondo;
  final Color superficie;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final grosor = size.width * 0.13;
    final rect = Rect.fromLTWH(grosor / 2, grosor / 2, size.width - grosor, size.height - grosor);
    final pincel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = grosor
      ..strokeCap = StrokeCap.butt;
    final total = valores.fold<double>(0, (s, v) => s + v);
    canvas.drawArc(rect, 0, math.pi * 2, false, pincel..color = fondo);
    if (total <= 0) return;
    const hueco = 0.04; // separación entre segmentos (radianes)
    var inicio = -math.pi / 2;
    final barrido = math.pi * 2 * t;
    for (var i = 0; i < valores.length; i++) {
      if (valores[i] <= 0) continue;
      final angulo = barrido * valores[i] / total;
      canvas.drawArc(rect, inicio + hueco / 2, math.max(0, angulo - hueco), false, pincel..color = colores[i]);
      inicio += angulo;
    }
  }

  @override
  bool shouldRepaint(_PintorAnillo old) => old.t != t || old.valores != valores;
}
