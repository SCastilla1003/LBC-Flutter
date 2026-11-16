import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/estados.dart';
import '../datos/temporadas_repositorio.dart';

/// Botón de la barra superior para cambiar la temporada en foco (Inicio y Líderes).
class SelectorTemporada extends ConsumerWidget {
  const SelectorTemporada({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Cambiar temporada',
      icon: const Icon(Icons.swap_horiz_rounded),
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (_) => const _ListaTemporadas(),
      ),
    );
  }
}

class _ListaTemporadas extends ConsumerWidget {
  const _ListaTemporadas();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporadas = ref.watch(temporadasProvider);
    final elegida = ref.watch(temporadaSeleccionadaProvider);
    final enFoco = ref.watch(idTemporadaEnFocoProvider).value;
    return SafeArea(
      child: temporadas.when(
        loading: () => const SizedBox(height: 240, child: EsqueletoLista(filas: 3, conAvatar: false)),
        error: (e, _) => EstadoError(error: e, compacto: true, onReintentar: () => ref.invalidate(temporadasProvider)),
        data: (lista) => ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.auto_awesome_rounded),
              title: const Text('Actual'),
              trailing: elegida == null ? const Icon(Icons.check_rounded) : null,
              onTap: () {
                ref.read(temporadaSeleccionadaProvider.notifier).elegir(null);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            for (final t in lista)
              ListTile(
                title: Text(t.nombreTemporada),
                subtitle: Text('${t.anio} · ${t.totalEquipos} equipos'),
                trailing: elegida == t.id || (elegida == null && enFoco == t.id)
                    ? const Icon(Icons.check_rounded)
                    : null,
                onTap: () {
                  ref.read(temporadaSeleccionadaProvider.notifier).elegir(t.id);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
