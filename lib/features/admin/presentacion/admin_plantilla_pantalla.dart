import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/red/fallo_api.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import 'admin_comun.dart';
import 'admin_equipos_pantalla.dart';
import 'admin_inscripcion_pantalla.dart';
import 'admin_jugadores_pantalla.dart';

//// Equipos inscritos en una temporada, con su roster. "Inscribir equipo" trae los
/// jugadores que el equipo tenía registrados (su roster más reciente).
class AdminPlantillasPantalla extends ConsumerWidget {
  const AdminPlantillasPantalla({super.key, required this.idTemporada});

  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(ligaRepositorioProvider);
    final temporada = ref.watch(temporadasLigaProvider).value?.where((t) => t.id == idTemporada).firstOrNull;
    final inscritos = ref.watch(equiposTemporadaLigaProvider(idTemporada));
    final todos = ref.watch(equiposLigaProvider).value ?? const <EquipoLiga>[];
    return ListaAdmin<EquipoRefLiga>(
      titulo: temporada == null ? 'Equipos de la temporada' : 'Equipos · ${temporada.anio}',
      valor: inscritos,
      onRecargar: () {
        ref.invalidate(equiposLigaProvider);
        ref.invalidate(equiposTemporadaLigaProvider(idTemporada));
      },
      textoNuevo: 'Inscribir equipo',
      onNuevo: () => _inscribirEquipo(
        context,
        ref,
        disponibles: [
          for (final e in todos)
            if (!(inscritos.value ?? const []).any((i) => i.id == e.id)) e,
        ],
        nombreTemporada: temporada == null ? 'la temporada' : '${temporada.nombre} ${temporada.anio}',
      ),
      mensajeVacio: 'Ningún equipo inscrito en esta temporada. Usa "Inscribir equipo".',
      iconoVacio: Icons.groups_outlined,
      fila: (e) => _FilaEquipoTemporada(
        idTemporada: idTemporada,
        equipo: e,
        alQuitar: () => borrarConConfirmacion(
          context,
          ref,
          titulo: 'Quitar de la temporada',
          mensaje: '${e.nombre} dejará de estar inscrito en esta temporada. Si todavía tiene jugadores '
              'o partidos, primero hay que quitarlos.',
          accion: 'Quitar',
          borrar: () => repo.desinscribirEquipo(idTemporada, e.id),
          exito: 'Equipo quitado de la temporada',
        ),
      ),
    );
  }

  /// Elegir equipo → avisar qué jugadores trae → inscribir equipo y jugadores.
  Future<void> _inscribirEquipo(
    BuildContext context,
    WidgetRef ref, {
    required List<EquipoLiga> disponibles,
    required String nombreTemporada,
  }) async {
    if (disponibles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los equipos de la liga ya están inscritos (crea más en "Equipos").')),
      );
      return;
    }
    final equipo = await showModalBottomSheet<EquipoLiga>(
      context: context,
      isScrollControlled: true,
      builder: (c) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(c).height * 0.7),
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              child: Text('Inscribir en $nombreTemporada', style: Theme.of(c).textTheme.titleLarge),
            ),
            for (final e in disponibles)
              ListTile(
                leading: EscudoLiga(equipo: refDe(e), tamano: 40),
                title: Text(e.nombre),
                subtitle: Text([e.abreviatura, ?e.ciudad].join(' · ')),
                onTap: () => Navigator.pop(c, e),
              ),
          ]),
        ),
      ),
    );
    if (equipo == null || !context.mounted) return;

    final repo = ref.read(ligaRepositorioProvider);
    final mensajero = ScaffoldMessenger.of(context);
    // Roster más reciente del equipo y situación de esos jugadores en esta temporada.
    final List<CambioRoster> cambios;
    final List<String> omitidos;
    final String? origen;
    try {
      final anterior = await repo.rosterAnterior(idTemporada, equipo.id);
      final candidatos = {for (final c in await candidatosDeTemporada(repo, idTemporada, equipo.id)) c.jugador.id: c};
      cambios = [];
      omitidos = [];
      for (final p in anterior?.plantilla ?? const <PlantillaLiga>[]) {
        final c = candidatos[p.jugador.id];
        final nombre = '${p.jugador.nombres} ${p.jugador.apellidos}';
        switch (c?.situacion) {
          case AgenteLibre(:final entradaId):
            cambios.add(Entra(nombre, jugadorId: p.jugador.id, entradaLibre: entradaId, numero: p.numero, posicion: p.posicion));
          case EnOtroEquipo(:final equipo):
            omitidos.add('$nombre (${equipo.abreviatura})');
          case EnEsteEquipo():
            break;
          case SinInscribir() || null:
            cambios.add(Entra(nombre, jugadorId: p.jugador.id, entradaLibre: null, numero: p.numero, posicion: p.posicion));
        }
      }
      origen = anterior == null ? null : '${anterior.temporada.nombre} ${anterior.temporada.anio}';
    } catch (e) {
      mensajero.showSnackBar(SnackBar(content: Text(FalloApi.desde(e).mensaje)));
      return;
    }
    if (!context.mounted) return;

    final ok = cambios.isEmpty && omitidos.isEmpty
        ? await confirmar(
            context,
            titulo: 'Inscribir ${equipo.nombre}',
            mensaje: '${equipo.nombre} todavía no tiene jugadores registrados. Quedará inscrito en $nombreTemporada '
                'y podrás armar su roster con "Actualizar roster".',
            accion: 'Inscribir',
          )
        : await confirmarCambiosRoster(
            context,
            titulo: 'Inscribir ${equipo.nombre} con su roster de $origen',
            cambios: cambios,
            omitidos: omitidos,
          );
    if (!ok || !context.mounted) return;

    try {
      await repo.inscribirEquipo(idTemporada, equipo.id);
    } catch (e) {
      mensajero.showSnackBar(SnackBar(content: Text(FalloApi.desde(e).mensaje)));
      return;
    }
    final fallos = await aplicarCambiosRoster(repo, idTemporada, equipo.id, cambios);
    refrescarLiga(ref);
    if (!context.mounted) return;
    if (fallos.isEmpty) {
      mensajero.showSnackBar(SnackBar(
        content: Text(cambios.isEmpty
            ? '${equipo.nombre} inscrito'
            : '${equipo.nombre} inscrito con ${cambios.length} jugadores'),
      ));
    } else {
      await showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('${equipo.nombre} inscrito; algunos jugadores no entraron'),
          content: Text(fallos.map((f) => '• $f').join('\n')),
          actions: [FilledButton(onPressed: () => Navigator.pop(c), child: const Text('Entendido'))],
        ),
      );
    }
  }
}

/// Fila de un equipo inscrito: escudo, nombre y cuántos jugadores tiene.
class _FilaEquipoTemporada extends ConsumerWidget {
  const _FilaEquipoTemporada({required this.idTemporada, required this.equipo, required this.alQuitar});

  final int idTemporada;
  final EquipoRefLiga equipo;
  final VoidCallback alQuitar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(plantillaLigaProvider((idTemporada, equipo.id))).value?.length;
    return FilaAdmin(
      distintivo: EscudoLiga(equipo: equipo, tamano: 40),
      titulo: equipo.nombre,
      detalle: n == null ? 'Roster…' : (n == 0 ? 'Sin jugadores · toca para armar el roster' : '$n jugadores en el roster'),
      onTap: () => context.push('/admin/t/$idTemporada/plantilla/${equipo.id}'),
      onEliminar: alQuitar,
    );
  }
}

// Plantilla de un equipo en la temporada ([idEquipo] nulo = agentes libres).
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
      textoNuevo: idEquipo == null ? 'Inscribir jugadores' : 'Actualizar roster',
      // Abre la lista para elegir varios a la vez, con número y posición.
      onNuevo: () => context.push(idEquipo == null
          ? '/admin/t/$idTemporada/agentes-libres/inscribir'
          : '/admin/t/$idTemporada/plantilla/$idEquipo/inscribir'),
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
