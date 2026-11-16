import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'base_graficas.dart';

class PuntoPartido {
  const PuntoPartido({
    required this.id,
    required this.total,
    required this.etiqueta,
    required this.detalle,
  });

  final String id;
  final int total;

  /// Etiqueta corta del eje (p. ej. "7 feb").
  final String etiqueta;

  /// Texto del tooltip (p. ej. "Pelícanos 5 – 3 Iguanas").
  final String detalle;
}

/// Carreras totales de cada partido en orden cronológico, con el promedio de la liga
/// como referencia. Tocar un punto abre el partido.
class GraficaPartidos extends StatelessWidget {
  const GraficaPartidos({super.key, required this.puntos, required this.promedio, this.onTap, this.alto = 200});

  final List<PuntoPartido> puntos;
  final double? promedio;
  final ValueChanged<String>? onTap;
  final double alto;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final color = Theme.of(context).colorScheme.primary;
    final maxY = puntos.fold<int>(1, (m, p) => math.max(m, p.total)).toDouble() + 2;
    final paso = math.max(1, (puntos.length / 5).ceil());
    return SizedBox(
      height: alto,
      child: EntradaAnimada(
        clave: puntos.length,
        builder: (context, t) => LineChart(
          LineChartData(
            minX: 0,
            maxX: math.max(1, puntos.length - 1).toDouble(),
            minY: 0,
            maxY: maxY,
            lineBarsData: [
              LineChartBarData(
                spots: [for (var i = 0; i < puntos.length; i++) FlSpot(i.toDouble(), puntos[i].total * t)],
                isCurved: true,
                preventCurveOverShooting: true,
                color: color,
                barWidth: 2,
                dotData: FlDotData(
                  getDotPainter: (_, _, _, _) =>
                      FlDotCirclePainter(radius: 3, color: color, strokeWidth: 1.5, strokeColor: e.superficie),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color.withValues(alpha: 0.28), color.withValues(alpha: 0.0)],
                  ),
                ),
              ),
            ],
            extraLinesData: ExtraLinesData(horizontalLines: [
              if (promedio != null)
                HorizontalLine(
                  y: promedio!,
                  color: e.eje,
                  strokeWidth: 1,
                  dashArray: const [4, 4],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: e.ejeTexto,
                    labelResolver: (_) => 'Prom. ${promedio!.toStringAsFixed(1).replaceAll('.', ',')}',
                  ),
                ),
            ]),
            gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => FlLine(color: e.rejilla, strokeWidth: 1),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  maxIncluded: false,
                  getTitlesWidget: (v, meta) => SideTitleWidget(meta: meta, child: Text('${v.toInt()}', style: e.ejeTexto)),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  interval: paso.toDouble(),
                  getTitlesWidget: (v, meta) {
                    final i = v.toInt();
                    if (i < 0 || i >= puntos.length || v != i.toDouble()) return const SizedBox.shrink();
                    return SideTitleWidget(meta: meta, child: Text(puntos[i].etiqueta, style: e.ejeTexto));
                  },
                ),
              ),
            ),
            lineTouchData: LineTouchData(
              touchCallback: (evento, respuesta) {
                if (onTap == null || evento is! FlTapUpEvent) return;
                final punto = respuesta?.lineBarSpots?.firstOrNull;
                if (punto != null) onTap!(puntos[punto.spotIndex].id);
              },
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => e.tooltip,
                fitInsideHorizontally: true,
                getTooltipItems: (spots) => [
                  for (final s in spots)
                    LineTooltipItem('${puntos[s.spotIndex].detalle}\n${puntos[s.spotIndex].total} carreras', e.tooltipTexto),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
