import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/tema/colores_equipo.dart';
import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/imagen_api.dart';
import '../datos/juego_repositorio.dart';
import '../datos/modelos_liga.dart';

/// Lado del plato donde se para el bateador, visto desde detrás del home: el derecho
/// sale a la izquierda (lado de tercera) y el zurdo a la derecha. El ambidiestro batea
/// del lado contrario a la mano del lanzador.
bool bateadorALaIzquierda(LadoBateo? batea, LadoLanzamiento? lanza) => switch (batea) {
      LadoBateo.zurdo => false,
      LadoBateo.ambidiestro => lanza == LadoLanzamiento.zurdo,
      _ => true,
    };

/// El terreno en vivo visto desde detrás del home: el lanzador en el montículo, el
/// bateador en su caja (derecho o zurdo), las caras de los corredores en sus bases y el
/// próximo bateador en su círculo (a la derecha si batea el visitante, a la izquierda si
/// batea el local).
class CampoEnVivo extends StatelessWidget {
  const CampoEnVivo({super.key, required this.juego, this.alTocar});

  final EstadoJuego juego;

  /// Si se da, tocar a un jugador lo abre.
  final void Function(JugadorResumenLiga jugador, EquipoRefLiga equipo)? alTocar;

  @override
  Widget build(BuildContext context) {
    final p = juego.partido;
    final s = p.situacion;
    final of = juego.ofensiva;
    final def = juego.defensa;
    final turno = of.orden.where((t) => t.jugador != null && t.jugador!.id == s?.bateador?.id).firstOrNull;
    final bateador = turno?.jugador;
    final lanzador = def.lanzador;
    final despues = (turno?.orden ?? of.proximo) % 9 + 1;
    final siguiente = of.orden.where((t) => t.orden == despues).firstOrNull?.jugador;
    JugadorResumenLiga? deOfensiva(int id) =>
        of.orden.map((t) => t.jugador).whereType<JugadorResumenLiga>().where((j) => j.id == id).firstOrNull;
    final c = s?.corredores;
    final corredores = [c?.primera, c?.segunda, c?.tercera];
    final colorOf = ColoresEquipo.de(context, of.equipo.color);
    final colorDef = ColoresEquipo.de(context, def.equipo.color);
    final izquierda = bateadorALaIzquierda(bateador?.batea, lanzador?.lanza);
    final proximoDerecha = !juego.bateaLocal;
    VoidCallback? abrir(JugadorResumenLiga? j, EquipoRefLiga e) =>
        j == null || alTocar == null ? null : () => alTocar!(j, e);

    return LayoutBuilder(builder: (context, cons) {
      final w = math.min(cons.maxWidth, 460.0);
      final h = w * 1.28;
      Offset en(double x, double y) => Offset(w * x, h * y);
      final home = en(0.5, 0.72);
      final primera = en(0.83, 0.47);
      final segunda = en(0.5, 0.23);
      final tercera = en(0.17, 0.47);
      final monticulo = en(0.5, 0.47);
      final bases = [primera, segunda, tercera];
      final caraGrande = (w * 0.17).clamp(52.0, 74.0);
      final caraCorredor = (w * 0.13).clamp(40.0, 58.0);
      final caraProximo = (w * 0.12).clamp(38.0, 52.0);
      final cajaBateo = home + Offset(w * (izquierda ? -0.13 : 0.13), 0);
      final circuloIzq = Offset(w * 0.115, h - w * 0.17);
      final circuloDer = Offset(w * 0.885, h - w * 0.17);
      final circuloProximo = proximoDerecha ? circuloDer : circuloIzq;
      const alturaEtiqueta = 16.0;

      // Coloca una ficha centrada en x, sin salirse del campo.
      Widget colocar(double cx, double ancho, Widget hijo, {double? top, double? bottom}) => Positioned(
            left: (cx - ancho / 2).clamp(4.0, w - ancho - 4),
            width: ancho,
            top: top,
            bottom: bottom,
            child: hijo,
          );

      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: w,
            height: h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0F7340), Color(0xFF0A522D)],
              ),
            ),
            child: Stack(children: [
              Positioned.fill(
                child: ExcludeSemantics(
                  child: CustomPaint(
                    painter: _Terreno(
                      home: home,
                      bases: bases,
                      monticulo: monticulo,
                      ocupadas: [for (final r in corredores) r != null],
                      cajas: [home + Offset(-w * 0.13, 0), home + Offset(w * 0.13, 0)],
                      circulos: [circuloIzq, circuloDer],
                      escala: w,
                    ),
                  ),
                ),
              ),
              Positioned(top: 10, left: 10, child: _EnVivo(suspendido: p.estado == EstadoPartidoLiga.suspendido)),
              Positioned(
                top: 12,
                right: 12,
                child: Text(
                  'Batea ${of.equipo.abreviatura}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
              // El lanzador, en el montículo.
              if (lanzador != null || s?.lanzador != null)
                colocar(
                  monticulo.dx,
                  w * 0.38,
                  top: monticulo.dy - h * 0.03 - caraGrande / 2 - alturaEtiqueta,
                  _Ficha(
                    etiqueta: 'LANZA',
                    jugador: lanzador,
                    nombre: lanzador == null ? s!.lanzador!.nombre : '${lanzador.nombres} ${lanzador.apellidos}',
                    detalle: '${def.equipo.abreviatura} · ${def.lanzamientos} lanz.',
                    cara: caraGrande,
                    color: colorDef,
                    onTap: abrir(lanzador, def.equipo),
                  ),
                ),
              // Los corredores, justo encima de su base.
              for (final (i, r) in corredores.indexed)
                if (r != null)
                  colocar(
                    bases[i].dx,
                    w * 0.3,
                    bottom: h - bases[i].dy + w * 0.035,
                    _Ficha(
                      jugador: deOfensiva(r.id),
                      nombre: r.nombre,
                      descripcion: 'En ${['primera', 'segunda', 'tercera'][i]}: ${r.nombre}',
                      cara: caraCorredor,
                      color: colorOf,
                      onTap: abrir(deOfensiva(r.id), of.equipo),
                    ),
                  ),
              // El bateador, en la caja de su lado.
              if (bateador != null || s?.bateador != null)
                colocar(
                  cajaBateo.dx,
                  w * 0.28,
                  top: cajaBateo.dy - caraGrande / 2 - alturaEtiqueta,
                  _Ficha(
                    etiqueta: 'AL BATE',
                    jugador: bateador,
                    nombre: bateador == null ? s!.bateador!.nombre : '${bateador.nombres} ${bateador.apellidos}',
                    detalle: [
                      of.equipo.abreviatura,
                      if (turno != null) '${turno.orden}º${turno.posicion == null ? '' : ' ${turno.posicion}'}',
                    ].join(' · '),
                    descripcion: 'Batea ${izquierda ? 'a la derecha' : 'a la zurda'}',
                    cara: caraGrande,
                    color: colorOf,
                    onTap: abrir(bateador, of.equipo),
                  ),
                ),
              // El próximo, en su círculo de espera.
              if (siguiente != null)
                colocar(
                  circuloProximo.dx,
                  w * 0.23,
                  top: circuloProximo.dy - caraProximo / 2 - alturaEtiqueta,
                  _Ficha(
                    etiqueta: 'PRÓXIMO',
                    jugador: siguiente,
                    nombre: '${siguiente.nombres} ${siguiente.apellidos}',
                    cara: caraProximo,
                    color: colorOf,
                    tamanoNombre: 12,
                    onTap: abrir(siguiente, of.equipo),
                  ),
                ),
            ]),
          ),
        ),
      );
    });
  }
}

class _EnVivo extends StatelessWidget {
  const _EnVivo({required this.suspendido});

  final bool suspendido;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: suspendido ? Colors.black54 : ColoresMarca.rojo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          suspendido ? 'SUSPENDIDO' : 'EN VIVO',
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1),
        ),
      ]),
    );
  }
}

/// Cara de un jugador con su nombre debajo (y, si se da, una etiqueta encima).
class _Ficha extends StatelessWidget {
  const _Ficha({
    required this.nombre,
    required this.cara,
    required this.color,
    this.jugador,
    this.etiqueta,
    this.detalle,
    this.descripcion,
    this.tamanoNombre = 14,
    this.onTap,
  });

  final JugadorResumenLiga? jugador;
  final String nombre;
  final String? etiqueta;
  final String? detalle;
  final String? descripcion;
  final double cara;
  final Color color;
  final double tamanoNombre;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final contenido = Column(mainAxisSize: MainAxisSize.min, children: [
      if (etiqueta != null)
        SizedBox(
          height: 16,
          child: Text(
            etiqueta!,
            style: const TextStyle(
              color: ColoresMarca.amarillo,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
      Container(
        width: cara,
        height: cara,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: color, width: 3),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: ImagenApi(urlFoto: jugador?.fotoUrl, nombre: nombre, tamano: cara - 6, color: color),
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.55), borderRadius: BorderRadius.circular(6)),
        child: Text(
          nombre,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontFamily: FuentesLbc.titular,
            fontWeight: FontWeight.w700,
            fontSize: tamanoNombre,
            height: 1.05,
          ),
        ),
      ),
      if (detalle != null)
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            detalle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ),
    ]);
    return Semantics(
      label: descripcion,
      button: onTap != null,
      child: MouseRegion(
        cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
        child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: contenido),
      ),
    );
  }
}

/// Dibujo del terreno: césped, tierra del cuadro, líneas, montículo, cajas de bateo,
/// círculos de espera y las bases (las ocupadas en amarillo).
class _Terreno extends CustomPainter {
  _Terreno({
    required this.home,
    required this.bases,
    required this.monticulo,
    required this.ocupadas,
    required this.cajas,
    required this.circulos,
    required this.escala,
  });

  final Offset home;
  final List<Offset> bases; // primera, segunda, tercera
  final Offset monticulo;
  final List<bool> ocupadas;
  final List<Offset> cajas;
  final List<Offset> circulos;
  final double escala;

  static const _tierra = Color(0xFFC4935F);
  static const _cesped = Color(0xFF11793F);

  @override
  void paint(Canvas canvas, Size size) {
    final w = escala;
    final (primera, segunda, tercera) = (bases[0], bases[1], bases[2]);

    // Franjas de corte del césped.
    final franja = Paint()..color = Colors.white.withValues(alpha: 0.035);
    final alto = size.height / 12;
    for (var i = 0; i < 12; i += 2) {
      canvas.drawRect(Rect.fromLTWH(0, i * alto, size.width, alto), franja);
    }

    // Tierra del cuadro: un abanico desde el home que pasa por detrás de segunda.
    final abierto = w * 0.075;
    final f = primera + Offset(abierto, 0);
    final t = tercera - Offset(abierto, 0);
    final tierra = Paint()..color = _tierra;
    canvas.drawPath(
      Path()
        ..moveTo(home.dx, home.dy + abierto)
        ..lineTo(f.dx, f.dy)
        ..arcToPoint(t, radius: Radius.circular((f.dx - t.dx) / 2), clockwise: false)
        ..close(),
      tierra,
    );

    // Césped interior.
    Offset hacia(Offset p, double k) => Offset.lerp(monticulo, p, k)!;
    canvas.drawPath(
      Path()
        ..addPolygon([hacia(home, 0.72), hacia(primera, 0.72), hacia(segunda, 0.72), hacia(tercera, 0.72)], true),
      Paint()..color = _cesped,
    );

    // Tierra del home y del montículo.
    canvas.drawCircle(home, w * 0.11, tierra);
    canvas.drawCircle(monticulo, w * 0.07, tierra);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: monticulo, width: w * 0.045, height: w * 0.01), const Radius.circular(1)),
      Paint()..color = Colors.white,
    );

    // Líneas de foul y caminos entre bases.
    final cal = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(home, home + (primera - home) * 4, cal);
    canvas.drawLine(home, home + (tercera - home) * 4, cal);
    canvas.drawPath(
      Path()..addPolygon([primera, segunda, tercera], false),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.45)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // Cajas de bateo.
    final caja = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (final c in cajas) {
      canvas.drawRect(Rect.fromCenter(center: c, width: w * 0.08, height: w * 0.15), caja);
    }

    // Círculos de espera.
    for (final c in circulos) {
      canvas.drawCircle(c, w * 0.075, Paint()..color = Colors.white.withValues(alpha: 0.1));
      canvas.drawCircle(
        c,
        w * 0.075,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    // Bases: las ocupadas brillan en amarillo.
    final lado = w * 0.032;
    for (final (i, b) in bases.indexed) {
      final rombo = Path()
        ..addPolygon([b + Offset(0, -lado), b + Offset(lado, 0), b + Offset(0, lado), b + Offset(-lado, 0)], true);
      canvas.drawPath(rombo.shift(const Offset(0, 2)), Paint()..color = Colors.black26);
      if (ocupadas[i]) {
        canvas.drawCircle(
          b,
          lado * 1.8,
          Paint()
            ..color = ColoresMarca.amarillo.withValues(alpha: 0.55)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
      }
      canvas.drawPath(rombo, Paint()..color = ocupadas[i] ? ColoresMarca.amarillo : Colors.white);
    }

    // Home: el pentágono.
    final s = w * 0.028;
    canvas.drawPath(
      Path()
        ..addPolygon([
          home + Offset(-s, -s * 0.7),
          home + Offset(s, -s * 0.7),
          home + Offset(s, s * 0.2),
          home + Offset(0, s),
          home + Offset(-s, s * 0.2),
        ], true),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_Terreno old) =>
      old.escala != escala || !listEquals(old.ocupadas, ocupadas) || old.home != home;
}
