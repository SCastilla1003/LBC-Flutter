import 'package:flutter/material.dart';

import 'base_graficas.dart';

class MetricaVersus {
  const MetricaVersus({
    required this.etiqueta,
    required this.valor,
    required this.referencia,
    required this.mayorEsMejor,
    required this.formato,
  });

  final String etiqueta;
  final double? valor;
  final double? referencia;
  final bool mayorEsMejor;
  final String Function(double? v) formato;

  /// Diferencia relativa con la liga, positiva si es mejor (−1 a 1, recortada).
  double? get ventaja {
    if (valor == null || referencia == null || referencia == 0) return null;
    final rel = (valor! - referencia!) / referencia!.abs();
    return (mayorEsMejor ? rel : -rel).clamp(-1.0, 1.0);
  }
}

/// "Termómetro" frente a la liga: cada métrica es una barra que nace en el promedio de
/// la liga (eje central) y crece a la derecha si el valor es mejor o a la izquierda si es
/// peor, ya teniendo en cuenta si en esa métrica más es mejor o menos es mejor.
class VersusLiga extends StatelessWidget {
  const VersusLiga({super.key, required this.metricas, required this.clave});

  final List<MetricaVersus> metricas;
  final Object clave;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    // La mayor diferencia ocupa media barra: así también se aprecian las pequeñas
    final escala = metricas.map((m) => m.ventaja?.abs() ?? 0).fold<double>(0, (a, b) => b > a ? b : a);
    return EntradaAnimada(
      clave: clave,
      builder: (context, t) => Column(children: [
        Row(children: [
          const Spacer(flex: 5),
          Expanded(
            flex: 8,
            child: Row(children: [
              Expanded(child: Text('◀ peor', textAlign: TextAlign.center, style: e.ejeTexto)),
              Expanded(child: Text('mejor ▶', textAlign: TextAlign.center, style: e.ejeTexto)),
            ]),
          ),
          const SizedBox(width: 64),
        ]),
        const SizedBox(height: 4),
        for (final m in metricas) _Fila(metrica: m, t: t, estilo: e, escala: escala <= 0 ? 1 : escala),
      ]),
    );
  }
}

class _Fila extends StatelessWidget {
  const _Fila({required this.metrica, required this.t, required this.estilo, required this.escala});

  final MetricaVersus metrica;
  final double t;
  final EstiloGrafica estilo;
  final double escala;

  @override
  Widget build(BuildContext context) {
    final v = metrica.ventaja;
    final color = v == null ? estilo.neutro : (v >= 0 ? estilo.victoria : estilo.derrota);
    return Tooltip(
      message: '${metrica.etiqueta}: ${metrica.formato(metrica.valor)} · liga ${metrica.formato(metrica.referencia)}',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          Expanded(
            flex: 5,
            child: Text(metrica.etiqueta, style: estilo.etiqueta, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 8,
            child: LayoutBuilder(builder: (context, c) {
              final mitad = c.maxWidth / 2;
              final largo = v == null ? 0.0 : (mitad - 2) * (v.abs() / escala).clamp(0.0, 1.0) * t;
              return SizedBox(
                height: 16,
                child: Stack(children: [
                  Positioned(left: mitad - 0.5, top: 0, bottom: 0, child: Container(width: 1, color: estilo.eje)),
                  if (v != null)
                    Positioned(
                      left: v >= 0 ? mitad + 1 : mitad - 1 - largo,
                      top: 3,
                      child: Container(
                        width: largo,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(v >= 0 ? 1 : 4),
                            right: Radius.circular(v >= 0 ? 4 : 1),
                          ),
                        ),
                      ),
                    ),
                ]),
              );
            }),
          ),
          SizedBox(
            width: 64,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              if (v != null)
                Icon(v >= 0 ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded, color: color, size: 20),
              Text(metrica.formato(metrica.valor), style: estilo.valor),
            ]),
          ),
        ]),
      ),
    );
  }
}
