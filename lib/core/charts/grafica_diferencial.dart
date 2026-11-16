import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'base_graficas.dart';

class BarraDiferencial {
  const BarraDiferencial({required this.id, required this.diferencial, required this.detalle, required this.etiqueta});

  final String id;
  final int diferencial;
  final String detalle;
  final String etiqueta;
}

/// Barras divergentes: diferencial de carreras de cada partido (hacia arriba y en verde si
/// ganó, hacia abajo y en rojo si perdió). Tocar una barra abre el partido.
class GraficaDiferencial extends StatelessWidget {
  const GraficaDiferencial({super.key, required this.barras, this.onTap, this.alto = 200});

  final List<BarraDiferencial> barras;
  final ValueChanged<String>? onTap;
  final double alto;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final maxAbs = barras.fold<int>(1, (m, b) => math.max(m, b.diferencial.abs())).toDouble();
    final ancho = math.max(4.0, math.min(18.0, 240 / math.max(1, barras.length)));
    return SizedBox(
      height: alto,
      child: EntradaAnimada(
        clave: barras.length,
        builder: (context, t) => BarChart(
          BarChartData(
            minY: -maxAbs - 1,
            maxY: maxAbs + 1,
            alignment: BarChartAlignment.spaceAround,
            barGroups: [
              for (var i = 0; i < barras.length; i++)
                BarChartGroupData(x: i, barRods: [
                  BarChartRodData(
                    toY: barras[i].diferencial * t,
                    width: ancho,
                    color: barras[i].diferencial > 0
                        ? e.victoria
                        : barras[i].diferencial < 0
                            ? e.derrota
                            : e.neutro,
                    borderRadius: barras[i].diferencial >= 0
                        ? const BorderRadius.vertical(top: Radius.circular(4))
                        : const BorderRadius.vertical(bottom: Radius.circular(4)),
                  ),
                ]),
            ],
            gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (v) =>
                  FlLine(color: v == 0 ? e.eje : e.rejilla, strokeWidth: v == 0 ? 1.2 : 1),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  minIncluded: false,
                  maxIncluded: false,
                  getTitlesWidget: (v, meta) => SideTitleWidget(
                    meta: meta,
                    child: Text(v > 0 ? '+${v.toInt()}' : '${v.toInt()}', style: e.ejeTexto),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  getTitlesWidget: (v, meta) {
                    final i = v.toInt();
                    final paso = math.max(1, (barras.length / 6).ceil());
                    if (i % paso != 0 || i >= barras.length) return const SizedBox.shrink();
                    return SideTitleWidget(meta: meta, child: Text(barras[i].etiqueta, style: e.ejeTexto));
                  },
                ),
              ),
            ),
            barTouchData: BarTouchData(
              touchCallback: (evento, respuesta) {
                if (onTap == null || evento is! FlTapUpEvent) return;
                final g = respuesta?.spot?.touchedBarGroupIndex;
                if (g != null) onTap!(barras[g].id);
              },
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => e.tooltip,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                getTooltipItem: (grupo, i, barra, j) => BarTooltipItem(barras[i].detalle, e.tooltipTexto),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
