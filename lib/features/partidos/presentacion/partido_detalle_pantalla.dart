import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/base_graficas.dart';
import '../../../core/modelos/modelos_comunes.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../datos/modelos_partido.dart';
import '../datos/partidos_repositorio.dart';
import 'tarjeta_partido.dart';

class PartidoDetallePantalla extends ConsumerWidget {
  const PartidoDetallePantalla({
    super.key,
    required this.idTemporada,
    required this.idPartido,
  });

  final String idTemporada;
  final String idPartido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clave = (idTemporada, idPartido);
    final partido = ref.watch(partidoProvider(clave));
    return Scaffold(
      appBar: AppBar(title: const Text('Partido')),
      body: VistaAsync(
        valor: partido,
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(partidoProvider(clave)),
        datos: (p) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(partidoProvider(clave));
            await ref.read(partidoProvider(clave).future);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              AnchoMaximo(
                ancho: 720,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Marcador(partido: p, idTemporada: idTemporada),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _Dato(
                          icono: Icons.event_rounded,
                          texto: Formato.fecha(p.fecha),
                        ),
                        if (Formato.hora(p.hora).isNotEmpty)
                          _Dato(
                            icono: Icons.schedule_rounded,
                            texto: Formato.hora(p.hora),
                          ),
                        if (p.estadio?.nombre != null)
                          _Dato(
                            icono: Icons.stadium_rounded,
                            texto: p.estadio!.nombre!,
                          ),
                        _Dato(
                          icono: Icons.timelapse_rounded,
                          texto: p.finalizado
                              ? '${p.innings} inn.'
                              : 'Inning ${p.inningActual}/${p.innings}',
                        ),
                        if (p.estado != EstadoPartido.programado) ...[
                          _Dato(
                            icono: Icons.sports_baseball_rounded,
                            texto: '${p.hitTotalesPartido} hits',
                          ),
                          _Dato(
                            icono: Icons.error_outline_rounded,
                            texto: '${p.erroresTotalesPartido} errores',
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) =>
      Chip(avatar: Icon(icono, size: 16), label: Text(texto));
}

class _Marcador extends StatelessWidget {
  const _Marcador({required this.partido, required this.idTemporada});

  final Partido partido;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final p = partido;
    final tema = Theme.of(context);
    final jugado = p.estado != EstadoPartido.programado;
    final colorL = ColoresEquipo.de(context, p.equipoLocal.color);
    final colorV = ColoresEquipo.de(context, p.equipoVisitante.color);
    final ganaL =
        p.idEquipoGanador != null && p.idEquipoGanador == p.equipoLocal.id;
    final ganaV =
        p.idEquipoGanador != null && p.idEquipoGanador == p.equipoVisitante.id;
    final tinta = tema.colorScheme.onSurface;
    final oscuro = tema.brightness == Brightness.dark;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: oscuro
              ? const [Color(0xFF251E1B), Color(0xFF2D2420)]
              : const [
                  ColoresMarca.blanco,
                  Color(0xFFFFFCF6),
                  Color(0xFFFFF7EA),
                ],
        ),
        border: Border.all(
          color: oscuro
              ? tema.colorScheme.outlineVariant
              : ColoresMarca.rojo.withValues(alpha: 0.13),
        ),
        boxShadow: [
          BoxShadow(
            color: oscuro
                ? Colors.black.withValues(alpha: 0.30)
                : ColoresMarca.rojoProfundo.withValues(alpha: 0.07),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: ColoresMarca.franjaInstitucional,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ChipEstado(estado: p.estado)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _Lado(
                        equipo: p.equipoLocal,
                        color: colorL,
                        gana: ganaL,
                        idTemporada: idTemporada,
                        etiqueta: 'Local',
                        tinta: tinta,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 18,
                        left: 4,
                        right: 4,
                      ),
                      child: jugado
                          ? EntradaAnimada(
                              clave:
                                  '${p.carrerasEquipoLocal}-${p.carrerasEquipoVisitante}',
                              builder: (context, t) => Text(
                                '${(p.carrerasEquipoLocal * t).round()} – ${(p.carrerasEquipoVisitante * t).round()}',
                                style: estiloCifra(tema.textTheme.displaySmall)
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: tema.colorScheme.primary,
                                      letterSpacing: -1.5,
                                    ),
                              ),
                            )
                          : Text(
                              'vs',
                              style: tema.textTheme.headlineMedium?.copyWith(
                                color: tema.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                    Expanded(
                      child: _Lado(
                        equipo: p.equipoVisitante,
                        color: colorV,
                        gana: ganaV,
                        idTemporada: idTemporada,
                        etiqueta: 'Visitante',
                        tinta: tinta,
                      ),
                    ),
                  ],
                ),
                if (jugado &&
                    p.carrerasEquipoLocal + p.carrerasEquipoVisitante > 0) ...[
                  const SizedBox(height: 18),
                  // Tira de carreras: cuánto del marcador aportó cada equipo
                  EntradaAnimada(
                    clave: p.id,
                    builder: (context, t) {
                      final total =
                          p.carrerasEquipoLocal + p.carrerasEquipoVisitante;
                      final fraccionL =
                          0.5 + (p.carrerasEquipoLocal / total - 0.5) * t;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 10,
                          child: Row(
                            children: [
                              Expanded(
                                flex: (fraccionL * 1000).round(),
                                child: Container(color: colorL),
                              ),
                              Container(
                                width: 2,
                                color: tema.colorScheme.outlineVariant,
                              ),
                              Expanded(
                                flex: ((1 - fraccionL) * 1000).round(),
                                child: Container(color: colorV),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Lado extends StatelessWidget {
  const _Lado({
    required this.equipo,
    required this.color,
    required this.gana,
    required this.idTemporada,
    required this.etiqueta,
    required this.tinta,
  });

  final EquipoRef equipo;
  final Color color;
  final bool gana;
  final String idTemporada;
  final String etiqueta;
  final Color tinta;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: equipo.id == null
          ? null
          : () => context.push('/temporadas/$idTemporada/equipos/${equipo.id}'),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: gana
                        ? ColoresMarca.dorado
                        : tinta.withValues(alpha: 0.25),
                    width: gana ? 2.2 : 1.2,
                  ),
                ),
                child: ImagenApi(
                  urlFoto: equipo.urlFoto,
                  nombre: equipo.nombre ?? '?',
                  tamano: 62,
                  color: color,
                ),
              ),
              if (gana)
                const Positioned(
                  right: -6,
                  top: -6,
                  child: Icon(
                    Icons.emoji_events_rounded,
                    color: ColoresMarca.dorado,
                    size: 24,
                    semanticLabel: 'Ganador',
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            equipo.nombre ?? '—',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: tema.textTheme.titleSmall?.copyWith(
              fontWeight: gana ? FontWeight.w900 : FontWeight.w600,
              color: tinta,
            ),
          ),
          Text(
            etiqueta,
            style: tema.textTheme.labelSmall?.copyWith(
              color: tinta.withValues(alpha: 0.66),
            ),
          ),
        ],
      ),
    );
  }
}
