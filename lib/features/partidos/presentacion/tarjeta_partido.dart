import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/modelos/modelos_comunes.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/imagen_api.dart';
import '../datos/modelos_partido.dart';

/// Tarjeta de un partido: local contra visitante, marcador (si se jugó), fecha y estadio.
class TarjetaPartido extends StatelessWidget {
  const TarjetaPartido({super.key, required this.partido, required this.idTemporada});

  final Partido partido;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final p = partido;
    final detalle = [
      Formato.fecha(p.fecha),
      if (Formato.hora(p.hora).isNotEmpty) Formato.hora(p.hora),
      if (p.estadio?.nombre != null) p.estadio!.nombre!,
    ].join(' · ');
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/temporadas/$idTemporada/partidos/${p.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: Text(detalle,
                      style: tema.textTheme.labelMedium?.copyWith(color: tema.colorScheme.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis),
                ),
                ChipEstado(estado: p.estado),
              ]),
              const SizedBox(height: 8),
              _FilaEquipo(
                equipo: p.equipoLocal,
                carreras: p.finalizado || p.estado == EstadoPartido.enJuego ? p.carrerasEquipoLocal : null,
                ganador: p.idEquipoGanador != null && p.idEquipoGanador == p.equipoLocal.id,
                etiqueta: 'Local',
              ),
              const SizedBox(height: 6),
              _FilaEquipo(
                equipo: p.equipoVisitante,
                carreras: p.finalizado || p.estado == EstadoPartido.enJuego ? p.carrerasEquipoVisitante : null,
                ganador: p.idEquipoGanador != null && p.idEquipoGanador == p.equipoVisitante.id,
                etiqueta: 'Visitante',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilaEquipo extends StatelessWidget {
  const _FilaEquipo({required this.equipo, required this.carreras, required this.ganador, required this.etiqueta});

  final EquipoRef equipo;
  final int? carreras;
  final bool ganador;
  final String etiqueta;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final color = ColoresEquipo.de(context, equipo.color);
    final peso = ganador ? FontWeight.w800 : FontWeight.w500;
    return Row(children: [
      ImagenApi(urlFoto: equipo.urlFoto, nombre: equipo.nombre ?? '?', tamano: 28, color: color),
      const SizedBox(width: 10),
      Expanded(
        child: Text.rich(
          TextSpan(children: [
            TextSpan(text: equipo.nombre ?? 'Equipo eliminado', style: TextStyle(fontWeight: peso)),
            TextSpan(
                text: '  $etiqueta',
                style: tema.textTheme.labelSmall?.copyWith(color: tema.colorScheme.onSurfaceVariant)),
          ]),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      if (ganador) Icon(Icons.check_circle_rounded, size: 16, color: ColoresEstado.victoria, semanticLabel: 'Ganó'),
      if (carreras != null)
        SizedBox(
          width: 36,
          child: Text('$carreras',
              textAlign: TextAlign.end,
              style: estiloCifra(tema.textTheme.titleMedium)?.copyWith(fontWeight: peso)),
        ),
    ]);
  }
}

class ChipEstado extends StatelessWidget {
  const ChipEstado({super.key, required this.estado});

  final EstadoPartido estado;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final (fondo, tinta, icono) = switch (estado) {
      EstadoPartido.finalizado => (esquema.surfaceContainerHighest, esquema.onSurfaceVariant, Icons.flag_rounded),
      EstadoPartido.enJuego => (esquema.tertiaryContainer, esquema.onTertiaryContainer, Icons.play_circle_rounded),
      EstadoPartido.programado => (esquema.secondaryContainer, esquema.onSecondaryContainer, Icons.schedule_rounded),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: fondo, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icono, size: 14, color: tinta),
        const SizedBox(width: 4),
        Text(estado.etiqueta, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: tinta)),
      ]),
    );
  }
}
