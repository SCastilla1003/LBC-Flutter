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
    final esquema = tema.colorScheme;
    final p = partido;
    final marcado = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.finalizado;
    final cifra = estiloMarcador(tema.textTheme.headlineMedium)?.copyWith(fontSize: 34);
    Widget carreras(int v, bool gana) => Text(
          '$v',
          style: cifra?.copyWith(
            color: p.ganadorId == null || gana ? esquema.onSurface : esquema.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        );
    return TarjetaLiga(
      onTap: () => context.go('/temporadas/$idTemporada/partidos/${p.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ChipEstadoPartido(estado: p.estado),
              const Spacer(),
              Icon(Icons.schedule_rounded, size: 14, color: esquema.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                DateFormat('h:mm a', 'es').format(p.fechaHora),
                style: tema.textTheme.labelMedium?.copyWith(color: esquema.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _Equipo(equipo: p.equipoLocal, ganador: p.ganadorId == p.equipoLocal.id)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: marcado
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          carreras(p.marcador.local, p.ganadorId == p.equipoLocal.id),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text('–', style: cifra?.copyWith(fontSize: 24, color: esquema.outline)),
                          ),
                          carreras(p.marcador.visita, p.ganadorId == p.equipoVisita.id),
                        ],
                      )
                    : Text('VS', style: cifra?.copyWith(fontSize: 22, color: esquema.primary, letterSpacing: 1)),
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
            const SizedBox(height: 12),
            Container(height: 1, color: esquema.outlineVariant),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stadium_outlined, size: 14, color: esquema.onSurfaceVariant),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    p.estadio!.nombre,
                    overflow: TextOverflow.ellipsis,
                    style: tema.textTheme.bodySmall?.copyWith(color: esquema.onSurfaceVariant),
                  ),
                ),
              ],
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
      style: tema.textTheme.titleMedium?.copyWith(
        fontFamily: FuentesLbc.titular,
        fontSize: 17,
        height: 1.05,
        fontWeight: ganador ? FontWeight.w800 : FontWeight.w700,
        color: ganador ? tema.colorScheme.primary : tema.colorScheme.onSurface,
      ),
    );
    final escudo = EscudoLiga(equipo: equipo, tamano: 40);
    final hijos = alineadoDerecha
        ? [Expanded(child: nombre), const SizedBox(width: 8), escudo]
        : [escudo, const SizedBox(width: 8), Expanded(child: nombre)];
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
    final esquema = tema.colorScheme;
    final cabecera = estiloMarcador(tema.textTheme.labelLarge)?.copyWith(fontSize: 14, color: ColoresMarca.tintaBarra);
    final cifra = estiloCifra(tema.textTheme.bodyMedium)?.copyWith(fontWeight: FontWeight.w600);
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
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // Cabecera de tabla tipo tablero.
                Container(
                  color: ColoresMarca.verdeNoche,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  child: Row(children: [
                    SizedBox(width: 30, child: Text('#', style: cabecera)),
                    Expanded(child: Text('Equipo', style: cabecera)),
                    for (final t in ['G', 'P', 'PCT', 'CF', 'CC'])
                      SizedBox(
                        width: 40,
                        child: Text(
                          t,
                          textAlign: TextAlign.center,
                          style: t == 'PCT' ? cabecera?.copyWith(color: ColoresMarca.amarillo) : cabecera,
                        ),
                      ),
                  ]),
                ),
                for (var i = 0; i < lista.length; i++)
                  Material(
                    color: i == 0
                        ? esquema.secondaryContainer
                        : (i.isOdd ? esquema.surfaceContainerLow : esquema.surfaceContainerLowest),
                    child: InkWell(
                      onTap: () => context.go('/temporadas/$idTemporada/equipos/${lista[i].equipo.id}'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              '${i + 1}',
                              style: estiloMarcador(tema.textTheme.titleLarge)?.copyWith(
                                fontSize: 22,
                                color: i == 0 ? esquema.onSecondaryContainer : esquema.onSurfaceVariant,
                              ),
                            ),
                          ),
                          EscudoLiga(equipo: lista[i].equipo, tamano: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(children: [
                              Flexible(
                                child: Text(
                                  lista[i].equipo.nombre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: tema.textTheme.labelLarge,
                                ),
                              ),
                              if (i == 0) ...[
                                const SizedBox(width: 4),
                                Icon(Icons.emoji_events_rounded, size: 15, color: esquema.onSecondaryContainer),
                              ],
                            ]),
                          ),
                          SizedBox(width: 40, child: Text('${lista[i].ganados}', textAlign: TextAlign.center, style: cifra)),
                          SizedBox(width: 40, child: Text('${lista[i].perdidos}', textAlign: TextAlign.center, style: cifra)),
                          SizedBox(
                            width: 40,
                            child: Text(
                              lista[i].pct.toStringAsFixed(3),
                              textAlign: TextAlign.center,
                              style: cifra?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                              width: 40, child: Text('${lista[i].carrerasFavor}', textAlign: TextAlign.center, style: cifra)),
                          SizedBox(
                              width: 40, child: Text('${lista[i].carrerasContra}', textAlign: TextAlign.center, style: cifra)),
                        ]),
                      ),
                    ),
                  ),
              ],
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
                      Text(e.nombre,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontFamily: FuentesLbc.titular, fontSize: 17, fontWeight: FontWeight.w700, height: 1.1)),
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
