import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/anillo_registro.dart';
import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/grafica_diferencial.dart';
import '../../../core/charts/versus_liga.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../comparador/presentacion/selector_comparar.dart';
import '../datos/equipos_repositorio.dart';
import '../datos/modelos_equipo.dart';

class EquipoDetallePantalla extends ConsumerWidget {
  const EquipoDetallePantalla({
    super.key,
    required this.idTemporada,
    required this.idEquipo,
  });

  final String idTemporada;
  final String idEquipo;

  Future<void> _comparar(BuildContext context, WidgetRef ref) async {
    final equipos = await ref
        .read(equiposProvider(idTemporada).future)
        .catchError((_) => <Equipo>[]);
    if (!context.mounted) return;
    final otro = await elegirParaComparar(context, [
      for (final e in equipos)
        if (e.id != idEquipo)
          OpcionComparar(
            id: e.id,
            nombre: e.nombre,
            detalle: '${e.registro.ganados}-${e.registro.perdidos}',
            urlFoto: e.urlFoto,
            color: ColoresEquipo.de(context, e.color),
          ),
    ]);
    if (otro != null && context.mounted) {
      context.push(
        '/temporadas/$idTemporada/comparar/equipos?a=$idEquipo&b=$otro',
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clave = (idTemporada, idEquipo);
    final detalle = ref.watch(equipoDetalleProvider(clave));
    return Scaffold(
      appBar: AppBar(
        title: Text(detalle.value?.nombre ?? 'Equipo'),
        actions: [
          IconButton(
            tooltip: 'Comparar',
            icon: const Icon(Icons.compare_arrows_rounded),
            onPressed: () => _comparar(context, ref),
          ),
        ],
      ),
      body: VistaAsync(
        valor: detalle,
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(equipoDetalleProvider(clave)),
        datos: (e) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(equipoEstadisticasProvider(clave));
            ref.invalidate(equipoDetalleProvider(clave));
            await ref.read(equipoDetalleProvider(clave).future);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              AnchoMaximo(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Cabecera(equipo: e),
                    const SizedBox(height: 16),
                    _Graficas(clave: clave),
                    _Plantel(equipo: e, idTemporada: idTemporada),
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

class _Cabecera extends StatelessWidget {
  const _Cabecera({required this.equipo});

  final EquipoDetalle equipo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final color = ColoresEquipo.de(context, equipo.color);
    final r = equipo.registro;
    final claro = Theme.of(context).brightness == Brightness.light;
    // Cabecera de equipo: banda verde noche con una franja diagonal del color
    // del equipo, costuras tenues y canto amarillo.
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: ColoresMarca.tablero,
        boxShadow: [
          BoxShadow(
            color: ColoresMarca.verdeNoche.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _FondoEquipo(color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Wrap(
                spacing: 20,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: ColoresMarca.blanco,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ImagenApi(
                          urlFoto: equipo.urlFoto,
                          nombre: equipo.nombre,
                          tamano: 76,
                          color: color,
                          cuadrada: true,
                        ),
                      ),
                      const SizedBox(width: 14),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 240),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              equipo.nombre,
                              style: tema.textTheme.headlineMedium?.copyWith(
                                color: ColoresMarca.tintaBarra,
                                height: 1,
                              ),
                            ),
                            if (equipo.ciudad != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    size: 14,
                                    color: ColoresMarca.tintaBarra.withValues(
                                      alpha: 0.72,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      equipo.ciudad!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: tema.textTheme.bodySmall?.copyWith(
                                        color: ColoresMarca.tintaBarra
                                            .withValues(alpha: 0.76),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: ColoresMarca.amarillo,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${r.ganados}-${r.perdidos} · ${Formato.promedio(r.porcentajeVictorias)}',
                                style:
                                    estiloMarcador(
                                      tema.textTheme.titleMedium,
                                    )?.copyWith(
                                      color: ColoresMarca.tintaSobreAmarillo,
                                      fontSize: 17,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 6,
                              children: [
                                _Mini(
                                  icono: Icons.add_circle_outline,
                                  valor: '${r.carrerasFavor}',
                                  tooltip: 'Carreras a favor',
                                  color: ColoresMarca.tintaBarra.withValues(
                                    alpha: 0.82,
                                  ),
                                ),
                                _Mini(
                                  icono: Icons.remove_circle_outline,
                                  valor: '${r.carrerasContra}',
                                  tooltip: 'Carreras en contra',
                                  color: ColoresMarca.tintaBarra.withValues(
                                    alpha: 0.82,
                                  ),
                                ),
                                _Mini(
                                  icono: Icons.balance_rounded,
                                  valor: Formato.conSigno(r.diferencial),
                                  tooltip: 'Diferencial',
                                  color: ColoresMarca.tintaBarra.withValues(
                                    alpha: 0.82,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: claro
                          ? tema.colorScheme.surfaceContainerLowest
                          : tema.colorScheme.surfaceContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: AnilloRegistro(
                      ganados: r.ganados,
                      perdidos: r.perdidos,
                      empates: r.empates,
                      centro: '${r.ganados}-${r.perdidos}',
                      subcentro: Formato.promedio(r.porcentajeVictorias),
                      tamano: 108,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 5, color: ColoresMarca.amarillo),
          ],
        ),
      ),
    );
  }
}

/// Fondo de la cabecera: franja diagonal con el color del equipo y costuras.
class _FondoEquipo extends CustomPainter {
  _FondoEquipo({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.70, 0)
        ..lineTo(w * 0.86, 0)
        ..lineTo(w * 0.62, h)
        ..lineTo(w * 0.46, h)
        ..close(),
      Paint()..color = color.withValues(alpha: 0.35),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.87, 0)
        ..lineTo(w * 0.89, 0)
        ..lineTo(w * 0.65, h)
        ..lineTo(w * 0.63, h)
        ..close(),
      Paint()..color = ColoresMarca.amarillo.withValues(alpha: 0.5),
    );
    // Costuras de pelota en la esquina superior izquierda.
    final costura = Paint()
      ..color = ColoresMarca.tintaBarra.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final rect = Rect.fromCircle(
      center: Offset(-w * 0.05, -h * 0.2),
      radius: h * 0.9,
    );
    canvas.drawArc(rect, 0.1, 1.2, false, costura);
    canvas.drawArc(rect.deflate(18), 0.1, 1.2, false, costura);
  }

  @override
  bool shouldRepaint(_FondoEquipo old) => old.color != color;
}

class _Mini extends StatelessWidget {
  const _Mini({
    required this.icono,
    required this.valor,
    required this.tooltip,
    this.color,
  });

  final IconData icono;
  final String valor;
  final String tooltip;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tinta = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 16, color: tinta),
          const SizedBox(width: 4),
          Text(
            valor,
            style: estiloCifra(Theme.of(context).textTheme.labelLarge)
                ?.copyWith(fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }
}

class _Graficas extends ConsumerWidget {
  const _Graficas({required this.clave});

  final ClaveEquipo clave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(equipoEstadisticasProvider(clave));
    final e = EstiloGrafica(context);
    return stats.when(
      loading: () => const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Brillo(child: Esqueleto(alto: 220, radio: 16)),
      ),
      error: (err, _) => EstadoError(
        error: err,
        compacto: true,
        onReintentar: () => ref.invalidate(equipoEstadisticasProvider(clave)),
      ),
      data: (s) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (s.partidos.isNotEmpty)
            TarjetaGrafica(
              titulo: '¿Cómo le fue partido a partido?',
              leyenda: [
                ItemLeyenda(color: e.victoria, texto: 'Ganó'),
                ItemLeyenda(color: e.derrota, texto: 'Perdió'),
              ],
              child: GraficaDiferencial(
                onTap: (id) =>
                    context.push('/temporadas/${clave.$1}/partidos/$id'),
                barras: [
                  for (final p in s.partidos)
                    BarraDiferencial(
                      id: p.idPartido,
                      diferencial: p.diferencial,
                      etiqueta: p.fecha == null
                          ? ''
                          : '${p.fecha!.day}/${p.fecha!.month}',
                      detalle:
                          '${p.local ? 'vs' : '@'} ${p.rival?.nombre ?? '?'}\n${p.carrerasFavor}-${p.carrerasContra}',
                    ),
                ],
              ),
            ),
          if (s.comparativaLiga.isNotEmpty)
            TarjetaGrafica(
              titulo: '¿Frente a la liga?',
              child: VersusLiga(
                clave: clave,
                metricas: [
                  for (final c in s.comparativaLiga)
                    MetricaVersus(
                      etiqueta: _corta(c.metrica, c.etiqueta),
                      valor: c.valorEquipo,
                      referencia: c.promedioLiga,
                      mayorEsMejor: c.mayorEsMejor,
                      formato: c.metrica == 'porcentajeVictorias'
                          ? Formato.promedio
                          : (v) => v == null
                                ? '—'
                                : (v == v.roundToDouble()
                                      ? '${v.toInt()}'
                                      : Formato.decimal(v)),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static String _corta(String metrica, String etiqueta) => switch (metrica) {
    'carrerasFavorPorPartido' => 'Anota/partido',
    'carrerasContraPorPartido' => 'Recibe/partido',
    'porcentajeVictorias' => '% victorias',
    'homeRuns' => 'Jonrones',
    'hits' => 'Hits',
    'roboDeBase' => 'Robos',
    'ponchados' => 'Ponches',
    'era' => 'ERA',
    'whip' => 'WHIP',
    _ => etiqueta,
  };
}

class _Plantel extends StatelessWidget {
  const _Plantel({required this.equipo, required this.idTemporada});

  final EquipoDetalle equipo;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    Widget fila(
      String id,
      String nombre,
      String? foto,
      String detalle,
      String tipo,
    ) => ListTile(
      dense: true,
      leading: ImagenApi(urlFoto: foto, nombre: nombre, tamano: 34),
      title: Text(nombre),
      subtitle: Text(detalle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => context.push('/temporadas/$idTemporada/$tipo/$id'),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (equipo.bateadores.isNotEmpty)
          Seccion(
            titulo: 'Bateadores',
            child: Card(
              child: Column(
                children: [
                  for (final b in equipo.bateadores)
                    fila(
                      b.id,
                      b.nombre,
                      b.urlFoto,
                      '${b.posicion ?? '—'} · ${b.hits} H · ${b.homeRuns} HR · ${b.carrerasImpulsadas} CI',
                      'bateadores',
                    ),
                ],
              ),
            ),
          ),
        if (equipo.lanzadores.isNotEmpty)
          Seccion(
            titulo: 'Lanzadores',
            child: Card(
              child: Column(
                children: [
                  for (final l in equipo.lanzadores)
                    fila(
                      l.id,
                      l.nombre,
                      l.urlFoto,
                      '${l.posicion ?? '—'} · ${l.inningsLanzados} IP · ERA ${Formato.decimal(l.era)}',
                      'lanzadores',
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
