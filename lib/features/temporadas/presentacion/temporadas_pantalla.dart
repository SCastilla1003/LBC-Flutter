import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/vista_async.dart';
import '../datos/temporadas_repositorio.dart';

class TemporadasPantalla extends ConsumerWidget {
  const TemporadasPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporadas = ref.watch(temporadasProvider);
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Temporadas')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(temporadasProvider.future),
        child: VistaAsync(
          valor: temporadas,
          onReintentar: () => ref.invalidate(temporadasProvider),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin temporadas',
          iconoVacio: Icons.calendar_today_outlined,
          datos: (lista) => ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: lista.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final t = lista[i];
              return AnchoMaximo(
                ancho: 800,
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: tema.colorScheme.primaryContainer,
                      foregroundColor: tema.colorScheme.onPrimaryContainer,
                      child: Text('${t.anio % 100}'.padLeft(2, '0'), style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    title: Text(t.nombreTemporada, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text([
                      '${t.anio}',
                      '${t.totalEquipos} equipos',
                      '${t.partidosFinalizados}/${t.totalPartidos} partidos',
                      if (t.campeon?.nombre != null) 'Campeón: ${t.campeon!.nombre}',
                    ].join(' · ')),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.push('/temporadas/${t.id}'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
