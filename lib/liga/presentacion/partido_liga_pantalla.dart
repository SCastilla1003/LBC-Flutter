import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'widgets_liga.dart';

/// Partido: marcador, marcador por entrada (estilo MLB), situación en vivo y accesos
/// a alineación y pitcheo. Si el partido está en vivo se refresca cada 8 segundos.
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
      _sondeo = Timer.periodic(
        const Duration(seconds: 8),
        (_) => ref.invalidate(partidoDetalleLigaProvider(widget.idPartido)),
      );
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

  @override
  Widget build(BuildContext context) {
    final valor = ref.watch(partidoDetalleLigaProvider(widget.idPartido));
    valor.whenData((p) => _vigilar(p.estado));
    return Scaffold(
      appBar: AppBar(title: const Text('Partido')),
      body: RecargableSimple(
        onRefresh: () => ref.refresh(partidoDetalleLigaProvider(widget.idPartido).future).then((_) {}, onError: (_) {}),
        child: VistaAsync<PartidoDetalle>(
          valor: valor,
          onReintentar: () => ref.invalidate(partidoDetalleLigaProvider(widget.idPartido)),
          datos: (p) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              children: [
                _Marcador(partido: p),
                _TablaEntradas(partido: p),
                if (p.estado == EstadoPartidoLiga.enJuego && p.situacion != null)
                  _Situacion(situacion: p.situacion!),
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
          ),
        ),
      ),
    );
  }
}

class _Marcador extends StatelessWidget {
  const _Marcador({required this.partido});

  final PartidoDetalle partido;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final p = partido;
    final marcado = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.finalizado;
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
                    ChipEstadoPartido(estado: p.estado),
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
                    Expanded(child: _Lado(equipo: p.equipoLocal, ganador: ganaLocal)),
                    if (marcado)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          carreras(p.marcador.local, ganaLocal),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '–',
                              style: estiloCarreras?.copyWith(fontSize: 40, color: tinta.withValues(alpha: 0.5)),
                            ),
                          ),
                          carreras(p.marcador.visita, ganaVisita),
                        ],
                      )
                    else
                      Text('VS', style: estiloCarreras?.copyWith(fontSize: 40, color: ColoresMarca.amarillo)),
                    Expanded(child: _Lado(equipo: p.equipoVisita, ganador: ganaVisita, derecha: true)),
                  ],
                ),
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
  const _Lado({required this.equipo, required this.ganador, this.derecha = false});

  final EquipoRefLiga equipo;
  final bool ganador;
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
    return Column(
      crossAxisAlignment: derecha ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [escudo, const SizedBox(height: 10), nombre],
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

// Situación en vivo: outs, cuenta, bateador, lanzador y corredores.
class _Situacion extends StatelessWidget {
  const _Situacion({required this.situacion});

  final SituacionLiga situacion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final s = situacion;
    final corredores = s.corredores;

    Widget linea(String titulo, String valor) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SizedBox(width: 92, child: Text(titulo, style: tema.textTheme.labelMedium?.copyWith(color: tema.colorScheme.onSurfaceVariant))),
              Expanded(child: Text(valor, style: tema.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700))),
            ],
          ),
        );

    return Padding(
      padding: EdgeInsets.zero,
      child: TarjetaLiga(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: ColoresMarca.rojo, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text('En vivo', style: tema.textTheme.titleLarge?.copyWith(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 6),
            linea('Outs', '${s.outs} / 3'),
            linea('Cuenta', '${s.bolas} bolas · ${s.strikes} strikes'),
            linea('Bateador', s.bateador?.nombre ?? '—'),
            linea('Lanzador', s.lanzador?.nombre ?? '—'),
            linea('1.ª base', corredores?.primera?.nombre ?? 'Vacía'),
            linea('2.ª base', corredores?.segunda?.nombre ?? 'Vacía'),
            linea('3.ª base', corredores?.tercera?.nombre ?? 'Vacía'),
          ],
        ),
      ),
    );
  }
}
