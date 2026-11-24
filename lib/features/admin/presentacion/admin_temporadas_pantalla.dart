import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import 'admin_comun.dart';

/// Temporadas: nombre, año, estado y fechas. Solo una debería estar "En curso":
/// es la que la app muestra como temporada actual.
class AdminTemporadasPantalla extends ConsumerWidget {
  const AdminTemporadasPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(ligaRepositorioProvider);
    return ListaAdmin<TemporadaLiga>(
      titulo: 'Temporadas',
      valor: ref.watch(temporadasLigaProvider),
      onRecargar: () => ref.invalidate(temporadasLigaProvider),
      textoNuevo: 'Nueva temporada',
      onNuevo: () => _formulario(context, null),
      mensajeVacio: 'Sin temporadas. Crea la primera y márcala "En curso" para que aparezca en la app.',
      iconoVacio: Icons.calendar_month_outlined,
      fila: (t) => FilaAdmin(
        distintivo: PlacaAdmin(
          texto: '${t.anio}'.substring(2),
          color: t.estado == EstadoTemporadaLiga.activa ? Theme.of(context).colorScheme.primary : null,
        ),
        titulo: t.nombre,
        detalle: '${t.anio} · ${etiquetaEstadoTemporada(t.estado)}',
        onEditar: () => _formulario(context, t),
        onEliminar: () => borrarConConfirmacion(
          context,
          ref,
          titulo: 'Eliminar temporada',
          mensaje: 'Se eliminará "${t.nombre}". Si ya tiene partidos o jugadores inscritos, '
              'la API no lo permitirá.',
          borrar: () => repo.eliminarTemporada(t.id),
          exito: 'Temporada eliminada',
        ),
      ),
    );
  }

  Future<void> _formulario(BuildContext context, TemporadaLiga? t) =>
      showDialog<void>(context: context, builder: (_) => _DialogoTemporada(temporada: t));
}

class _DialogoTemporada extends ConsumerStatefulWidget {
  const _DialogoTemporada({required this.temporada});

  final TemporadaLiga? temporada;

  @override
  ConsumerState<_DialogoTemporada> createState() => _DialogoTemporadaState();
}

class _DialogoTemporadaState extends ConsumerState<_DialogoTemporada> {
  late final _nombre = TextEditingController(text: widget.temporada?.nombre);
  late final _anio = TextEditingController(text: '${widget.temporada?.anio ?? DateTime.now().year}');
  late var _estado = widget.temporada?.estado ?? EstadoTemporadaLiga.borrador;
  late DateTime? _inicio = widget.temporada?.fechaInicio;
  late DateTime? _fin = widget.temporada?.fechaFin;

  @override
  void dispose() {
    _nombre.dispose();
    _anio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.temporada;
    final repo = ref.read(ligaRepositorioProvider);
    return DialogoFormulario(
      titulo: t == null ? 'Nueva temporada' : 'Editar temporada',
      exito: t == null ? 'Temporada creada' : 'Temporada actualizada',
      guardar: () {
        final datos = DatosTemporada(
          nombre: _nombre.text.trim(),
          anio: int.parse(_anio.text),
          estado: _estado,
          fechaInicio: _inicio,
          fechaFin: _fin,
        );
        return t == null ? repo.crearTemporada(datos) : repo.actualizarTemporada(t.id, datos);
      },
      campos: [
        CampoTexto(controller: _nombre, etiqueta: 'Nombre', obligatorio: true),
        CampoNumero(controller: _anio, etiqueta: 'Año', minimo: 1900, maximo: 2100),
        DropdownButtonFormField<EstadoTemporadaLiga>(
          initialValue: _estado,
          decoration: const InputDecoration(
            labelText: 'Estado',
            helperText: '"En curso" es la temporada que la app muestra al abrir.',
          ),
          items: [
            for (final e in EstadoTemporadaLiga.values)
              DropdownMenuItem(value: e, child: Text(etiquetaEstadoTemporada(e))),
          ],
          onChanged: (v) => setState(() => _estado = v ?? _estado),
        ),
        CampoFecha(etiqueta: 'Inicio', inicial: _inicio, alCambiar: (v) => _inicio = v),
        CampoFecha(etiqueta: 'Fin', inicial: _fin, alCambiar: (v) => _fin = v),
      ],
    );
  }
}
