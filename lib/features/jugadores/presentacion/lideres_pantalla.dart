import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/ranking_animado.dart';
import '../../../core/red/fallo_api.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../temporadas/datos/temporadas_repositorio.dart';
import '../../temporadas/presentacion/selector_temporada.dart';
import '../datos/jugadores_repositorio.dart';
import '../datos/modelos_jugador.dart';
import 'etiquetas.dart';

class LideresPantalla extends ConsumerStatefulWidget {
  const LideresPantalla({super.key});

  @override
  ConsumerState<LideresPantalla> createState() => _LideresPantallaState();
}

class _LideresPantallaState extends ConsumerState<LideresPantalla> {
  String _tipo = 'bateo';
  final _estadistica = {'bateo': 'homeRuns', 'pitcheo': 'ponchados'};

  static const _rapidas = {
    'bateo': ['homeRuns', 'carrerasImpulsadas', 'roboDeBase', 'hits'],
    'pitcheo': ['ponchados', 'era', 'whip', 'k9'],
  };

  @override
  Widget build(BuildContext context) {
    final idEnFoco = ref.watch(idTemporadaEnFocoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Líderes'),
        actions: const [SelectorTemporada()],
      ),
      body: idEnFoco.when(
        loading: () => const EsqueletoLista(),
        error: (e, _) => e is FalloNoEncontrado
            ? const EstadoVacio(mensaje: 'Sin temporadas')
            : EstadoError(
                error: e,
                onReintentar: () => ref.invalidate(temporadaActualProvider),
              ),
        data: _contenido,
      ),
    );
  }

  Widget _contenido(String idTemporada) {
    final consulta = (idTemporada, _tipo, _estadistica[_tipo]!, 10);
    final lideres = ref.watch(lideresProvider(consulta));
    final colores =
        ref.watch(coloresEquiposProvider(idTemporada)).value ?? const {};
    final disponibles =
        lideres.value?.estadisticasDisponibles ?? _rapidas[_tipo]!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: AnchoMaximo(
            ancho: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'bateo',
                      label: Text('Bateo'),
                      icon: Icon(Icons.sports_baseball_outlined),
                    ),
                    ButtonSegment(
                      value: 'pitcheo',
                      label: Text('Pitcheo'),
                      icon: Icon(Icons.sports_handball_outlined),
                    ),
                  ],
                  selected: {_tipo},
                  onSelectionChanged: (s) => setState(() => _tipo = s.first),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final e in _rapidas[_tipo]!)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(EtiquetasEstadistica.de(_tipo, e)),
                            selected: _estadistica[_tipo] == e,
                            onSelected: (_) =>
                                setState(() => _estadistica[_tipo] = e),
                          ),
                        ),
                      PopupMenuButton<String>(
                        tooltip: 'Más',
                        onSelected: (e) =>
                            setState(() => _estadistica[_tipo] = e),
                        itemBuilder: (_) => [
                          for (final e in disponibles)
                            PopupMenuItem(
                              value: e,
                              child: Text(EtiquetasEstadistica.de(_tipo, e)),
                            ),
                        ],
                        child: const Chip(
                          avatar: Icon(Icons.tune_rounded, size: 16),
                          label: Text('Más'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(lideresProvider(consulta).future),
            child: VistaAsync(
              valor: lideres,
              onReintentar: () => ref.invalidate(lideresProvider(consulta)),
              esVacio: (l) => l.lideres.isEmpty,
              mensajeVacio: 'Sin datos',
              iconoVacio: Icons.emoji_events_outlined,
              datos: (l) => ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  AnchoMaximo(
                    ancho: 800,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _PortadaLideres(l: l, tipo: _tipo),
                        TarjetaGrafica(
                          titulo: EtiquetasEstadistica.de(
                            l.tipo,
                            l.estadistica,
                          ),
                          subtitulo: l.menorEsMejor
                              ? 'Menos es mejor · toca un jugador para ver su perfil'
                              : 'Toca un jugador para abrir su perfil completo',
                          icono: l.tipo == 'pitcheo'
                              ? Icons.sports_handball_rounded
                              : Icons.sports_baseball_rounded,
                          accion: l.menorEsMejor
                              ? const Tooltip(
                                  message: 'Menos es mejor',
                                  child: Icon(Icons.south_rounded, size: 18),
                                )
                              : null,
                          child: RankingAnimado(
                            clave: '${l.tipo}-${l.estadistica}-$idTemporada',
                            menorEsMejor: l.menorEsMejor,
                            onTap: (id) => context.push(
                              '/temporadas/$idTemporada/${l.tipo == 'pitcheo' ? 'lanzadores' : 'bateadores'}/$id',
                            ),
                            entradas: [
                              for (final x in l.lideres)
                                EntradaRanking(
                                  id: x.idJugador,
                                  nombre: x.nombre,
                                  subtitulo: x.nombreEquipo,
                                  valor: x.valor,
                                  texto: EtiquetasEstadistica.valor(
                                    l.estadistica,
                                    x.valor,
                                  ),
                                  color: ColoresEquipo.de(
                                    context,
                                    colores[x.idEquipo],
                                  ),
                                  avatar: ImagenApi(
                                    urlFoto: x.urlFoto,
                                    nombre: x.nombre,
                                    tamano: 34,
                                    color: ColoresEquipo.de(
                                      context,
                                      colores[x.idEquipo],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PortadaLideres extends StatelessWidget {
  const _PortadaLideres({required this.l, required this.tipo});

  final Lideres l;
  final String tipo;

  @override
  Widget build(BuildContext context) {
    final primero = l.lideres.firstOrNull;
    final esPitcheo = tipo == 'pitcheo';
    final esquema = Theme.of(context).colorScheme;
    return HeroLbc(
      compacto: true,
      etiqueta: 'Liga de Béisbol de Cartagena',
      titulo: esPitcheo ? 'Líderes al montículo' : 'Líderes al bate',
      subtitulo: primero == null
          ? 'Los mejores de la temporada, estadística por estadística.'
          : '${primero.nombre} (${primero.nombreEquipo ?? '—'}) manda con '
                '${EtiquetasEstadistica.valor(l.estadistica, primero.valor)} en '
                '${EtiquetasEstadistica.de(l.tipo, l.estadistica)}.',
      icono: esPitcheo
          ? Icons.sports_handball_rounded
          : Icons.emoji_events_rounded,
      contenido: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          PastillaHero(
            icono: Icons.format_list_numbered_rounded,
            texto: 'Top ${l.lideres.length}',
          ),
          PastillaHero(
            icono: Icons.straighten_rounded,
            texto: EtiquetasEstadistica.de(l.tipo, l.estadistica),
          ),
        ],
      ),
      accion: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: esquema.secondary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColoresMarca.doradoOscuro.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.workspace_premium_rounded,
          color: esquema.onSecondary,
          size: 30,
        ),
      ),
    );
  }
}
