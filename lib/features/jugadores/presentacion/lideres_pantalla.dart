import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/estadisticas_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/datos/temporada_en_foco.dart';

/// Una categoría de líderes: cómo se lee el valor, cómo se muestra y si exige mínimo.
class _Categoria<T> {
  const _Categoria(this.sigla, this.nombre, this.valor, this.texto, {this.menorEsMejor = false, this.tasa = false});

  final String sigla;
  final String nombre;
  final num Function(T) valor;
  final String Function(T) texto;
  final bool menorEsMejor;

  /// Promedios y tasas: solo cuentan los que tienen suficientes turnos o entradas.
  final bool tasa;
}

final _categoriasBateo = <_Categoria<CifrasBateo>>[
  _Categoria('AVG', 'Promedio', (b) => b.avg, (b) => promedio(b.avg), tasa: true),
  _Categoria('HR', 'Jonrones', (b) => b.hr, (b) => '${b.hr}'),
  _Categoria('RBI', 'Impulsadas', (b) => b.rbi, (b) => '${b.rbi}'),
  _Categoria('H', 'Hits', (b) => b.h, (b) => '${b.h}'),
  _Categoria('R', 'Anotadas', (b) => b.carreras, (b) => '${b.carreras}'),
  _Categoria('SB', 'Bases robadas', (b) => b.sb, (b) => '${b.sb}'),
  _Categoria('OBP', 'En base', (b) => b.obp, (b) => promedio(b.obp), tasa: true),
  _Categoria('SLG', 'Slugging', (b) => b.slg, (b) => promedio(b.slg), tasa: true),
  _Categoria('OPS', 'OPS', (b) => b.ops, (b) => promedio(b.ops), tasa: true),
  _Categoria('BB', 'Bases por bolas', (b) => b.bb, (b) => '${b.bb}'),
];

final _categoriasPitcheo = <_Categoria<CifrasPitcheo>>[
  _Categoria('ERA', 'Efectividad', (p) => p.era, (p) => dosDecimales(p.era), menorEsMejor: true, tasa: true),
  _Categoria('K', 'Ponches', (p) => p.so, (p) => '${p.so}'),
  _Categoria('G', 'Ganados', (p) => p.ganados, (p) => '${p.ganados}'),
  _Categoria('WHIP', 'WHIP', (p) => p.whip, (p) => dosDecimales(p.whip), menorEsMejor: true, tasa: true),
  _Categoria('IP', 'Entradas', (p) => p.outs, (p) => p.ip),
  _Categoria('K/9', 'Ponches por 9', (p) => p.k9, (p) => dosDecimales(p.k9), tasa: true),
  _Categoria('AVG', 'Promedio rival', (p) => p.promedioContra, (p) => promedio(p.promedioContra),
      menorEsMejor: true, tasa: true),
];

/// Líderes de bateo y pitcheo de la temporada, calculados con las jugadas del anotador.
class LideresPantalla extends ConsumerStatefulWidget {
  const LideresPantalla({super.key});

  @override
  ConsumerState<LideresPantalla> createState() => _LideresPantallaState();
}

class _LideresPantallaState extends ConsumerState<LideresPantalla> {
  bool _pitcheo = false;
  int _bateo = 0;
  int _lanzar = 0;

  @override
  Widget build(BuildContext context) {
    final temporada = ref.watch(temporadaEnFocoLigaProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Líderes')),
      body: RecargableSimple(
        onRefresh: () async {
          if (temporada == null) return;
          ref.invalidate(bateoTemporadaProvider(temporada.id));
          ref.invalidate(pitcheoTemporadaProvider(temporada.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnchoMaximo(
            ancho: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroLbc(
                  compacto: true,
                  etiqueta: temporada == null ? 'Liga de Béisbol de Cartagena' : '${temporada.nombre} · ${temporada.anio}',
                  titulo: 'Líderes al bate y al montículo',
                  subtitulo: 'Los mejores de la temporada, estadística por estadística.',
                  icono: Icons.emoji_events_rounded,
                ),
                const SizedBox(height: 16),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: false, label: Text('Bateo'), icon: Icon(Icons.sports_cricket_rounded)),
                    ButtonSegment(value: true, label: Text('Pitcheo'), icon: Icon(Icons.sports_baseball_rounded)),
                  ],
                  selected: {_pitcheo},
                  onSelectionChanged: (v) => setState(() => _pitcheo = v.first),
                ),
                const SizedBox(height: 12),
                if (temporada == null)
                  const EstadoVacio(mensaje: 'Todavía no hay temporadas.')
                else if (_pitcheo)
                  VistaAsync<List<FilaPitcheo>>(
                    valor: ref.watch(pitcheoTemporadaProvider(temporada.id)),
                    cargando: const EsqueletoLista(),
                    onReintentar: () => ref.invalidate(pitcheoTemporadaProvider(temporada.id)),
                    datos: (filas) => _Tabla<CifrasPitcheo>(
                      idTemporada: temporada.id,
                      categorias: _categoriasPitcheo,
                      elegida: _lanzar,
                      alElegir: (i) => setState(() => _lanzar = i),
                      filas: [for (final f in filas) (f.jugador, f.equipo, f.pitcheo)],
                      volumen: (p) => p.outs,
                      minimo: (n) => 'Mínimo ${n ~/ 3}.${n % 3} entradas lanzadas',
                    ),
                  )
                else
                  VistaAsync<List<FilaBateo>>(
                    valor: ref.watch(bateoTemporadaProvider(temporada.id)),
                    cargando: const EsqueletoLista(),
                    onReintentar: () => ref.invalidate(bateoTemporadaProvider(temporada.id)),
                    datos: (filas) => _Tabla<CifrasBateo>(
                      idTemporada: temporada.id,
                      categorias: _categoriasBateo,
                      elegida: _bateo,
                      alElegir: (i) => setState(() => _bateo = i),
                      filas: [for (final f in filas) (f.jugador, f.equipo, f.bateo)],
                      volumen: (b) => b.pa,
                      minimo: (n) => 'Mínimo $n apariciones al plato',
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

class _Tabla<T> extends StatelessWidget {
  const _Tabla({
    required this.idTemporada,
    required this.categorias,
    required this.elegida,
    required this.alElegir,
    required this.filas,
    required this.volumen,
    required this.minimo,
  });

  final int idTemporada;
  final List<_Categoria<T>> categorias;
  final int elegida;
  final ValueChanged<int> alElegir;
  final List<(JugadorResumenLiga, EquipoRefLiga?, T)> filas;

  /// Turnos (bateo) u outs (pitcheo): para el mínimo de los promedios.
  final int Function(T) volumen;
  final String Function(int) minimo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final c = categorias[elegida];
    // Para promedios: al menos la mitad de los turnos (o entradas) del que más tiene.
    final maximo = filas.fold<int>(0, (m, f) => volumen(f.$3) > m ? volumen(f.$3) : m);
    final int umbral = c.tasa ? max(1, (maximo / 2).ceil()) : 0;
    final lista = [
      for (final f in filas)
        if (volumen(f.$3) >= umbral) f,
    ]..sort((a, b) {
        final va = c.valor(a.$3);
        final vb = c.valor(b.$3);
        final orden = c.menorEsMejor ? va.compareTo(vb) : vb.compareTo(va);
        return orden != 0 ? orden : volumen(b.$3).compareTo(volumen(a.$3));
      });
    final top = lista.take(10).toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          separatorBuilder: (_, _) => const SizedBox(width: 6),
          itemBuilder: (_, i) => ChoiceChip(
            label: Text(categorias[i].sigla),
            selected: i == elegida,
            onSelected: (_) => alElegir(i),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
        child: Text(
          [c.nombre, if (c.tasa && filas.isNotEmpty) minimo(umbral)].join(' · '),
          style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
        ),
      ),
      if (top.isEmpty)
        const Padding(
          padding: EdgeInsets.only(top: 24),
          child: EstadoVacio(
            icono: Icons.query_stats_rounded,
            mensaje: 'Todavía no hay estadísticas: aparecen en cuanto se anota un partido en vivo.',
          ),
        )
      else
        for (final (i, (jugador, equipo, cifras)) in top.indexed)
          _FilaLider(
            puesto: i + 1,
            jugador: jugador,
            equipo: equipo,
            valor: c.texto(cifras),
            onTap: () => context.push(
                '/temporadas/$idTemporada/jugadores/${jugador.id}${equipo == null ? '' : '?e=${equipo.id}'}'),
          ),
    ]);
  }
}

class _FilaLider extends StatelessWidget {
  const _FilaLider({
    required this.puesto,
    required this.jugador,
    required this.equipo,
    required this.valor,
    required this.onTap,
  });

  final int puesto;
  final JugadorResumenLiga jugador;
  final EquipoRefLiga? equipo;
  final String valor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final lider = puesto == 1;
    final nombre = '${jugador.nombres} ${jugador.apellidos}';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: lider ? ColoresMarca.verdeNoche : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: lider ? 14 : 8),
          child: Row(children: [
            SizedBox(
              width: 26,
              child: Text(
                '$puesto',
                style: estiloMarcador(tema.textTheme.titleMedium)
                    ?.copyWith(color: lider ? ColoresMarca.amarillo : tema.colorScheme.onSurfaceVariant),
              ),
            ),
            ImagenApi(urlFoto: jugador.fotoUrl, nombre: nombre, tamano: lider ? 56 : 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tema.textTheme.titleMedium?.copyWith(
                    fontFamily: FuentesLbc.titular,
                    fontWeight: FontWeight.w700,
                    fontSize: lider ? 20 : 17,
                    color: lider ? Colors.white : null,
                  ),
                ),
                Text(
                  equipo?.nombre ?? 'Agente libre',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tema.textTheme.bodySmall?.copyWith(color: lider ? Colors.white70 : null),
                ),
              ]),
            ),
            Text(
              valor,
              style: estiloMarcador(lider ? tema.textTheme.headlineMedium : tema.textTheme.titleLarge)
                  ?.copyWith(color: lider ? ColoresMarca.amarillo : null),
            ),
          ]),
        ),
      ),
    );
  }
}
