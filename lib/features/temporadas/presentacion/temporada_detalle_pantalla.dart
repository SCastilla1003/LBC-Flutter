import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/barras_apiladas.dart';
import '../../../core/charts/base_graficas.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../equipos/datos/modelos_equipo.dart';
import '../../jugadores/datos/jugadores_repositorio.dart';
import '../../partidos/datos/modelos_partido.dart';
import '../../partidos/presentacion/partidos_pantalla.dart';
import '../datos/modelos_temporada.dart';
import '../datos/temporadas_repositorio.dart';

class TemporadaDetallePantalla extends ConsumerWidget {
  const TemporadaDetallePantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(temporadaDetalleProvider(idTemporada));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(detalle.value?.nombreTemporada ?? 'Temporada'),
          actions: [
            IconButton(
              tooltip: 'Ver en Inicio y Líderes',
              icon: const Icon(Icons.push_pin_outlined),
              onPressed: () {
                ref.read(temporadaSeleccionadaProvider.notifier).elegir(idTemporada);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Temporada fijada en Inicio y Líderes')));
              },
            ),
          ],
          bottom: const TabBar(tabs: [Tab(text: 'Equipos'), Tab(text: 'Partidos'), Tab(text: 'Estadios')]),
        ),
        body: VistaAsync(
          valor: detalle,
          cargando: const EsqueletoDetalle(),
          onReintentar: () => ref.invalidate(temporadaDetalleProvider(idTemporada)),
          datos: (t) => TabBarView(children: [
            _PestanaEquipos(temporada: t),
            ListaPartidos(idTemporada: idTemporada),
            _PestanaEstadios(temporada: t),
          ]),
        ),
      ),
    );
  }
}

class _PestanaEquipos extends ConsumerWidget {
  const _PestanaEquipos({required this.temporada});

  final TemporadaDetalle temporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = temporada;
    return RefreshIndicator(
      onRefresh: () => ref.refresh(temporadaDetalleProvider(t.id).future),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          AnchoMaximo(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Wrap(spacing: 8, runSpacing: 8, children: [
                FilledButton.tonalIcon(
                  onPressed: () => context.push('/temporadas/${t.id}/posiciones'),
                  icon: const Icon(Icons.leaderboard_outlined),
                  label: const Text('Tabla de posiciones'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ref.read(temporadaSeleccionadaProvider.notifier).elegir(t.id);
                    context.go('/lideres');
                  },
                  icon: const Icon(Icons.emoji_events_outlined),
                  label: const Text('Líderes'),
                ),
              ]),
              const SizedBox(height: 20),
              if (t.equipos.isEmpty)
                const EstadoVacio(mensaje: 'Sin equipos', icono: Icons.groups_outlined)
              else
                LayoutBuilder(builder: (context, c) {
                  final columnas = (c.maxWidth / 320).floor().clamp(1, 3);
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final e in t.equipos)
                        SizedBox(
                            width: (c.maxWidth - (columnas - 1) * 10) / columnas,
                            child: TarjetaEquipo(equipo: e, idTemporada: t.id)),
                    ],
                  );
                }),
              if (t.totalAgentesLibres > 0) ...[
                const SizedBox(height: 24),
                _AgentesLibres(idTemporada: t.id),
              ],
            ]),
          ),
        ],
      ),
    );
  }
}

class TarjetaEquipo extends StatelessWidget {
  const TarjetaEquipo({super.key, required this.equipo, required this.idTemporada});

  final Equipo equipo;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final color = ColoresEquipo.de(context, equipo.color);
    final r = equipo.registro;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/temporadas/$idTemporada/equipos/${equipo.id}'),
        child: Row(children: [
          Container(width: 6, height: 76, color: color),
          const SizedBox(width: 12),
          ImagenApi(urlFoto: equipo.urlFoto, nombre: equipo.nombre, tamano: 48, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(equipo.nombre,
                  style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis),
              Text(
                [if (equipo.ciudad != null) equipo.ciudad!, '${equipo.totalBateadores + equipo.totalLanzadores} jugadores']
                    .join(' · '),
                style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('${r.ganados}-${r.perdidos}',
                  style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              Text(Formato.promedio(r.porcentajeVictorias), style: tema.textTheme.labelSmall),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _AgentesLibres extends ConsumerWidget {
  const _AgentesLibres({required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentes = ref.watch(agentesLibresProvider(idTemporada));
    return Seccion(
      titulo: 'Agentes libres',
      child: agentes.when(
        loading: () => const SizedBox(height: 120, child: EsqueletoLista(filas: 2)),
        error: (e, _) =>
            EstadoError(error: e, compacto: true, onReintentar: () => ref.invalidate(agentesLibresProvider(idTemporada))),
        data: (a) => Card(
          child: Column(children: [
            for (final b in a.bateadores)
              ListTile(
                leading: ImagenApi(urlFoto: b.urlFoto, nombre: b.nombre, tamano: 36),
                title: Text(b.nombre),
                subtitle: Text('Bateador · ${b.posicion ?? 'Sin posición'}'),
                onTap: () => context.push('/temporadas/$idTemporada/bateadores/${b.id}'),
              ),
            for (final l in a.lanzadores)
              ListTile(
                leading: ImagenApi(urlFoto: l.urlFoto, nombre: l.nombre, tamano: 36),
                title: Text(l.nombre),
                subtitle: Text('Lanzador · ${l.posicion ?? 'Sin posición'}'),
                onTap: () => context.push('/temporadas/$idTemporada/lanzadores/${l.id}'),
              ),
          ]),
        ),
      ),
    );
  }
}

class _PestanaEstadios extends ConsumerWidget {
  const _PestanaEstadios({required this.temporada});

  final TemporadaDetalle temporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadios = temporada.estadios;
    return RecargableSimple(
      onRefresh: () => ref.refresh(temporadaDetalleProvider(temporada.id).future),
      child: estadios.isEmpty
          ? const EstadoVacio(mensaje: 'Sin estadios', icono: Icons.stadium_outlined)
          : Padding(
              padding: const EdgeInsets.all(16),
              child: AnchoMaximo(
                ancho: 800,
                child: Builder(builder: (context) {
                  final e = EstiloGrafica(context);
                  final jugado = e.rampa(3)[1];
                  final orden = [...estadios]
                    ..sort((a, b) => (b.partidosJugados + b.partidosProgramados).compareTo(a.partidosJugados + a.partidosProgramados));
                  return TarjetaGrafica(
                    titulo: '¿Dónde se juega?',
                    leyenda: [ItemLeyenda(color: jugado, texto: 'Jugados'), ItemLeyenda(color: e.neutro, texto: 'Por jugar')],
                    child: BarrasApiladas(
                      clave: orden.map((s) => s.id).join(),
                      altoBarra: 18,
                      filas: [
                        for (final Estadio s in orden)
                          FilaApilada(
                            id: s.id,
                            nombre: s.ubicacion == null ? s.nombre : '${s.nombre} · ${s.ubicacion}',
                            inicio: const Icon(Icons.stadium_rounded),
                            valorFinal: '${s.partidosJugados + s.partidosProgramados}',
                            segmentos: [
                              SegmentoBarra(valor: s.partidosJugados.toDouble(), color: jugado),
                              SegmentoBarra(valor: s.partidosProgramados.toDouble(), color: e.neutro),
                            ],
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
