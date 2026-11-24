import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/bump_posiciones.dart';
import '../../../core/charts/mosaico_records.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../partidos/datos/modelos_partido.dart';
import '../../partidos/datos/partidos_repositorio.dart';
import '../../temporadas/datos/temporadas_repositorio.dart';
import '../datos/equipos_repositorio.dart';
import '../datos/modelos_equipo.dart';

class PosicionesPantalla extends ConsumerWidget {
  const PosicionesPantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posiciones = ref.watch(posicionesProvider(idTemporada));
    final partidos = ref.watch(partidosProvider(idTemporada));
    final nombreTemporada = ref
        .watch(temporadaDetalleProvider(idTemporada))
        .value
        ?.nombreTemporada;
    return Scaffold(
      appBar: AppBar(title: const Text('Tabla de posiciones')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(posicionesProvider(idTemporada));
          ref.invalidate(partidosProvider(idTemporada));
          await ref.read(posicionesProvider(idTemporada).future);
        },
        child: VistaAsync(
          valor: posiciones,
          onReintentar: () => ref.invalidate(posicionesProvider(idTemporada)),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin equipos',
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              AnchoMaximo(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Portada(
                      nombreTemporada: nombreTemporada,
                      posiciones: lista,
                    ),
                    _MapaTemporada(posiciones: lista, idTemporada: idTemporada),
                    _PeleaLiderato(
                      idTemporada: idTemporada,
                      posiciones: lista,
                      partidos: partidos,
                    ),
                    _Tabla(posiciones: lista, idTemporada: idTemporada),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Portada extends StatelessWidget {
  const _Portada({required this.nombreTemporada, required this.posiciones});

  final String? nombreTemporada;
  final List<Posicion> posiciones;

  @override
  Widget build(BuildContext context) {
    final lider = posiciones.firstOrNull;
    final jugados = posiciones.fold<int>(0, (s, p) => s + p.partidosJugados);
    return HeroLbc(
      compacto: true,
      etiqueta: nombreTemporada ?? 'Temporada actual',
      titulo: 'Tabla de posiciones',
      subtitulo: lider == null
          ? 'La liga, equipo por equipo.'
          : '${lider.nombre} lidera con ${lider.ganados}-${lider.perdidos} (${Formato.promedio(lider.porcentajeVictorias)}).',
      icono: Icons.leaderboard_rounded,
      contenido: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          PastillaHero(
            icono: Icons.groups_rounded,
            texto: '${posiciones.length} equipos',
          ),
          PastillaHero(
            icono: Icons.sports_baseball_rounded,
            texto: '$jugados partidos',
          ),
        ],
      ),
      accion: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColoresMarca.dorado, Color(0xFFFFE7A3)],
          ),
          border: Border.all(
            color: ColoresMarca.doradoOscuro.withValues(alpha: 0.35),
          ),
          boxShadow: [
            BoxShadow(
              color: ColoresMarca.doradoOscuro.withValues(alpha: 0.20),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.emoji_events_rounded,
          color: ColoresMarca.rojoProfundo,
          size: 30,
        ),
      ),
    );
  }
}

class _MapaTemporada extends StatelessWidget {
  const _MapaTemporada({required this.posiciones, required this.idTemporada});

  final List<Posicion> posiciones;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    return TarjetaGrafica(
      titulo: 'El mapa de la temporada',
      subtitulo: 'Mosaico: ancho = partidos jugados · altura = récord',
      icono: Icons.view_column_rounded,
      child: MosaicoRecords(
        columnas: [
          for (final p in posiciones)
            ColumnaMosaico(
              id: p.idEquipo,
              nombre: p.nombre,
              color: ColoresEquipo.de(context, p.color),
              ganados: p.ganados,
              perdidos: p.perdidos,
              empates: p.empates,
            ),
        ],
        onTap: (id) => context.push('/temporadas/$idTemporada/equipos/$id'),
      ),
    );
  }
}

class _PeleaLiderato extends ConsumerWidget {
  const _PeleaLiderato({
    required this.idTemporada,
    required this.posiciones,
    required this.partidos,
  });

  final String idTemporada;
  final List<Posicion> posiciones;
  final AsyncValue<List<Partido>> partidos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TarjetaGrafica(
      titulo: 'La pelea por el liderato',
      subtitulo: 'Bump chart: puesto de cada equipo al cierre de cada fecha',
      icono: Icons.swap_vert_rounded,
      child: partidos.when(
        loading: () => const SizedBox(
          height: 260,
          child: EsqueletoLista(filas: 4, conAvatar: false),
        ),
        error: (e, _) => EstadoError(
          error: e,
          compacto: true,
          onReintentar: () => ref.invalidate(partidosProvider(idTemporada)),
        ),
        data: (lista) {
          final equipos = [
            for (final p in posiciones)
              (p.idEquipo, p.nombre, ColoresEquipo.de(context, p.color)),
          ];
          final carrera = calcularCarreraLiderato(
            equipos: equipos,
            partidos: [
              for (final p in lista)
                if (p.finalizado)
                  (
                    p.fecha,
                    p.equipoLocal.id,
                    p.equipoVisitante.id,
                    p.carrerasEquipoLocal,
                    p.carrerasEquipoVisitante,
                  ),
            ],
          );
          return GraficaBump(carrera: carrera);
        },
      ),
    );
  }
}

class _Tabla extends StatelessWidget {
  const _Tabla({required this.posiciones, required this.idTemporada});

  final List<Posicion> posiciones;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 12, 10),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: tema.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.table_rows_rounded,
                    size: 18,
                    color: tema.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Clasificación',
                    style: tema.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  'G · P · %',
                  style: tema.textTheme.labelSmall?.copyWith(
                    color: tema.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          LayoutBuilder(
            builder: (context, c) {
              final ancha = c.maxWidth >= 600;
              return Column(
                children: [
                  _Encabezado(ancha: ancha),
                  const Divider(),
                  for (final p in posiciones)
                    _Fila(p: p, ancha: ancha, idTemporada: idTemporada),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

const _anchoNum = 44.0;

class _Encabezado extends StatelessWidget {
  const _Encabezado({required this.ancha});

  final bool ancha;

  @override
  Widget build(BuildContext context) {
    final estilo = Theme.of(context).textTheme.labelMedium
        ?.copyWith(fontWeight: FontWeight.w800);
    Widget n(String t, [String? ayuda]) => SizedBox(
      width: _anchoNum,
      child: Tooltip(
        message: ayuda ?? t,
        child: Text(t, textAlign: TextAlign.end, style: estilo),
      ),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text('#', style: estilo)),
          Expanded(child: Text('Equipo', style: estilo)),
          n('G', 'Ganados'),
          n('P', 'Perdidos'),
          n('%', 'Porcentaje de victorias'),
          n('JD', 'Juegos detrás del líder'),
          if (ancha) ...[
            n('Dif', 'Diferencial de carreras'),
            SizedBox(
              width: 64,
              child: Text('Racha', textAlign: TextAlign.end, style: estilo),
            ),
          ],
        ],
      ),
    );
  }
}

class _Fila extends StatelessWidget {
  const _Fila({
    required this.p,
    required this.ancha,
    required this.idTemporada,
  });

  final Posicion p;
  final bool ancha;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cifra = estiloCifra(tema.textTheme.bodyMedium);
    Widget n(String t, {bool fuerte = false}) => SizedBox(
      width: _anchoNum,
      child: Text(
        t,
        textAlign: TextAlign.end,
        style: fuerte ? cifra?.copyWith(fontWeight: FontWeight.w900) : cifra,
      ),
    );
    final color = ColoresEquipo.de(context, p.color);
    final podio = p.posicion <= 3;
    final fondo = p.posicion == 1
        ? tema.colorScheme.primaryContainer.withValues(alpha: 0.42)
        : podio
        ? tema.colorScheme.surfaceContainer.withValues(alpha: 0.55)
        : Colors.transparent;
    return Material(
      color: fondo,
      child: InkWell(
        onTap: () =>
            context.push('/temporadas/$idTemporada/equipos/${p.idEquipo}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: p.posicion <= 3
                    ? Row(
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            size: 15,
                            color: switch (p.posicion) {
                              1 => ColoresMarca.doradoOscuro,
                              2 => const Color(0xFF8C8C8C),
                              _ => const Color(0xFFB87333),
                            },
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${p.posicion}',
                            style: cifra?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ],
                      )
                    : Text(
                        '${p.posicion}',
                        style: cifra?.copyWith(fontWeight: FontWeight.w700),
                      ),
              ),
              FranjaColor(color: color, alto: 32),
              const SizedBox(width: 8),
              ImagenApi(
                urlFoto: p.urlFoto,
                nombre: p.nombre,
                tamano: 32,
                color: color,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  p.nombre,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              n('${p.ganados}'),
              n('${p.perdidos}'),
              n(Formato.promedio(p.porcentajeVictorias), fuerte: true),
              n(
                p.juegosDetras == 0
                    ? '—'
                    : p.juegosDetras.toStringAsFixed(1).replaceAll('.', ','),
              ),
              if (ancha) ...[
                n(Formato.conSigno(p.diferencial)),
                SizedBox(
                  width: 64,
                  child: Text(
                    p.racha ?? '—',
                    textAlign: TextAlign.end,
                    style: cifra,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
