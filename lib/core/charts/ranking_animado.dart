import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'base_graficas.dart';

class EntradaRanking {
  const EntradaRanking({
    required this.id,
    required this.nombre,
    required this.subtitulo,
    required this.valor,
    required this.texto,
    required this.avatar,
    required this.color,
  });

  final String id;
  final String nombre;
  final String? subtitulo;
  final double valor;
  final String texto;
  final Widget avatar;
  final Color color;
}

/// Ranking tipo "carrera de barras": cada barra crece de forma escalonada hasta su valor
/// relativo al líder. Si [menorEsMejor], la barra del mejor (el menor) es la más larga.
class RankingAnimado extends StatelessWidget {
  const RankingAnimado({super.key, required this.entradas, required this.clave, this.menorEsMejor = false, this.onTap});

  final List<EntradaRanking> entradas;
  final Object clave;
  final bool menorEsMejor;
  final ValueChanged<String>? onTap;

  static const _medallas = [Color(0xFFD4A017), Color(0xFF9EA4AA), Color(0xFFB0703C)];

  double _proporcion(double v, double mejor) {
    if (menorEsMejor) return v <= 0 ? 1 : (mejor / v).clamp(0.05, 1.0);
    return mejor <= 0 ? 0 : (v / mejor).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    if (entradas.isEmpty) return const SizedBox.shrink();
    final mejor = menorEsMejor
        ? entradas.map((x) => x.valor).reduce(math.min)
        : entradas.map((x) => x.valor).reduce(math.max);
    return EntradaAnimada(
      clave: clave,
      duracion: const Duration(milliseconds: 1100),
      builder: (context, t) => Column(children: [
        for (var i = 0; i < entradas.length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap == null ? null : () => onTap!(entradas[i].id),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(children: [
                SizedBox(
                  width: 26,
                  child: i < 3
                      ? Icon(Icons.emoji_events_rounded, size: 20, color: _medallas[i])
                      : Text('${i + 1}', textAlign: TextAlign.center, style: e.valor),
                ),
                const SizedBox(width: 6),
                entradas[i].avatar,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(
                        child: Text(entradas[i].nombre,
                            style: e.etiqueta.copyWith(fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      if (entradas[i].subtitulo != null)
                        Flexible(
                          child: Text(entradas[i].subtitulo!, style: e.etiquetaSuave, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                    ]),
                    const SizedBox(height: 4),
                    LayoutBuilder(builder: (context, c) {
                      final avance = ((t * (1 + entradas.length * 0.06)) - i * 0.06).clamp(0.0, 1.0);
                      return Container(
                        width: math.max(4, c.maxWidth * _proporcion(entradas[i].valor, mejor) * avance),
                        height: 10,
                        decoration: BoxDecoration(color: entradas[i].color, borderRadius: BorderRadius.circular(4)),
                      );
                    }),
                  ]),
                ),
                SizedBox(width: 56, child: Text(entradas[i].texto, textAlign: TextAlign.end, style: e.valor.copyWith(fontSize: 16))),
              ]),
            ),
          ),
      ]),
    );
  }
}
