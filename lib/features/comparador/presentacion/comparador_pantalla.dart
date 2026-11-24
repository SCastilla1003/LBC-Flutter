import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/charts/anillo_registro.dart';
import '../../../core/charts/barras_enfrentadas.dart';
import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/radar_comparativo.dart';
import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../equipos/datos/modelos_equipo.dart';
import '../../jugadores/datos/jugadores_repositorio.dart';
import '../../jugadores/datos/modelos_jugador.dart';
import '../../jugadores/presentacion/perfil_bateador_pantalla.dart';

/// Cara a cara entre dos bateadores, dos lanzadores o dos equipos de la misma temporada.
class ComparadorPantalla extends ConsumerWidget {
  const ComparadorPantalla({
    super.key,
    required this.idTemporada,
    required this.tipo,
    required this.a,
    required this.b,
  });

  final String idTemporada;

  /// "bateadores", "lanzadores" o "equipos".
  final String tipo;
  final String a;
  final String b;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colores =
        ref.watch(coloresEquiposProvider(idTemporada)).value ?? const {};
    final Widget cuerpo = switch (tipo) {
      'bateadores' => _cargar2(
        ref,
        ref.watch(perfilBateadorProvider((idTemporada, a))),
        ref.watch(perfilBateadorProvider((idTemporada, b))),
        () {
          ref.invalidate(perfilBateadorProvider((idTemporada, a)));
          ref.invalidate(perfilBateadorProvider((idTemporada, b)));
        },
        (pa, pb) => _Bateadores(a: pa, b: pb, colores: colores),
      ),
      'lanzadores' => _cargar2(
        ref,
        ref.watch(perfilLanzadorProvider((idTemporada, a))),
        ref.watch(perfilLanzadorProvider((idTemporada, b))),
        () {
          ref.invalidate(perfilLanzadorProvider((idTemporada, a)));
          ref.invalidate(perfilLanzadorProvider((idTemporada, b)));
        },
        (pa, pb) => _Lanzadores(a: pa.jugador, b: pb.jugador, colores: colores),
      ),
      _ => _cargar2(
        ref,
        ref.watch(equipoEstadisticasProvider((idTemporada, a))),
        ref.watch(equipoEstadisticasProvider((idTemporada, b))),
        () {
          ref.invalidate(equipoEstadisticasProvider((idTemporada, a)));
          ref.invalidate(equipoEstadisticasProvider((idTemporada, b)));
        },
        (ea, eb) => _Equipos(a: ea, b: eb),
      ),
    };
    return Scaffold(
      appBar: AppBar(title: const Text('Cara a cara')),
      body: cuerpo,
    );
  }

  Widget _cargar2<A, B>(
    WidgetRef ref,
    AsyncValue<A> va,
    AsyncValue<B> vb,
    VoidCallback reintentar,
    Widget Function(A, B) datos,
  ) {
    if (va.hasError || vb.hasError) {
      return EstadoError(
        error: (va.error ?? vb.error)!,
        onReintentar: reintentar,
      );
    }
    if (!va.hasValue || !vb.hasValue) return const EsqueletoDetalle();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AnchoMaximo(ancho: 760, child: datos(va.value as A, vb.value as B)),
      ],
    );
  }
}

/// Dos colores distinguibles: el de cada equipo o, si coinciden, el gris del eje para el segundo.
(Color, Color) _colores(BuildContext context, String? claveA, String? claveB) {
  final ca = ColoresEquipo.de(context, claveA);
  final cb = claveA == claveB
      ? EstiloGrafica(context).eje
      : ColoresEquipo.de(context, claveB);
  return (ca, cb);
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({
    required this.nombreA,
    required this.nombreB,
    required this.fotoA,
    required this.fotoB,
    required this.colorA,
    required this.colorB,
    this.subA,
    this.subB,
  });

  final String nombreA;
  final String nombreB;
  final String? fotoA;
  final String? fotoB;
  final Color colorA;
  final Color colorB;
  final String? subA;
  final String? subB;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final tinta = tema.colorScheme.onSurface;
    final suave = tema.colorScheme.onSurfaceVariant;
    Widget lado(String n, String? f, Color c, String? s) => Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tema.colorScheme.surfaceContainer,
              border: Border.all(color: c.withValues(alpha: 0.45), width: 1.5),
            ),
            child: ImagenApi(urlFoto: f, nombre: n, tamano: 64, color: c),
          ),
          const SizedBox(height: 8),
          Text(
            n,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: tema.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: tinta,
            ),
          ),
          if (s != null)
            Text(
              s,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: tema.textTheme.labelSmall?.copyWith(color: suave),
            ),
          const SizedBox(height: 7),
          Container(
            height: 4,
            width: 48,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: tema.brightness == Brightness.dark
                ? const [Color(0xFF251E1B), Color(0xFF2D2420)]
                : const [
                    ColoresMarca.blanco,
                    Color(0xFFFFFCF6),
                    Color(0xFFFFF7EA),
                  ],
          ),
          border: Border.all(
            color: tema.brightness == Brightness.dark
                ? tema.colorScheme.outlineVariant
                : ColoresMarca.rojo.withValues(alpha: 0.13),
          ),
          boxShadow: [
            BoxShadow(
              color: tema.brightness == Brightness.dark
                  ? Colors.black.withValues(alpha: 0.30)
                  : ColoresMarca.rojoProfundo.withValues(alpha: 0.07),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: ColoresMarca.franjaInstitucional,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lado(nombreA, fotoA, colorA, subA),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 4, right: 4),
                    child: Text(
                      'VS',
                      style: tema.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: tema.colorScheme.primary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  lado(nombreB, fotoB, colorB, subB),
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
  const _Bateadores({required this.a, required this.b, required this.colores});

  final BateadorPerfil a;
  final BateadorPerfil b;
  final Map<String, String?> colores;

  @override
  Widget build(BuildContext context) {
    final ja = a.jugador;
    final jb = b.jugador;
    final (ca, cb) = _colores(
      context,
      colores[ja.idEquipo],
      colores[jb.idEquipo],
    );
    final r = a.referenciaLiga;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Encabezado(
          nombreA: ja.nombre,
          nombreB: jb.nombre,
          fotoA: ja.urlFoto,
          fotoB: jb.urlFoto,
          colorA: ca,
          colorB: cb,
          subA: ja.nombreEquipo,
          subB: jb.nombreEquipo,
        ),
        TarjetaGrafica(
          titulo: '¿Qué perfil tiene cada uno?',
          child: RadarComparativo(
            clave: '${ja.id}-${jb.id}',
            ejes: [for (final x in ejesRadarBateo) x.$2],
            maximos: [for (final x in ejesRadarBateo) r[x.$1]?.maximo ?? 0],
            series: [
              SerieRadar(
                nombre: ja.nombre.split(' ').first,
                color: ca,
                valores: [
                  for (final x in ejesRadarBateo) valorBateador(ja, x.$1),
                ],
              ),
              SerieRadar(
                nombre: jb.nombre.split(' ').first,
                color: cb,
                valores: [
                  for (final x in ejesRadarBateo) valorBateador(jb, x.$1),
                ],
              ),
            ],
          ),
        ),
        TarjetaGrafica(
          titulo: '¿Quién gana cada duelo?',
          child: BarrasEnfrentadas(
            clave: '${ja.id}-${jb.id}',
            colorA: ca,
            colorB: cb,
            duelos: [
              Duelo(
                etiqueta: 'Jonrones',
                a: ja.homeRuns.toDouble(),
                b: jb.homeRuns.toDouble(),
              ),
              Duelo(
                etiqueta: 'Impulsadas',
                a: ja.carrerasImpulsadas.toDouble(),
                b: jb.carrerasImpulsadas.toDouble(),
              ),
              Duelo(
                etiqueta: 'Hits',
                a: ja.hits.toDouble(),
                b: jb.hits.toDouble(),
              ),
              Duelo(
                etiqueta: 'Total de bases',
                a: ja.totalBases.toDouble(),
                b: jb.totalBases.toDouble(),
              ),
              Duelo(
                etiqueta: 'Robos',
                a: ja.roboDeBase.toDouble(),
                b: jb.roboDeBase.toDouble(),
              ),
              Duelo(
                etiqueta: 'Bases por bola',
                a: ja.basePorBola.toDouble(),
                b: jb.basePorBola.toDouble(),
              ),
              Duelo(
                etiqueta: 'Ponches',
                a: ja.ponches.toDouble(),
                b: jb.ponches.toDouble(),
                menorEsMejor: true,
              ),
              Duelo(
                etiqueta: 'Errores',
                a: ja.errores.toDouble(),
                b: jb.errores.toDouble(),
                menorEsMejor: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Lanzadores extends StatelessWidget {
  const _Lanzadores({required this.a, required this.b, required this.colores});

  final Lanzador a;
  final Lanzador b;
  final Map<String, String?> colores;

  @override
  Widget build(BuildContext context) {
    final (ca, cb) = _colores(
      context,
      colores[a.idEquipo],
      colores[b.idEquipo],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Encabezado(
          nombreA: a.nombre,
          nombreB: b.nombre,
          fotoA: a.urlFoto,
          fotoB: b.urlFoto,
          colorA: ca,
          colorB: cb,
          subA: a.nombreEquipo,
          subB: b.nombreEquipo,
        ),
        TarjetaGrafica(
          titulo: '¿Quién gana cada duelo?',
          child: BarrasEnfrentadas(
            clave: '${a.id}-${b.id}',
            colorA: ca,
            colorB: cb,
            duelos: [
              Duelo(etiqueta: 'ERA', a: a.era, b: b.era, menorEsMejor: true),
              Duelo(etiqueta: 'WHIP', a: a.whip, b: b.whip, menorEsMejor: true),
              Duelo(etiqueta: 'K/9', a: a.k9, b: b.k9),
              Duelo(etiqueta: 'BB/9', a: a.bb9, b: b.bb9, menorEsMejor: true),
              Duelo(etiqueta: 'K/BB', a: a.kbb, b: b.kbb),
              Duelo(
                etiqueta: 'Innings',
                a: a.inningsLanzados.toDouble(),
                b: b.inningsLanzados.toDouble(),
              ),
              Duelo(
                etiqueta: 'Ponches',
                a: a.ponchados.toDouble(),
                b: b.ponchados.toDouble(),
              ),
              Duelo(
                etiqueta: 'Hits permitidos',
                a: a.hitsPermitidos.toDouble(),
                b: b.hitsPermitidos.toDouble(),
                menorEsMejor: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Equipos extends StatelessWidget {
  const _Equipos({required this.a, required this.b});

  final EquipoEstadisticas a;
  final EquipoEstadisticas b;

  @override
  Widget build(BuildContext context) {
    final ea = a.equipo;
    final eb = b.equipo;
    final (ca, cb) = _colores(context, ea.color, eb.color);
    final ra = ea.registro;
    final rb = eb.registro;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Encabezado(
          nombreA: ea.nombre,
          nombreB: eb.nombre,
          fotoA: ea.urlFoto,
          fotoB: eb.urlFoto,
          colorA: ca,
          colorB: cb,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnilloRegistro(
              ganados: ra.ganados,
              perdidos: ra.perdidos,
              empates: ra.empates,
              centro: '${ra.ganados}-${ra.perdidos}',
              subcentro: Formato.promedio(ra.porcentajeVictorias),
              tamano: 104,
            ),
            AnilloRegistro(
              ganados: rb.ganados,
              perdidos: rb.perdidos,
              empates: rb.empates,
              centro: '${rb.ganados}-${rb.perdidos}',
              subcentro: Formato.promedio(rb.porcentajeVictorias),
              tamano: 104,
            ),
          ],
        ),
        const SizedBox(height: 16),
        TarjetaGrafica(
          titulo: '¿Quién gana cada duelo?',
          child: BarrasEnfrentadas(
            clave: '${ea.id}-${eb.id}',
            colorA: ca,
            colorB: cb,
            duelos: [
              Duelo(
                etiqueta: 'Carreras a favor',
                a: ra.carrerasFavor.toDouble(),
                b: rb.carrerasFavor.toDouble(),
              ),
              Duelo(
                etiqueta: 'Carreras en contra',
                a: ra.carrerasContra.toDouble(),
                b: rb.carrerasContra.toDouble(),
                menorEsMejor: true,
              ),
              Duelo(
                etiqueta: 'Jonrones',
                a: a.bateo.homeRuns.toDouble(),
                b: b.bateo.homeRuns.toDouble(),
              ),
              Duelo(
                etiqueta: 'Hits',
                a: a.bateo.hits.toDouble(),
                b: b.bateo.hits.toDouble(),
              ),
              Duelo(
                etiqueta: 'Robos',
                a: a.bateo.roboDeBase.toDouble(),
                b: b.bateo.roboDeBase.toDouble(),
              ),
              Duelo(
                etiqueta: 'ERA',
                a: a.pitcheo.era,
                b: b.pitcheo.era,
                menorEsMejor: true,
              ),
              Duelo(
                etiqueta: 'WHIP',
                a: a.pitcheo.whip,
                b: b.pitcheo.whip,
                menorEsMejor: true,
              ),
              Duelo(
                etiqueta: 'Ponches',
                a: a.pitcheo.ponchados.toDouble(),
                b: b.pitcheo.ponchados.toDouble(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
