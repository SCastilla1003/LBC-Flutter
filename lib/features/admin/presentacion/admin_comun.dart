import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/red/fallo_api.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../jugadores/datos/jugadores_repositorio.dart';
import '../../partidos/datos/partidos_repositorio.dart';
import '../../temporadas/datos/temporadas_repositorio.dart';

/// Tras cualquier escritura se descartan los datos en memoria: todo se vuelve a pedir a la API.
void refrescarLiga(WidgetRef ref) {
  ref.invalidate(temporadasProvider);
  ref.invalidate(temporadaActualProvider);
  ref.invalidate(temporadaDetalleProvider);
  ref.invalidate(estadisticasTemporadaProvider);
  ref.invalidate(equiposProvider);
  ref.invalidate(posicionesProvider);
  ref.invalidate(equipoDetalleProvider);
  ref.invalidate(equipoEstadisticasProvider);
  ref.invalidate(perfilBateadorProvider);
  ref.invalidate(perfilLanzadorProvider);
  ref.invalidate(bateadoresTemporadaProvider);
  ref.invalidate(lanzadoresTemporadaProvider);
  ref.invalidate(agentesLibresProvider);
  ref.invalidate(lideresProvider);
  ref.invalidate(partidosProvider);
  ref.invalidate(partidoProvider);
  ref.invalidate(estadiosProvider);
}

/// Ejecuta una escritura, avisa del resultado con un SnackBar y refresca los datos.
/// Devuelve true si salió bien.
Future<bool> ejecutarAccion(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function() accion, {
  required String exito,
}) async {
  final mensajero = ScaffoldMessenger.of(context);
  final colorError = Theme.of(context).colorScheme.error;
  try {
    await accion();
    refrescarLiga(ref);
    mensajero.showSnackBar(SnackBar(content: Text(exito)));
    return true;
  } catch (e) {
    final fallo = FalloApi.desde(e);
    final detalle = fallo is FalloValidacion && fallo.campos.isNotEmpty ? '\n${fallo.campos.values.join('\n')}' : '';
    mensajero.showSnackBar(SnackBar(
      content: Text('${fallo.mensaje}$detalle'),
      backgroundColor: colorError,
    ));
    return false;
  }
}

Future<bool> confirmar(BuildContext context, {required String titulo, required String mensaje, String accion = 'Eliminar'}) async {
  final r = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: Theme.of(c).colorScheme.error, foregroundColor: Theme.of(c).colorScheme.onError),
          onPressed: () => Navigator.pop(c, true),
          child: Text(accion),
        ),
      ],
    ),
  );
  return r ?? false;
}

/// Abre la galería y sube la foto elegida con [subir] (recibe bytes y nombre del archivo).
Future<void> elegirYSubirFoto(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function(List<int> bytes, String nombre) subir,
) async {
  final archivo = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1024, imageQuality: 85);
  if (archivo == null || !context.mounted) return;
  final bytes = await archivo.readAsBytes();
  if (!context.mounted) return;
  await ejecutarAccion(context, ref, () => subir(bytes, archivo.name), exito: 'Foto actualizada');
}

/// Campo numérico entero (≥ 0).
class CampoNumero extends StatelessWidget {
  const CampoNumero({super.key, required this.controller, required this.etiqueta, this.minimo = 0, this.maximo});

  final TextEditingController controller;
  final String etiqueta;
  final int minimo;
  final int? maximo;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: etiqueta, isDense: true),
      validator: (v) {
        final n = int.tryParse(v ?? '');
        if (n == null) return 'Obligatorio';
        if (n < minimo) return 'Mínimo $minimo';
        if (maximo != null && n > maximo!) return 'Máximo $maximo';
        return null;
      },
    );
  }
}

/// Rejilla adaptable para formularios con muchos campos numéricos.
class RejillaCampos extends StatelessWidget {
  const RejillaCampos({super.key, required this.hijos});

  final List<Widget> hijos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final columnas = (c.maxWidth / 170).floor().clamp(2, 4);
      final ancho = (c.maxWidth - (columnas - 1) * 12) / columnas;
      return Wrap(spacing: 12, runSpacing: 12, children: [for (final h in hijos) SizedBox(width: ancho, child: h)]);
    });
  }
}

/// Lee un entero de un controlador (0 si está vacío).
int entero(TextEditingController c) => int.tryParse(c.text) ?? 0;
