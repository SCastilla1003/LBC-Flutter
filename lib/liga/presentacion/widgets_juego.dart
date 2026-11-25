import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/tema/tema_lbc.dart';
import '../datos/modelos_liga.dart';

/// Flecha de alta (arriba) o baja (abajo) seguida de un texto.
class IndicadorMitad extends StatelessWidget {
  const IndicadorMitad({super.key, required this.mitad, required this.texto, required this.color, this.estilo});

  final MitadEntrada mitad;
  final String texto;
  final Color color;
  final TextStyle? estilo;

  @override
  Widget build(BuildContext context) {
    final alta = mitad == MitadEntrada.alta;
    return Semantics(
      label: '${alta ? 'Alta' : 'Baja'} $texto',
      excludeSemantics: true,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(alta ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded, color: color, size: 22),
        Flexible(child: Text(texto, style: estilo?.copyWith(color: color) ?? TextStyle(color: color))),
      ]),
    );
  }
}

/// Diamante con las bases ocupadas en amarillo. [bases] índices 1..3 (no nulo = hay corredor).
class DiamanteBases extends StatelessWidget {
  const DiamanteBases({super.key, required this.bases, this.tamano = 20});

  final List<Object?> bases;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    Widget base(int n) {
      final ocupada = bases[n] != null;
      return Transform.rotate(
        angle: pi / 4,
        child: Container(
          width: tamano,
          height: tamano,
          decoration: BoxDecoration(
            color: ocupada ? ColoresMarca.amarillo : Colors.transparent,
            border: Border.all(color: ocupada ? ColoresMarca.amarillo : Colors.white54, width: 2),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }

    final ocupadas = [
      if (bases[1] != null) 'primera',
      if (bases[2] != null) 'segunda',
      if (bases[3] != null) 'tercera',
    ];
    final t = tamano;
    return Semantics(
      label: 'Corredores: ${ocupadas.isEmpty ? 'ninguno' : ocupadas.join(', ')}',
      child: SizedBox(
        width: t * 4.2,
        height: t * 3,
        child: Stack(children: [
          Positioned(top: t * 0.1, left: t * 1.6, child: base(2)),
          Positioned(top: t * 1.5, left: t * 0.2, child: base(3)),
          Positioned(top: t * 1.5, right: t * 0.2, child: base(1)),
        ]),
      ),
    );
  }
}

/// Fila de puntos del conteo: B (bolas), S (strikes) u O (outs).
class PuntosConteo extends StatelessWidget {
  const PuntosConteo({
    super.key,
    required this.etiqueta,
    required this.total,
    required this.marcados,
    required this.color,
  });

  final String etiqueta;
  final int total;
  final int marcados;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 16,
          child: Text(etiqueta,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
        ),
        for (var i = 0; i < total; i++)
          Container(
            width: 11,
            height: 11,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i < marcados ? color : Colors.transparent,
              border: Border.all(color: i < marcados ? color : Colors.white38, width: 1.5),
            ),
          ),
      ]),
    );
  }
}

/// Bolas, strikes y outs en una columna.
class ConteoJuego extends StatelessWidget {
  const ConteoJuego({super.key, required this.bolas, required this.strikes, required this.outs});

  final int bolas;
  final int strikes;
  final int outs;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$bolas bolas, $strikes strikes, $outs outs',
      excludeSemantics: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        PuntosConteo(etiqueta: 'B', total: 4, marcados: bolas, color: ColoresMarca.verdeNeon),
        PuntosConteo(etiqueta: 'S', total: 3, marcados: strikes, color: ColoresMarca.amarillo),
        PuntosConteo(etiqueta: 'O', total: 3, marcados: outs, color: ColoresMarca.rojoClaro),
      ]),
    );
  }
}

/// Letrero del walk off con el que terminó el partido ("WALK OFF GRAND SLAM"...).
class LetreroWalkOff extends StatelessWidget {
  const LetreroWalkOff({super.key, required this.finalEspecial, this.equipo});

  final FinalEspecial finalEspecial;

  /// Quién lo ganó (el local).
  final String? equipo;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.elasticOut,
      builder: (_, escala, hijo) => Transform.scale(scale: escala, child: hijo),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [ColoresMarca.amarillo, Color(0xFFFFA000)]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: ColoresMarca.amarillo.withValues(alpha: 0.45), blurRadius: 16)],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.celebration_rounded, color: ColoresMarca.tintaSobreAmarillo, size: 22),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                finalEspecial.texto,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColoresMarca.tintaSobreAmarillo,
                  fontFamily: FuentesLbc.titular,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  letterSpacing: 1.5,
                  height: 1.05,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.celebration_rounded, color: ColoresMarca.tintaSobreAmarillo, size: 22),
          ]),
          if (equipo != null)
            Text(
              '¡$equipo lo deja en el terreno!',
              textAlign: TextAlign.center,
              style: const TextStyle(color: ColoresMarca.tintaSobreAmarillo, fontWeight: FontWeight.w700, fontSize: 12),
            ),
        ]),
      ),
    );
  }
}
