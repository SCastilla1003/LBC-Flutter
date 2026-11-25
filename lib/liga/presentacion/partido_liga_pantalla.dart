import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/estadisticas_repositorio.dart';
import '../datos/juego_repositorio.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'campo_en_vivo.dart';
import 'widgets_juego.dart';
import 'widgets_liga.dart';

/// Partido: marcador, marcador por entrada (estilo MLB) y accesos a alineación y
/// pitcheo. En vivo muestra además la entrada, las bases, el conteo, el duelo
/// bateador–lanzador con sus fotos y el jugada a jugada, y se refresca cada 6 segundos.
class PartidoLigaPantalla extends ConsumerStatefulWidget {
  const PartidoLigaPantalla({super.key, required this.idTemporada, required this.idPartido});

  final int idTemporada;
  final int idPartido;

  @override
  ConsumerState<PartidoLigaPantalla> createState() => _PartidoLigaPantallaState();
}

class _PartidoLigaPantallaState extends ConsumerState<PartidoLigaPantalla> {
  Timer? _sondeo;

  void _vigilar(EstadoPartidoLiga estado) {
    final enVivo = estado == EstadoPartidoLiga.enJuego;
    if (enVivo && _sondeo == null) {
      _sondeo = Timer.periodic(const Duration(seconds: 6), (_) {
        ref.invalidate(estadoJuegoProvider(widget.idPartido));
        ref.invalidate(partidoDetalleLigaProvider(widget.idPartido));
      });
    } else if (!enVivo) {
      _sondeo?.cancel();
      _sondeo = null;
    }
  }

  @override
  void dispose() {
    _sondeo?.cancel();
    super.dispose();
  }

  Future<void> _recargar() async {
    ref.invalidate(estadoJuegoProvider(widget.idPartido));
    await ref.refresh(partidoDetalleLigaProvider(widget.idPartido).future).then((_) {}, onError: (_) {});
  }

  @override
  Widget build(BuildContext context) {
    final detalle = ref.watch(partidoDetalleLigaProvider(widget.idPartido));
    final estado = detalle.value?.estado;
    // Ya empezó: el estado del juego trae además bateador, lanzador (con fotos) y jugadas.
    final empezado = estado != null &&
        estado != EstadoPartidoLiga.programado &&
        estado != EstadoPartidoLiga.alineacionPublicada;
    final juego = empezado ? ref.watch(estadoJuegoProvider(widget.idPartido)).value : null;
    // El del juego llega junto con el duelo y las jugadas: así todo muestra el mismo momento.
    final valor = juego != null ? AsyncValue.data(juego.partido) : detalle;
    valor.whenData((p) => _vigilar(p.estado));
    return Scaffold(
      appBar: AppBar(title: const Text('Partido')),
      body: RecargableSimple(
        onRefresh: _recargar,
        child: VistaAsync<PartidoDetalle>(
          valor: valor,
          onReintentar: () => ref.invalidate(partidoDetalleLigaProvider(widget.idPartido)),
          datos: (p) {
            final enCurso = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.suspendido;
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Marcador(partido: p, idTemporada: widget.idTemporada),
                  if (enCurso && juego != null)
                    _Duelo(juego: juego, idTemporada: widget.idTemporada),
                  _TablaEntradas(partido: p),
                  if (juego != null && juego.jugadas.isNotEmpty) _JugadaAJugada(jugadas: juego.jugadas),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.go(
                              '/temporadas/${widget.idTemporada}/partidos/${widget.idPartido}/alineacion'),
                          icon: const Icon(Icons.format_list_numbered),
                          label: const Text('Alineación'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => context.go(
                              '/temporadas/${widget.idTemporada}/partidos/${widget.idPartido}/pitcheo'),
                          icon: const Icon(Icons.sports_baseball),
                          label: const Text('Pitcheo'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Tablero del partido: equipos (visitante a la izquierda, como "VIS @ LOC"), carreras y,
/// en vivo, entrada, bases ocupadas y conteo.
class _Marcador extends StatelessWidget {
  const _Marcador({required this.partido, required this.idTemporada});

  final PartidoDetalle partido;
  final int idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final p = partido;
    final enCurso = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.suspendido;
    final marcado = enCurso || p.estado == EstadoPartidoLiga.finalizado;
    const tinta = ColoresMarca.tintaBarra;
    final ganaLocal = p.ganadorId == p.equipoLocal.id;
    final ganaVisita = p.ganadorId == p.equipoVisita.id;
    final estiloCarreras = estiloMarcador(tema.textTheme.displayMedium)?.copyWith(fontSize: 64);
    Widget carreras(int v, bool gana) => Text(
          '$v',
          style: estiloCarreras?.copyWith(
            color: gana ? ColoresMarca.amarillo : tinta.withValues(alpha: p.ganadorId == null ? 1 : 0.7),
          ),
        );
    final s = p.situacion;
    final c = s?.corredores;
    // Tablero de estadio: verde noche, cifras grandes y canto amarillo.
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: ColoresMarca.tablero,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColoresMarca.verdeNoche.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChipEstadoPartido(estado: p.estado, motivo: p.motivo),
                    Flexible(
                      child: Text(
                        DateFormat("EEE d MMM · h:mm a", 'es').format(p.fechaHora),
                        overflow: TextOverflow.ellipsis,
                        style: tema.textTheme.labelMedium?.copyWith(color: tinta.withValues(alpha: 0.75)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: _Lado(equipo: p.equipoVisita, ganador: ganaVisita, lado: 'Visitante', idTemporada: idTemporada)),
                    if (marcado)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          carreras(p.marcador.visita, ganaVisita),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '–',
                              style: estiloCarreras?.copyWith(fontSize: 40, color: tinta.withValues(alpha: 0.5)),
                            ),
                          ),
                          carreras(p.marcador.local, ganaLocal),
                        ],
                      )
                    else
                      Text('VS', style: estiloCarreras?.copyWith(fontSize: 40, color: ColoresMarca.amarillo)),
                    Expanded(
                      child: _Lado(
                        equipo: p.equipoLocal,
                        ganador: ganaLocal,
                        lado: 'Local',
                        derecha: true,
                        idTemporada: idTemporada,
                      ),
                    ),
                  ],
                ),
                if (enCurso) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          IndicadorMitad(
                            mitad: p.mitad,
                            texto: '${p.mitad == MitadEntrada.alta ? 'Alta' : 'Baja'} del ${p.entradaActual}',
                            color: ColoresMarca.amarillo,
                            estilo: estiloMarcador(tema.textTheme.titleLarge)?.copyWith(fontSize: 20),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            p.estado == EstadoPartidoLiga.suspendido
                                ? 'Partido ${p.motivo?.etiqueta.toLowerCase() ?? 'suspendido'}'
                                : '${s?.outs ?? 0} ${(s?.outs ?? 0) == 1 ? 'out' : 'outs'}',
                            style: tema.textTheme.labelMedium?.copyWith(color: tinta.withValues(alpha: 0.75)),
                          ),
                        ]),
                      ),
                      DiamanteBases(bases: [null, c?.primera, c?.segunda, c?.tercera], tamano: 18),
                      const SizedBox(width: 12),
                      ConteoJuego(bolas: s?.bolas ?? 0, strikes: s?.strikes ?? 0, outs: s?.outs ?? 0),
                    ]),
                  ),
                ],
                if (p.finalEspecial != null) ...[
                  const SizedBox(height: 16),
                  LetreroWalkOff(finalEspecial: p.finalEspecial!, equipo: p.equipoLocal.nombre),
                ],
                if (p.estado == EstadoPartidoLiga.suspendido && p.motivo != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    'El administrador decidirá si el partido continúa o se deja así.',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.bodySmall?.copyWith(color: tinta.withValues(alpha: 0.8)),
                  ),
                ],
                if (p.estadio != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stadium_outlined, size: 15, color: tinta.withValues(alpha: 0.7)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          p.estadio!.nombre,
                          overflow: TextOverflow.ellipsis,
                          style: tema.textTheme.bodySmall?.copyWith(color: tinta.withValues(alpha: 0.75)),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(height: 5, color: ColoresMarca.amarillo),
        ],
      ),
    );
  }
}

class _Lado extends StatelessWidget {
  const _Lado({
    required this.equipo,
    required this.ganador,
    required this.lado,
    required this.idTemporada,
    this.derecha = false,
  });

  final EquipoRefLiga equipo;
  final int idTemporada;
  final bool ganador;
  final String lado;
  final bool derecha;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final nombre = Text(
      equipo.nombre,
      textAlign: derecha ? TextAlign.right : TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: tema.textTheme.titleMedium?.copyWith(
        fontFamily: FuentesLbc.titular,
        fontSize: 18,
        height: 1.05,
        fontWeight: ganador ? FontWeight.w800 : FontWeight.w700,
        color: ganador ? ColoresMarca.amarillo : ColoresMarca.tintaBarra,
      ),
    );
    final escudo = EscudoLiga(equipo: equipo, tamano: 56);
    // Escudo y nombre llevan a la página del equipo.
    void abrir() => context.push('/temporadas/$idTemporada/equipos/${equipo.id}');
    return Column(
      crossAxisAlignment: derecha ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: 'Ver ${equipo.nombre}',
          child: InkWell(
            onTap: abrir,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: derecha ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  ExcludeSemantics(child: escudo),
                  const SizedBox(height: 10),
                  ExcludeSemantics(child: nombre),
                ],
              ),
            ),
          ),
        ),
        Text(
          lado,
          style: tema.textTheme.labelSmall?.copyWith(color: ColoresMarca.tintaBarra.withValues(alpha: 0.6)),
        ),
      ],
    );
  }
}

/// Duelo del momento en el terreno: lanzador, bateador en su caja, corredores y próximo,
/// con sus caras. Debajo, el cara a cara del bateador contra el lanzador.
class _Duelo extends StatelessWidget {
  const _Duelo({required this.juego, required this.idTemporada});

  final EstadoJuego juego;
  final int idTemporada;

  @override
  Widget build(BuildContext context) {
    final s = juego.partido.situacion;
    final bateador = juego.ofensiva.orden
        .where((t) => t.jugador != null && t.jugador!.id == s?.bateador?.id)
        .firstOrNull
        ?.jugador;
    final lanzador = juego.defensa.lanzador;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
        child: Column(children: [
          CampoEnVivo(
            juego: juego,
            alTocar: (j, e) => context.push('/temporadas/$idTemporada/jugadores/${j.id}?e=${e.id}'),
          ),
          if (bateador != null && lanzador != null)
            _HistorialDuelo(bateador: bateador.id, lanzador: lanzador.id, idTemporada: idTemporada),
        ]),
      ),
    );
  }
}

/// "Historial: 1-3, 1 HR · Hit 27%" del duelo actual; abre el detalle en Predicción.
class _HistorialDuelo extends ConsumerWidget {
  const _HistorialDuelo({required this.bateador, required this.lanzador, required this.idTemporada});

  final int bateador;
  final int lanzador;
  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final e = ref.watch(enfrentamientoProvider((bateador, lanzador, idTemporada))).value;
    if (e == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        color: tema.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => context.go('/prediccion?b=$bateador&l=$lanzador'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [
              Icon(Icons.history_rounded, size: 20, color: tema.colorScheme.onSecondaryContainer),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Cara a cara: ${e.lineaHistorial} · Hit ${(e.pronostico.hit * 100).round()}%',
                  style: tema.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: tema.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: tema.colorScheme.onSecondaryContainer),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Jugada a jugada (lo más reciente arriba). Los lanzamientos van en letra pequeña.
class _JugadaAJugada extends StatefulWidget {
  const _JugadaAJugada({required this.jugadas});

  final List<AccionJuego> jugadas;

  @override
  State<_JugadaAJugada> createState() => _JugadaAJugadaState();
}

class _JugadaAJugadaState extends State<_JugadaAJugada> {
  bool _lanzamientos = false;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final lista = _lanzamientos ? widget.jugadas : widget.jugadas.where((a) => a.tipo != 'LANZAMIENTO').toList();
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(child: Text('Jugada a jugada', style: tema.textTheme.titleLarge?.copyWith(fontSize: 20))),
            FilterChip(
              label: const Text('Lanzamientos'),
              selected: _lanzamientos,
              onSelected: (v) => setState(() => _lanzamientos = v),
            ),
          ]),
          const SizedBox(height: 10),
          if (lista.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('Todavía no hay jugadas.', style: tema.textTheme.bodySmall),
            ),
          for (final a in lista)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  width: 40,
                  child: IndicadorMitad(
                    mitad: a.mitad,
                    texto: '${a.entrada}',
                    color: tema.colorScheme.primary,
                    estilo: estiloCifra(tema.textTheme.labelMedium),
                  ),
                ),
                Expanded(
                  child: Text(
                    a.descripcion,
                    style: a.tipo == 'LANZAMIENTO'
                        ? tema.textTheme.bodySmall
                        : tema.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
            ),
        ]),
      ),
    );
  }
}

/// Marcador por entrada: visita arriba, local abajo. Las entradas sin jugar salen con "·".
/// Cabecera verde noche como un tablero; la columna de carreras va resaltada.
class _TablaEntradas extends StatelessWidget {
  const _TablaEntradas({required this.partido});

  final PartidoDetalle partido;

  @override
  Widget build(BuildContext context) {
    final p = partido;
    final entradas = p.lineScore.entradas;
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    String celda(int? v) => v?.toString() ?? '·';
    final cifra = estiloMarcador(tema.textTheme.titleMedium)?.copyWith(fontSize: 18, color: esquema.onSurface);
    final cabecera =
        estiloMarcador(tema.textTheme.labelLarge)?.copyWith(fontSize: 14, color: ColoresMarca.tintaBarra);

    Widget c(String t, TextStyle? e, {Color? fondo, double alto = 40, Alignment al = Alignment.center}) => Container(
          height: alto,
          alignment: al,
          color: fondo,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(t, style: e),
        );

    final resalte = esquema.secondaryContainer;
    final tintaResalte = esquema.onSecondaryContainer;

    TableRow fila(String abrev, int? Function(EntradaLineScore) pick, int r, int h, int e, {bool ultima = false}) =>
        TableRow(
          decoration: BoxDecoration(
            border: ultima ? null : Border(bottom: BorderSide(color: esquema.outlineVariant)),
          ),
          children: [
            c(abrev, cifra?.copyWith(fontSize: 16, letterSpacing: 0.8), al: Alignment.centerLeft),
            for (final en in entradas) c(celda(pick(en)), cifra),
            c('$r', cifra?.copyWith(fontSize: 20, color: tintaResalte), fondo: resalte),
            c('$h', cifra),
            c('$e', cifra),
          ],
        );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text('Marcador por entrada', style: tema.textTheme.titleLarge?.copyWith(fontSize: 20)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(34),
                columnWidths: {
                  0: const FixedColumnWidth(58),
                  entradas.length + 1: const FixedColumnWidth(40),
                  entradas.length + 2: const FixedColumnWidth(36),
                  entradas.length + 3: const FixedColumnWidth(36),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                  left: BorderSide(color: esquema.outlineVariant),
                  right: BorderSide(color: esquema.outlineVariant),
                  bottom: BorderSide(color: esquema.outlineVariant),
                ),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: ColoresMarca.verdeNoche),
                    children: [
                      c('', cabecera, alto: 32),
                      for (final en in entradas) c('${en.numero}', cabecera, alto: 32),
                      c('R', cabecera?.copyWith(color: ColoresMarca.amarillo), alto: 32),
                      c('H', cabecera, alto: 32),
                      c('E', cabecera, alto: 32),
                    ],
                  ),
                  fila(p.equipoVisita.abreviatura, (e) => e.visita, p.marcador.visita, p.hits.visita,
                      p.errores.visita),
                  fila(p.equipoLocal.abreviatura, (e) => e.local, p.marcador.local, p.hits.local, p.errores.local,
                      ultima: true),
                ],
              ),
            ),
          ),
          if (p.lineScore.entradasExtra)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Partido de ${entradas.length} entradas (más de las ${p.lineScore.entradasProgramadas} programadas).',
                style: tema.textTheme.bodySmall?.copyWith(color: esquema.onSurfaceVariant),
              ),
            ),
        ],
      ),
    );
  }
}
