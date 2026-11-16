import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'base_graficas.dart';

/// Serie de "juegos sobre .500" de un equipo: tras cada partido, ganados − perdidos.
class SerieCarrera {
  const SerieCarrera({required this.id, required this.nombre, required this.color, required this.valores});

  final String id;
  final String nombre;
  final Color color;

  /// valores[i] = ganados − perdidos tras su partido i+1.
  final List<int> valores;

  int get actual => valores.isEmpty ? 0 : valores.last;
}

/// Carrera por el primer puesto: una línea escalonada por equipo, por encima o por debajo
/// de .500. Tocar un equipo en la leyenda lo resalta y apaga al resto.
class GraficaCarrera extends StatefulWidget {
  const GraficaCarrera({super.key, required this.series, this.alto = 240});

  final List<SerieCarrera> series;
  final double alto;

  @override
  State<GraficaCarrera> createState() => _GraficaCarreraState();
}

class _GraficaCarreraState extends State<GraficaCarrera> {
  String? _resaltado;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final series = [...widget.series]..sort((a, b) => b.actual.compareTo(a.actual));
    final maxX = series.fold<int>(1, (m, s) => math.max(m, s.valores.length));
    final todos = [0, for (final s in series) ...s.valores];
    double par(double v) => (v / 2).ceil() * 2.0;
    final maxY = par(todos.reduce(math.max) + 1.0);
    final minY = -par(-(todos.reduce(math.min) - 1.0));

    LineChartBarData linea(SerieCarrera s) {
      final activo = _resaltado == null || _resaltado == s.id;
      return LineChartBarData(
        spots: [const FlSpot(0, 0), for (var i = 0; i < s.valores.length; i++) FlSpot(i + 1.0, s.valores[i].toDouble())],
        isStepLineChart: true,
        lineChartStepData: const LineChartStepData(stepDirection: LineChartStepData.stepDirectionForward),
        color: s.color.withValues(alpha: activo ? 1 : 0.15),
        barWidth: _resaltado == s.id ? 3.5 : 2,
        dotData: FlDotData(
          show: true,
          checkToShowDot: (spot, bar) => spot.x == s.valores.length,
          getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
            radius: 4.5,
            color: s.color.withValues(alpha: activo ? 1 : 0.15),
            strokeWidth: 2,
            strokeColor: e.superficie,
          ),
        ),
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      LayoutBuilder(builder: (context, c) {
        final columnas = c.maxWidth < 520 ? 2 : 3;
        final ancho = (c.maxWidth - (columnas - 1) * 8) / columnas;
        return Wrap(spacing: 8, runSpacing: 0, children: [
          for (final s in series)
            SizedBox(
              width: ancho,
              child: ItemLeyenda(
                color: s.color,
                texto: '${s.nombre} ${s.actual > 0 ? '+' : ''}${s.actual}',
                linea: true,
                activo: _resaltado == null || _resaltado == s.id,
                onTap: () => setState(() => _resaltado = _resaltado == s.id ? null : s.id),
              ),
            ),
        ]);
      }),
      const SizedBox(height: 12),
      SizedBox(
        height: widget.alto,
        child: EntradaAnimada(
          clave: series.map((s) => s.id).join(),
          builder: (context, t) => LineChart(
            duration: Anim.cambio,
            curve: Anim.curva,
            LineChartData(
              minX: 0,
              maxX: math.max(1, maxX * t),
              minY: minY,
              maxY: maxY,
              clipData: const FlClipData.all(),
              lineBarsData: [
                // El resaltado se dibuja encima
                for (final s in series.where((s) => s.id != _resaltado)) linea(s),
                for (final s in series.where((s) => s.id == _resaltado)) linea(s),
              ],
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval: 1,
                checkToShowHorizontalLine: (v) => v % 2 == 0,
                getDrawingHorizontalLine: (_) => FlLine(color: e.rejilla, strokeWidth: 1),
              ),
              extraLinesData: ExtraLinesData(horizontalLines: [
                HorizontalLine(
                  y: 0,
                  color: e.eje,
                  strokeWidth: 1,
                  dashArray: const [4, 4],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: e.ejeTexto,
                    labelResolver: (_) => '.500',
                  ),
                ),
              ]),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: 2,
                    minIncluded: false,
                    maxIncluded: false,
                    getTitlesWidget: (v, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(v > 0 ? '+${v.toInt()}' : '${v.toInt()}', style: e.ejeTexto),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Text('Partido', style: e.ejeTexto),
                  axisNameSize: 16,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 20,
                    interval: math.max(1, (maxX / 6).ceilToDouble()),
                    getTitlesWidget: (v, meta) =>
                        SideTitleWidget(meta: meta, child: Text(v == 0 ? '' : '${v.toInt()}', style: e.ejeTexto)),
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => e.tooltip,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipItems: (puntos) => [
                    for (final p in puntos)
                      () {
                        final s = series.where((s) => s.id != _resaltado).followedBy(series.where((s) => s.id == _resaltado)).elementAt(p.barIndex);
                        if (_resaltado != null && s.id != _resaltado) return null;
                        final y = p.y.toInt();
                        return LineTooltipItem('${s.nombre}  ${y > 0 ? '+' : ''}$y', e.tooltipTexto.copyWith(color: s.color.withValues(alpha: 1)));
                      }(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

/// Construye las series de la carrera a partir de los partidos finalizados (en orden).
/// [partidos]: (idLocal, idVisitante, carrerasLocal, carrerasVisitante).
Map<String, List<int>> juegosSobre500(List<(String?, String?, int, int)> partidos) {
  final acumulado = <String, int>{};
  final series = <String, List<int>>{};
  void sumar(String? id, int delta) {
    if (id == null) return;
    final v = (acumulado[id] ?? 0) + delta;
    acumulado[id] = v;
    (series[id] ??= []).add(v);
  }

  for (final (local, visitante, cl, cv) in partidos) {
    if (cl == cv) {
      sumar(local, 0);
      sumar(visitante, 0);
    } else {
      sumar(local, cl > cv ? 1 : -1);
      sumar(visitante, cv > cl ? 1 : -1);
    }
  }
  return series;
}
