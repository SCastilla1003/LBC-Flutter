import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/vista_async.dart';
import '../datos/modelos_temporada.dart';
import '../datos/temporadas_repositorio.dart';

class TemporadasPantalla extends ConsumerWidget {
  const TemporadasPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporadas = ref.watch(temporadasProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Temporadas')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(temporadasProvider.future),
        child: VistaAsync(
          valor: temporadas,
          onReintentar: () => ref.invalidate(temporadasProvider),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin temporadas',
          iconoVacio: Icons.calendar_today_outlined,
          datos: (lista) => ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: lista.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              if (i == 0) {
                return AnchoMaximo(
                  ancho: 800,
                  child: HeroLbc(
                    compacto: true,
                    etiqueta: 'Historia de la liga',
                    titulo: 'Temporadas',
                    subtitulo: 'Todas las campañas de la Liga de Béisbol de Cartagena.',
                    icono: Icons.calendar_month_rounded,
                    contenido: PastillaHero(
                      icono: Icons.auto_awesome_rounded,
                      texto: '${lista.length} temporadas registradas',
                    ),
                  ),
                );
              }
              final t = lista[i - 1];
              return AnchoMaximo(
                ancho: 800,
                child: _TarjetaTemporada(temporada: t),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TarjetaTemporada extends StatelessWidget {
  const _TarjetaTemporada({required this.temporada});

  final TemporadaResumen temporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final t = temporada;
    final avance = t.totalPartidos == 0
        ? 0.0
        : t.partidosFinalizados / t.totalPartidos;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/temporadas/${t.id}'),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 84,
                decoration: const BoxDecoration(
                  gradient: ColoresMarca.tablero,
                  border: Border(
                    right: BorderSide(color: ColoresMarca.amarillo, width: 4),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${t.anio}',
                      style: estiloMarcador(tema.textTheme.headlineSmall)
                          ?.copyWith(color: ColoresMarca.amarillo, fontSize: 28),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'LBC',
                      style: tema.textTheme.labelSmall?.copyWith(
                        color: ColoresMarca.tintaBarra.withValues(alpha: 0.6),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 13, 8, 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              t.nombreTemporada,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: tema.textTheme.titleLarge?.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: tema.colorScheme.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        [
                          '${t.totalEquipos} equipos',
                          '${t.partidosFinalizados}/${t.totalPartidos} partidos',
                        ].join(' · '),
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: tema.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (t.campeon?.nombre != null) ...[
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.emoji_events_rounded,
                              size: 14,
                              color: ColoresMarca.doradoOscuro,
                              semanticLabel: 'Campeón',
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Campeón: ${t.campeon!.nombre}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: tema.textTheme.labelSmall?.copyWith(
                                  color: tema.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 9),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: avance,
                          minHeight: 5,
                          color: tema.colorScheme.primary,
                          backgroundColor: tema.colorScheme.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
