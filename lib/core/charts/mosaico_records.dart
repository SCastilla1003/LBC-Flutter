import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import '../widgets/imagen_api.dart';
import 'base_graficas.dart';

/// Una columna del mosaico: el ancho representa los partidos jugados y la altura
/// la proporción de ganados, empatados y perdidos.
class ColumnaMosaico {
  const ColumnaMosaico({
    required this.id,
    required this.nombre,
    required this.color,
    required this.ganados,
    required this.perdidos,
    this.empates = 0,
  });

  final String id;
  final String nombre;
  final Color color;
  final int ganados;
  final int perdidos;
  final int empates;

  int get total => ganados + perdidos + empates;

  double get porcentaje => total == 0 ? 0 : (ganados + empates * 0.5) / total;

  String get record {
    final e = empates > 0 ? '-$empates' : '';
    return '$ganados-$perdidos$e';
  }
}

/// Mosaico (Marimekko) de récords: columnas de ancho proporcional a los partidos
/// jugados, divididas en ganados (color del equipo), empates (dorado) y perdidos
/// (neutro). Es una lectura poco común pero muy directa de la temporada.
class MosaicoRecords extends StatelessWidget {
  const MosaicoRecords({
    super.key,
    required this.columnas,
    this.alto = 210,
    this.onTap,
  });

  final List<ColumnaMosaico> columnas;
  final double alto;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final conDatos = columnas.where((c) => c.total > 0).toList();
    if (conDatos.isEmpty) {
      return Text('Aún no hay partidos jugados.', style: e.etiquetaSuave);
    }
    final maximo = conDatos.map((c) => c.total).reduce(math.max);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 4,
          children: [
            ItemLeyenda(
              color: conDatos.first.color,
              colores: [for (final c in conDatos.take(6)) c.color],
              texto: 'Ganados',
            ),
            const ItemLeyenda(color: ColoresMarca.dorado, texto: 'Empates'),
            ItemLeyenda(color: e.neutro, texto: 'Perdidos'),
          ],
        ),
        const SizedBox(height: 14),
        EntradaAnimada(
          clave: conDatos
              .map((c) => '${c.id}${c.ganados}${c.perdidos}${c.empates}')
              .join(),
          builder: (context, t) => SizedBox(
            height: alto,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final c in conDatos)
                  Expanded(
                    // El ancho relativo a los partidos jugados: más juegos, más espacio.
                    flex: math.max(1, (c.total / maximo * 100).round()),
                    child: _Columna(
                      c: c,
                      t: t,
                      alto: alto,
                      estilo: e,
                      onTap: onTap,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'El ancho de cada columna son los partidos jugados; la altura, el récord.',
          style: e.ejeTexto,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Columna extends StatelessWidget {
  const _Columna({
    required this.c,
    required this.t,
    required this.alto,
    required this.estilo,
    this.onTap,
  });

  final ColumnaMosaico c;
  final double t;
  final double alto;
  final EstiloGrafica estilo;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    final etiquetaPct = '${(c.porcentaje * 100).round()}%';
    final contenido = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            etiquetaPct,
            maxLines: 1,
            style: estilo.ejeTexto.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: alto - 40,
            child: Transform.scale(
              scaleY: t.clamp(0.0, 1.0),
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(c.total > 0 ? 5 : 2),
                ),
                child: Column(
                  children: [
                    if (c.ganados > 0)
                      Expanded(
                        flex: c.ganados,
                        child: Container(color: c.color),
                      ),
                    if (c.empates > 0)
                      Expanded(
                        flex: c.empates,
                        child: Container(color: ColoresMarca.dorado),
                      ),
                    if (c.perdidos > 0)
                      Expanded(
                        flex: c.perdidos,
                        child: Container(color: estilo.neutro),
                      ),
                    if (c.total == 0)
                      Expanded(
                        child: Container(
                          color: estilo.neutro.withValues(alpha: 0.4),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            inicialesDe(c.nombre),
            maxLines: 1,
            style: estilo.ejeTexto.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );

    final tooltip = Tooltip(
      message: '${c.nombre}\n${c.record} · $etiquetaPct de victorias',
      child: contenido,
    );
    if (onTap == null) return tooltip;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => onTap!(c.id),
      child: tooltip,
    );
  }
}
