import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/tema/colores_equipo.dart';
import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/comunes.dart';
import '../../core/widgets/estados.dart';
import '../../core/widgets/vista_async.dart';
import '../../features/jugadores/presentacion/cabecera_jugador.dart';
import '../datos/estadisticas_repositorio.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'graficas_jugador.dart';

/// Perfil de un jugador en una temporada: foto en cromo, equipo, ficha y estadísticas
/// de la temporada y de su carrera (bateo y, si lanza, pitcheo). [idEquipo] nulo = agente libre.
class JugadorLigaPantalla extends ConsumerWidget {
  const JugadorLigaPantalla({super.key, required this.idTemporada, required this.idJugador, this.idEquipo});

  final int idTemporada;
  final int idJugador;
  final int? idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugador = ref.watch(jugadorLigaProvider(idJugador));
    // La inscripción (número, posición y equipo) viene de la plantilla de la temporada.
    final plantilla = idEquipo == null
        ? ref.watch(agentesLibresLigaProvider(idTemporada))
        : ref.watch(plantillaLigaProvider((idTemporada, idEquipo!)));
    final entrada = plantilla.value?.where((p) => p.jugador.id == idJugador).firstOrNull;
    final anio = ref.watch(temporadasLigaProvider).value?.where((t) => t.id == idTemporada).firstOrNull?.anio;
    return Scaffold(
      appBar: AppBar(title: const Text('Jugador')),
      body: RecargableSimple(
        onRefresh: () async {
          ref.invalidate(jugadorLigaProvider(idJugador));
          ref.invalidate(estadisticasJugadorProvider((idTemporada, idJugador)));
        },
        child: VistaAsync<JugadorLiga>(
          valor: jugador,
          cargando: const EsqueletoDetalle(),
          onReintentar: () => ref.invalidate(jugadorLigaProvider(idJugador)),
          datos: (j) => Padding(
            padding: const EdgeInsets.all(16),
            child: AnchoMaximo(
              ancho: 760,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CabeceraJugador(
                    nombre: '${j.nombres} ${j.apellidos}',
                    urlFoto: j.fotoUrl,
                    detalle: [
                      if (entrada?.posicion != null) _nombrePosicion(entrada!.posicion!)
                      else if (j.esLanzador) 'Pitcher',
                      if (j.batea != null || j.lanza != null) 'B/L: ${_inicial(j.batea)}/${_inicial(j.lanza)}',
                      if (j.edad != null) '${j.edad} años',
                    ].join(' · '),
                    idTemporada: '$idTemporada',
                    idEquipo: entrada?.equipo == null ? null : '${entrada!.equipo!.id}',
                    nombreEquipo: entrada?.equipo?.nombre,
                    agenteLibre: entrada != null && entrada.equipo == null,
                    color: entrada?.equipo?.color == null ? null : ColoresEquipo.de(context, entrada!.equipo!.color),
                  ),
                  Seccion(
                    titulo: 'Ficha',
                    icono: Icons.badge_outlined,
                    child: RejillaCifras(
                      hijos: [
                        Cifra(valor: entrada?.numero == null ? '—' : '#${entrada!.numero}', etiqueta: 'Número', destacada: true),
                        Cifra(valor: entrada?.posicion ?? '—', etiqueta: 'Posición'),
                        Cifra(valor: j.esLanzador ? 'Pitcher' : 'De posición', etiqueta: 'Rol'),
                        Cifra(valor: j.edad == null ? '—' : '${j.edad}', etiqueta: 'Edad'),
                        Cifra(valor: _lado(j.batea), etiqueta: 'Batea'),
                        Cifra(valor: _lado(j.lanza), etiqueta: 'Lanza (mano)'),
                        if (j.fechaNacimiento != null)
                          Cifra(valor: DateFormat('d MMM y', 'es').format(j.fechaNacimiento!), etiqueta: 'Nacimiento'),
                      ],
                    ),
                  ),
                  Seccion(
                    titulo: 'Estadísticas',
                    icono: Icons.query_stats_rounded,
                    child: _Estadisticas(
                      idTemporada: idTemporada,
                      idJugador: idJugador,
                      anio: anio,
                      pitcherPrimero: j.esLanzador,
                      color: colorDe(context, entrada?.equipo),
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

  static String _lado(Object? l) => switch (l) {
        LadoBateo.derecho || LadoLanzamiento.derecho => 'Derecho',
        LadoBateo.zurdo || LadoLanzamiento.zurdo => 'Zurdo',
        LadoBateo.ambidiestro => 'Ambidiestro',
        _ => '—',
      };

  static String _inicial(Object? l) => switch (l) {
        LadoBateo.derecho || LadoLanzamiento.derecho => 'D',
        LadoBateo.zurdo || LadoLanzamiento.zurdo => 'Z',
        LadoBateo.ambidiestro => 'A',
        _ => '—',
      };

  static String _nombrePosicion(String p) => switch (p) {
        'P' => 'Lanzador',
        'C' => 'Receptor',
        '1B' => 'Primera base',
        '2B' => 'Segunda base',
        '3B' => 'Tercera base',
        'SS' => 'Campocorto',
        'LF' => 'Jardín izquierdo',
        'CF' => 'Jardín central',
        'RF' => 'Jardín derecho',
        'DH' => 'Bateador designado',
        _ => p,
      };
}

class _Estadisticas extends ConsumerWidget {
  const _Estadisticas({
    required this.idTemporada,
    required this.idJugador,
    required this.anio,
    required this.pitcherPrimero,
    required this.color,
  });

  final int idTemporada;
  final int idJugador;
  final int? anio;
  final bool pitcherPrimero;

  /// Color del equipo: el del jugador en las gráficas.
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VistaAsync<EstadisticasJugador>(
      valor: ref.watch(estadisticasJugadorProvider((idTemporada, idJugador))),
      cargando: const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator())),
      onReintentar: () => ref.invalidate(estadisticasJugadorProvider((idTemporada, idJugador))),
      datos: (e) {
        if (e.temporada.vacio && e.carrera.vacio) {
          return const EstadoVacio(
            icono: Icons.query_stats_rounded,
            mensaje: 'Todavía no tiene estadísticas. Aparecen en cuanto juega un partido anotado en vivo.',
          );
        }
        final titulo = anio == null ? 'Esta temporada' : 'Temporada $anio';
        void comparar(bool pitcheo) =>
            compararCon(context, ref, idTemporada: idTemporada, idJugador: idJugador, pitcheo: pitcheo);
        final bateo = [
          if (e.temporada.bateo != null || e.carrera.bateo != null)
            _BloqueBateo(
              titulo: titulo,
              temporada: e.temporada.bateo,
              carrera: e.carrera.bateo,
              onComparar: e.temporada.bateo == null ? null : () => comparar(false),
            ),
          if (e.temporada.bateo != null) GraficasBateo(idTemporada: idTemporada, idJugador: idJugador, color: color),
        ];
        final pitcheo = [
          if (e.temporada.pitcheo != null || e.carrera.pitcheo != null)
            _BloquePitcheo(
              titulo: titulo,
              temporada: e.temporada.pitcheo,
              carrera: e.carrera.pitcheo,
              onComparar: e.temporada.pitcheo == null ? null : () => comparar(true),
            ),
          if (e.temporada.pitcheo != null)
            GraficasPitcheo(idTemporada: idTemporada, idJugador: idJugador, color: color),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: pitcherPrimero ? [...pitcheo, ...bateo] : [...bateo, ...pitcheo],
        );
      },
    );
  }
}

/// Fila de cifras al estilo MLB: etiqueta arriba, valor abajo, columnas parejas.
class _FilaCifras extends StatelessWidget {
  const _FilaCifras({required this.titulo, required this.columnas});

  final String titulo;
  final List<(String, String)> columnas;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(titulo, style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Row(children: [
          for (final (etiqueta, valor) in columnas)
            Expanded(
              child: Column(children: [
                Text(etiqueta, style: estiloEtiqueta(tema.textTheme.labelSmall)?.copyWith(color: esquema.onSurfaceVariant)),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(valor, style: estiloMarcador(tema.textTheme.titleLarge)?.copyWith(fontSize: 22)),
                ),
              ]),
            ),
        ]),
      ]),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado(this.texto, this.icono, {this.onComparar});

  final String texto;
  final IconData icono;

  /// Abre el cara a cara con otro jugador (null = sin estadísticas de la temporada).
  final VoidCallback? onComparar;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Row(children: [
        Icon(icono, size: 18, color: tema.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            texto.toUpperCase(),
            style: estiloEtiqueta(tema.textTheme.labelMedium)?.copyWith(color: tema.colorScheme.primary),
          ),
        ),
        if (onComparar != null)
          TextButton.icon(
            onPressed: onComparar,
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            icon: const Icon(Icons.compare_arrows_rounded, size: 18),
            label: const Text('Comparar'),
          ),
      ]),
    );
  }
}

class _BloqueBateo extends StatelessWidget {
  const _BloqueBateo({required this.titulo, this.temporada, this.carrera, this.onComparar});

  final String titulo;
  final CifrasBateo? temporada;
  final CifrasBateo? carrera;
  final VoidCallback? onComparar;

  static List<(String, String)> _resumen(CifrasBateo b) => [
        ('AB', '${b.ab}'),
        ('AVG', promedio(b.avg)),
        ('HR', '${b.hr}'),
        ('RBI', '${b.rbi}'),
        ('SB', '${b.sb}'),
        ('OPS', promedio(b.ops)),
      ];

  @override
  Widget build(BuildContext context) {
    final t = temporada;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _Encabezado('Bateo', Icons.sports_cricket_rounded, onComparar: onComparar),
          _FilaCifras(titulo: titulo, columnas: t == null ? _resumen(const CifrasBateo()) : _resumen(t)),
          if (carrera != null) _FilaCifras(titulo: 'Carrera', columnas: _resumen(carrera!)),
          if (t != null)
            _Detalle(cifras: [
              ('J', '${t.juegos}'),
              ('PA', '${t.pa}'),
              ('H', '${t.h}'),
              ('2B', '${t.dobles}'),
              ('3B', '${t.triples}'),
              ('R', '${t.carreras}'),
              ('BB', '${t.bb}'),
              ('HBP', '${t.hbp}'),
              ('K', '${t.so}'),
              ('CS', '${t.cs}'),
              ('OBP', promedio(t.obp)),
              ('SLG', promedio(t.slg)),
            ]),
        ]),
      ),
    );
  }
}

class _BloquePitcheo extends StatelessWidget {
  const _BloquePitcheo({required this.titulo, this.temporada, this.carrera, this.onComparar});

  final String titulo;
  final CifrasPitcheo? temporada;
  final CifrasPitcheo? carrera;
  final VoidCallback? onComparar;

  static List<(String, String)> _resumen(CifrasPitcheo p) => [
        ('G-P', '${p.ganados}-${p.perdidos}'),
        ('ERA', dosDecimales(p.era)),
        ('IP', p.ip),
        ('K', '${p.so}'),
        ('WHIP', dosDecimales(p.whip)),
      ];

  @override
  Widget build(BuildContext context) {
    final t = temporada;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _Encabezado('Pitcheo', Icons.sports_baseball_rounded, onComparar: onComparar),
          _FilaCifras(titulo: titulo, columnas: t == null ? _resumen(const CifrasPitcheo()) : _resumen(t)),
          if (carrera != null) _FilaCifras(titulo: 'Carrera', columnas: _resumen(carrera!)),
          if (t != null)
            _Detalle(cifras: [
              ('J', '${t.juegos}'),
              ('JI', '${t.iniciados}'),
              ('H', '${t.hits}'),
              ('C', '${t.carreras}'),
              ('CL', '${t.limpias}'),
              ('BB', '${t.bb}'),
              ('HR', '${t.hr}'),
              ('Lanz.', '${t.lanzamientos}'),
              ('K/9', dosDecimales(t.k9)),
              ('BB/9', dosDecimales(t.bb9)),
              ('AVG rival', promedio(t.promedioContra)),
            ]),
        ]),
      ),
    );
  }
}

/// Todas las cifras de la temporada, plegadas para no saturar.
class _Detalle extends StatelessWidget {
  const _Detalle({required this.cifras});

  final List<(String, String)> cifras;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Theme(
      data: tema.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 12),
        title: Text('Todas las cifras de la temporada', style: tema.textTheme.labelLarge),
        children: [
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final (etiqueta, valor) in cifras)
              Container(
                width: 76,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: tema.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [
                  Text(valor, style: estiloMarcador(tema.textTheme.titleMedium)),
                  const SizedBox(height: 2),
                  Text(etiqueta, style: tema.textTheme.labelSmall),
                ]),
              ),
          ]),
        ],
      ),
    );
  }
}
