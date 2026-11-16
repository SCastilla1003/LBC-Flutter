import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'base_graficas.dart';

class SerieRadar {
  const SerieRadar({required this.nombre, required this.color, required this.valores, this.relleno = true});

  final String nombre;
  final Color color;

  /// Un valor crudo por eje (en el mismo orden que [RadarComparativo.ejes]).
  final List<double> valores;
  final bool relleno;
}

/// Radar con varias series superpuestas, normalizado eje por eje contra [maximos]
/// (p. ej. el máximo de la liga), así métricas de escalas distintas son comparables.
class RadarComparativo extends StatelessWidget {
  const RadarComparativo({
    super.key,
    required this.ejes,
    required this.maximos,
    required this.series,
    required this.clave,
    this.alto = 260,
  });

  final List<String> ejes;
  final List<double> maximos;
  final List<SerieRadar> series;
  final Object clave;
  final double alto;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Wrap(spacing: 14, children: [for (final s in series) ItemLeyenda(color: s.color, texto: s.nombre)]),
      SizedBox(
        height: alto,
        child: EntradaAnimada(
          clave: clave,
          builder: (context, t) => RadarChart(
            RadarChartData(
              radarShape: RadarShape.polygon,
              tickCount: 4,
              ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 1),
              tickBorderData: BorderSide(color: e.rejilla),
              gridBorderData: BorderSide(color: e.rejilla),
              radarBorderData: BorderSide(color: e.eje.withValues(alpha: 0.6)),
              titlePositionPercentageOffset: 0.14,
              titleTextStyle: e.etiquetaSuave,
              getTitle: (i, angulo) => RadarChartTitle(text: ejes[i]),
              radarTouchData: RadarTouchData(enabled: false),
              dataSets: [
                // Conjunto invisible que fija la escala a 0–100
                RadarDataSet(
                  dataEntries: [for (final _ in ejes) const RadarEntry(value: 100)],
                  fillColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  entryRadius: 0,
                  borderWidth: 0,
                ),
                for (final s in series)
                  RadarDataSet(
                    dataEntries: [
                      for (var i = 0; i < ejes.length; i++)
                        RadarEntry(
                          value: maximos[i] <= 0 ? 0 : math.min(100, s.valores[i] / maximos[i] * 100) * t,
                        ),
                    ],
                    fillColor: s.relleno ? s.color.withValues(alpha: 0.22) : Colors.transparent,
                    borderColor: s.color,
                    borderWidth: 2,
                    entryRadius: 3,
                  ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
