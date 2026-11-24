import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/tema/colores_equipo.dart';
import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/comunes.dart';
import '../../core/widgets/estados.dart';
import '../../core/widgets/imagen_api.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'temporada_liga_pantalla.dart';
import 'widgets_liga.dart';

/// Equipo en una temporada (contrato v1): cabecera, récord, plantilla y partidos.
class EquipoLigaPantalla extends ConsumerWidget {
  const EquipoLigaPantalla({super.key, required this.idTemporada, required this.idEquipo});

  final int idTemporada;
  final int idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipo = ref.watch(equipoLigaProvider(idEquipo));
    return Scaffold(
      appBar: AppBar(title: Text(equipo.value?.nombre ?? 'Equipo')),
      body: RecargableSimple(
        onRefresh: () async {
          ref.invalidate(equipoLigaProvider(idEquipo));
          ref.invalidate(posicionesLigaProvider(idTemporada));
          ref.invalidate(plantillaLigaProvider((idTemporada, idEquipo)));
          ref.invalidate(partidosEquipoLigaProvider((idTemporada, idEquipo)));
        },
        child: VistaAsync<EquipoLiga>(
          valor: equipo,
          cargando: const EsqueletoDetalle(),
          onReintentar: () => ref.invalidate(equipoLigaProvider(idEquipo)),
          datos: (e) => Padding(
            padding: const EdgeInsets.all(16),
            child: AnchoMaximo(
              ancho: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Cabecera(equipo: e, idTemporada: idTemporada),
                  const SizedBox(height: 20),
                  _Plantilla(idTemporada: idTemporada, idEquipo: idEquipo),
                  _Partidos(idTemporada: idTemporada, idEquipo: idEquipo),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Cabecera extends ConsumerWidget {
  const _Cabecera({required this.equipo, required this.idTemporada});

  final EquipoLiga equipo;
  final int idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final color = ColoresEquipo.de(context, equipo.color);
    final posiciones = ref.watch(posicionesLigaProvider(idTemporada)).value ?? const <PosicionLiga>[];
    final i = posiciones.indexWhere((p) => p.equipo.id == equipo.id);
    final r = i < 0 ? null : posiciones[i];
    const tinta = ColoresMarca.tintaBarra;
    final ref0 = EquipoRefLiga(
      id: equipo.id,
      nombre: equipo.nombre,
      abreviatura: equipo.abreviatura,
      color: equipo.color,
      escudoUrl: equipo.escudoUrl,
    );
    // Banda verde noche con una franja diagonal del color del equipo y canto amarillo.
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: ColoresMarca.tablero,
        boxShadow: [
          BoxShadow(color: ColoresMarca.verdeNoche.withValues(alpha: 0.25), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: CustomPaint(
        painter: _Franja(color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
              child: Row(
                children: [
                  EscudoLiga(equipo: ref0, tamano: 76),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(equipo.nombre, style: tema.textTheme.headlineMedium?.copyWith(color: tinta, height: 1)),
                        const SizedBox(height: 4),
                        Text(
                          [equipo.abreviatura, ?equipo.ciudad].join(' · '),
                          style: tema.textTheme.bodySmall?.copyWith(color: tinta.withValues(alpha: 0.78)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                          decoration: BoxDecoration(color: ColoresMarca.amarillo, borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            r == null
                                ? 'Sin partidos terminados'
                                : '${i + 1}º · ${r.ganados}-${r.perdidos} · ${Formato.promedio(r.pct)}',
                            style: estiloMarcador(tema.textTheme.titleMedium)
                                ?.copyWith(color: ColoresMarca.tintaSobreAmarillo, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (r != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: Row(children: [
                  for (final (valor, etiqueta) in [
                    ('${r.juegos}', 'Juegos'),
                    ('${r.carrerasFavor}', 'C. a favor'),
                    ('${r.carrerasContra}', 'C. en contra'),
                    (Formato.conSigno(r.carrerasFavor - r.carrerasContra), 'Diferencia'),
                  ])
                    Expanded(
                      child: Column(children: [
                        Text(valor, style: estiloMarcador(tema.textTheme.headlineSmall)?.copyWith(color: tinta)),
                        Text(etiqueta, style: tema.textTheme.labelSmall?.copyWith(color: tinta.withValues(alpha: 0.75))),
                      ]),
                    ),
                ]),
              ),
            Container(height: 5, color: ColoresMarca.amarillo),
          ],
        ),
      ),
    );
  }
}

class _Franja extends CustomPainter {
  _Franja({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.72, 0)
        ..lineTo(w * 0.88, 0)
        ..lineTo(w * 0.64, h)
        ..lineTo(w * 0.48, h)
        ..close(),
      Paint()..color = color.withValues(alpha: 0.35),
    );
  }

  @override
  bool shouldRepaint(_Franja old) => old.color != color;
}

class _Plantilla extends ConsumerWidget {
  const _Plantilla({required this.idTemporada, required this.idEquipo});

  final int idTemporada;
  final int idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tema = Theme.of(context);
    final plantilla = ref.watch(plantillaLigaProvider((idTemporada, idEquipo)));
    return Seccion(
      titulo: 'Plantilla',
      icono: Icons.groups_rounded,
      child: plantilla.when(
        loading: () => const SizedBox(height: 160, child: EsqueletoLista(filas: 3)),
        error: (e, _) => EstadoError(
          error: e,
          compacto: true,
          onReintentar: () => ref.invalidate(plantillaLigaProvider((idTemporada, idEquipo))),
        ),
        data: (lista) {
          if (lista.isEmpty) {
            return const EstadoVacio(mensaje: 'Sin jugadores inscritos en esta temporada.', icono: Icons.person_off_outlined);
          }
          final ordenados = [...lista]..sort((a, b) => (a.numero ?? 999).compareTo(b.numero ?? 999));
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              for (var i = 0; i < ordenados.length; i++)
                Container(
                  color: i.isOdd ? tema.colorScheme.surfaceContainerLow : null,
                  child: ListTile(
                    onTap: () => context.push(
                        '/temporadas/$idTemporada/jugadores/${ordenados[i].jugador.id}?e=$idEquipo'),
                    leading: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ImagenApi(
                          urlFoto: ordenados[i].jugador.fotoUrl,
                          nombre: '${ordenados[i].jugador.nombres} ${ordenados[i].jugador.apellidos}',
                          tamano: 40,
                        ),
                        if (ordenados[i].numero != null)
                          Positioned(
                            right: -6,
                            bottom: -4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: ColoresMarca.verdeNoche,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${ordenados[i].numero}',
                                style: estiloMarcador(tema.textTheme.labelLarge)
                                    ?.copyWith(color: ColoresMarca.amarillo, fontSize: 13),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      '${ordenados[i].jugador.nombres} ${ordenados[i].jugador.apellidos}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(_detalle(ordenados[i])),
                    trailing: ordenados[i].posicion == null
                        ? null
                        : Text(
                            ordenados[i].posicion!,
                            style: estiloMarcador(tema.textTheme.titleLarge)
                                ?.copyWith(color: tema.colorScheme.primary, fontSize: 20),
                          ),
                  ),
                ),
            ]),
          );
        },
      ),
    );
  }

  static String _detalle(PlantillaLiga p) => [
        switch (p.jugador.batea) {
          LadoBateo.derecho => 'Batea derecho',
          LadoBateo.zurdo => 'Batea zurdo',
          LadoBateo.ambidiestro => 'Batea ambidiestro',
          null => null,
        },
        switch (p.jugador.lanza) {
          LadoLanzamiento.derecho => 'lanza derecho',
          LadoLanzamiento.zurdo => 'lanza zurdo',
          null => null,
        },
      ].whereType<String>().join(' · ');
}

class _Partidos extends ConsumerWidget {
  const _Partidos({required this.idTemporada, required this.idEquipo});

  final int idTemporada;
  final int idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partidos = ref.watch(partidosEquipoLigaProvider((idTemporada, idEquipo)));
    return Seccion(
      titulo: 'Partidos',
      icono: Icons.sports_baseball_rounded,
      child: partidos.when(
        loading: () => const SizedBox(height: 160, child: EsqueletoLista(filas: 2)),
        error: (e, _) => EstadoError(
          error: e,
          compacto: true,
          onReintentar: () => ref.invalidate(partidosEquipoLigaProvider((idTemporada, idEquipo))),
        ),
        data: (lista) => lista.isEmpty
            ? const EstadoVacio(mensaje: 'Sin partidos programados.', icono: Icons.event_busy_outlined)
            : Column(children: [
                for (final p in [...lista]..sort((a, b) => a.fechaHora.compareTo(b.fechaHora)))
                  TarjetaPartidoLiga(partido: p, idTemporada: idTemporada),
              ]),
      ),
    );
  }
}
