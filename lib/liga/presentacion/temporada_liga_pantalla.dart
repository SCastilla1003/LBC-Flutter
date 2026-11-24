import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'widgets_liga.dart';

/// Una temporada: pestañas de partidos, posiciones y equipos.
/// Los equipos llevan a sus estadísticas (pantallas que se conservan).
class TemporadaLigaPantalla extends ConsumerWidget {
  const TemporadaLigaPantalla({super.key, required this.idTemporada});

  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporada = ref.watch(temporadaLigaProvider(idTemporada));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(temporada.maybeWhen(data: (t) => t.nombre, orElse: () => 'Temporada')),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Partidos'),
              Tab(text: 'Posiciones'),
              Tab(text: 'Equipos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PestanaPartidos(idTemporada: idTemporada),
            _PestanaPosiciones(idTemporada: idTemporada),
            _PestanaEquipos(idTemporada: idTemporada),
          ],
        ),
      ),
    );
  }
}

enum _Filtro { todos, enVivo, finalizados, programados }

class _PestanaPartidos extends ConsumerStatefulWidget {
  const _PestanaPartidos({required this.idTemporada});

  final int idTemporada;

  @override
  ConsumerState<_PestanaPartidos> createState() => _PestanaPartidosState();
}

class _PestanaPartidosState extends ConsumerState<_PestanaPartidos> {
  _Filtro _filtro = _Filtro.todos;

  bool _coincide(PartidoResumen p) => switch (_filtro) {
        _Filtro.todos => true,
        _Filtro.enVivo => p.estado == EstadoPartidoLiga.enJuego,
        _Filtro.finalizados => p.estado == EstadoPartidoLiga.finalizado,
        _Filtro.programados => p.estado == EstadoPartidoLiga.programado ||
            p.estado == EstadoPartidoLiga.alineacionPublicada,
      };

  @override
  Widget build(BuildContext context) {
    final valor = ref.watch(partidosLigaProvider(widget.idTemporada));
    return RecargableSimple(
      onRefresh: () => ref.refresh(partidosLigaProvider(widget.idTemporada).future).then((_) {}, onError: (_) {}),
      child: VistaAsync<List<PartidoResumen>>(
        valor: valor,
        onReintentar: () => ref.invalidate(partidosLigaProvider(widget.idTemporada)),
        esVacio: (lista) => lista.isEmpty,
        mensajeVacio: 'No hay partidos en esta temporada todavía.',
        iconoVacio: Icons.sports_baseball_outlined,
        datos: (lista) {
          final visibles = lista.where(_coincide).toList();
          final grupos = <String, List<PartidoResumen>>{};
          for (final p in visibles) {
            grupos.putIfAbsent(_tituloFecha(p.fechaHora), () => []).add(p);
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final f in _Filtro.values)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(_etiqueta(f)),
                            selected: _filtro == f,
                            onSelected: (_) => setState(() => _filtro = f),
                          ),
                        ),
                    ],
                  ),
                ),
                if (visibles.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: Text('No hay partidos con este filtro.')),
                  ),
                for (final g in grupos.entries) ...[
                  EncabezadoSeccion(g.key),
                  for (final p in g.value) _TarjetaPartido(partido: p, idTemporada: widget.idTemporada),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  static String _etiqueta(_Filtro f) => switch (f) {
        _Filtro.todos => 'Todos',
        _Filtro.enVivo => 'En vivo',
        _Filtro.finalizados => 'Finalizados',
        _Filtro.programados => 'Por jugar',
      };

  static String _tituloFecha(DateTime f) {
    final texto = DateFormat('EEEE d MMMM', 'es').format(f);
    return texto[0].toUpperCase() + texto.substring(1);
  }
}

class _TarjetaPartido extends StatelessWidget {
  const _TarjetaPartido({required this.partido, required this.idTemporada});

  final PartidoResumen partido;
  final int idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final p = partido;
    final marcado = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.finalizado;
    return TarjetaLiga(
      onTap: () => context.go('/temporadas/$idTemporada/partidos/${p.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ChipEstadoPartido(estado: p.estado),
              const Spacer(),
              Text(
                DateFormat('h:mm a', 'es').format(p.fechaHora),
                style: tema.textTheme.labelMedium?.copyWith(color: tema.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _Equipo(equipo: p.equipoLocal, ganador: p.ganadorId == p.equipoLocal.id)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  marcado ? '${p.marcador.local} – ${p.marcador.visita}' : 'vs',
                  style: tema.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              Expanded(
                child: _Equipo(
                  equipo: p.equipoVisita,
                  ganador: p.ganadorId == p.equipoVisita.id,
                  alineadoDerecha: true,
                ),
              ),
            ],
          ),
          if (p.estadio != null) ...[
            const SizedBox(height: 10),
            Text(
              p.estadio!.nombre,
              textAlign: TextAlign.center,
              style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class _Equipo extends StatelessWidget {
  const _Equipo({required this.equipo, required this.ganador, this.alineadoDerecha = false});

  final EquipoRefLiga equipo;
  final bool ganador;
  final bool alineadoDerecha;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final nombre = Text(
      equipo.nombre,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: alineadoDerecha ? TextAlign.right : TextAlign.left,
      style: tema.textTheme.labelLarge?.copyWith(
        fontWeight: ganador ? FontWeight.w900 : FontWeight.w600,
        color: ganador ? ColoresMarca.verdeTexto : tema.colorScheme.onSurface,
      ),
    );
    final escudo = EscudoLiga(equipo: equipo, tamano: 40);
    final hijos = alineadoDerecha ? [Expanded(child: nombre), const SizedBox(width: 8), escudo] : [escudo, const SizedBox(width: 8), Expanded(child: nombre)];
    return Row(mainAxisAlignment: alineadoDerecha ? MainAxisAlignment.end : MainAxisAlignment.start, children: hijos);
  }
}

class _PestanaPosiciones extends ConsumerWidget {
  const _PestanaPosiciones({required this.idTemporada});

  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valor = ref.watch(posicionesLigaProvider(idTemporada));
    final tema = Theme.of(context);
    return RecargableSimple(
      onRefresh: () => ref.refresh(posicionesLigaProvider(idTemporada).future).then((_) {}, onError: (_) {}),
      child: VistaAsync<List<PosicionLiga>>(
        valor: valor,
        onReintentar: () => ref.invalidate(posicionesLigaProvider(idTemporada)),
        esVacio: (lista) => lista.isEmpty,
        mensajeVacio: 'Las posiciones aparecen cuando terminen los primeros partidos.',
        iconoVacio: Icons.leaderboard_outlined,
        datos: (lista) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  Row(children: [
                    const SizedBox(width: 26),
                    const Expanded(child: SizedBox()),
                    for (final t in ['G', 'P', 'PCT', 'CF', 'CC']) SizedBox(width: 40, child: Text(t, textAlign: TextAlign.center, style: tema.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800))),
                  ]),
                  const Divider(),
                  for (var i = 0; i < lista.length; i++)
                    InkWell(
                      onTap: () => context.go('/temporadas/$idTemporada/equipos/${lista[i].equipo.id}'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(children: [
                          SizedBox(width: 26, child: Text('${i + 1}', style: tema.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800))),
                          EscudoLiga(equipo: lista[i].equipo, tamano: 28),
                          const SizedBox(width: 8),
                          Expanded(child: Text(lista[i].equipo.nombre, maxLines: 1, overflow: TextOverflow.ellipsis, style: tema.textTheme.labelLarge)),
                          SizedBox(width: 40, child: Text('${lista[i].ganados}', textAlign: TextAlign.center)),
                          SizedBox(width: 40, child: Text('${lista[i].perdidos}', textAlign: TextAlign.center)),
                          SizedBox(width: 40, child: Text(lista[i].pct.toStringAsFixed(3), textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700))),
                          SizedBox(width: 40, child: Text('${lista[i].carrerasFavor}', textAlign: TextAlign.center)),
                          SizedBox(width: 40, child: Text('${lista[i].carrerasContra}', textAlign: TextAlign.center)),
                        ]),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PestanaEquipos extends ConsumerWidget {
  const _PestanaEquipos({required this.idTemporada});

  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valor = ref.watch(equiposTemporadaLigaProvider(idTemporada));
    return RecargableSimple(
      onRefresh: () => ref.refresh(equiposTemporadaLigaProvider(idTemporada).future).then((_) {}, onError: (_) {}),
      child: VistaAsync<List<EquipoRefLiga>>(
        valor: valor,
        onReintentar: () => ref.invalidate(equiposTemporadaLigaProvider(idTemporada)),
        esVacio: (lista) => lista.isEmpty,
        mensajeVacio: 'Esta temporada todavía no tiene equipos inscritos.',
        iconoVacio: Icons.groups_outlined,
        datos: (lista) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final e in lista)
                SizedBox(
                  width: 160,
                  child: TarjetaLiga(
                    onTap: () => context.go('/temporadas/$idTemporada/equipos/${e.id}'),
                    child: Column(children: [
                      EscudoLiga(equipo: e, tamano: 56),
                      const SizedBox(height: 10),
                      Text(e.nombre, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                    ]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
