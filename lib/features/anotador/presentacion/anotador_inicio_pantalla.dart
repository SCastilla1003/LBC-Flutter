import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/datos/temporada_en_foco.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import '../../admin/presentacion/admin_comun.dart';
import '../../admin/presentacion/admin_partidos_pantalla.dart';

/// Partidos para anotar (rol anotador y admin): los que están en vivo primero,
/// luego los próximos y al final los terminados.
class AnotadorInicioPantalla extends ConsumerWidget {
  const AnotadorInicioPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporada = ref.watch(temporadaEnFocoLigaProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Anotar partidos')),
      body: VistaAsync<TemporadaLiga?>(
        valor: temporada,
        onReintentar: () => ref.invalidate(temporadaEnFocoLigaProvider),
        datos: (t) => t == null
            ? const Center(child: EstadoVacio(mensaje: 'Todavía no hay temporadas.'))
            : _Partidos(temporada: t),
      ),
    );
  }
}

class _Partidos extends ConsumerWidget {
  const _Partidos({required this.temporada});

  final TemporadaLiga temporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formato = DateFormat("EEE d MMM · h:mm a", 'es');
    int grupo(PartidoResumen p) => switch (p.estado) {
          EstadoPartidoLiga.enJuego || EstadoPartidoLiga.suspendido => 0,
          EstadoPartidoLiga.programado || EstadoPartidoLiga.alineacionPublicada => 1,
          EstadoPartidoLiga.finalizado => 2,
        };
    return RefreshIndicator(
      onRefresh: () => ref.refresh(partidosLigaProvider(temporada.id).future),
      child: VistaAsync<List<PartidoResumen>>(
        valor: ref.watch(partidosLigaProvider(temporada.id)),
        cargando: const EsqueletoLista(),
        onReintentar: () => ref.invalidate(partidosLigaProvider(temporada.id)),
        datos: (lista) {
          final ordenados = [...lista]
            ..sort((a, b) {
              final g = grupo(a).compareTo(grupo(b));
              if (g != 0) return g;
              // Terminados: el más reciente arriba.
              return grupo(a) == 2 ? b.fechaHora.compareTo(a.fechaHora) : a.fechaHora.compareTo(b.fechaHora);
            });
          const titulos = ['En juego', 'Próximos', 'Terminados'];
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              AnchoMaximo(
                ancho: 760,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  if (ordenados.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 48),
                      child: EstadoVacio(mensaje: 'Esta temporada no tiene partidos programados.'),
                    ),
                  for (final (i, p) in ordenados.indexed) ...[
                    if (i == 0 || grupo(ordenados[i - 1]) != grupo(p)) EncabezadoSeccion(titulos[grupo(p)]),
                    FilaAdmin(
                      distintivo: PlacaAdmin(texto: '${p.fechaHora.day}'),
                      titulo: grupo(p) == 1
                          ? '${p.equipoVisita.abreviatura} @ ${p.equipoLocal.abreviatura}'
                          : '${p.equipoVisita.abreviatura} ${p.marcador.visita} – ${p.marcador.local} '
                              '${p.equipoLocal.abreviatura}',
                      detalle: [formato.format(p.fechaHora), ?p.estadio?.nombre, etiquetaEstadoPartido(p.estado)]
                          .join(' · '),
                      onTap: () => context.push('/anotador/t/${temporada.id}/p/${p.id}'),
                    ),
                  ],
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
