import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/charts/barras_enfrentadas.dart';
import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/radar_comparativo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/estadisticas_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/graficas_jugador.dart';

/// Cara a cara entre dos jugadores de la misma temporada, con las estadísticas
/// calculadas de los partidos anotados en vivo. [pitcheo] compara como lanzadores.
class ComparadorPantalla extends ConsumerWidget {
  const ComparadorPantalla({
    super.key,
    required this.idTemporada,
    required this.pitcheo,
    required this.a,
    required this.b,
  });

  final int idTemporada;
  final bool pitcheo;
  final int a;
  final int b;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(pitcheo ? 'Cara a cara · Pitcheo' : 'Cara a cara · Bateo')),
      body: pitcheo
          ? VistaAsync<List<FilaPitcheo>>(
              valor: ref.watch(pitcheoTemporadaProvider(idTemporada)),
              cargando: const EsqueletoDetalle(),
              onReintentar: () => ref.invalidate(pitcheoTemporadaProvider(idTemporada)),
              datos: (filas) {
                final liga = ligaPitcheo(filas);
                final fa = liga.where((f) => f.jugador.id == a).firstOrNull;
                final fb = liga.where((f) => f.jugador.id == b).firstOrNull;
                if (fa == null || fb == null) return const _SinDatos();
                return _Lista(child: _Lanzadores(idTemporada: idTemporada, a: fa, b: fb));
              },
            )
          : VistaAsync<List<FilaBateo>>(
              valor: ref.watch(bateoTemporadaProvider(idTemporada)),
              cargando: const EsqueletoDetalle(),
              onReintentar: () => ref.invalidate(bateoTemporadaProvider(idTemporada)),
              datos: (filas) {
                final liga = ligaBateo(filas);
                final fa = liga.where((f) => f.jugador.id == a).firstOrNull;
                final fb = liga.where((f) => f.jugador.id == b).firstOrNull;
                if (fa == null || fb == null) return const _SinDatos();
                return _Lista(child: _Bateadores(idTemporada: idTemporada, a: fa, b: fb, liga: liga));
              },
            ),
    );
  }
}

class _Lista extends StatelessWidget {
  const _Lista({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [AnchoMaximo(ancho: 760, child: child)],
      );
}

class _SinDatos extends StatelessWidget {
  const _SinDatos();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(24),
        child: EstadoVacio(
          icono: Icons.compare_arrows_rounded,
          mensaje: 'Uno de los dos todavía no tiene estadísticas esta temporada.',
        ),
      );
}

/// Dos colores distinguibles: el de cada equipo o, si coinciden, el gris del eje para el segundo.
(Color, Color) _colores(BuildContext context, EquipoRefLiga? ea, EquipoRefLiga? eb) {
  final ca = colorDe(context, ea);
  final cb = ea?.color == eb?.color ? EstiloGrafica(context).eje : colorDe(context, eb);
  return (ca, cb);
}

String _nombre(JugadorResumenLiga j) => '${j.nombres} ${j.apellidos}';

class _Encabezado extends StatelessWidget {
  const _Encabezado({
    required this.idTemporada,
    required this.a,
    required this.b,
    required this.equipoA,
    required this.equipoB,
    required this.colorA,
    required this.colorB,
  });

  final int idTemporada;
  final JugadorResumenLiga a;
  final JugadorResumenLiga b;
  final EquipoRefLiga? equipoA;
  final EquipoRefLiga? equipoB;
  final Color colorA;
  final Color colorB;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final tinta = tema.colorScheme.onSurface;
    final suave = tema.colorScheme.onSurfaceVariant;
    Widget lado(JugadorResumenLiga j, EquipoRefLiga? e, Color c) => Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => context.push(rutaJugador(idTemporada, j, e)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tema.colorScheme.surfaceContainer,
                    border: Border.all(color: c.withValues(alpha: 0.45), width: 1.5),
                  ),
                  child: ImagenApi(urlFoto: j.fotoUrl, nombre: _nombre(j), tamano: 64, color: c),
                ),
                const SizedBox(height: 8),
                Text(
                  _nombre(j),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900, color: tinta),
                ),
                Text(
                  e?.nombre ?? 'Agente libre',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tema.textTheme.labelSmall?.copyWith(color: suave),
                ),
                const SizedBox(height: 7),
                Container(
                  height: 4,
                  width: 48,
                  decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
          ),
        );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: tema.brightness == Brightness.dark ? tema.colorScheme.surfaceContainer : ColoresMarca.blanco,
          border: Border.all(color: tema.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: tema.brightness == Brightness.dark ? 0.28 : 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 4, decoration: const BoxDecoration(gradient: ColoresMarca.franjaInstitucional)),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lado(a, equipoA, colorA),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 4, right: 4),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(gradient: ColoresMarca.tablero, shape: BoxShape.circle),
                      child: Text(
                        'VS',
                        style: estiloMarcador(tema.textTheme.titleLarge)
                            ?.copyWith(fontSize: 19, color: ColoresMarca.amarillo, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                  lado(b, equipoB, colorB),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bateadores extends StatelessWidget {
  const _Bateadores({required this.idTemporada, required this.a, required this.b, required this.liga});

  final int idTemporada;
  final FilaBateo a;
  final FilaBateo b;
  final List<FilaBateo> liga;

  @override
  Widget build(BuildContext context) {
    final (ca, cb) = _colores(context, a.equipo, b.equipo);
    final x = a.bateo;
    final y = b.bateo;
    Duelo cuenta(String etiqueta, int Function(CifrasBateo) leer, {bool menorEsMejor = false}) =>
        Duelo(etiqueta: etiqueta, a: leer(x).toDouble(), b: leer(y).toDouble(), menorEsMejor: menorEsMejor);
    Duelo tasa(String etiqueta, double Function(CifrasBateo) leer) =>
        Duelo(etiqueta: etiqueta, a: leer(x), b: leer(y), formato: promedio);
    double maximo(double Function(CifrasBateo) leer) =>
        liga.map((f) => leer(f.bateo)).fold(0, (m, v) => v > m ? v : m);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Encabezado(
          idTemporada: idTemporada,
          a: a.jugador,
          b: b.jugador,
          equipoA: a.equipo,
          equipoB: b.equipo,
          colorA: ca,
          colorB: cb,
        ),
        TarjetaGrafica(
          titulo: '¿Qué perfil tiene cada uno?',
          subtitulo: 'Cada eje va de cero al mejor de la liga',
          icono: Icons.radar_rounded,
          child: RadarComparativo(
            clave: 'bateo-${a.jugador.id}-${b.jugador.id}',
            ejes: [for (final e in ejesRadarBateo) e.$1],
            maximos: [for (final e in ejesRadarBateo) maximo(e.$2)],
            series: [
              SerieRadar(nombre: a.jugador.nombres.split(' ').first, color: ca, valores: [for (final e in ejesRadarBateo) e.$2(x)]),
              SerieRadar(nombre: b.jugador.nombres.split(' ').first, color: cb, valores: [for (final e in ejesRadarBateo) e.$2(y)]),
            ],
          ),
        ),
        TarjetaGrafica(
          titulo: '¿Quién gana cada duelo?',
          subtitulo: 'La cifra resaltada es la del que gana',
          icono: Icons.compare_arrows_rounded,
          child: BarrasEnfrentadas(
            clave: 'duelos-${a.jugador.id}-${b.jugador.id}',
            colorA: ca,
            colorB: cb,
            duelos: [
              tasa('Promedio (AVG)', (c) => c.avg),
              tasa('En base (OBP)', (c) => c.obp),
              tasa('Slugging (SLG)', (c) => c.slg),
              tasa('OPS', (c) => c.ops),
              cuenta('Hits', (c) => c.h),
              cuenta('Jonrones', (c) => c.hr),
              cuenta('Impulsadas', (c) => c.rbi),
              cuenta('Anotadas', (c) => c.carreras),
              cuenta('Bases robadas', (c) => c.sb),
              cuenta('Bases por bolas', (c) => c.bb),
              cuenta('Ponches', (c) => c.so, menorEsMejor: true),
            ],
          ),
        ),
        _Volumen(texto: '${_nombre(a.jugador)}: ${x.pa} PA en ${x.juegos} J · ${_nombre(b.jugador)}: ${y.pa} PA en ${y.juegos} J'),
      ],
    );
  }
}

class _Lanzadores extends StatelessWidget {
  const _Lanzadores({required this.idTemporada, required this.a, required this.b});

  final int idTemporada;
  final FilaPitcheo a;
  final FilaPitcheo b;

  @override
  Widget build(BuildContext context) {
    final (ca, cb) = _colores(context, a.equipo, b.equipo);
    final x = a.pitcheo;
    final y = b.pitcheo;
    Duelo cuenta(String etiqueta, int Function(CifrasPitcheo) leer, {bool menorEsMejor = false}) =>
        Duelo(etiqueta: etiqueta, a: leer(x).toDouble(), b: leer(y).toDouble(), menorEsMejor: menorEsMejor);
    Duelo decimal(String etiqueta, double Function(CifrasPitcheo) leer, {bool menorEsMejor = false}) =>
        Duelo(etiqueta: etiqueta, a: leer(x), b: leer(y), menorEsMejor: menorEsMejor, formato: dosDecimales);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Encabezado(
          idTemporada: idTemporada,
          a: a.jugador,
          b: b.jugador,
          equipoA: a.equipo,
          equipoB: b.equipo,
          colorA: ca,
          colorB: cb,
        ),
        TarjetaGrafica(
          titulo: '¿Quién gana cada duelo?',
          subtitulo: 'La cifra resaltada es la del que gana',
          icono: Icons.compare_arrows_rounded,
          child: BarrasEnfrentadas(
            clave: 'duelos-${a.jugador.id}-${b.jugador.id}',
            colorA: ca,
            colorB: cb,
            duelos: [
              decimal('Efectividad (ERA)', (c) => c.era, menorEsMejor: true),
              decimal('WHIP', (c) => c.whip, menorEsMejor: true),
              decimal('Ponches por 9', (c) => c.k9),
              decimal('Bases por bolas por 9', (c) => c.bb9, menorEsMejor: true),
              Duelo(
                etiqueta: 'Promedio rival',
                a: x.promedioContra,
                b: y.promedioContra,
                menorEsMejor: true,
                formato: promedio,
              ),
              Duelo(
                etiqueta: 'Entradas',
                a: x.outs.toDouble(),
                b: y.outs.toDouble(),
                formato: (v) => '${v ~/ 3}.${v.toInt() % 3}',
              ),
              cuenta('Ponches', (c) => c.so),
              cuenta('Ganados', (c) => c.ganados),
              cuenta('Hits permitidos', (c) => c.hits, menorEsMejor: true),
            ],
          ),
        ),
        _Volumen(texto: '${_nombre(a.jugador)}: ${x.ip} IP en ${x.juegos} J · ${_nombre(b.jugador)}: ${y.ip} IP en ${y.juegos} J'),
      ],
    );
  }
}

/// Cuánto ha jugado cada uno: para leer las tasas con cuidado.
class _Volumen extends StatelessWidget {
  const _Volumen({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant),
    );
  }
}
