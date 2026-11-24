import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/barras_apiladas.dart';
import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/grafica_carrera.dart';
import '../../../core/charts/grafica_partidos.dart';
import '../../../core/charts/waffle.dart';
import '../../../core/red/fallo_api.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../equipos/datos/modelos_equipo.dart';
import '../../partidos/datos/modelos_partido.dart';
import '../../partidos/datos/partidos_repositorio.dart';
import '../../partidos/presentacion/tarjeta_partido.dart';
import '../datos/modelos_temporada.dart';
import '../datos/temporadas_repositorio.dart';
import 'selector_temporada.dart';

class InicioPantalla extends ConsumerWidget {
  const InicioPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idEnFoco = ref.watch(idTemporadaEnFocoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const MarcaTitulo(),
        actions: const [SelectorTemporada(), SizedBox(width: 6)],
      ),
      body: idEnFoco.when(
        loading: () => const EsqueletoDetalle(),
        error: (e, _) => e is FalloNoEncontrado
            ? const EstadoVacio(
                mensaje: 'Sin temporadas',
                icono: Icons.calendar_today_outlined,
              )
            : EstadoError(
                error: e,
                onReintentar: () {
                  ref.invalidate(temporadaActualProvider);
                  ref.invalidate(idTemporadaEnFocoProvider);
                },
              ),
        data: (id) => _Contenido(idTemporada: id),
      ),
    );
  }
}

class _Contenido extends ConsumerWidget {
  const _Contenido({required this.idTemporada});

  final String idTemporada;

  Future<void> _recargar(WidgetRef ref) async {
    ref.invalidate(temporadaDetalleProvider(idTemporada));
    ref.invalidate(posicionesProvider(idTemporada));
    ref.invalidate(partidosProvider(idTemporada));
    ref.invalidate(estadisticasTemporadaProvider(idTemporada));
    await ref.read(estadisticasTemporadaProvider(idTemporada).future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(temporadaDetalleProvider(idTemporada));
    final estadisticas = ref.watch(estadisticasTemporadaProvider(idTemporada));
    return RefreshIndicator(
      onRefresh: () => _recargar(ref),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          AnchoMaximo(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                detalle.when(
                  loading: () =>
                      const Brillo(child: Esqueleto(alto: 84, radio: 20)),
                  error: (e, _) => EstadoError(
                    error: e,
                    compacto: true,
                    onReintentar: () =>
                        ref.invalidate(temporadaDetalleProvider(idTemporada)),
                  ),
                  data: (t) => _Cabecera(temporada: t),
                ),
                const SizedBox(height: 16),
                estadisticas.when(
                  loading: () => Brillo(
                    child: Column(
                      children: [
                        RejillaCifras(
                          hijos: List.generate(
                            4,
                            (_) => const Esqueleto(alto: 76, radio: 12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Esqueleto(alto: 260, radio: 16),
                      ],
                    ),
                  ),
                  error: (e, _) => EstadoError(
                    error: e,
                    compacto: true,
                    onReintentar: () => ref.invalidate(
                      estadisticasTemporadaProvider(idTemporada),
                    ),
                  ),
                  data: (s) =>
                      _Graficas(estadisticas: s, idTemporada: idTemporada),
                ),
                _Partidos(idTemporada: idTemporada),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Cabecera extends StatelessWidget {
  const _Cabecera({required this.temporada});

  final TemporadaDetalle temporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final avance = temporada.totalPartidos == 0
        ? 0.0
        : temporada.partidosFinalizados / temporada.totalPartidos;
    return HeroLbc(
      etiqueta: 'Temporada ${temporada.anio} · LBC',
      titulo: temporada.nombreTemporada,
      subtitulo: temporada.campeon != null
          ? 'Campeón: ${temporada.campeon!.nombre ?? '—'}'
          : 'Liga de Béisbol de Cartagena',
      icono: Icons.emoji_events_rounded,
      onTap: () => context.push('/temporadas/${temporada.id}'),
      contenido: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          PastillaHero(
            icono: Icons.sports_baseball_rounded,
            texto:
                '${temporada.partidosFinalizados} de ${temporada.totalPartidos} partidos',
          ),
          if (temporada.campeon != null)
            const PastillaHero(
              icono: Icons.workspace_premium_rounded,
              texto: 'Campeón vigente',
            ),
        ],
      ),
      accion: SizedBox(
        width: 66,
        height: 66,
        child: EntradaAnimada(
          clave: avance,
          builder: (context, t) => Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: avance * t,
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                  color: tema.colorScheme.primary,
                  backgroundColor: tema.colorScheme.primaryContainer.withValues(
                    alpha: 0.55,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(avance * 100 * t).round()}%',
                    style: estiloCifra(tema.textTheme.labelLarge)?.copyWith(
                      color: tema.colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'jugado',
                    style: tema.textTheme.labelSmall?.copyWith(
                      color: tema.colorScheme.onSurfaceVariant,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Graficas extends ConsumerWidget {
  const _Graficas({required this.estadisticas, required this.idTemporada});

  final EstadisticasTemporada estadisticas;
  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = estadisticas;
    final e = EstiloGrafica(context);
    final tema = Theme.of(context);
    final k = s.kpis;
    final posiciones = ref.watch(posicionesProvider(idTemporada));

    // Juegos sobre .500 de cada equipo a partir de la serie de partidos de la API
    final referencias = <String, (String, Color)>{};
    for (final p in s.carrerasPorPartido) {
      for (final r in [p.local, p.visitante]) {
        if (r?.id != null) {
          referencias[r!.id!] = (
            r.nombre ?? '?',
            ColoresEquipo.de(context, r.color),
          );
        }
      }
    }
    final carrera = juegosSobre500([
      for (final p in s.carrerasPorPartido)
        (p.local?.id, p.visitante?.id, p.carrerasLocal, p.carrerasVisitante),
    ]);

    final h = s.distribucionHits;
    final rampa = e.rampa(4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RejillaCifras(
          hijos: [
            _Kpi(
              valor: k.partidosJugados,
              etiqueta: 'Jugados',
              icono: Icons.sports_baseball_rounded,
              tono: tema.colorScheme.primary,
            ),
            _Kpi(
              valor: k.carrerasTotales,
              etiqueta: 'Carreras',
              extra: k.promedioCarrerasPorPartido == null
                  ? null
                  : '${Formato.decimal(k.promedioCarrerasPorPartido)}/p',
              icono: Icons.directions_run_rounded,
              tono: tema.colorScheme.secondary,
            ),
            _Kpi(
              valor: k.liderJonrones?.valor ?? 0,
              etiqueta: k.liderJonrones == null
                  ? 'Jonrones'
                  : 'HR · ${k.liderJonrones!.nombre}',
              icono: Icons.bolt_rounded,
              destacado: true,
              onTap: k.liderJonrones == null
                  ? null
                  : () => context.push(
                      '/temporadas/$idTemporada/bateadores/${k.liderJonrones!.idJugador}',
                    ),
            ),
            _Kpi(
              valor: k.mejorRecord?.ganados ?? 0,
              sufijo: k.mejorRecord == null
                  ? null
                  : '-${k.mejorRecord!.perdidos}',
              etiqueta: k.mejorRecord?.nombre ?? 'Mejor récord',
              icono: Icons.emoji_events_rounded,
              tono: tema.colorScheme.tertiary,
              onTap: k.mejorRecord == null
                  ? null
                  : () => context.push(
                      '/temporadas/$idTemporada/equipos/${k.mejorRecord!.idEquipo}',
                    ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TarjetaGrafica(
          titulo: '¿Quién lidera?',
          subtitulo: 'Récord de cada equipo, con la barra dividida en ganados y perdidos',
          icono: Icons.leaderboard_rounded,
          accion: IconButton(
            tooltip: 'Tabla completa',
            icon: const Icon(Icons.table_rows_outlined),
            onPressed: () =>
                context.push('/temporadas/$idTemporada/posiciones'),
          ),
          leyenda: [
            ItemLeyenda(
              color: e.victoria,
              texto: 'Ganados',
              colores: [
                for (final p in posiciones.value?.take(4) ?? const <Posicion>[])
                  ColoresEquipo.de(context, p.color),
              ],
            ),
            ItemLeyenda(color: e.neutro, texto: 'Perdidos'),
          ],
          child: posiciones.when(
            loading: () =>
                const SizedBox(height: 200, child: EsqueletoLista(filas: 4)),
            error: (err, _) => EstadoError(
              error: err,
              compacto: true,
              onReintentar: () =>
                  ref.invalidate(posicionesProvider(idTemporada)),
            ),
            data: (lista) => lista.isEmpty
                ? const EstadoVacio(mensaje: 'Sin equipos')
                : _BarrasPosiciones(
                    posiciones: lista,
                    idTemporada: idTemporada,
                  ),
          ),
        ),
        if (carrera.isNotEmpty)
          TarjetaGrafica(
            titulo: '¿Cómo va la carrera?',
            subtitulo: 'Juegos sobre .500 acumulados partido a partido',
            icono: Icons.stacked_line_chart_rounded,
            child: GraficaCarrera(
              series: [
                for (final c in carrera.entries)
                  if (referencias[c.key] != null)
                    SerieCarrera(
                      id: c.key,
                      nombre: referencias[c.key]!.$1,
                      color: referencias[c.key]!.$2,
                      valores: c.value,
                    ),
              ],
            ),
          ),
        if (s.carrerasPorPartido.isNotEmpty)
          TarjetaGrafica(
            titulo: '¿Cuántas carreras hay por partido?',
            subtitulo: 'Cada punto es un partido; toca para abrir su ficha',
            icono: Icons.show_chart_rounded,
            child: GraficaPartidos(
              promedio: k.promedioCarrerasPorPartido,
              onTap: (id) =>
                  context.push('/temporadas/$idTemporada/partidos/$id'),
              puntos: [
                for (final p in s.carrerasPorPartido)
                  PuntoPartido(
                    id: p.idPartido,
                    total: p.carrerasTotales,
                    etiqueta: p.fecha == null
                        ? ''
                        : '${p.fecha!.day}/${p.fecha!.month}',
                    detalle:
                        '${p.local?.nombre ?? '?'} ${p.carrerasLocal} – ${p.carrerasVisitante} ${p.visitante?.nombre ?? '?'}',
                  ),
              ],
            ),
          ),
        if (h.total > 0)
          TarjetaGrafica(
            titulo: '¿Cómo se batea en la liga?',
            subtitulo: 'Waffle: cada cuadro es el 1 % de todos los hits',
            icono: Icons.grid_on_rounded,
            child: GraficaWaffle(
              clave: h.total,
              unidad: 'hits',
              partes: [
                ParteWaffle(
                  etiqueta: 'Sencillos',
                  valor: h.sencillos.toDouble(),
                  color: rampa[0],
                ),
                ParteWaffle(
                  etiqueta: 'Dobles',
                  valor: h.dobles.toDouble(),
                  color: rampa[1],
                ),
                ParteWaffle(
                  etiqueta: 'Triples',
                  valor: h.triples.toDouble(),
                  color: rampa[2],
                ),
                ParteWaffle(
                  etiqueta: 'Jonrones',
                  valor: h.homeRuns.toDouble(),
                  color: rampa[3],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi({
    required this.valor,
    required this.etiqueta,
    required this.icono,
    this.sufijo,
    this.extra,
    this.tono,
    this.destacado = false,
    this.onTap,
  });

  final num valor;
  final String etiqueta;
  final IconData icono;
  final String? sufijo;
  final String? extra;
  final Color? tono;
  final bool destacado;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final acento = tono ?? tema.colorScheme.primary;
    final tinta = tema.colorScheme.onSurface;
    final oscuro = tema.brightness == Brightness.dark;
    return Semantics(
      button: onTap != null,
      label: '$etiqueta: $valor${sufijo ?? ''}',
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            gradient: destacado
                ? (oscuro
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2D2420), Color(0xFF3A2B24)],
                        )
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColoresMarca.blanco,
                            Color(0xFFFFFBF3),
                            Color(0xFFFFF4E0),
                          ],
                        ))
                : null,
            color: destacado ? null : tema.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: destacado
                  ? (oscuro
                        ? ColoresMarca.dorado.withValues(alpha: 0.5)
                        : ColoresMarca.rojo.withValues(alpha: 0.38))
                  : tema.colorScheme.outlineVariant.withValues(alpha: 0.7),
              width: destacado ? 1.4 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: destacado
                    ? (oscuro
                          ? Colors.black.withValues(alpha: 0.3)
                          : ColoresMarca.rojo.withValues(alpha: 0.09))
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: destacado
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ColoresMarca.rojo,
                                ColoresMarca.rojoOscuro,
                              ],
                            )
                          : null,
                      color: destacado ? null : acento.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icono,
                      size: 17,
                      color: destacado ? ColoresMarca.blanco : acento,
                    ),
                  ),
                  const Spacer(),
                  if (extra != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: destacado
                            ? (oscuro
                                  ? tema.colorScheme.primaryContainer
                                  : ColoresMarca.rojoSuave.withValues(
                                      alpha: 0.55,
                                    ))
                            : tema.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        extra!,
                        style: tema.textTheme.labelSmall?.copyWith(
                          color: destacado
                              ? (oscuro
                                    ? tema.colorScheme.onPrimaryContainer
                                    : ColoresMarca.rojoProfundo)
                              : tema.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 9),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: ContadorAnimado(
                      valor: valor,
                      estilo: tema.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: tinta,
                        letterSpacing: -0.7,
                      ),
                    ),
                  ),
                  if (sufijo != null)
                    Text(
                      sufijo!,
                      style: estiloCifra(tema.textTheme.headlineSmall)
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: tinta,
                            letterSpacing: -0.7,
                          ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                etiqueta,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: tema.textTheme.labelMedium?.copyWith(
                  color: destacado
                      ? (oscuro
                            ? ColoresMarca.rojoClaro
                            : ColoresMarca.rojoOscuro)
                      : tema.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarrasPosiciones extends StatelessWidget {
  const _BarrasPosiciones({
    required this.posiciones,
    required this.idTemporada,
  });

  final List<Posicion> posiciones;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    return BarrasApiladas(
      clave: posiciones
          .map((p) => '${p.idEquipo}${p.ganados}${p.perdidos}')
          .join(),
      filas: [
        for (final p in posiciones)
          FilaApilada(
            id: p.idEquipo,
            nombre: p.nombre,
            inicio: ImagenApi(
              urlFoto: p.urlFoto,
              nombre: p.nombre,
              tamano: 32,
              color: ColoresEquipo.de(context, p.color),
            ),
            valorFinal: Formato.promedio(p.porcentajeVictorias),
            onTap: () =>
                context.push('/temporadas/$idTemporada/equipos/${p.idEquipo}'),
            segmentos: [
              SegmentoBarra(
                valor: p.ganados.toDouble(),
                color: ColoresEquipo.de(context, p.color),
              ),
              if (p.empates > 0)
                SegmentoBarra(
                  valor: p.empates.toDouble(),
                  color: e.neutro.withValues(alpha: 0.6),
                ),
              SegmentoBarra(valor: p.perdidos.toDouble(), color: e.neutro),
            ],
          ),
      ],
    );
  }
}

class _Partidos extends ConsumerWidget {
  const _Partidos({required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partidos = ref.watch(partidosProvider(idTemporada));
    return partidos.when(
      loading: () =>
          const SizedBox(height: 120, child: EsqueletoLista(filas: 2)),
      error: (e, _) => EstadoError(
        error: e,
        compacto: true,
        onReintentar: () => ref.invalidate(partidosProvider(idTemporada)),
      ),
      data: (lista) {
        final jugados = lista
            .where((p) => p.finalizado)
            .toList()
            .reversed
            .take(3)
            .toList();
        final proximos = lista
            .where((p) => p.estado != EstadoPartido.finalizado)
            .take(3)
            .toList();
        Widget bloque(String titulo, List<Partido> ps) => Seccion(
          titulo: titulo,
          accion: TextButton(
            onPressed: () => context.push('/temporadas/$idTemporada/partidos'),
            child: const Text('Todos'),
          ),
          child: Column(
            children: [
              for (final p in ps)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TarjetaPartido(partido: p, idTemporada: idTemporada),
                ),
            ],
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (jugados.isNotEmpty) bloque('Últimos resultados', jugados),
            if (proximos.isNotEmpty) bloque('Próximos', proximos),
          ],
        );
      },
    );
  }
}
