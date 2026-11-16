import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../temporadas/datos/modelos_temporada.dart';
import '../../temporadas/datos/temporadas_repositorio.dart';

/// Temporada sobre la que trabaja el panel de administración.
class TemporadaAdmin extends Notifier<String?> {
  @override
  String? build() => null;

  void elegir(String? id) => state = id;
}

final temporadaAdminProvider = NotifierProvider<TemporadaAdmin, String?>(TemporadaAdmin.new);

class AdminPanelPantalla extends ConsumerWidget {
  const AdminPanelPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporadas = ref.watch(temporadasProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Panel de administración')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(temporadasProvider.future),
        child: VistaAsync(
          valor: temporadas,
          onReintentar: () => ref.invalidate(temporadasProvider),
          datos: (lista) => _Contenido(temporadas: lista),
        ),
      ),
    );
  }
}

class _Contenido extends ConsumerWidget {
  const _Contenido({required this.temporadas});

  final List<TemporadaResumen> temporadas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elegida = ref.watch(temporadaAdminProvider);
    final actual = temporadas.where((t) => t.id == elegida).firstOrNull ?? temporadas.firstOrNull;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        AnchoMaximo(
          ancho: 760,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_month_rounded),
                title: const Text('Temporadas'),
                trailing: Text('${temporadas.length}'),
                onTap: () => context.push('/admin/temporadas'),
              ),
            ),
            const SizedBox(height: 24),
            if (actual == null)
              const EstadoVacio(mensaje: 'Sin temporadas', icono: Icons.calendar_today_outlined)
            else ...[
              DropdownButtonFormField<String>(
                initialValue: actual.id,
                decoration: const InputDecoration(labelText: 'Temporada'),
                items: [
                  for (final t in temporadas)
                    DropdownMenuItem(value: t.id, child: Text('${t.nombreTemporada} (${t.anio})')),
                ],
                onChanged: (id) => ref.read(temporadaAdminProvider.notifier).elegir(id),
              ),
              const SizedBox(height: 16),
              for (final (icono, titulo, ruta) in [
                (Icons.groups_rounded, 'Equipos y jugadores', 'equipos'),
                (Icons.person_search_rounded, 'Agentes libres', 'agentes-libres'),
                (Icons.sports_baseball_rounded, 'Partidos', 'partidos'),
                (Icons.stadium_rounded, 'Estadios', 'estadios'),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: ListTile(
                      leading: Icon(icono),
                      title: Text(titulo),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.push('/admin/t/${actual.id}/$ruta'),
                    ),
                  ),
                ),
            ],
          ]),
        ),
      ],
    );
  }
}
