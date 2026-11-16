import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'base_graficas.dart';

class SegmentoBarra {
  const SegmentoBarra({required this.valor, required this.color, this.etiqueta});

  final double valor;
  final Color color;

  /// Texto dentro del segmento (si cabe). Por defecto, el valor.
  final String? etiqueta;
}

class FilaApilada {
  const FilaApilada({
    required this.id,
    required this.nombre,
    required this.segmentos,
    this.inicio,
    this.valorFinal,
    this.onTap,
  });

  final String id;
  final String nombre;
  final List<SegmentoBarra> segmentos;
  final Widget? inicio;
  final String? valorFinal;
  final VoidCallback? onTap;

  double get total => segmentos.fold(0, (s, x) => s + x.valor);
}

/// Barras horizontales apiladas con crecimiento animado, separación de 2 px entre
/// segmentos y la cifra de cada segmento dentro de él.
class BarrasApiladas extends StatelessWidget {
  const BarrasApiladas({super.key, required this.filas, required this.clave, this.maximo, this.altoBarra = 14});

  final List<FilaApilada> filas;
  final Object clave;
  final double? maximo;
  final double altoBarra;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final maxTotal = maximo ?? filas.fold<double>(1, (m, f) => math.max(m, f.total));
    return EntradaAnimada(
      clave: clave,
      builder: (context, t) => Column(children: [
        for (var i = 0; i < filas.length; i++)
          _Fila(
            fila: filas[i],
            maximo: maxTotal,
            // Escalonado: cada fila arranca un poco después que la anterior
            t: ((t * (1 + filas.length * 0.08)) - i * 0.08).clamp(0.0, 1.0),
            alto: altoBarra,
            estilo: e,
          ),
      ]),
    );
  }
}

class _Fila extends StatelessWidget {
  const _Fila({required this.fila, required this.maximo, required this.t, required this.alto, required this.estilo});

  final FilaApilada fila;
  final double maximo;
  final double t;
  final double alto;
  final EstiloGrafica estilo;

  @override
  Widget build(BuildContext context) {
    final contenido = Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        if (fila.inicio != null) ...[fila.inicio!, const SizedBox(width: 10)],
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(fila.nombre, style: estilo.etiqueta, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            LayoutBuilder(builder: (context, c) {
              final ancho = c.maxWidth;
              final visibles = fila.segmentos.where((s) => s.valor > 0).toList();
              final huecos = math.max(0, visibles.length - 1) * 2.0;
              final util = math.max(0.0, ancho - huecos);
              return SizedBox(
                height: alto,
                child: Row(children: [
                  for (var i = 0; i < visibles.length; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    _Segmento(
                      segmento: visibles[i],
                      ancho: util * visibles[i].valor / maximo * t,
                      alto: alto,
                      primero: i == 0,
                      ultimo: i == visibles.length - 1,
                    ),
                  ],
                ]),
              );
            }),
          ]),
        ),
        if (fila.valorFinal != null)
          SizedBox(width: 52, child: Text(fila.valorFinal!, textAlign: TextAlign.end, style: estilo.valor)),
      ]),
    );
    if (fila.onTap == null) return contenido;
    return InkWell(borderRadius: BorderRadius.circular(8), onTap: fila.onTap, child: contenido);
  }
}

class _Segmento extends StatelessWidget {
  const _Segmento({required this.segmento, required this.ancho, required this.alto, required this.primero, required this.ultimo});

  final SegmentoBarra segmento;
  final double ancho;
  final double alto;
  final bool primero;
  final bool ultimo;

  @override
  Widget build(BuildContext context) {
    final texto = segmento.etiqueta ?? segmento.valor.round().toString();
    final tinta = ThemeData.estimateBrightnessForColor(segmento.color) == Brightness.dark ? Colors.white : Colors.black87;
    return Container(
      width: ancho,
      height: alto,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: segmento.color,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(primero ? 4 : 1),
          right: Radius.circular(ultimo ? 4 : 1),
        ),
      ),
      child: ancho > texto.length * alto * 0.68 * 0.62 + 10 && alto >= 12
          ? Text(texto, style: TextStyle(color: tinta, fontSize: alto * 0.68, fontWeight: FontWeight.w700, height: 1))
          : null,
    );
  }
}

/// Una sola barra al 100 % con su leyenda (cantidad y porcentaje), p. ej. tipos de hit.
class BarraComposicion extends StatelessWidget {
  const BarraComposicion({super.key, required this.partes, required this.clave});

  /// (etiqueta, valor, color)
  final List<(String, double, Color)> partes;
  final Object clave;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final total = partes.fold<double>(0, (s, p) => s + p.$2);
    if (total <= 0) return Text('—', style: e.etiquetaSuave);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      BarrasApiladas(
        clave: clave,
        maximo: total,
        altoBarra: 26,
        filas: [
          FilaApilada(
            id: 'composicion',
            nombre: '',
            segmentos: [
              for (final p in partes)
                SegmentoBarra(valor: p.$2, color: p.$3, etiqueta: '${(p.$2 / total * 100).round()}%'),
            ],
          ),
        ],
      ),
      const SizedBox(height: 4),
      Wrap(spacing: 14, runSpacing: 4, children: [
        for (final p in partes) ItemLeyenda(color: p.$3, texto: '${p.$1} ${p.$2.round()}'),
      ]),
    ]);
  }
}
