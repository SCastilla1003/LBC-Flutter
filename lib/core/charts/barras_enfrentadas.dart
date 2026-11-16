import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'base_graficas.dart';

class Duelo {
  const Duelo({required this.etiqueta, required this.a, required this.b, this.menorEsMejor = false, this.formato});

  final String etiqueta;
  final double? a;
  final double? b;
  final bool menorEsMejor;
  final String Function(double v)? formato;

  String texto(double? v) => v == null ? '—' : (formato?.call(v) ?? (v == v.roundToDouble() ? '${v.toInt()}' : v.toStringAsFixed(2).replaceAll('.', ',')));

  /// -1 gana A, 1 gana B, 0 empate o sin datos.
  int get ganador {
    if (a == null || b == null || a == b) return 0;
    final aMejor = menorEsMejor ? a! < b! : a! > b!;
    return aMejor ? -1 : 1;
  }
}

/// "Cara a cara": barras que salen del centro hacia cada lado, una métrica por fila.
/// La cifra del que gana cada duelo va resaltada.
class BarrasEnfrentadas extends StatelessWidget {
  const BarrasEnfrentadas({super.key, required this.duelos, required this.colorA, required this.colorB, required this.clave});

  final List<Duelo> duelos;
  final Color colorA;
  final Color colorB;
  final Object clave;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    return EntradaAnimada(
      clave: clave,
      builder: (context, t) => Column(children: [
        for (final d in duelos)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(children: [
              Text(d.etiqueta, style: e.etiquetaSuave),
              const SizedBox(height: 3),
              Row(children: [
                SizedBox(
                  width: 52,
                  child: Text(d.texto(d.a),
                      textAlign: TextAlign.start,
                      style: e.valor.copyWith(
                          fontWeight: d.ganador == -1 ? FontWeight.w900 : FontWeight.w400,
                          color: d.ganador == 1 ? e.etiquetaSuave.color : null)),
                ),
                Expanded(child: _Lado(valor: d.a, otro: d.b, color: colorA, haciaIzquierda: true, t: t, atenuado: d.ganador == 1)),
                const SizedBox(width: 4),
                Expanded(child: _Lado(valor: d.b, otro: d.a, color: colorB, haciaIzquierda: false, t: t, atenuado: d.ganador == -1)),
                SizedBox(
                  width: 52,
                  child: Text(d.texto(d.b),
                      textAlign: TextAlign.end,
                      style: e.valor.copyWith(
                          fontWeight: d.ganador == 1 ? FontWeight.w900 : FontWeight.w400,
                          color: d.ganador == -1 ? e.etiquetaSuave.color : null)),
                ),
              ]),
            ]),
          ),
      ]),
    );
  }
}

class _Lado extends StatelessWidget {
  const _Lado({required this.valor, required this.otro, required this.color, required this.haciaIzquierda, required this.t, required this.atenuado});

  final double? valor;
  final double? otro;
  final Color color;
  final bool haciaIzquierda;
  final double t;
  final bool atenuado;

  @override
  Widget build(BuildContext context) {
    final maximo = math.max(valor ?? 0, otro ?? 0);
    final proporcion = maximo <= 0 || valor == null ? 0.0 : valor! / maximo;
    return LayoutBuilder(builder: (context, c) {
      return Align(
        alignment: haciaIzquierda ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: c.maxWidth * proporcion * t,
          height: 12,
          decoration: BoxDecoration(
            color: color.withValues(alpha: atenuado ? 0.4 : 1),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(haciaIzquierda ? 4 : 1),
              right: Radius.circular(haciaIzquierda ? 1 : 4),
            ),
          ),
        ),
      );
    });
  }
}
