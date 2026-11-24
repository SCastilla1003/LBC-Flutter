import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../liga/datos/temporada_en_foco.dart';

/// Líderes de bateo y pitcheo.
///
/// Con el contrato v1, las estadísticas de jugadores se calculan a partir de
/// las jugadas que registra el anotador en vivo, que todavía no está activo en
/// la API. Hasta entonces la pantalla lo explica en lugar de fallar.
class LideresPantalla extends ConsumerWidget {
  const LideresPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporada = ref.watch(temporadaEnFocoLigaProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Líderes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AnchoMaximo(
            ancho: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroLbc(
                  compacto: true,
                  etiqueta: temporada == null ? 'Liga de Béisbol de Cartagena' : '${temporada.nombre} · ${temporada.anio}',
                  titulo: 'Líderes al bate y al montículo',
                  subtitulo: 'Los mejores de la temporada, estadística por estadística.',
                  icono: Icons.emoji_events_rounded,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: EstadoVacio(
                    icono: Icons.query_stats_rounded,
                    mensaje: 'Las estadísticas de los jugadores se calculan con las jugadas que '
                        'registra el anotador en vivo.\nLos líderes aparecerán aquí cuando se '
                        'empiecen a anotar los partidos.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
