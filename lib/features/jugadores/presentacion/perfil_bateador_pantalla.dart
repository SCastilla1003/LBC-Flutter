import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/diamante_bases.dart';
import '../../../core/charts/nube_liga.dart';
import '../../../core/charts/radar_comparativo.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../comparador/presentacion/selector_comparar.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../datos/jugadores_repositorio.dart';
import '../datos/modelos_jugador.dart';
import 'cabecera_jugador.dart';

/// Ejes del radar de bateo: (clave en la API, etiqueta corta).
const ejesRadarBateo = [
  ('homeRuns', 'HR'),
  ('carrerasImpulsadas', 'CI'),
  ('hits', 'Hits'),
  ('extrabases', 'Extrabases'),
  ('roboDeBase', 'Robos'),
  ('basePorBola', 'BB'),
];

double valorBateador(Bateador b, String clave) => switch (clave) {
      'homeRuns' => b.homeRuns.toDouble(),
      'carrerasImpulsadas' => b.carrerasImpulsadas.toDouble(),
      'hits' => b.hits.toDouble(),
      'extrabases' => b.extrabases.toDouble(),
      'roboDeBase' => b.roboDeBase.toDouble(),
      'basePorBola' => b.basePorBola.toDouble(),
      _ => 0,
    };

class PerfilBateadorPantalla extends ConsumerWidget {
  const PerfilBateadorPantalla({super.key, required this.idTemporada, required this.idJugador});

  final String idTemporada;
  final String idJugador;

  Future<void> _comparar(BuildContext context, WidgetRef ref) async {
    final todos = await ref.read(bateadoresTemporadaProvider(idTemporada).future).catchError((_) => <Bateador>[]);
    if (!context.mounted) return;
    final otro = await elegirParaComparar(context, [
      for (final b in todos)
        if (b.id != idJugador)
          OpcionComparar(id: b.id, nombre: b.nombre, detalle: b.nombreEquipo, urlFoto: b.urlFoto),
    ]);
    if (otro != null && context.mounted) {
      context.push('/temporadas/$idTemporada/comparar/bateadores?a=$idJugador&b=$otro');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clave = (idTemporada, idJugador);
    final perfil = ref.watch(perfilBateadorProvider(clave));
    final colores = ref.watch(coloresEquiposProvider(idTemporada)).value ?? const {};
    return Scaffold(
      appBar: AppBar(
        title: Text(perfil.value?.jugador.nombre ?? 'Bateador'),
        actions: [
          IconButton(
              tooltip: 'Comparar', icon: const Icon(Icons.compare_arrows_rounded), onPressed: () => _comparar(context, ref)),
        ],
      ),
      body: VistaAsync(
        valor: perfil,
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(perfilBateadorProvider(clave)),
        datos: (p) {
          final b = p.jugador;
          final r = p.referenciaLiga;
          final color = ColoresEquipo.de(context, colores[b.idEquipo]);
          final e = EstiloGrafica(context);
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(perfilBateadorProvider(clave));
              await ref.read(perfilBateadorProvider(clave).future);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                AnchoMaximo(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    CabeceraJugador(
                      nombre: b.nombre,
                      urlFoto: b.urlFoto,
                      detalle: detalleJugador(rol: 'Bateador', posicion: b.posicion, edad: b.edad, derechoZurdo: b.derechoZurdo),
                      idTemporada: idTemporada,
                      idEquipo: b.idEquipo,
                      nombreEquipo: b.nombreEquipo,
                      color: color,
                      agenteLibre: b.agenteLibre,
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(builder: (context, c) {
                      final radar = TarjetaGrafica(
                        titulo: '¿Dónde destaca?',
                        child: RadarComparativo(
                          clave: b.id,
                          ejes: [for (final x in ejesRadarBateo) x.$2],
                          maximos: [for (final x in ejesRadarBateo) r[x.$1]?.maximo ?? 0],
                          series: [
                            SerieRadar(
                              nombre: 'Liga',
                              color: e.eje,
                              valores: [for (final x in ejesRadarBateo) r[x.$1]?.promedio ?? 0],
                              relleno: false,
                            ),
                            SerieRadar(
                              nombre: b.nombre.split(' ').first,
                              color: color,
                              valores: [for (final x in ejesRadarBateo) valorBateador(b, x.$1)],
                            ),
                          ],
                        ),
                      );
                      final diamante = TarjetaGrafica(
                        titulo: '¿Hasta dónde llega?',
                        child: DiamanteBases(
                          sencillos: b.sencillos,
                          dobles: b.dobles,
                          triples: b.triples,
                          jonrones: b.homeRuns,
                          totalBases: b.totalBases,
                        ),
                      );
                      if (c.maxWidth < 700) return Column(children: [radar, diamante]);
                      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Expanded(child: radar),
                        const SizedBox(width: 16),
                        Expanded(child: diamante),
                      ]);
                    }),
                    _Disciplina(idTemporada: idTemporada, jugador: b, color: color),
                    RejillaCifras(hijos: [
                      cifraConLiga('vecesEmbasado', b.vecesEmbasado, 'En base', r),
                      cifraConLiga('relacionBbK', b.relacionBbK, 'BB/K', r),
                      cifraConLiga('basePorGolpe', b.basePorGolpe, 'Golpeado', r),
                      cifraConLiga('errores', b.errores, 'Errores', r),
                    ]),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Disciplina extends ConsumerWidget {
  const _Disciplina({required this.idTemporada, required this.jugador, required this.color});

  final String idTemporada;
  final Bateador jugador;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(bateadoresTemporadaProvider(idTemporada));
    return todos.when(
      loading: () => const Padding(padding: EdgeInsets.only(bottom: 16), child: Brillo(child: Esqueleto(alto: 240, radio: 16))),
      error: (e, _) =>
          EstadoError(error: e, compacto: true, onReintentar: () => ref.invalidate(bateadoresTemporadaProvider(idTemporada))),
      data: (lista) {
        final liga = lista.where((b) => !b.agenteLibre || b.id == jugador.id).toList();
        if (liga.length < 3) return const SizedBox.shrink();
        return TarjetaGrafica(
          titulo: '¿Qué tan disciplinado es?',
          child: NubeLiga(
            idResaltado: jugador.id,
            colorResaltado: color,
            ejeX: 'Ponches',
            ejeY: 'BB',
            cuadrantes: const ['Disciplinado', 'Paciente', 'Contacto', 'Impaciente'],
            onTap: (id) => id == jugador.id ? null : context.push('/temporadas/$idTemporada/bateadores/$id'),
            puntos: [
              for (final b in liga)
                PuntoNube(id: b.id, nombre: b.nombre, x: b.ponches.toDouble(), y: b.basePorBola.toDouble()),
            ],
          ),
        );
      },
    );
  }
}
