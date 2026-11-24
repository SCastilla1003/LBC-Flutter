import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/imagen_api.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import 'admin_comun.dart';

String etiquetaBateo(LadoBateo? l) => switch (l) {
      LadoBateo.derecho => 'Derecho',
      LadoBateo.zurdo => 'Zurdo',
      LadoBateo.ambidiestro => 'Ambidiestro',
      null => '—',
    };

String etiquetaLanzamiento(LadoLanzamiento? l) => switch (l) {
      LadoLanzamiento.derecho => 'Derecho',
      LadoLanzamiento.zurdo => 'Zurdo',
      null => 'No lanza',
    };

/// Jugadores de la liga (catálogo global). Su equipo en cada temporada se
/// asigna en la plantilla.
class AdminJugadoresPantalla extends ConsumerStatefulWidget {
  const AdminJugadoresPantalla({super.key});

  @override
  ConsumerState<AdminJugadoresPantalla> createState() => _AdminJugadoresPantallaState();
}

class _AdminJugadoresPantallaState extends ConsumerState<AdminJugadoresPantalla> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(ligaRepositorioProvider);
    final valor = ref.watch(jugadoresLigaProvider).whenData((l) {
      final f = _filtro.toLowerCase();
      final ordenados = [...l]..sort((a, b) => a.apellidos.toLowerCase().compareTo(b.apellidos.toLowerCase()));
      return f.isEmpty
          ? ordenados
          : ordenados.where((j) => '${j.nombres} ${j.apellidos}'.toLowerCase().contains(f)).toList();
    });
    return ListaAdmin<JugadorLiga>(
      titulo: 'Jugadores',
      valor: valor,
      onRecargar: () => ref.invalidate(jugadoresLigaProvider),
      textoNuevo: 'Nuevo jugador',
      onNuevo: () => _formulario(context, null),
      mensajeVacio: _filtro.isEmpty ? 'Sin jugadores todavía.' : 'Ningún jugador coincide con la búsqueda.',
      iconoVacio: Icons.person_outline_rounded,
      cabecera: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: TextField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Buscar jugador'),
          onChanged: (v) => setState(() => _filtro = v.trim()),
        ),
      ),
      fila: (j) => FilaAdmin(
        distintivo: ImagenApi(urlFoto: j.fotoUrl, nombre: '${j.nombres} ${j.apellidos}', tamano: 40),
        titulo: '${j.nombres} ${j.apellidos}',
        detalle: [
          if (j.edad != null) '${j.edad} años',
          'Batea: ${etiquetaBateo(j.batea)}',
          'Lanza: ${etiquetaLanzamiento(j.lanza)}',
        ].join(' · '),
        onEditar: () => _formulario(context, j),
        onEliminar: () => borrarConConfirmacion(
          context,
          ref,
          titulo: 'Eliminar jugador',
          mensaje: 'Se eliminará a ${j.nombres} ${j.apellidos}. Si está inscrito en alguna temporada o '
              'aparece en alineaciones, la API no lo permitirá.',
          borrar: () => repo.eliminarJugador(j.id),
          exito: 'Jugador eliminado',
        ),
      ),
    );
  }

  Future<void> _formulario(BuildContext context, JugadorLiga? j) =>
      showDialog<void>(context: context, builder: (_) => _DialogoJugador(jugador: j));
}

class _DialogoJugador extends ConsumerStatefulWidget {
  const _DialogoJugador({required this.jugador});

  final JugadorLiga? jugador;

  @override
  ConsumerState<_DialogoJugador> createState() => _DialogoJugadorState();
}

class _DialogoJugadorState extends ConsumerState<_DialogoJugador> {
  late final _nombres = TextEditingController(text: widget.jugador?.nombres);
  late final _apellidos = TextEditingController(text: widget.jugador?.apellidos);
  late final _foto = TextEditingController(text: widget.jugador?.fotoUrl);
  late DateTime? _nacimiento = widget.jugador?.fechaNacimiento;
  late LadoBateo? _batea = widget.jugador?.batea;
  late LadoLanzamiento? _lanza = widget.jugador?.lanza;

  @override
  void dispose() {
    for (final c in [_nombres, _apellidos, _foto]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final j = widget.jugador;
    final repo = ref.read(ligaRepositorioProvider);
    return DialogoFormulario(
      titulo: j == null ? 'Nuevo jugador' : 'Editar jugador',
      exito: j == null ? 'Jugador creado' : 'Jugador actualizado',
      guardar: () {
        final datos = DatosJugador(
          nombres: _nombres.text.trim(),
          apellidos: _apellidos.text.trim(),
          fechaNacimiento: _nacimiento,
          batea: _batea,
          lanza: _lanza,
          fotoUrl: textoOpcional(_foto),
        );
        return j == null ? repo.crearJugador(datos) : repo.actualizarJugador(j.id, datos);
      },
      campos: [
        CampoTexto(controller: _nombres, etiqueta: 'Nombres', obligatorio: true),
        CampoTexto(controller: _apellidos, etiqueta: 'Apellidos', obligatorio: true),
        CampoFecha(etiqueta: 'Fecha de nacimiento', inicial: _nacimiento, alCambiar: (v) => _nacimiento = v),
        DropdownButtonFormField<LadoBateo?>(
          initialValue: _batea,
          decoration: const InputDecoration(labelText: 'Batea'),
          items: [
            const DropdownMenuItem(value: null, child: Text('Sin indicar')),
            for (final l in LadoBateo.values) DropdownMenuItem(value: l, child: Text(etiquetaBateo(l))),
          ],
          onChanged: (v) => setState(() => _batea = v),
        ),
        DropdownButtonFormField<LadoLanzamiento?>(
          initialValue: _lanza,
          decoration: const InputDecoration(
            labelText: 'Lanza',
            helperText: 'Solo los jugadores que lanzan pueden ser lanzadores en la alineación.',
          ),
          items: [
            DropdownMenuItem(value: null, child: Text(etiquetaLanzamiento(null))),
            for (final l in LadoLanzamiento.values)
              DropdownMenuItem(value: l, child: Text(etiquetaLanzamiento(l))),
          ],
          onChanged: (v) => setState(() => _lanza = v),
        ),
        CampoTexto(
          controller: _foto,
          etiqueta: 'URL de la foto',
          teclado: TextInputType.url,
          validador: (v) => Uri.tryParse(v)?.hasScheme == true ? null : 'URL no válida',
        ),
      ],
    );
  }
}
