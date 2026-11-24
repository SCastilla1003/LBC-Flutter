import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import 'admin_comun.dart';

/// Estadios de la liga (catálogo global, nombre único).
class AdminEstadiosPantalla extends ConsumerWidget {
  const AdminEstadiosPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(ligaRepositorioProvider);
    return ListaAdmin<EstadioLiga>(
      titulo: 'Estadios',
      valor: ref.watch(estadiosLigaProvider),
      onRecargar: () => ref.invalidate(estadiosLigaProvider),
      textoNuevo: 'Nuevo estadio',
      onNuevo: () => _formulario(context, null),
      mensajeVacio: 'Sin estadios todavía.',
      iconoVacio: Icons.stadium_outlined,
      fila: (s) => FilaAdmin(
        distintivo: const PlacaAdmin(icono: Icons.stadium_rounded),
        titulo: s.nombre,
        detalle: s.ubicacion,
        onEditar: () => _formulario(context, s),
        onEliminar: () => borrarConConfirmacion(
          context,
          ref,
          titulo: 'Eliminar estadio',
          mensaje: 'Se eliminará "${s.nombre}".',
          borrar: () => repo.eliminarEstadio(s.id),
          exito: 'Estadio eliminado',
        ),
      ),
    );
  }

  Future<void> _formulario(BuildContext context, EstadioLiga? s) =>
      showDialog<void>(context: context, builder: (_) => _DialogoEstadio(estadio: s));
}

class _DialogoEstadio extends ConsumerStatefulWidget {
  const _DialogoEstadio({required this.estadio});

  final EstadioLiga? estadio;

  @override
  ConsumerState<_DialogoEstadio> createState() => _DialogoEstadioState();
}

class _DialogoEstadioState extends ConsumerState<_DialogoEstadio> {
  late final _nombre = TextEditingController(text: widget.estadio?.nombre);
  late final _ubicacion = TextEditingController(text: widget.estadio?.ubicacion);

  @override
  void dispose() {
    _nombre.dispose();
    _ubicacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.estadio;
    final repo = ref.read(ligaRepositorioProvider);
    return DialogoFormulario(
      titulo: s == null ? 'Nuevo estadio' : 'Editar estadio',
      exito: s == null ? 'Estadio creado' : 'Estadio actualizado',
      guardar: () {
        final nombre = _nombre.text.trim();
        final ubicacion = textoOpcional(_ubicacion);
        return s == null
            ? repo.crearEstadio(nombre: nombre, ubicacion: ubicacion)
            : repo.actualizarEstadio(s.id, nombre: nombre, ubicacion: ubicacion);
      },
      campos: [
        CampoTexto(controller: _nombre, etiqueta: 'Nombre', obligatorio: true),
        CampoTexto(controller: _ubicacion, etiqueta: 'Ubicación'),
      ],
    );
  }
}
