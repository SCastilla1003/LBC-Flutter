import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/red/fallo_api.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/juego_repositorio.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../jugadores/datos/jugadores_repositorio.dart';
import '../../partidos/datos/partidos_repositorio.dart';
import '../../temporadas/datos/temporadas_repositorio.dart';

/// Tras cualquier escritura se descartan los datos en memoria: todo se vuelve a pedir a la API.
void refrescarLiga(WidgetRef ref) {
  // Contrato v1 (panel y pantallas de liga).
  ref.invalidate(temporadasLigaProvider);
  ref.invalidate(temporadaActualLigaProvider);
  ref.invalidate(temporadaLigaProvider);
  ref.invalidate(equiposTemporadaLigaProvider);
  ref.invalidate(partidosLigaProvider);
  ref.invalidate(partidoDetalleLigaProvider);
  ref.invalidate(posicionesLigaProvider);
  ref.invalidate(alineacionLigaProvider);
  ref.invalidate(pitcheoLigaProvider);
  ref.invalidate(equiposLigaProvider);
  ref.invalidate(estadiosLigaProvider);
  ref.invalidate(jugadoresLigaProvider);
  ref.invalidate(plantillaLigaProvider);
  ref.invalidate(agentesLibresLigaProvider);
  ref.invalidate(estadoJuegoProvider);
  // Pantallas que aún leen el contrato anterior.
  ref.invalidate(temporadasProvider);
  ref.invalidate(temporadaActualProvider);
  ref.invalidate(temporadaDetalleProvider);
  ref.invalidate(estadisticasTemporadaProvider);
  ref.invalidate(equiposProvider);
  ref.invalidate(posicionesProvider);
  ref.invalidate(equipoDetalleProvider);
  ref.invalidate(lideresProvider);
  ref.invalidate(partidosProvider);
  ref.invalidate(partidoProvider);
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

/// Pide confirmación y borra; muestra el resultado.
Future<void> borrarConConfirmacion(
  BuildContext context,
  WidgetRef ref, {
  required String titulo,
  required String mensaje,
  required Future<void> Function() borrar,
  required String exito,
  String accion = 'Eliminar',
}) async {
  final ok = await confirmar(context, titulo: titulo, mensaje: mensaje, accion: accion);
  if (ok && context.mounted) await ejecutarAccion(context, ref, borrar, exito: exito);
}

/// Pantalla de lista del panel: barra, botón flotante de alta, recarga y estados.
class ListaAdmin<T> extends StatelessWidget {
  const ListaAdmin({
    super.key,
    required this.titulo,
    required this.valor,
    required this.onRecargar,
    required this.fila,
    this.textoNuevo,
    this.onNuevo,
    this.mensajeVacio = 'Todavía no hay nada aquí.',
    this.iconoVacio = Icons.inbox_outlined,
    this.cabecera,
  });

  final String titulo;
  final AsyncValue<List<T>> valor;
  final VoidCallback onRecargar;
  final Widget Function(T) fila;
  final String? textoNuevo;
  final VoidCallback? onNuevo;
  final String mensajeVacio;
  final IconData iconoVacio;
  final Widget? cabecera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      floatingActionButton: onNuevo == null
          ? null
          : FloatingActionButton.extended(
              onPressed: onNuevo,
              icon: const Icon(Icons.add_rounded),
              label: Text(textoNuevo ?? 'Nuevo'),
            ),
      body: RefreshIndicator(
        onRefresh: () async => onRecargar(),
        child: VistaAsync<List<T>>(
          valor: valor,
          onReintentar: onRecargar,
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              AnchoMaximo(
                ancho: 760,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ?cabecera,
                    if (lista.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: EstadoVacio(mensaje: mensajeVacio, icono: iconoVacio),
                      )
                    else
                      for (final e in lista) fila(e),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fila del panel: tarjeta con un distintivo, título, detalle y acciones.
class FilaAdmin extends StatelessWidget {
  const FilaAdmin({
    super.key,
    required this.titulo,
    this.detalle,
    this.distintivo,
    this.onTap,
    this.onEditar,
    this.onEliminar,
  });

  final String titulo;
  final String? detalle;
  final Widget? distintivo;
  final VoidCallback? onTap;
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.fromLTRB(14, 4, 6, 4),
          leading: distintivo,
          title: Text(
            titulo,
            style: tema.textTheme.titleMedium?.copyWith(
              fontFamily: FuentesLbc.titular,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: detalle == null ? null : Text(detalle!),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            if (onEditar != null)
              IconButton(tooltip: 'Editar', icon: const Icon(Icons.edit_outlined), onPressed: onEditar),
            if (onEliminar != null)
              IconButton(
                tooltip: 'Eliminar',
                icon: Icon(Icons.delete_outline_rounded, color: tema.colorScheme.error),
                onPressed: onEliminar,
              ),
            if (onTap != null) Icon(Icons.chevron_right_rounded, color: tema.colorScheme.primary),
          ]),
        ),
      ),
    );
  }
}

/// Placa cuadrada con texto o icono, en verde de la marca.
class PlacaAdmin extends StatelessWidget {
  const PlacaAdmin({super.key, this.texto, this.icono, this.color});

  final String? texto;
  final IconData? icono;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final fondo = color ?? esquema.primaryContainer;
    final tinta = color == null
        ? esquema.primary
        : (ThemeData.estimateBrightnessForColor(fondo) == Brightness.dark ? Colors.white : ColoresMarca.tinta);
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: fondo, borderRadius: BorderRadius.circular(9)),
      child: icono != null
          ? Icon(icono, size: 20, color: tinta)
          : Text(
              texto ?? '',
              style: estiloMarcador(Theme.of(context).textTheme.titleMedium)?.copyWith(fontSize: 17, color: tinta),
            ),
    );
  }
}

/// Diálogo de formulario con guardado: valida, ejecuta [guardar] y se cierra si salió bien.
class DialogoFormulario extends ConsumerStatefulWidget {
  const DialogoFormulario({
    super.key,
    required this.titulo,
    required this.campos,
    required this.guardar,
    required this.exito,
  });

  final String titulo;
  final List<Widget> campos;
  final Future<void> Function() guardar;
  final String exito;

  @override
  ConsumerState<DialogoFormulario> createState() => _DialogoFormularioState();
}

class _DialogoFormularioState extends ConsumerState<DialogoFormulario> {
  final _form = GlobalKey<FormState>();
  bool _guardando = false;

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _guardando = true);
    final ok = await ejecutarAccion(context, ref, widget.guardar, exito: widget.exito);
    if (!mounted) return;
    setState(() => _guardando = false);
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titulo),
      content: Form(
        key: _form,
        child: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              for (var i = 0; i < widget.campos.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                widget.campos[i],
              ],
            ]),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          onPressed: _guardando ? null : _guardar,
          child: _guardando
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Guardar'),
        ),
      ],
    );
  }
}

/// Campo de texto obligatorio u opcional.
class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.controller,
    required this.etiqueta,
    this.obligatorio = false,
    this.validador,
    this.mayusculas = false,
    this.teclado,
  });

  final TextEditingController controller;
  final String etiqueta;
  final bool obligatorio;
  final String? Function(String)? validador;
  final bool mayusculas;
  final TextInputType? teclado;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        keyboardType: teclado,
        textCapitalization: mayusculas ? TextCapitalization.characters : TextCapitalization.sentences,
        decoration: InputDecoration(labelText: obligatorio ? etiqueta : '$etiqueta (opcional)'),
        validator: (v) {
          final t = (v ?? '').trim();
          if (obligatorio && t.isEmpty) return 'Obligatorio';
          return t.isEmpty ? null : validador?.call(t);
        },
      );
}

/// Campo numérico entero; vacío permitido si no es obligatorio.
class CampoNumero extends StatelessWidget {
  const CampoNumero({
    super.key,
    required this.controller,
    required this.etiqueta,
    this.minimo = 0,
    this.maximo,
    this.obligatorio = true,
  });

  final TextEditingController controller;
  final String etiqueta;
  final int minimo;
  final int? maximo;
  final bool obligatorio;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: obligatorio ? etiqueta : '$etiqueta (opcional)'),
      validator: (v) {
        if ((v ?? '').isEmpty) return obligatorio ? 'Obligatorio' : null;
        final n = int.tryParse(v!);
        if (n == null) return 'Número no válido';
        if (n < minimo) return 'Mínimo $minimo';
        if (maximo != null && n > maximo!) return 'Máximo $maximo';
        return null;
      },
    );
  }
}

/// Entero de un controlador, o null si está vacío.
int? enteroOpcional(TextEditingController c) => int.tryParse(c.text.trim());

/// Texto de un controlador, o null si está vacío.
String? textoOpcional(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();

/// Selector de fecha (y opcionalmente hora) con aspecto de campo de formulario.
class CampoFecha extends FormField<DateTime> {
  CampoFecha({
    super.key,
    required String etiqueta,
    required DateTime? inicial,
    required ValueChanged<DateTime?> alCambiar,
    bool conHora = false,
    bool obligatorio = false,
  }) : super(
          initialValue: inicial,
          validator: (v) => obligatorio && v == null ? 'Obligatorio' : null,
          builder: (estado) {
            final context = estado.context;
            final v = estado.value;
            final formato = DateFormat(conHora ? "EEE d MMM y · h:mm a" : "d MMM y", 'es');
            Future<void> elegir() async {
              final ahora = DateTime.now();
              final fecha = await showDatePicker(
                context: context,
                initialDate: v ?? ahora,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (fecha == null || !context.mounted) return;
              var resultado = fecha;
              if (conHora) {
                final hora = await showTimePicker(
                  context: context,
                  initialTime: v == null ? const TimeOfDay(hour: 15, minute: 0) : TimeOfDay.fromDateTime(v),
                );
                if (hora == null) return;
                resultado = DateTime(fecha.year, fecha.month, fecha.day, hora.hour, hora.minute);
              }
              estado.didChange(resultado);
              alCambiar(resultado);
            }

            return InkWell(
              onTap: elegir,
              borderRadius: BorderRadius.circular(RadioLbc.campo),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: obligatorio ? etiqueta : '$etiqueta (opcional)',
                  errorText: estado.errorText,
                  suffixIcon: v != null && !obligatorio
                      ? IconButton(
                          tooltip: 'Quitar',
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            estado.didChange(null);
                            alCambiar(null);
                          },
                        )
                      : Icon(conHora ? Icons.schedule_rounded : Icons.event_rounded),
                ),
                isEmpty: v == null,
                child: Text(v == null ? '' : formato.format(v)),
              ),
            );
          },
        );
}

/// Imagen elegida en el dispositivo, pendiente de subir.
class FotoElegida {
  const FotoElegida(this.bytes, this.nombre);

  final Uint8List bytes;
  final String nombre;
}

/// Abre la galería o la cámara y devuelve la imagen ya reducida (máx. 1024 px).
Future<FotoElegida?> elegirFoto(BuildContext context) async {
  final origen = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (c) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: const Text('Elegir de la galería'),
          onTap: () => Navigator.pop(c, ImageSource.gallery),
        ),
        if (!kIsWeb)
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Tomar una foto'),
            onTap: () => Navigator.pop(c, ImageSource.camera),
          ),
      ]),
    ),
  );
  if (origen == null) return null;
  final archivo = await ImagePicker().pickImage(source: origen, maxWidth: 1024, imageQuality: 85);
  if (archivo == null) return null;
  return FotoElegida(await archivo.readAsBytes(), archivo.name);
}

/// Foto o escudo en un formulario: muestra la actual o la recién elegida y
/// permite cambiarla o quitarla. La subida ocurre al guardar.
class SelectorFoto extends StatelessWidget {
  const SelectorFoto({
    super.key,
    required this.etiqueta,
    required this.nombre,
    required this.urlActual,
    required this.elegida,
    required this.quitada,
    required this.alElegir,
    required this.alQuitar,
    this.cuadrada = false,
  });

  final String etiqueta;
  final String nombre;
  final String? urlActual;
  final FotoElegida? elegida;
  final bool quitada;
  final ValueChanged<FotoElegida> alElegir;
  final VoidCallback alQuitar;
  final bool cuadrada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final radio = BorderRadius.circular(cuadrada ? 16 : 40);
    final hayFoto = elegida != null || (urlActual != null && !quitada);
    final vista = elegida != null
        ? ClipRRect(
            borderRadius: radio,
            child: Container(
              color: cuadrada ? Colors.white : null,
              child: Image.memory(elegida!.bytes, width: 80, height: 80, fit: cuadrada ? BoxFit.contain : BoxFit.cover),
            ),
          )
        : ImagenApi(
            urlFoto: quitada ? null : urlActual,
            nombre: nombre.isEmpty ? '?' : nombre,
            tamano: 80,
            cuadrada: cuadrada,
            completa: cuadrada,
          );
    return Row(children: [
      vista,
      const SizedBox(width: 16),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(etiqueta, style: tema.textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(spacing: 8, runSpacing: 4, children: [
            OutlinedButton.icon(
              onPressed: () async {
                final f = await elegirFoto(context);
                if (f != null) alElegir(f);
              },
              icon: const Icon(Icons.add_a_photo_outlined, size: 18),
              label: Text(hayFoto ? 'Cambiar' : 'Subir'),
            ),
            if (hayFoto)
              TextButton(
                onPressed: alQuitar,
                style: TextButton.styleFrom(foregroundColor: tema.colorScheme.error),
                child: const Text('Quitar'),
              ),
          ]),
        ]),
      ),
    ]);
  }
}
