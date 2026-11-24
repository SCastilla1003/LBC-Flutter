import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/tema/colores_equipo.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import 'admin_comun.dart';

EquipoRefLiga refDe(EquipoLiga e) =>
    EquipoRefLiga(id: e.id, nombre: e.nombre, abreviatura: e.abreviatura, color: e.color, escudoUrl: e.escudoUrl);

/// Equipos de la liga (catálogo global). Entran en una temporada al inscribirles jugadores.
class AdminEquiposPantalla extends ConsumerWidget {
  const AdminEquiposPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(ligaRepositorioProvider);
    return ListaAdmin<EquipoLiga>(
      titulo: 'Equipos',
      valor: ref.watch(equiposLigaProvider),
      onRecargar: () => ref.invalidate(equiposLigaProvider),
      textoNuevo: 'Nuevo equipo',
      onNuevo: () => _formulario(context, null),
      mensajeVacio: 'Sin equipos todavía.',
      iconoVacio: Icons.shield_outlined,
      fila: (e) => FilaAdmin(
        distintivo: EscudoLiga(equipo: refDe(e), tamano: 40),
        titulo: e.nombre,
        detalle: [e.abreviatura, ?e.ciudad, if (e.color != null) ColoresEquipo.nombres[e.color] ?? e.color!]
            .join(' · '),
        onEditar: () => _formulario(context, e),
        onEliminar: () => borrarConConfirmacion(
          context,
          ref,
          titulo: 'Eliminar equipo',
          mensaje: 'Se eliminará "${e.nombre}". Si ya jugó partidos o tiene jugadores inscritos, '
              'la API no lo permitirá.',
          borrar: () => repo.eliminarEquipo(e.id),
          exito: 'Equipo eliminado',
        ),
      ),
    );
  }

  Future<void> _formulario(BuildContext context, EquipoLiga? e) =>
      showDialog<void>(context: context, builder: (_) => _DialogoEquipo(equipo: e));
}

class _DialogoEquipo extends ConsumerStatefulWidget {
  const _DialogoEquipo({required this.equipo});

  final EquipoLiga? equipo;

  @override
  ConsumerState<_DialogoEquipo> createState() => _DialogoEquipoState();
}

class _DialogoEquipoState extends ConsumerState<_DialogoEquipo> {
  late final _nombre = TextEditingController(text: widget.equipo?.nombre);
  late final _abrev = TextEditingController(text: widget.equipo?.abreviatura);
  late final _ciudad = TextEditingController(text: widget.equipo?.ciudad);
  FotoElegida? _escudo;
  bool _quitarEscudo = false;
  late String? _color = ColoresEquipo.paleta.containsKey(widget.equipo?.color) ? widget.equipo?.color : null;

  @override
  void dispose() {
    for (final c in [_nombre, _abrev, _ciudad]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.equipo;
    final repo = ref.read(ligaRepositorioProvider);
    return DialogoFormulario(
      titulo: e == null ? 'Nuevo equipo' : 'Editar equipo',
      exito: e == null ? 'Equipo creado' : 'Equipo actualizado',
      guardar: () async {
        final datos = DatosEquipo(
          nombre: _nombre.text.trim(),
          abreviatura: _abrev.text.trim().toUpperCase(),
          ciudad: textoOpcional(_ciudad),
          color: _color,
          // El escudo se gestiona aparte (bucket); se conserva el que ya tenía.
          escudoUrl: e?.escudoUrl,
        );
        final guardado = e == null ? await repo.crearEquipo(datos) : await repo.actualizarEquipo(e.id, datos);
        if (_escudo != null) {
          await repo.subirEscudo(guardado.id, _escudo!.bytes, _escudo!.nombre);
        } else if (_quitarEscudo && e?.escudoUrl != null) {
          await repo.borrarEscudo(guardado.id);
        }
      },
      campos: [
        SelectorFoto(
          etiqueta: 'Escudo',
          nombre: _nombre.text.trim(),
          urlActual: e?.escudoUrl,
          elegida: _escudo,
          quitada: _quitarEscudo,
          cuadrada: true,
          alElegir: (f) => setState(() {
            _escudo = f;
            _quitarEscudo = false;
          }),
          alQuitar: () => setState(() {
            _escudo = null;
            _quitarEscudo = true;
          }),
        ),
        CampoTexto(controller: _nombre, etiqueta: 'Nombre', obligatorio: true),
        CampoTexto(
          controller: _abrev,
          etiqueta: 'Abreviatura',
          obligatorio: true,
          mayusculas: true,
          validador: (v) => RegExp(r'^[A-Za-z]{2,5}$').hasMatch(v) ? null : 'Entre 2 y 5 letras',
        ),
        CampoTexto(controller: _ciudad, etiqueta: 'Ciudad'),
        DropdownButtonFormField<String?>(
          initialValue: _color,
          decoration: const InputDecoration(labelText: 'Color del equipo'),
          items: [
            const DropdownMenuItem(value: null, child: Text('Sin color')),
            for (final clave in ColoresEquipo.paleta.keys)
              DropdownMenuItem(
                value: clave,
                child: Row(children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(color: ColoresEquipo.de(context, clave), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Text(ColoresEquipo.nombres[clave] ?? clave),
                ]),
              ),
          ],
          onChanged: (v) => setState(() => _color = v),
        ),
      ],
    );
  }
}
