import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/red/fallo_api.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/juego_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';
import '../../admin/presentacion/admin_comun.dart';
import 'anotador_pantalla.dart';

/// Ficha de un partido para admin y anotador. El partido ya se ve en la app como
/// "Programado" desde que se crea: las alineaciones se cargan cuando se tengan y
/// solo se exigen completas para iniciar el juego.
class PartidoControlPantalla extends ConsumerWidget {
  const PartidoControlPantalla({super.key, required this.idTemporada, required this.idPartido});

  final int idTemporada;
  final int idPartido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partido')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(estadoJuegoProvider(idPartido).future),
        child: VistaAsync<EstadoJuego>(
          valor: ref.watch(estadoJuegoProvider(idPartido)),
          cargando: const EsqueletoDetalle(),
          onReintentar: () => ref.invalidate(estadoJuegoProvider(idPartido)),
          datos: (e) => _Contenido(idTemporada: idTemporada, estado: e),
        ),
      ),
    );
  }
}

class _Contenido extends ConsumerStatefulWidget {
  const _Contenido({required this.idTemporada, required this.estado});

  final int idTemporada;
  final EstadoJuego estado;

  @override
  ConsumerState<_Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends ConsumerState<_Contenido> {
  bool _iniciando = false;

  PartidoDetalle get _p => widget.estado.partido;
  String get _base => '/anotador/t/${widget.idTemporada}/p/${_p.id}';

  /// Abre otra pantalla y, al volver, recarga la ficha (pudo cambiar el juego o la alineación).
  Future<void> _abrir(String ruta) async {
    await context.push(ruta);
    ref.invalidate(estadoJuegoProvider(_p.id));
  }

  Future<void> _iniciar() async {
    final ok = await confirmar(
      context,
      titulo: 'Iniciar partido',
      mensaje: '${_p.equipoVisita.nombre} batea primero. Desde ahora el partido sale "En vivo" en la app '
          'y ya no se pueden editar las alineaciones (los cambios se hacen desde el anotador).',
      accion: 'Iniciar',
    );
    if (!ok || !mounted) return;
    setState(() => _iniciando = true);
    final mensajero = ScaffoldMessenger.of(context);
    try {
      await ref.read(juegoRepositorioProvider).iniciar(_p.id);
      refrescarLiga(ref);
      if (mounted) await _abrir('$_base/juego');
    } catch (e) {
      mensajero.showSnackBar(SnackBar(
        content: Text(FalloApi.desde(e).mensaje),
        backgroundColor: ColoresMarca.rojo,
      ));
    } finally {
      if (mounted) setState(() => _iniciando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final e = widget.estado;
    final p = _p;
    final antes = p.estado == EstadoPartidoLiga.programado || p.estado == EstadoPartidoLiga.alineacionPublicada;
    final enJuego = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.suspendido;
    final fecha = DateFormat("EEEE d 'de' MMMM · h:mm a", 'es').format(p.fechaHora);

    Widget equipo(EquipoRefLiga eq, int carreras, String lado) => Expanded(
          child: Column(children: [
            EscudoLiga(equipo: eq, tamano: 56),
            const SizedBox(height: 8),
            Text(eq.nombre,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            Text(lado, style: tema.textTheme.bodySmall),
            if (!antes) ...[
              const SizedBox(height: 6),
              Text('$carreras', style: estiloMarcador(tema.textTheme.displaySmall)),
            ],
          ]),
        );

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        AnchoMaximo(
          ancho: 760,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TarjetaLiga(
              child: Column(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  equipo(p.equipoVisita, p.marcador.visita, 'Visitante'),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Text('vs', style: tema.textTheme.titleLarge),
                  ),
                  equipo(p.equipoLocal, p.marcador.local, 'Local'),
                ]),
                const SizedBox(height: 12),
                ChipEstadoPartido(estado: p.estado),
                const SizedBox(height: 8),
                Text(
                  [fecha, ?p.estadio?.nombre].join(' · '),
                  textAlign: TextAlign.center,
                  style: tema.textTheme.bodySmall,
                ),
              ]),
            ),
            if (antes)
              _Aviso(
                icono: Icons.visibility_rounded,
                texto: 'El partido ya se ve en la app como "Programado". No hace falta tener las '
                    'alineaciones para eso: cárgalas cuando las tengas, antes de iniciar el juego.',
              ),
            const EncabezadoSeccion('Alineaciones'),
            TarjetaLiga(
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Row(children: [
                  Icon(
                    e.alineacionCompleta ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
                    color: e.alineacionCompleta ? ColoresMarca.verdeVivo : ColoresMarca.amarillo,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.alineacionCompleta
                          ? 'Completas: 9 bateadores y lanzador por equipo'
                          : 'Todavía incompletas',
                      style: tema.textTheme.titleSmall,
                    ),
                  ),
                ]),
                if (!e.alineacionCompleta && e.faltantes.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  for (final f in e.faltantes) Text('• $f', style: tema.textTheme.bodySmall),
                ],
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _abrir('$_base/alineacion'),
                  icon: Icon(antes ? Icons.edit_note_rounded : Icons.list_alt_rounded),
                  label: Text(antes ? 'Editar alineaciones' : 'Ver alineaciones'),
                ),
              ]),
            ),
            const EncabezadoSeccion('Juego'),
            if (antes) ...[
              FilledButton.icon(
                onPressed: !e.alineacionCompleta || _iniciando ? null : _iniciar,
                icon: _iniciando
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.play_arrow_rounded),
                label: const Text('Iniciar partido'),
              ),
              if (!e.alineacionCompleta)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Para iniciar, completa las alineaciones de los dos equipos.',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.bodySmall,
                  ),
                ),
            ] else
              FilledButton.icon(
                onPressed: () => _abrir('$_base/juego'),
                icon: Icon(enJuego ? Icons.sports_baseball_rounded : Icons.fact_check_outlined),
                label: Text(enJuego ? 'Abrir anotador' : 'Revisar anotación'),
              ),
            if (e.jugadas.isNotEmpty) ...[
              const EncabezadoSeccion('Últimas jugadas'),
              for (final a in e.jugadas.take(5))
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      width: 40,
                      child: IndicadorMitad(mitad: a.mitad, texto: '${a.entrada}', color: tema.colorScheme.primary),
                    ),
                    Expanded(child: Text(a.descripcion)),
                  ]),
                ),
            ],
          ]),
        ),
      ],
    );
  }
}

class _Aviso extends StatelessWidget {
  const _Aviso({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: esquema.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icono, color: esquema.onPrimaryContainer),
        const SizedBox(width: 10),
        Expanded(child: Text(texto, style: TextStyle(color: esquema.onPrimaryContainer))),
      ]),
    );
  }
}
