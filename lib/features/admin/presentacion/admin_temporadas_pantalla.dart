import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/vista_async.dart';
import '../../equipos/datos/modelos_equipo.dart';
import '../../temporadas/datos/modelos_temporada.dart';
import '../../temporadas/datos/temporadas_repositorio.dart';
import 'admin_comun.dart';

class AdminTemporadasPantalla extends ConsumerWidget {
  const AdminTemporadasPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporadas = ref.watch(temporadasProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Temporadas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _formulario(context, ref, null),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva temporada'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(temporadasProvider.future),
        child: VistaAsync(
          valor: temporadas,
          onReintentar: () => ref.invalidate(temporadasProvider),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin temporadas',
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              for (final t in lista)
                AnchoMaximo(
                  ancho: 760,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        title: Text(t.nombreTemporada),
                        subtitle: Text('${t.anio} · ${t.totalEquipos} equipos · ${t.totalPartidos} partidos'
                            '${t.campeon?.nombre != null ? ' · Campeón: ${t.campeon!.nombre}' : ''}'),
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            tooltip: 'Editar',
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () => _formulario(context, ref, t),
                          ),
                          IconButton(
                            tooltip: 'Eliminar',
                            icon: const Icon(Icons.delete_outline_rounded),
                            onPressed: () async {
                              final ok = await confirmar(context,
                                  titulo: 'Eliminar temporada',
                                  mensaje: 'Se eliminará "${t.nombreTemporada}" con todos sus equipos, jugadores, '
                                      'partidos, estadios y fotos. Esta acción no se puede deshacer.');
                              if (ok && context.mounted) {
                                await ejecutarAccion(context, ref,
                                    () => ref.read(temporadasRepositorioProvider).eliminar(t.id),
                                    exito: 'Temporada eliminada');
                              }
                            },
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _formulario(BuildContext context, WidgetRef ref, TemporadaResumen? t) async {
    List<Equipo> equipos = const [];
    if (t != null) {
      try {
        equipos = (await ref.read(temporadaDetalleProvider(t.id).future)).equipos;
      } catch (_) {}
    }
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => _DialogoTemporada(temporada: t, equipos: equipos),
    );
  }
}

class _DialogoTemporada extends ConsumerStatefulWidget {
  const _DialogoTemporada({required this.temporada, required this.equipos});

  final TemporadaResumen? temporada;
  final List<Equipo> equipos;

  @override
  ConsumerState<_DialogoTemporada> createState() => _DialogoTemporadaState();
}

class _DialogoTemporadaState extends ConsumerState<_DialogoTemporada> {
  final _form = GlobalKey<FormState>();
  late final _nombre = TextEditingController(text: widget.temporada?.nombreTemporada);
  late final _anio = TextEditingController(text: '${widget.temporada?.anio ?? DateTime.now().year}');
  late String? _campeon = widget.temporada?.campeon?.id;
  bool _guardando = false;

  @override
  void dispose() {
    _nombre.dispose();
    _anio.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _guardando = true);
    final repo = ref.read(temporadasRepositorioProvider);
    final t = widget.temporada;
    final ok = await ejecutarAccion(
      context,
      ref,
      () => t == null
          ? repo.crear(nombre: _nombre.text.trim(), anio: int.parse(_anio.text))
          : repo.actualizar(t.id, nombre: _nombre.text.trim(), anio: int.parse(_anio.text), idEquipoCampeon: _campeon),
      exito: t == null ? 'Temporada creada' : 'Temporada actualizada',
    );
    if (!mounted) return;
    setState(() => _guardando = false);
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.temporada == null ? 'Nueva temporada' : 'Editar temporada'),
      content: Form(
        key: _form,
        child: SizedBox(
          width: 420,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              controller: _nombre,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Obligatorio' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _anio,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: 'Año'),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                return n == null || n < 1900 || n > 2100 ? 'Año no válido' : null;
              },
            ),
            if (widget.temporada != null) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                initialValue: _campeon,
                decoration: const InputDecoration(labelText: 'Campeón'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Sin campeón')),
                  for (final e in widget.equipos) DropdownMenuItem(value: e.id, child: Text(e.nombre)),
                ],
                onChanged: (v) => setState(() => _campeon = v),
              ),
            ],
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(onPressed: _guardando ? null : _guardar, child: const Text('Guardar')),
      ],
    );
  }
}
