import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'base_graficas.dart';

/// Una categoría del waffle: etiqueta, valor absoluto y color.
class ParteWaffle {
  const ParteWaffle({
    required this.etiqueta,
    required this.valor,
    required this.color,
  });

  final String etiqueta;
  final double valor;
  final Color color;
}

/// Reparte 100 cuadros entre las partes usando el método del mayor residuo,
/// para que nunca se pierda ni se invente un cuadro por redondeo.
List<int> cuadrosWaffle(List<double> valores) {
  final total = valores.fold<double>(0, (s, v) => s + v);
  if (total <= 0) return List<int>.filled(valores.length, 0);
  final exactos = [for (final v in valores) v / total * 100];
  final base = [for (final v in exactos) v.floor()];
  var faltan = 100 - base.fold<int>(0, (s, v) => s + v);
  final orden = List<int>.generate(valores.length, (i) => i)
    ..sort((a, b) => (exactos[b] - base[b]).compareTo(exactos[a] - base[a]));
  for (var i = 0; i < orden.length && faltan > 0; i++) {
    base[orden[i]]++;
    faltan--;
  }
  return base;
}

/// Waffle de 10 × 10: cada cuadro es 1 % del total. Poco habitual y muy legible
/// para composiciones (sencillos, dobles, triples y jonrones, por ejemplo).
class GraficaWaffle extends StatelessWidget {
  const GraficaWaffle({
    super.key,
    required this.partes,
    required this.clave,
    this.unidad = '',
    this.ladoMaximo = 300,
  });

  final List<ParteWaffle> partes;
  final Object clave;
  final String unidad;
  final double ladoMaximo;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final total = partes.fold<double>(0, (s, p) => s + p.valor);
    if (total <= 0) return Text('Sin datos.', style: e.etiquetaSuave);
    final cuadros = cuadrosWaffle([for (final p in partes) p.valor]);
    final colores = <Color>[
      for (var i = 0; i < partes.length; i++)
        ...List<Color>.filled(cuadros[i], partes[i].color),
    ];
    final etiquetas = <String>[
      for (var i = 0; i < partes.length; i++)
        ...List<String>.filled(cuadros[i], partes[i].etiqueta),
    ];
    final totalEntero = total.round();

    return Semantics(
      label:
          'Composición de $totalEntero $unidad: '
          '${[for (final p in partes) '${p.etiqueta} ${p.valor.round()}'].join(', ')}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final lado = math.min(ladoMaximo, c.maxWidth);
              return Center(
                child: SizedBox(
                  width: lado,
                  child: EntradaAnimada(
                    clave: clave,
                    builder: (context, t) {
                      final visibles = (t * 100).round();
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Column(
                          children: [
                            for (var fila = 0; fila < 10; fila++)
                              Expanded(
                                child: Row(
                                  children: [
                                    for (
                                      var columna = 0;
                                      columna < 10;
                                      columna++
                                    )
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.6),
                                          child: Tooltip(
                                            message:
                                                fila * 10 + columna <
                                                    colores.length
                                                ? '${etiquetas[fila * 10 + columna]} · 1 %'
                                                : '',
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color:
                                                    fila * 10 + columna <
                                                        visibles
                                                    ? colores[fila * 10 +
                                                          columna]
                                                    : e.neutro.withValues(
                                                        alpha: 0.18,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(2.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              for (var i = 0; i < partes.length; i++)
                ItemLeyenda(
                  color: partes[i].color,
                  texto:
                      '${partes[i].etiqueta} · ${partes[i].valor.round()} '
                      '(${cuadros[i]} %)',
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Cada cuadro equivale al 1 % del total.',
            textAlign: TextAlign.center,
            style: e.ejeTexto,
          ),
        ],
      ),
    );
  }
}
