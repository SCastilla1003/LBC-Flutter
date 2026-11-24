import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'widgets_liga.dart';

class TemporadasLigaPantalla extends ConsumerWidget {
  const TemporadasLigaPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valor = ref.watch(temporadasLigaProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Temporadas')),
      body: RecargableSimple(
        onRefresh: () => ref.refresh(temporadasLigaProvider.future).then((_) {}, onError: (_) {}),
        child: VistaAsync<List<TemporadaLiga>>(
          valor: valor,
          onReintentar: () => ref.invalidate(temporadasLigaProvider),
          esVacio: (lista) => lista.isEmpty,
          mensajeVacio: 'Todavía no hay temporadas.',
          iconoVacio: Icons.calendar_month_outlined,
          datos: (lista) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [for (final t in lista) _TarjetaTemporada(temporada: t)],
            ),
          ),
        ),
      ),
    );
  }
}

class _TarjetaTemporada extends StatelessWidget {
  const _TarjetaTemporada({required this.temporada});

  final TemporadaLiga temporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return TarjetaLiga(
      onTap: () => context.go('/temporadas/${temporada.id}'),
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 64,
            decoration: const BoxDecoration(
              gradient: ColoresMarca.franjaInstitucionalVertical,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(6)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temporada.nombre,
                  style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  '${temporada.anio} · ${etiquetaEstadoTemporada(temporada.estado)}',
                  style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: tema.colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
