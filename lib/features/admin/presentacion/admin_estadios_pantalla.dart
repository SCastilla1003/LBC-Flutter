import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/vista_async.dart';
import '../../partidos/datos/modelos_partido.dart';
import '../../partidos/datos/partidos_repositorio.dart';
import 'admin_comun.dart';

class AdminEstadiosPantalla extends ConsumerWidget {
  const AdminEstadiosPantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadios = ref.watch(estadiosProvider(idTemporada));
    return Scaffold(
      appBar: AppBar(title: const Text('Estadios')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _formulario(context, null),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nuevo estadio'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(estadiosProvider(idTemporada).future),
        child: VistaAsync(
          valor: estadios,
          onReintentar: () => ref.invalidate(estadiosProvider(idTemporada)),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin estadios',
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              for (final s in lista)
                AnchoMaximo(
                  ancho: 760,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.stadium_rounded),
                        title: Text(s.nombre),
                        subtitle: Text('${s.ubicacion ?? 'Sin ubicación'} · ${s.partidosJugados + s.partidosProgramados} partidos'),
                        onTap: () => _formulario(context, s),
                        trailing: IconButton(
                          tooltip: 'Eliminar',
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () async {
                            final ok = await confirmar(context,
                                titulo: 'Eliminar estadio',
                                mensaje: 'Se eliminará "${s.nombre}". Si tiene partidos, primero debes cambiarlos de estadio.');
                            if (ok && context.mounted) {
                              await ejecutarAccion(context, ref,
                                  () => ref.read(partidosRepositorioProvider).eliminarEstadio(idTemporada, s.id),
                                  exito: 'Estadio eliminado');
                            }
                          },
                        ),
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

  Future<void> _formulario(BuildContext context, Estadio? estadio) => showDialog<void>(
        context: context,
        builder: (_) => _DialogoEstadio(idTemporada: idTemporada, estadio: estadio),
      );
}

class _DialogoEstadio extends ConsumerStatefulWidget {
  const _DialogoEstadio({required this.idTemporada, required this.estadio});

  final String idTemporada;
  final Estadio? estadio;

  @override
  ConsumerState<_DialogoEstadio> createState() => _DialogoEstadioState();
}

class _DialogoEstadioState extends ConsumerState<_DialogoEstadio> {
  final _form = GlobalKey<FormState>();
  late final _nombre = TextEditingController(text: widget.estadio?.nombre);
  late final _ubicacion = TextEditingController(text: widget.estadio?.ubicacion);
  bool _guardando = false;

  @override
  void dispose() {
    _nombre.dispose();
    _ubicacion.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _guardando = true);
    final repo = ref.read(partidosRepositorioProvider);
    final ubicacion = _ubicacion.text.trim().isEmpty ? null : _ubicacion.text.trim();
    final s = widget.estadio;
    final ok = await ejecutarAccion(
      context,
      ref,
      () => s == null
          ? repo.crearEstadio(widget.idTemporada, nombre: _nombre.text.trim(), ubicacion: ubicacion)
          : repo.actualizarEstadio(widget.idTemporada, s.id, nombre: _nombre.text.trim(), ubicacion: ubicacion),
      exito: s == null ? 'Estadio creado' : 'Estadio actualizado',
    );
    if (!mounted) return;
    setState(() => _guardando = false);
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.estadio == null ? 'Nuevo estadio' : 'Editar estadio'),
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
            TextFormField(controller: _ubicacion, decoration: const InputDecoration(labelText: 'Ubicación')),
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
