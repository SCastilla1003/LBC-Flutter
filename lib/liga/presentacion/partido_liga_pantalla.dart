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
    return Card(
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: ColoresMarca.franjaInstitucional,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChipEstadoPartido(estado: p.estado),
                    Text(
                      DateFormat("EEE d MMM · h:mm a", 'es').format(p.fechaHora),
                      style: tema.textTheme.labelMedium?.copyWith(color: tema.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _Lado(equipo: p.equipoLocal, ganador: p.ganadorId == p.equipoLocal.id)),
                    Text(
                      marcado ? '${p.marcador.local}  –  ${p.marcador.visita}' : 'vs',
                      style: tema.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    Expanded(child: _Lado(equipo: p.equipoVisita, ganador: p.ganadorId == p.equipoVisita.id, derecha: true)),
                  ],
                ),
                if (p.estadio != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    p.estadio!.nombre,
                    style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
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
      style: tema.textTheme.titleSmall?.copyWith(
        fontWeight: ganador ? FontWeight.w900 : FontWeight.w600,
        color: ganador ? ColoresMarca.verdeTexto : tema.colorScheme.onSurface,
      ),
    );
    final escudo = EscudoLiga(equipo: equipo, tamano: 52);
    final columna = Column(
      crossAxisAlignment: derecha ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [escudo, const SizedBox(height: 8), nombre],
    );
    return columna;
  }
}

/// Marcador por entrada: visita arriba, local abajo. Las entradas sin jugar salen con "·".
class _TablaEntradas extends StatelessWidget {
  const _TablaEntradas({required this.partido});

  final PartidoDetalle partido;

  @override
  Widget build(BuildContext context) {
    final p = partido;
    final entradas = p.lineScore.entradas;
    final tema = Theme.of(context);
    String celda(int? v) => v?.toString() ?? '·';

    DataRow fila(String abrev, int? Function(EntradaLineScore) pick, int r, int h, int e) => DataRow(cells: [
          DataCell(Text(abrev, style: const TextStyle(fontWeight: FontWeight.w800))),
          for (final en in entradas) DataCell(Text(celda(pick(en)), style: estiloCifra(tema.textTheme.bodyMedium))),
          DataCell(Text('$r', style: const TextStyle(fontWeight: FontWeight.w900))),
          DataCell(Text('$h', style: estiloCifra(tema.textTheme.bodyMedium))),
          DataCell(Text('$e', style: estiloCifra(tema.textTheme.bodyMedium))),
        ]);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Text('Marcador por entrada', style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 36,
                dataRowMinHeight: 36,
                dataRowMaxHeight: 40,
                columnSpacing: 14,
                columns: [
                  const DataColumn(label: Text('')),
                  for (final en in entradas) DataColumn(numeric: true, label: Text('${en.numero}')),
                  const DataColumn(numeric: true, label: Text('R', style: TextStyle(fontWeight: FontWeight.w900))),
                  const DataColumn(numeric: true, label: Text('H')),
                  const DataColumn(numeric: true, label: Text('E')),
                ],
                rows: [
                  fila(p.equipoVisita.abreviatura, (e) => e.visita, p.marcador.visita, p.hits.visita, p.errores.visita),
                  fila(p.equipoLocal.abreviatura, (e) => e.local, p.marcador.local, p.hits.local, p.errores.local),
                ],
              ),
            ),
            if (p.lineScore.entradasExtra)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 6),
                child: Text(
                  'Partido de ${entradas.length} entradas (más de las ${p.lineScore.entradasProgramadas} programadas).',
                  style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Situación en vivo: outs, cuenta, bateador, lanzador y corredores.
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
      padding: const EdgeInsets.only(top: 12),
      child: TarjetaLiga(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('En vivo', style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
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
