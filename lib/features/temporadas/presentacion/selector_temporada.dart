import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/estados.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/temporada_en_foco.dart';
import '../../../liga/presentacion/widgets_liga.dart';

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
    final temporadas = ref.watch(temporadasLigaProvider);
    final elegida = ref.watch(temporadaElegidaLigaProvider);
    final enFoco = ref.watch(temporadaEnFocoLigaProvider).value?.id;
    final esquema = Theme.of(context).colorScheme;
    return SafeArea(
      child: temporadas.when(
        loading: () => const SizedBox(height: 240, child: EsqueletoLista(filas: 3, conAvatar: false)),
        error: (e, _) =>
            EstadoError(error: e, compacto: true, onReintentar: () => ref.invalidate(temporadasLigaProvider)),
        data: (lista) => ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: Icon(Icons.auto_awesome_rounded, color: esquema.primary),
              title: const Text('La temporada en curso'),
              trailing: elegida == null ? Icon(Icons.check_rounded, color: esquema.primary) : null,
              onTap: () {
                ref.read(temporadaElegidaLigaProvider.notifier).elegir(null);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            for (final t in [...lista]..sort((a, b) => b.anio.compareTo(a.anio)))
              ListTile(
                title: Text(t.nombre),
                subtitle: Text('${t.anio} · ${etiquetaEstadoTemporada(t.estado)}'),
                trailing: elegida == t.id || (elegida == null && enFoco == t.id)
                    ? Icon(Icons.check_rounded, color: esquema.primary)
                    : null,
                onTap: () {
                  ref.read(temporadaElegidaLigaProvider.notifier).elegir(t.id);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
