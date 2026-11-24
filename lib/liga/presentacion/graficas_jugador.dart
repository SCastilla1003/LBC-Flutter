import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/charts/base_graficas.dart';
import '../../core/charts/diamante_bases.dart';
import '../../core/charts/medidor.dart';
import '../../core/charts/nube_liga.dart';
import '../../core/charts/radar_comparativo.dart';
import '../../core/tema/colores_equipo.dart';
import '../../features/comparador/presentacion/selector_comparar.dart';
import '../datos/estadisticas_repositorio.dart';
import '../datos/modelos_liga.dart';

/// Ejes del radar de bateo: (etiqueta, cómo se lee). Mezcla promedios y volumen; cada
/// eje se normaliza contra el máximo de la liga, así que las escalas no chocan.
final ejesRadarBateo = <(String, double Function(CifrasBateo))>[
  ('AVG', (b) => b.avg),
  ('OBP', (b) => b.obp),
  ('SLG', (b) => b.slg),
  ('HR', (b) => b.hr.toDouble()),
  ('RBI', (b) => b.rbi.toDouble()),
  ('BB', (b) => b.bb.toDouble()),
];

double _max(Iterable<double> v) => v.isEmpty ? 0 : v.reduce(math.max);
double _min(Iterable<double> v) => v.isEmpty ? 0 : v.reduce(math.min);
double _prom(Iterable<double> v) => v.isEmpty ? 0 : v.reduce((a, b) => a + b) / v.length;

/// Bateadores con al menos una aparición en la temporada.
List<FilaBateo> ligaBateo(List<FilaBateo> filas) => [for (final f in filas) if (f.bateo.pa > 0) f];

/// Lanzadores con al menos un out en la temporada.
List<FilaPitcheo> ligaPitcheo(List<FilaPitcheo> filas) => [for (final f in filas) if (f.pitcheo.outs > 0) f];

String rutaJugador(int idTemporada, JugadorResumenLiga j, EquipoRefLiga? e) =>
    '/temporadas/$idTemporada/jugadores/${j.id}${e == null ? '' : '?e=${e.id}'}';

/// Color de cada jugador: el de su equipo.
Color colorDe(BuildContext context, EquipoRefLiga? e) => ColoresEquipo.de(context, e?.color);

/// Elige otro jugador con estadísticas de la temporada y abre el cara a cara.
Future<void> compararCon(
  BuildContext context,
  WidgetRef ref, {
  required int idTemporada,
  required int idJugador,
  required bool pitcheo,
}) async {
  final List<(JugadorResumenLiga, EquipoRefLiga?)> opciones = pitcheo
      ? [
          for (final f in ligaPitcheo(await ref.read(pitcheoTemporadaProvider(idTemporada).future)))
            (f.jugador, f.equipo),
        ]
      : [
          for (final f in ligaBateo(await ref.read(bateoTemporadaProvider(idTemporada).future))) (f.jugador, f.equipo),
        ];
  if (!context.mounted) return;
  final otro = await elegirParaComparar(context, [
    for (final (j, e) in opciones)
      if (j.id != idJugador)
        OpcionComparar(
          id: '${j.id}',
          nombre: '${j.nombres} ${j.apellidos}',
          detalle: e?.nombre ?? 'Agente libre',
          urlFoto: j.fotoUrl,
          color: e == null ? null : colorDe(context, e),
        ),
  ]);
  if (otro != null && context.mounted) {
    context.push('/temporadas/$idTemporada/comparar/${pitcheo ? 'pitcheo' : 'bateo'}?a=$idJugador&b=$otro');
  }
}

/// Radar contra la liga, diamante de hits y nube de disciplina de un bateador.
class GraficasBateo extends ConsumerWidget {
  const GraficasBateo({super.key, required this.idTemporada, required this.idJugador, required this.color});

  final int idTemporada;
  final int idJugador;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filas = ref.watch(bateoTemporadaProvider(idTemporada)).value;
    if (filas == null) return const SizedBox.shrink();
    final liga = ligaBateo(filas);
    final yo = liga.where((f) => f.jugador.id == idJugador).firstOrNull;
    if (yo == null) return const SizedBox.shrink();
    final b = yo.bateo;
    final e = EstiloGrafica(context);
    final sencillos = math.max(0, b.h - b.dobles - b.triples - b.hr);

    final radar = TarjetaGrafica(
      titulo: '¿Dónde destaca?',
      subtitulo: 'Contra el promedio de ${liga.length} ${liga.length == 1 ? 'bateador' : 'bateadores'} de la liga',
      icono: Icons.radar_rounded,
      child: RadarComparativo(
        clave: 'bateo-$idJugador',
        ejes: [for (final x in ejesRadarBateo) x.$1],
        maximos: [for (final x in ejesRadarBateo) _max(liga.map((f) => x.$2(f.bateo)))],
        series: [
          SerieRadar(
            nombre: 'Liga',
            color: e.eje,
            relleno: false,
            valores: [for (final x in ejesRadarBateo) _prom(liga.map((f) => x.$2(f.bateo)))],
          ),
          SerieRadar(
            nombre: yo.jugador.nombres.split(' ').first,
            color: color,
            valores: [for (final x in ejesRadarBateo) x.$2(b)],
          ),
        ],
      ),
    );
    final diamante = TarjetaGrafica(
      titulo: '¿Hasta dónde llega?',
      subtitulo: 'Sus hits por base alcanzada',
      icono: Icons.change_history_rounded,
      child: Center(
        child: DiamanteBases(
          sencillos: sencillos,
          dobles: b.dobles,
          triples: b.triples,
          jonrones: b.hr,
          totalBases: sencillos + 2 * b.dobles + 3 * b.triples + 4 * b.hr,
        ),
      ),
    );
    final equipos = {for (final f in liga) f.jugador.id: f};

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 640) return Column(children: [radar, diamante]);
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: radar),
          const SizedBox(width: 16),
          Expanded(child: diamante),
        ]);
      }),
      if (liga.length >= 3)
        TarjetaGrafica(
          titulo: '¿Qué tan disciplinado es?',
          subtitulo: 'Ponches contra bases por bolas · toca un punto para ver al jugador',
          icono: Icons.bubble_chart_rounded,
          child: NubeLiga(
            idResaltado: '$idJugador',
            colorResaltado: color,
            ejeX: 'Ponches',
            ejeY: 'BB',
            cuadrantes: const ['Disciplinado', 'Paciente', 'Contacto', 'Impaciente'],
            onTap: (id) {
              final f = equipos[int.parse(id)];
              if (f != null && f.jugador.id != idJugador) {
                context.push(rutaJugador(idTemporada, f.jugador, f.equipo));
              }
            },
            puntos: [
              for (final f in liga)
                PuntoNube(
                  id: '${f.jugador.id}',
                  nombre: '${f.jugador.nombres} ${f.jugador.apellidos}',
                  x: f.bateo.so.toDouble(),
                  y: f.bateo.bb.toDouble(),
                ),
            ],
          ),
        ),
    ]);
  }
}

/// Medidores de ERA y WHIP contra la liga y nube de dominio/control de un lanzador.
class GraficasPitcheo extends ConsumerWidget {
  const GraficasPitcheo({super.key, required this.idTemporada, required this.idJugador, required this.color});

  final int idTemporada;
  final int idJugador;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filas = ref.watch(pitcheoTemporadaProvider(idTemporada)).value;
    if (filas == null) return const SizedBox.shrink();
    final liga = ligaPitcheo(filas);
    final yo = liga.where((f) => f.jugador.id == idJugador).firstOrNull;
    if (yo == null) return const SizedBox.shrink();
    final p = yo.pitcheo;
    final equipos = {for (final f in liga) f.jugador.id: f};

    Widget medidor(String etiqueta, double valor, double Function(CifrasPitcheo) leer) {
      final v = liga.map((f) => leer(f.pitcheo));
      final maximo = math.max(_max(v), valor) * 1.15;
      return Medidor(
        valor: valor,
        minimo: 0,
        maximo: maximo <= 0 ? 1 : maximo,
        etiqueta: etiqueta,
        formato: dosDecimales,
        referencia: liga.length >= 2 ? _prom(v) : null,
        zonas: liga.length >= 2 ? zonasMenorEsMejor(context, minimo: _min(v), promedio: _prom(v), maximo: _max(v)) : const [],
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TarjetaGrafica(
        titulo: '¿Qué tan efectivo es?',
        subtitulo: liga.length >= 2
            ? 'La marca es el promedio de ${liga.length} lanzadores de la liga · menos es mejor'
            : 'Menos es mejor',
        icono: Icons.speed_rounded,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 16,
          runSpacing: 16,
          children: [
            medidor('ERA', p.era, (x) => x.era),
            medidor('WHIP', p.whip, (x) => x.whip),
          ],
        ),
      ),
      if (liga.length >= 3)
        TarjetaGrafica(
          titulo: '¿Domina o controla?',
          subtitulo: 'Ponches y bases por bolas cada 9 entradas · toca un punto para ver al jugador',
          icono: Icons.bubble_chart_rounded,
          child: NubeLiga(
            idResaltado: '$idJugador',
            colorResaltado: color,
            ejeX: 'BB/9',
            ejeY: 'K/9',
            cuadrantes: const ['Dominante', 'Potencia', 'Control', 'En apuros'],
            onTap: (id) {
              final f = equipos[int.parse(id)];
              if (f != null && f.jugador.id != idJugador) {
                context.push(rutaJugador(idTemporada, f.jugador, f.equipo));
              }
            },
            puntos: [
              for (final f in liga)
                PuntoNube(
                  id: '${f.jugador.id}',
                  nombre: '${f.jugador.nombres} ${f.jugador.apellidos}',
                  x: f.pitcheo.bb9,
                  y: f.pitcheo.k9,
                ),
            ],
          ),
        ),
    ]);
  }
}
