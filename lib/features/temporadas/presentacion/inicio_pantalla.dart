import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/barras_apiladas.dart';
import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/grafica_carrera.dart';
import '../../../core/charts/grafica_partidos.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/datos/temporada_en_foco.dart';
import '../../../liga/presentacion/temporada_liga_pantalla.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import 'selector_temporada.dart';

/// Inicio (contrato v1): portada de la temporada en foco, cifras clave,
/// gráficas calculadas con los partidos y las posiciones, y los últimos y
/// próximos partidos.
class InicioPantalla extends ConsumerWidget {
  const InicioPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enFoco = ref.watch(temporadaEnFocoLigaProvider);
    return Scaffold(
      appBar: AppBar(
        title: const MarcaTitulo(),
        actions: const [SelectorTemporada(), SizedBox(width: 6)],
      ),
      body: enFoco.when(
        loading: () => const EsqueletoDetalle(),
        error: (e, _) => EstadoError(error: e, onReintentar: () => ref.invalidate(temporadasLigaProvider)),
        data: (t) => t == null
            ? const EstadoVacio(mensaje: 'Sin temporadas', icono: Icons.calendar_today_outlined)
            : _Contenido(temporada: t),
      ),
    );
  }
}

class _Contenido extends ConsumerWidget {
  const _Contenido({required this.temporada});

  final TemporadaLiga temporada;

  Future<void> _recargar(WidgetRef ref) async {
    ref.invalidate(temporadasLigaProvider);
    ref.invalidate(posicionesLigaProvider(temporada.id));
    ref.invalidate(partidosLigaProvider(temporada.id));
    await ref.read(partidosLigaProvider(temporada.id).future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partidos = ref.watch(partidosLigaProvider(temporada.id));
    final posiciones = ref.watch(posicionesLigaProvider(temporada.id));
    return RefreshIndicator(
      onRefresh: () => _recargar(ref),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          AnchoMaximo(
            child: partidos.when(
              loading: () => Brillo(
                child: Column(children: [
                  const Esqueleto(alto: 120, radio: 16),
                  const SizedBox(height: 16),
                  RejillaCifras(hijos: List.generate(4, (_) => const Esqueleto(alto: 96, radio: 12))),
                  const SizedBox(height: 16),
                  const Esqueleto(alto: 260, radio: 12),
                ]),
              ),
              error: (e, _) => EstadoError(
                error: e,
                onReintentar: () => ref.invalidate(partidosLigaProvider(temporada.id)),
              ),
              data: (lista) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Cabecera(temporada: temporada, partidos: lista),
                  _Cifras(temporada: temporada, partidos: lista, posiciones: posiciones.value),
                  const SizedBox(height: 16),
                  _Graficas(temporada: temporada, partidos: lista, posiciones: posiciones),
                  _Partidos(temporada: temporada, partidos: lista),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool _jugado(PartidoResumen p) => p.estado == EstadoPartidoLiga.finalizado;

class _Cabecera extends StatelessWidget {
  const _Cabecera({required this.temporada, required this.partidos});

  final TemporadaLiga temporada;
  final List<PartidoResumen> partidos;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final jugados = partidos.where(_jugado).length;
    final avance = partidos.isEmpty ? 0.0 : jugados / partidos.length;
    final enVivo = partidos.where((p) => p.estado == EstadoPartidoLiga.enJuego).length;
    return HeroLbc(
      etiqueta: 'Temporada ${temporada.anio} · LBC',
      titulo: temporada.nombre,
      subtitulo: 'Liga de Béisbol de Cartagena · ${etiquetaEstadoTemporada(temporada.estado)}',
      icono: Icons.emoji_events_rounded,
      onTap: () => context.push('/temporadas/${temporada.id}'),
      contenido: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          PastillaHero(icono: Icons.sports_baseball_rounded, texto: '$jugados de ${partidos.length} partidos'),
          if (enVivo > 0) PastillaHero(icono: Icons.circle, texto: '$enVivo en vivo'),
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
                  backgroundColor: tema.colorScheme.primaryContainer.withValues(alpha: 0.55),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(avance * 100 * t).round()}%',
                    style: estiloMarcador(tema.textTheme.titleLarge)?.copyWith(
                      color: tema.colorScheme.onSurface,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'jugado',
                    style: tema.textTheme.labelSmall?.copyWith(
                      color: tema.colorScheme.onSurfaceVariant,
                      fontSize: 9,
                      letterSpacing: 0.4,
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

class _Cifras extends StatelessWidget {
  const _Cifras({required this.temporada, required this.partidos, required this.posiciones});

  final TemporadaLiga temporada;
  final List<PartidoResumen> partidos;
  final List<PosicionLiga>? posiciones;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final jugados = partidos.where(_jugado).toList();
    final carreras = jugados.fold<int>(0, (s, p) => s + p.marcador.local + p.marcador.visita);
    final promedio = jugados.isEmpty ? null : carreras / jugados.length;
    final lider = posiciones?.firstOrNull;
    final equipos = <int>{for (final p in partidos) ...[p.equipoLocal.id, p.equipoVisita.id]}.length;
    return RejillaCifras(
      hijos: [
        _Kpi(
          valor: jugados.length,
          etiqueta: 'Jugados',
          icono: Icons.sports_baseball_rounded,
          tono: tema.colorScheme.primary,
        ),
        _Kpi(
          valor: carreras,
          etiqueta: 'Carreras',
          extra: promedio == null ? null : '${Formato.decimal(promedio)}/p',
          icono: Icons.directions_run_rounded,
          tono: tema.brightness == Brightness.dark ? ColoresMarca.verdeNeon : ColoresMarca.verdeNoche,
        ),
        _Kpi(
          valor: lider?.ganados ?? 0,
          sufijo: lider == null ? null : '-${lider.perdidos}',
          etiqueta: lider?.equipo.nombre ?? 'Líder',
          icono: Icons.emoji_events_rounded,
          destacado: true,
          onTap: lider == null ? null : () => context.push('/temporadas/${temporada.id}/equipos/${lider.equipo.id}'),
        ),
        _Kpi(
          valor: equipos,
          etiqueta: 'Equipos',
          icono: Icons.groups_rounded,
          tono: tema.brightness == Brightness.dark ? tema.colorScheme.secondary : ColoresMarca.amarilloTexto,
        ),
      ],
    );
  }
}

class _Graficas extends StatelessWidget {
  const _Graficas({required this.temporada, required this.partidos, required this.posiciones});

  final TemporadaLiga temporada;
  final List<PartidoResumen> partidos;
  final AsyncValue<List<PosicionLiga>> posiciones;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final jugados = partidos.where(_jugado).toList()..sort((a, b) => a.fechaHora.compareTo(b.fechaHora));
    final equipos = <String, (String, Color)>{
      for (final p in jugados)
        for (final eq in [p.equipoLocal, p.equipoVisita]) '${eq.id}': (eq.nombre, ColoresEquipo.de(context, eq.color)),
    };
    final carrera = juegosSobre500([
      for (final p in jugados) ('${p.equipoLocal.id}', '${p.equipoVisita.id}', p.marcador.local, p.marcador.visita),
    ]);
    final totalCarreras = jugados.fold<int>(0, (s, p) => s + p.marcador.local + p.marcador.visita);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TarjetaGrafica(
          titulo: '¿Quién lidera?',
          subtitulo: 'Récord de cada equipo, con la barra dividida en ganados y perdidos',
          icono: Icons.leaderboard_rounded,
          accion: IconButton(
            tooltip: 'Tabla completa',
            icon: const Icon(Icons.table_rows_outlined),
            onPressed: () => context.push('/temporadas/${temporada.id}'),
          ),
          leyenda: [
            ItemLeyenda(
              color: e.victoria,
              texto: 'Ganados',
              colores: [
                for (final p in posiciones.value?.take(4) ?? const <PosicionLiga>[])
                  ColoresEquipo.de(context, p.equipo.color),
              ],
            ),
            ItemLeyenda(color: e.neutro, texto: 'Perdidos'),
          ],
          child: posiciones.when(
            loading: () => const SizedBox(height: 200, child: EsqueletoLista(filas: 4)),
            error: (err, _) => EstadoError(error: err, compacto: true),
            data: (lista) => lista.isEmpty
                ? const EstadoVacio(
                    mensaje: 'Las posiciones aparecen cuando terminen los primeros partidos.',
                    icono: Icons.leaderboard_outlined,
                  )
                : BarrasApiladas(
                    clave: lista.map((p) => '${p.equipo.id}${p.ganados}${p.perdidos}').join(),
                    filas: [
                      for (final p in lista)
                        FilaApilada(
                          id: '${p.equipo.id}',
                          nombre: p.equipo.nombre,
                          inicio: EscudoLiga(equipo: p.equipo, tamano: 32),
                          valorFinal: Formato.promedio(p.pct),
                          onTap: () => context.push('/temporadas/${temporada.id}/equipos/${p.equipo.id}'),
                          segmentos: [
                            SegmentoBarra(valor: p.ganados.toDouble(), color: ColoresEquipo.de(context, p.equipo.color)),
                            SegmentoBarra(valor: p.perdidos.toDouble(), color: e.neutro),
                          ],
                        ),
                    ],
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
                  if (equipos[c.key] != null)
                    SerieCarrera(id: c.key, nombre: equipos[c.key]!.$1, color: equipos[c.key]!.$2, valores: c.value),
              ],
            ),
          ),
        if (jugados.isNotEmpty)
          TarjetaGrafica(
            titulo: '¿Cuántas carreras hay por partido?',
            subtitulo: 'Cada punto es un partido; toca para abrir su ficha',
            icono: Icons.show_chart_rounded,
            child: GraficaPartidos(
              promedio: totalCarreras / jugados.length,
              onTap: (id) => context.push('/temporadas/${temporada.id}/partidos/$id'),
              puntos: [
                for (final p in jugados)
                  PuntoPartido(
                    id: '${p.id}',
                    total: p.marcador.local + p.marcador.visita,
                    etiqueta: '${p.fechaHora.day}/${p.fechaHora.month}',
                    detalle:
                        '${p.equipoLocal.nombre} ${p.marcador.local} – ${p.marcador.visita} ${p.equipoVisita.nombre}',
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Partidos extends StatelessWidget {
  const _Partidos({required this.temporada, required this.partidos});

  final TemporadaLiga temporada;
  final List<PartidoResumen> partidos;

  @override
  Widget build(BuildContext context) {
    final ordenados = [...partidos]..sort((a, b) => a.fechaHora.compareTo(b.fechaHora));
    final jugados = ordenados.where(_jugado).toList().reversed.take(3).toList();
    final proximos = ordenados
        .where((p) => p.estado != EstadoPartidoLiga.finalizado && p.estado != EstadoPartidoLiga.suspendido)
        .take(3)
        .toList();
    if (jugados.isEmpty && proximos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 8),
        child: EstadoVacio(mensaje: 'Esta temporada todavía no tiene partidos.', icono: Icons.sports_baseball_outlined),
      );
    }
    Widget bloque(String titulo, List<PartidoResumen> ps) => Seccion(
          titulo: titulo,
          accion: TextButton(
            onPressed: () => context.push('/temporadas/${temporada.id}'),
            child: const Text('Todos'),
          ),
          child: Column(
            children: [for (final p in ps) TarjetaPartidoLiga(partido: p, idTemporada: temporada.id)],
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (proximos.isNotEmpty) bloque('Próximos', proximos),
        if (jugados.isNotEmpty) bloque('Últimos resultados', jugados),
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
    final esquema = tema.colorScheme;
    final acento = tono ?? esquema.primary;
    // El KPI destacado es una placa de tablero (verde noche + cifra amarilla);
    // los demás, tarjetas blancas con borde fino.
    final tinta = destacado ? ColoresMarca.amarillo : esquema.onSurface;
    final tintaEtiqueta = destacado
        ? ColoresMarca.tintaBarra
        : esquema.onSurfaceVariant;
    final cifra = estiloMarcador(tema.textTheme.headlineMedium)?.copyWith(
      fontSize: 34,
      color: tinta,
    );
    return Semantics(
      button: onTap != null,
      label: '$etiqueta: $valor${sufijo ?? ''}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(RadioLbc.tarjeta),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: destacado ? ColoresMarca.tablero : null,
              color: destacado ? null : esquema.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(RadioLbc.tarjeta),
              border: destacado
                  ? null
                  : Border.all(color: esquema.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: destacado
                      ? ColoresMarca.verdeNoche.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.03),
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
                        color: destacado
                            ? ColoresMarca.amarillo
                            : acento.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icono,
                        size: 17,
                        color: destacado
                            ? ColoresMarca.tintaSobreAmarillo
                            : acento,
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
                              ? ColoresMarca.tintaBarra.withValues(alpha: 0.14)
                              : esquema.surfaceContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          extra!,
                          style: estiloCifra(tema.textTheme.labelSmall)
                              ?.copyWith(
                                color: destacado
                                    ? ColoresMarca.tintaBarra
                                    : esquema.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.5,
                                letterSpacing: 0.2,
                              ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: ContadorAnimado(valor: valor, estilo: cifra),
                    ),
                    if (sufijo != null) Text(sufijo!, style: cifra),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  etiqueta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: estiloEtiqueta(tema.textTheme.labelMedium)?.copyWith(
                    color: tintaEtiqueta,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

