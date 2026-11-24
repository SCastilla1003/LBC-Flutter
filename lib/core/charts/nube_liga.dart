import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'base_graficas.dart';

class PuntoNube {
  const PuntoNube({required this.id, required this.nombre, required this.x, required this.y});

  final String id;
  final String nombre;
  final double x;
  final double y;
}

/// Nube de la liga: todos los jugadores como puntos grises y el jugador en foco resaltado
/// con su color. Las líneas punteadas son los promedios de la liga y dividen el plano en
/// cuatro cuadrantes con nombre. Tocar un punto abre ese jugador.
class NubeLiga extends StatelessWidget {
  const NubeLiga({
    super.key,
    required this.puntos,
    required this.idResaltado,
    required this.colorResaltado,
    required this.ejeX,
    required this.ejeY,
    required this.cuadrantes,
    this.onTap,
    this.alto = 240,
  });

  final List<PuntoNube> puntos;
  final String idResaltado;
  final Color colorResaltado;
  final String ejeX;
  final String ejeY;

  /// Nombres de los cuadrantes: [arriba-izq, arriba-der, abajo-izq, abajo-der].
  final List<String> cuadrantes;
  final ValueChanged<String>? onTap;
  final double alto;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    if (puntos.isEmpty) return const SizedBox.shrink();
    final promX = puntos.map((p) => p.x).reduce((a, b) => a + b) / puntos.length;
    final promY = puntos.map((p) => p.y).reduce((a, b) => a + b) / puntos.length;
    final (maxX, pasoX) = _escala(puntos.map((p) => p.x));
    final (maxY, pasoY) = _escala(puntos.map((p) => p.y));
    // El resaltado al final para que quede encima
    final orden = [...puntos.where((p) => p.id != idResaltado), ...puntos.where((p) => p.id == idResaltado)];

    Widget esquina(String texto, Alignment a) => Align(
          alignment: a,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(54, 4, 8, 42),
            child: Text(texto, style: e.ejeTexto.copyWith(fontStyle: FontStyle.italic)),
          ),
        );

    return SizedBox(
      height: alto,
      child: EntradaAnimada(
        clave: idResaltado,
        builder: (context, t) => Stack(children: [
          esquina(cuadrantes[0], Alignment.topLeft),
          esquina(cuadrantes[1], Alignment.topRight),
          esquina(cuadrantes[2], Alignment.bottomLeft),
          esquina(cuadrantes[3], Alignment.bottomRight),
          // Promedios de la liga (el área del gráfico empieza tras los ejes: 46 px a la izquierda, 34 abajo)
          Positioned.fill(
            child: CustomPaint(
              painter: _LineasPromedio(
                x: promX / maxX,
                y: promY / maxY,
                color: e.eje,
                izquierda: 46,
                abajo: 34,
              ),
            ),
          ),
          ScatterChart(
            ScatterChartData(
              minX: 0,
              maxX: maxX,
              minY: 0,
              maxY: maxY,
              scatterSpots: [
                for (final p in orden)
                  ScatterSpot(
                    p.x * t + promX * (1 - t),
                    p.y * t + promY * (1 - t),
                    dotPainter: p.id == idResaltado
                        ? FlDotCirclePainter(radius: 8, color: colorResaltado, strokeWidth: 3, strokeColor: e.superficie)
                        : FlDotCirclePainter(radius: 4.5, color: e.neutro, strokeWidth: 1, strokeColor: e.superficie),
                  ),
              ],
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border(left: BorderSide(color: e.rejilla), bottom: BorderSide(color: e.rejilla)),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  axisNameWidget: Text(ejeY, style: e.ejeTexto),
                  axisNameSize: 16,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: pasoY,
                    maxIncluded: false,
                    getTitlesWidget: (v, meta) => SideTitleWidget(meta: meta, child: Text(_n(v), style: e.ejeTexto)),
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(ejeX, style: e.ejeTexto),
                  axisNameSize: 16,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 18,
                    interval: pasoX,
                    maxIncluded: false,
                    getTitlesWidget: (v, meta) => SideTitleWidget(meta: meta, child: Text(_n(v), style: e.ejeTexto)),
                  ),
                ),
              ),
              scatterTouchData: ScatterTouchData(
                touchSpotThreshold: 10,
                touchCallback: (evento, respuesta) {
                  if (onTap == null || evento is! FlTapUpEvent) return;
                  final i = respuesta?.touchedSpot?.spotIndex;
                  if (i != null) onTap!(orden[i].id);
                },
                touchTooltipData: ScatterTouchTooltipData(
                  getTooltipColor: (_) => e.tooltip,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipItems: (spot) {
                    final i = orden.indexWhere((p) => (p.x - spot.x).abs() < 1e-6 && (p.y - spot.y).abs() < 1e-6);
                    if (i < 0) return null;
                    final p = orden[i];
                    return ScatterTooltipItem('${p.nombre}\n$ejeX ${_n(p.x)} · $ejeY ${_n(p.y)}', textStyle: e.tooltipTexto);
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Tope y paso del eje. Si todos son enteros (ponches, bases por bolas), las marcas
  /// también: nada de "0,5 ponches". Con pocos datos el tope es al menos 2.
  static (double, double?) _escala(Iterable<double> valores) {
    final maximo = valores.reduce(math.max);
    final tope = (maximo * 1.15 + 0.5).ceilToDouble();
    final enteros = valores.every((v) => v == v.roundToDouble());
    if (!enteros) return (tope, null);
    final paso = math.max(1, (tope / 5).ceil()).toDouble();
    return (math.max(tope, 2 * paso), paso);
  }

  static String _n(double v) => v == v.roundToDouble() ? '${v.toInt()}' : v.toStringAsFixed(1).replaceAll('.', ',');
}

class _LineasPromedio extends CustomPainter {
  _LineasPromedio({required this.x, required this.y, required this.color, required this.izquierda, required this.abajo});

  final double x;
  final double y;
  final Color color;
  final double izquierda;
  final double abajo;

  @override
  void paint(Canvas canvas, Size size) {
    final ancho = size.width - izquierda;
    final alto = size.height - abajo;
    final pincel = Paint()
      ..color = color
      ..strokeWidth = 1;
    final px = izquierda + ancho * x;
    final py = alto * (1 - y);
    for (var v = 0.0; v < alto; v += 7) {
      canvas.drawLine(Offset(px, v), Offset(px, math.min(v + 3, alto)), pincel);
    }
    for (var h = izquierda; h < size.width; h += 7) {
      canvas.drawLine(Offset(h, py), Offset(math.min(h + 3, size.width), py), pincel);
    }
  }

  @override
  bool shouldRepaint(_LineasPromedio old) => old.x != x || old.y != y || old.color != color;
}
