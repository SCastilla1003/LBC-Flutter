import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'widgets_liga.dart';

/// Alineación de los dos equipos: orden de bateo, lanzador inicial y banca.
class AlineacionLigaPantalla extends ConsumerWidget {
  const AlineacionLigaPantalla({super.key, required this.idTemporada, required this.idPartido});

  final int idTemporada;
  final int idPartido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valor = ref.watch(alineacionLigaProvider(idPartido));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alineación'),
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/temporadas/$idTemporada/partidos/$idPartido/pitcheo'),
            icon: const Icon(Icons.sports_baseball),
            label: const Text('Pitcheo'),
          ),
        ],
      ),
      body: RecargableSimple(
        onRefresh: () => ref.refresh(alineacionLigaProvider(idPartido).future).then((_) {}, onError: (_) {}),
        child: VistaAsync<Alineacion>(
          valor: valor,
          onReintentar: () => ref.invalidate(alineacionLigaProvider(idPartido)),
          esVacio: (a) => !a.publicada,
          mensajeVacio: 'La alineación se publicará antes del partido.',
          iconoVacio: Icons.format_list_numbered,
          datos: (a) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              children: [
                if (a.visita != null) _SeccionAlineacion(equipo: a.visita!),
                if (a.local != null) _SeccionAlineacion(equipo: a.local!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SeccionAlineacion extends StatelessWidget {
  const _SeccionAlineacion({required this.equipo});

  final EquipoAlineacion equipo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final e = equipo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          EscudoLiga(equipo: e.equipo, tamano: 40),
          const SizedBox(width: 10),
          Expanded(child: Text(e.equipo.nombre, style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
        ]),
        const EncabezadoSeccion('Orden de bateo'),
        TarjetaLiga(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Column(
            children: [
              if (e.bateo.isEmpty)
                const Padding(padding: EdgeInsets.all(12), child: Text('Sin orden de bateo todavía.')),
              for (final b in e.bateo)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ColoresMarca.rojo,
                    foregroundColor: ColoresMarca.blanco,
                    radius: 14,
                    child: Text('${b.orden}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
                  ),
                  title: Text(nombreJugador(b.jugador), style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text('${b.posicion} · batea ${_lado(b.jugador.batea)}'),
                ),
            ],
          ),
        ),
        const EncabezadoSeccion('Lanzador inicial'),
        TarjetaLiga(
          child: Text(
            e.lanzadorInicial == null ? 'Por definir' : nombreJugador(e.lanzadorInicial!),
            style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const EncabezadoSeccion('Banca'),
        TarjetaLiga(
          child: e.banca.isEmpty
              ? const Text('Sin jugadores en banca.')
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final j in e.banca) Chip(label: Text(nombreJugador(j)))],
                ),
        ),
      ],
    );
  }

  static String _lado(LadoBateo? lado) => switch (lado) {
        LadoBateo.derecho => 'derecho',
        LadoBateo.zurdo => 'zurdo',
        LadoBateo.ambidiestro => 'ambidiestro',
        null => '—',
      };
}

/// Pitcheo: lanzador inicial y relevistas de cada equipo.
class PitcheoLigaPantalla extends ConsumerWidget {
  const PitcheoLigaPantalla({super.key, required this.idTemporada, required this.idPartido});

  final int idTemporada;
  final int idPartido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valor = ref.watch(pitcheoLigaProvider(idPartido));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pitcheo'),
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/temporadas/$idTemporada/partidos/$idPartido/alineacion'),
            icon: const Icon(Icons.format_list_numbered),
            label: const Text('Alineación'),
          ),
        ],
      ),
      body: RecargableSimple(
        onRefresh: () => ref.refresh(pitcheoLigaProvider(idPartido).future).then((_) {}, onError: (_) {}),
        child: VistaAsync<Pitcheo>(
          valor: valor,
          onReintentar: () => ref.invalidate(pitcheoLigaProvider(idPartido)),
          esVacio: (p) => !p.publicada,
          mensajeVacio: 'El pitcheo se publicará con la alineación.',
          iconoVacio: Icons.sports_baseball_outlined,
          datos: (p) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              children: [
                if (p.visita != null) _SeccionPitcheo(equipo: p.visita!),
                if (p.local != null) _SeccionPitcheo(equipo: p.local!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SeccionPitcheo extends StatelessWidget {
  const _SeccionPitcheo({required this.equipo});

  final EquipoPitcheo equipo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final e = equipo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          EscudoLiga(equipo: e.equipo, tamano: 40),
          const SizedBox(width: 10),
          Expanded(child: Text(e.equipo.nombre, style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
        ]),
        const EncabezadoSeccion('Lanzador inicial'),
        TarjetaLiga(
          child: Row(children: [
            const Icon(Icons.sports_baseball, color: ColoresMarca.rojo),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                e.lanzadorInicial == null ? 'Por definir' : nombreJugador(e.lanzadorInicial!),
                style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ]),
        ),
        const EncabezadoSeccion('Relevistas'),
        if (e.relevistas.isEmpty)
          const TarjetaLiga(child: Text('Sin relevistas en la banca.'))
        else
          TarjetaLiga(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                for (final r in e.relevistas)
                  ListTile(
                    leading: const Icon(Icons.sports_baseball_outlined, color: ColoresMarca.verde),
                    title: Text(nombreJugador(r), style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('lanza ${r.lanza == LadoLanzamiento.zurdo ? 'zurdo' : 'derecho'}'),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
