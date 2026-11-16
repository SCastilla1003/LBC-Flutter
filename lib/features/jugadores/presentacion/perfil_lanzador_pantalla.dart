import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/medidor.dart';
import '../../../core/charts/nube_liga.dart';
import '../../../core/modelos/modelos_comunes.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../comparador/presentacion/selector_comparar.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../datos/jugadores_repositorio.dart';
import '../datos/modelos_jugador.dart';
import 'cabecera_jugador.dart';

class PerfilLanzadorPantalla extends ConsumerWidget {
  const PerfilLanzadorPantalla({super.key, required this.idTemporada, required this.idJugador});

  final String idTemporada;
  final String idJugador;

  Future<void> _comparar(BuildContext context, WidgetRef ref) async {
    final todos = await ref.read(lanzadoresTemporadaProvider(idTemporada).future).catchError((_) => <Lanzador>[]);
    if (!context.mounted) return;
    final otro = await elegirParaComparar(context, [
      for (final l in todos)
        if (l.id != idJugador) OpcionComparar(id: l.id, nombre: l.nombre, detalle: l.nombreEquipo, urlFoto: l.urlFoto),
    ]);
    if (otro != null && context.mounted) {
      context.push('/temporadas/$idTemporada/comparar/lanzadores?a=$idJugador&b=$otro');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clave = (idTemporada, idJugador);
    final perfil = ref.watch(perfilLanzadorProvider(clave));
    final colores = ref.watch(coloresEquiposProvider(idTemporada)).value ?? const {};
    return Scaffold(
      appBar: AppBar(
        title: Text(perfil.value?.jugador.nombre ?? 'Lanzador'),
        actions: [
          IconButton(
              tooltip: 'Comparar', icon: const Icon(Icons.compare_arrows_rounded), onPressed: () => _comparar(context, ref)),
        ],
      ),
      body: VistaAsync(
        valor: perfil,
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(perfilLanzadorProvider(clave)),
        datos: (p) {
          final l = p.jugador;
          final r = p.referenciaLiga;
          final color = ColoresEquipo.de(context, colores[l.idEquipo]);
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(perfilLanzadorProvider(clave));
              await ref.read(perfilLanzadorProvider(clave).future);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                AnchoMaximo(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    CabeceraJugador(
                      nombre: l.nombre,
                      urlFoto: l.urlFoto,
                      detalle: detalleJugador(rol: 'Lanzador', posicion: l.posicion, edad: l.edad, derechoZurdo: l.derechoZurdo),
                      idTemporada: idTemporada,
                      idEquipo: l.idEquipo,
                      nombreEquipo: l.nombreEquipo,
                      color: color,
                      agenteLibre: l.agenteLibre,
                    ),
                    const SizedBox(height: 16),
                    TarjetaGrafica(
                      titulo: '¿Qué tan efectivo es?',
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _MedidorLiga(etiqueta: 'ERA', valor: l.era, referencia: r['era']),
                          _MedidorLiga(etiqueta: 'WHIP', valor: l.whip, referencia: r['whip']),
                        ],
                      ),
                    ),
                    _DominioControl(idTemporada: idTemporada, jugador: l, color: color),
                    RejillaCifras(hijos: [
                      cifraConLiga('inningsLanzados', l.inningsLanzados, 'Innings', r),
                      cifraConLiga('ponchados', l.ponchados, 'Ponches', r),
                      cifraConLiga('kbb', l.kbb, 'K/BB', r),
                      cifraConLiga('lanzamientosPorInning', l.lanzamientosPorInning, 'Lanz./inning', r),
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

/// Medidor con zonas Élite / Promedio / Alta según la liga (menos es mejor) y una marca en el promedio.
class _MedidorLiga extends StatelessWidget {
  const _MedidorLiga({required this.etiqueta, required this.valor, required this.referencia});

  final String etiqueta;
  final double? valor;
  final Referencia? referencia;

  @override
  Widget build(BuildContext context) {
    final ref = referencia;
    if (ref?.promedio == null || ref?.minimo == null || ref?.maximo == null) {
      return Medidor(valor: valor, minimo: 0, maximo: math.max(1, (valor ?? 1) * 1.5), etiqueta: etiqueta, formato: Formato.decimal);
    }
    final maximo = math.max(ref!.maximo!, valor ?? 0) * 1.1;
    return Medidor(
      valor: valor,
      minimo: 0,
      maximo: maximo <= 0 ? 1 : maximo,
      etiqueta: etiqueta,
      formato: Formato.decimal,
      referencia: ref.promedio,
      zonas: zonasMenorEsMejor(context, minimo: ref.minimo!, promedio: ref.promedio!, maximo: ref.maximo!),
    );
  }
}

class _DominioControl extends ConsumerWidget {
  const _DominioControl({required this.idTemporada, required this.jugador, required this.color});

  final String idTemporada;
  final Lanzador jugador;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(lanzadoresTemporadaProvider(idTemporada));
    return todos.when(
      loading: () => const Padding(padding: EdgeInsets.only(bottom: 16), child: Brillo(child: Esqueleto(alto: 240, radio: 16))),
      error: (e, _) =>
          EstadoError(error: e, compacto: true, onReintentar: () => ref.invalidate(lanzadoresTemporadaProvider(idTemporada))),
      data: (lista) {
        final liga = lista.where((l) => l.k9 != null && l.bb9 != null && (!l.agenteLibre || l.id == jugador.id)).toList();
        if (liga.length < 3 || jugador.k9 == null) return const SizedBox.shrink();
        return TarjetaGrafica(
          titulo: '¿Domina o controla?',
          child: NubeLiga(
            idResaltado: jugador.id,
            colorResaltado: color,
            ejeX: 'BB/9',
            ejeY: 'K/9',
            cuadrantes: const ['Dominante', 'Potencia', 'Control', 'En apuros'],
            onTap: (id) => id == jugador.id ? null : context.push('/temporadas/$idTemporada/lanzadores/$id'),
            puntos: [for (final l in liga) PuntoNube(id: l.id, nombre: l.nombre, x: l.bb9!, y: l.k9!)],
          ),
        );
      },
    );
  }
}
