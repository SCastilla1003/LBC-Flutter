import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import 'admin_comun.dart';

String etiquetaEstadoPartido(EstadoPartidoLiga e) => switch (e) {
      EstadoPartidoLiga.programado => 'Programado',
      EstadoPartidoLiga.alineacionPublicada => 'Alineación lista',
      EstadoPartidoLiga.enJuego => 'En vivo',
      EstadoPartidoLiga.finalizado => 'Final',
      EstadoPartidoLiga.suspendido => 'Suspendido',
    };

/// Partidos de una temporada: se programan aquí; el marcador lo lleva el anotador.
class AdminPartidosPantalla extends ConsumerWidget {
  const AdminPartidosPantalla({super.key, required this.idTemporada});

  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(ligaRepositorioProvider);
    final formato = DateFormat("EEE d MMM · h:mm a", 'es');
    return ListaAdmin<PartidoResumen>(
      titulo: 'Partidos',
      valor: ref
          .watch(partidosLigaProvider(idTemporada))
          .whenData((l) => [...l]..sort((a, b) => a.fechaHora.compareTo(b.fechaHora))),
      onRecargar: () => ref.invalidate(partidosLigaProvider(idTemporada)),
      textoNuevo: 'Nuevo partido',
      onNuevo: () => showDialog<void>(
        context: context,
        builder: (_) => _DialogoPartido(idTemporada: idTemporada),
      ),
      mensajeVacio: 'Esta temporada no tiene partidos programados.',
      iconoVacio: Icons.sports_baseball_outlined,
      fila: (p) {
        final jugado = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.finalizado;
        return FilaAdmin(
          distintivo: PlacaAdmin(texto: '${p.fechaHora.day}'),
          titulo: jugado
              ? '${p.equipoLocal.abreviatura} ${p.marcador.local} – ${p.marcador.visita} ${p.equipoVisita.abreviatura}'
              : '${p.equipoLocal.nombre} vs ${p.equipoVisita.nombre}',
          detalle: [
            formato.format(p.fechaHora),
            ?p.estadio?.nombre,
            etiquetaEstadoPartido(p.estado),
          ].join(' · '),
          onEditar: () async {
            // Las entradas programadas solo vienen en el detalle del partido.
            int? entradas;
            try {
              entradas = (await ref.read(partidoDetalleLigaProvider(p.id).future)).entradasProgramadas;
            } catch (_) {}
            if (!context.mounted) return;
            await showDialog<void>(
              context: context,
              builder: (_) => _DialogoPartido(idTemporada: idTemporada, partido: p, entradas: entradas),
            );
          },
          // La API solo permite borrar partidos programados.
          onEliminar: p.estado != EstadoPartidoLiga.programado
              ? null
              : () => borrarConConfirmacion(
                    context,
                    ref,
                    titulo: 'Eliminar partido',
                    mensaje: 'Se eliminará ${p.equipoLocal.nombre} vs ${p.equipoVisita.nombre} '
                        '(${formato.format(p.fechaHora)}).',
                    borrar: () => repo.eliminarPartido(p.id),
                    exito: 'Partido eliminado',
                  ),
        );
      },
    );
  }
}

/// Crea un partido o, si [partido] no es nulo, cambia su fecha, estadio o entradas.
class _DialogoPartido extends ConsumerStatefulWidget {
  const _DialogoPartido({required this.idTemporada, this.partido, this.entradas});

  final int idTemporada;
  final PartidoResumen? partido;
  final int? entradas;

  @override
  ConsumerState<_DialogoPartido> createState() => _DialogoPartidoState();
}

class _DialogoPartidoState extends ConsumerState<_DialogoPartido> {
  late final _entradas = TextEditingController(text: '${widget.entradas ?? 9}');
  late int? _local = widget.partido?.equipoLocal.id;
  late int? _visita = widget.partido?.equipoVisita.id;
  late DateTime? _fechaHora = widget.partido?.fechaHora;
  late int? _estadio = widget.partido?.estadio?.id;

  @override
  void dispose() {
    _entradas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.partido;
    final repo = ref.read(ligaRepositorioProvider);
    final equipos = ref.watch(equiposLigaProvider).value ?? const <EquipoLiga>[];
    final estadios = ref.watch(estadiosLigaProvider).value ?? const <EstadioLiga>[];

    DropdownButtonFormField<int> selectorEquipo(String etiqueta, int? valor, ValueChanged<int?> alCambiar) =>
        DropdownButtonFormField<int>(
          initialValue: valor,
          isExpanded: true,
          decoration: InputDecoration(labelText: etiqueta),
          items: [for (final e in equipos) DropdownMenuItem(value: e.id, child: Text(e.nombre))],
          validator: (v) {
            if (v == null) return 'Elige un equipo';
            if (_local != null && _local == _visita) return 'Los equipos deben ser distintos';
            return null;
          },
          onChanged: alCambiar,
        );

    return DialogoFormulario(
      titulo: p == null ? 'Nuevo partido' : 'Editar partido',
      exito: p == null ? 'Partido programado' : 'Partido actualizado',
      guardar: () => p == null
          ? repo.crearPartido(
              widget.idTemporada,
              equipoLocalId: _local!,
              equipoVisitaId: _visita!,
              fechaHora: _fechaHora!,
              estadioId: _estadio,
              entradasProgramadas: enteroOpcional(_entradas),
            )
          : repo.actualizarPartido(
              p.id,
              fechaHora: _fechaHora!,
              estadioId: _estadio,
              entradasProgramadas: enteroOpcional(_entradas),
            ),
      campos: [
        // Los equipos de un partido no cambian una vez creado.
        if (p == null) ...[
          selectorEquipo('Local', _local, (v) => setState(() => _local = v)),
          selectorEquipo('Visitante', _visita, (v) => setState(() => _visita = v)),
        ] else
          Text(
            '${p.equipoLocal.nombre} vs ${p.equipoVisita.nombre}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
        CampoFecha(
          etiqueta: 'Fecha y hora',
          inicial: _fechaHora,
          conHora: true,
          obligatorio: true,
          alCambiar: (v) => _fechaHora = v,
        ),
        DropdownButtonFormField<int?>(
          initialValue: estadios.any((s) => s.id == _estadio) ? _estadio : null,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Estadio (opcional)'),
          items: [
            const DropdownMenuItem(value: null, child: Text('Sin estadio')),
            for (final s in estadios) DropdownMenuItem(value: s.id, child: Text(s.nombre)),
          ],
          onChanged: (v) => setState(() => _estadio = v),
        ),
        CampoNumero(controller: _entradas, etiqueta: 'Entradas programadas', minimo: 1, maximo: 15),
      ],
    );
  }
}
