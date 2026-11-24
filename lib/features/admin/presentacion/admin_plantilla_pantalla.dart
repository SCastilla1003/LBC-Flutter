import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import 'admin_comun.dart';
import 'admin_equipos_pantalla.dart';
import 'admin_jugadores_pantalla.dart';

/// Plantillas de una temporada: todos los equipos de la liga; al entrar en uno
/// se inscriben sus jugadores para esta temporada.
class AdminPlantillasPantalla extends ConsumerWidget {
  const AdminPlantillasPantalla({super.key, required this.idTemporada});

  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inscritos = ref.watch(equiposTemporadaLigaProvider(idTemporada)).value?.map((e) => e.id).toSet() ?? {};
    return ListaAdmin<EquipoLiga>(
      titulo: 'Plantillas',
      valor: ref.watch(equiposLigaProvider),
      onRecargar: () {
        ref.invalidate(equiposLigaProvider);
        ref.invalidate(equiposTemporadaLigaProvider(idTemporada));
      },
      mensajeVacio: 'Primero crea los equipos de la liga en "Equipos".',
      iconoVacio: Icons.groups_outlined,
      fila: (e) => FilaAdmin(
        distintivo: EscudoLiga(equipo: refDe(e), tamano: 40),
        titulo: e.nombre,
        detalle: inscritos.contains(e.id) ? 'Con jugadores en esta temporada' : 'Sin jugadores inscritos',
        onTap: () => context.push('/admin/t/$idTemporada/plantilla/${e.id}'),
      ),
    );
  }
}

/// Plantilla de un equipo en la temporada ([idEquipo] nulo = agentes libres).
class AdminPlantillaEquipoPantalla extends ConsumerWidget {
  const AdminPlantillaEquipoPantalla({super.key, required this.idTemporada, required this.idEquipo});

  final int idTemporada;
  final int? idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(ligaRepositorioProvider);
    final equipos = ref.watch(equiposLigaProvider).value ?? const <EquipoLiga>[];
    final equipo = equipos.where((e) => e.id == idEquipo).firstOrNull;
    final valor = idEquipo == null
        ? ref.watch(agentesLibresLigaProvider(idTemporada))
        : ref.watch(plantillaLigaProvider((idTemporada, idEquipo!)));
    void recargar() => idEquipo == null
        ? ref.invalidate(agentesLibresLigaProvider(idTemporada))
        : ref.invalidate(plantillaLigaProvider((idTemporada, idEquipo!)));

    return ListaAdmin<PlantillaLiga>(
      titulo: idEquipo == null ? 'Agentes libres' : (equipo?.nombre ?? 'Plantilla'),
      valor: valor.whenData((l) => [...l]..sort((a, b) => (a.numero ?? 999).compareTo(b.numero ?? 999))),
      onRecargar: recargar,
      textoNuevo: 'Inscribir jugador',
      onNuevo: () => showDialog<void>(
        context: context,
        builder: (_) => _DialogoInscripcion(
          idTemporada: idTemporada,
          idEquipo: idEquipo,
          yaInscritos: valor.value?.map((p) => p.jugador.id).toSet() ?? const {},
        ),
      ),
      mensajeVacio: idEquipo == null
          ? 'No hay agentes libres en esta temporada.'
          : 'Este equipo no tiene jugadores inscritos en la temporada.',
      iconoVacio: Icons.person_add_alt_outlined,
      fila: (p) {
        final nombre = '${p.jugador.nombres} ${p.jugador.apellidos}';
        return FilaAdmin(
          distintivo: PlacaAdmin(texto: p.numero?.toString() ?? '—'),
          titulo: nombre,
          detalle: [
            p.posicion ?? 'Sin posición',
            'Batea: ${etiquetaBateo(p.jugador.batea)}',
            if (p.jugador.lanza != null) 'Lanza: ${etiquetaLanzamiento(p.jugador.lanza)}',
          ].join(' · '),
          onEditar: () => showDialog<void>(
            context: context,
            builder: (_) => _DialogoEntrada(idTemporada: idTemporada, entrada: p, equipos: equipos),
          ),
          onEliminar: () => borrarConConfirmacion(
            context,
            ref,
            titulo: 'Quitar de la temporada',
            mensaje: '$nombre dejará de estar inscrito en esta temporada. El jugador no se borra de la liga.',
            accion: 'Quitar',
            borrar: () => repo.quitarDeTemporada(idTemporada, p.id),
            exito: 'Jugador retirado de la temporada',
          ),
        );
      },
    );
  }
}

/// Inscribe un jugador de la liga en este equipo (o como agente libre).
class _DialogoInscripcion extends ConsumerStatefulWidget {
  const _DialogoInscripcion({required this.idTemporada, required this.idEquipo, required this.yaInscritos});

  final int idTemporada;
  final int? idEquipo;
  final Set<int> yaInscritos;

  @override
  ConsumerState<_DialogoInscripcion> createState() => _DialogoInscripcionState();
}

class _DialogoInscripcionState extends ConsumerState<_DialogoInscripcion> {
  final _numero = TextEditingController();
  int? _jugador;
  String? _posicion;

  @override
  void dispose() {
    _numero.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(ligaRepositorioProvider);
    final jugadores = (ref.watch(jugadoresLigaProvider).value ?? const <JugadorLiga>[])
        .where((j) => !widget.yaInscritos.contains(j.id))
        .toList()
      ..sort((a, b) => a.apellidos.toLowerCase().compareTo(b.apellidos.toLowerCase()));
    return DialogoFormulario(
      titulo: 'Inscribir jugador',
      exito: 'Jugador inscrito',
      guardar: () => repo.inscribir(
        widget.idTemporada,
        jugadorId: _jugador!,
        equipoId: widget.idEquipo,
        numero: enteroOpcional(_numero),
        posicion: _posicion,
      ),
      campos: [
        DropdownButtonFormField<int>(
          initialValue: _jugador,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Jugador',
            helperText: jugadores.isEmpty ? 'Crea jugadores en "Jugadores" para poder inscribirlos.' : null,
          ),
          items: [
            for (final j in jugadores)
              DropdownMenuItem(value: j.id, child: Text('${j.apellidos}, ${j.nombres}', overflow: TextOverflow.ellipsis)),
          ],
          validator: (v) => v == null ? 'Elige un jugador' : null,
          onChanged: (v) => setState(() => _jugador = v),
        ),
        CampoNumero(controller: _numero, etiqueta: 'Número', maximo: 99, obligatorio: false),
        _CampoPosicion(valor: _posicion, alCambiar: (v) => setState(() => _posicion = v)),
      ],
    );
  }
}

/// Edita una inscripción: equipo (traspaso o agente libre), número y posición.
class _DialogoEntrada extends ConsumerStatefulWidget {
  const _DialogoEntrada({required this.idTemporada, required this.entrada, required this.equipos});

  final int idTemporada;
  final PlantillaLiga entrada;
  final List<EquipoLiga> equipos;

  @override
  ConsumerState<_DialogoEntrada> createState() => _DialogoEntradaState();
}

class _DialogoEntradaState extends ConsumerState<_DialogoEntrada> {
  late final _numero = TextEditingController(text: widget.entrada.numero?.toString());
  late int? _equipo = widget.entrada.equipo?.id;
  late String? _posicion = widget.entrada.posicion;

  @override
  void dispose() {
    _numero.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(ligaRepositorioProvider);
    final p = widget.entrada;
    return DialogoFormulario(
      titulo: '${p.jugador.nombres} ${p.jugador.apellidos}',
      exito: 'Inscripción actualizada',
      guardar: () => repo.actualizarInscripcion(
        widget.idTemporada,
        p.id,
        equipoId: _equipo,
        numero: enteroOpcional(_numero),
        posicion: _posicion,
      ),
      campos: [
        DropdownButtonFormField<int?>(
          initialValue: _equipo,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Equipo', helperText: 'Cambiar de equipo es un traspaso.'),
          items: [
            const DropdownMenuItem(value: null, child: Text('Agente libre')),
            for (final e in widget.equipos) DropdownMenuItem(value: e.id, child: Text(e.nombre)),
          ],
          onChanged: (v) => setState(() => _equipo = v),
        ),
        CampoNumero(controller: _numero, etiqueta: 'Número', maximo: 99, obligatorio: false),
        _CampoPosicion(valor: _posicion, alCambiar: (v) => setState(() => _posicion = v)),
      ],
    );
  }
}

class _CampoPosicion extends StatelessWidget {
  const _CampoPosicion({required this.valor, required this.alCambiar});

  final String? valor;
  final ValueChanged<String?> alCambiar;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String?>(
        initialValue: valor,
        decoration: const InputDecoration(labelText: 'Posición (opcional)'),
        items: [
          const DropdownMenuItem(value: null, child: Text('Sin posición')),
          for (final p in posicionesLiga) DropdownMenuItem(value: p, child: Text(_nombrePosicion(p))),
        ],
        onChanged: alCambiar,
      );
}

String _nombrePosicion(String p) => switch (p) {
      'P' => 'P · Lanzador',
      'C' => 'C · Receptor',
      '1B' => '1B · Primera base',
      '2B' => '2B · Segunda base',
      '3B' => '3B · Tercera base',
      'SS' => 'SS · Campocorto',
      'LF' => 'LF · Jardín izquierdo',
      'CF' => 'CF · Jardín central',
      'RF' => 'RF · Jardín derecho',
      'DH' => 'DH · Bateador designado',
      _ => p,
    };
