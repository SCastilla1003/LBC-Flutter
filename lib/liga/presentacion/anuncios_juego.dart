import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/tema/tema_lbc.dart';
import '../datos/juego_repositorio.dart';

/// Recorrido de la pelota en una jugada.
enum Vuelo {
  /// Del lanzador al home (bola, strike, foul, ponche, base por bolas).
  lanzamiento,

  /// Rodado por el cuadro.
  rodado,

  /// Línea al jardín.
  linea,

  /// Elevado alto.
  elevado,

  /// Batazo largo a la brecha o a la esquina (doble, triple).
  largo,

  /// Por encima de la cerca.
  jonron,
}

/// Cartel que se muestra en el campo cuando pasa algo: "¡STRIKE!", "OUT", "¡JONRÓN!"...
class Anuncio {
  const Anuncio(this.titulo, this.color, {this.detalle, this.vuelo, this.grande = false});

  final String titulo;
  final Color color;

  /// Segunda línea, por ejemplo "¡2 CARRERAS!".
  final String? detalle;
  final Vuelo? vuelo;

  /// Jugadas importantes (jonrón, carreras): el cartel sale más grande.
  final bool grande;
}

int _carreras(String d) {
  final m = RegExp(r'Anotan? ([^.]*)\.').firstMatch(d);
  if (m == null) return 0;
  return m.group(1)!.split(',').where((n) => n.trim().isNotEmpty).length;
}

/// Qué anunciar para una acción del anotador (null = nada, como un cambio de jugador).
Anuncio? anuncioDe(AccionJuego a) {
  final d = a.descripcion;
  final t = d.toLowerCase();
  if (a.tipo == 'INICIO') return const Anuncio('¡PLAY BALL!', ColoresMarca.amarillo, grande: true);
  if (a.tipo == 'LANZAMIENTO') {
    if (t.startsWith('bola')) return const Anuncio('BOLA', ColoresMarca.verdeNeon, vuelo: Vuelo.lanzamiento);
    if (t.startsWith('strike')) return const Anuncio('¡STRIKE!', ColoresMarca.amarillo, vuelo: Vuelo.lanzamiento);
    if (t.startsWith('foul')) return const Anuncio('FOUL', Colors.white, vuelo: Vuelo.lanzamiento);
    return null;
  }
  if (a.tipo != 'JUGADA') return null;

  final carreras = _carreras(d);
  final detalle = carreras == 0 ? null : (carreras == 1 ? '¡CARRERA!' : '¡$carreras CARRERAS!');
  Anuncio con(String titulo, Color color, Vuelo? vuelo, {bool grande = false}) =>
      Anuncio(titulo, color, detalle: detalle, vuelo: vuelo, grande: grande || carreras > 0);

  if (t.contains('jonrón')) {
    return Anuncio(carreras == 4 ? '¡GRAND SLAM!' : '¡JONRÓN!', ColoresMarca.amarillo,
        detalle: detalle, vuelo: Vuelo.jonron, grande: true);
  }
  if (t.contains('doble play')) return con('DOBLE PLAY', ColoresMarca.rojoClaro, Vuelo.rodado);
  if (t.contains('triple')) return con('¡TRIPLE!', ColoresMarca.verdeNeon, Vuelo.largo);
  if (t.contains('doble')) return con('¡DOBLE!', ColoresMarca.verdeNeon, Vuelo.largo);
  if (t.contains('sencillo')) return con('¡HIT!', ColoresMarca.verdeNeon, Vuelo.linea);
  if (t.contains('ponche')) return con('¡PONCHE!', ColoresMarca.rojoClaro, Vuelo.lanzamiento);
  if (t.contains('base por bolas')) return con('BASE POR BOLAS', ColoresMarca.verdeNeon, Vuelo.lanzamiento);
  if (t.contains('golpeado')) return con('PELOTAZO', ColoresMarca.verdeNeon, Vuelo.lanzamiento);
  if (t.contains('elevado de sacrificio')) return con('SACRIFICIO', ColoresMarca.rojoClaro, Vuelo.elevado);
  if (t.contains('toque de sacrificio')) return con('SACRIFICIO', ColoresMarca.rojoClaro, Vuelo.rodado);
  if (t.contains('rolata')) return con('OUT', ColoresMarca.rojoClaro, Vuelo.rodado);
  if (t.contains('elevado') || t.contains('globo')) return con('OUT', ColoresMarca.rojoClaro, Vuelo.elevado);
  if (t.contains('línea')) return con('OUT', ColoresMarca.rojoClaro, Vuelo.linea);
  if (t.contains('bola ocupada')) return con('OUT', ColoresMarca.rojoClaro, Vuelo.rodado);
  if (t.contains('por error')) return con('¡ERROR!', ColoresMarca.amarillo, Vuelo.rodado);
  if (t.contains('base robada')) return con('BASE ROBADA', ColoresMarca.verdeNeon, null);
  if (t.contains('atrapado robando')) return con('OUT', ColoresMarca.rojoClaro, null);
  if (t.contains('descontrolado')) return con('WILD PITCH', ColoresMarca.amarillo, Vuelo.lanzamiento);
  if (t.contains('passed ball')) return con('PASSED BALL', ColoresMarca.amarillo, Vuelo.lanzamiento);
  if (t.contains('balk')) return con('BALK', ColoresMarca.amarillo, null);
  return detalle == null ? null : con(detalle, ColoresMarca.amarillo, null);
}

/// El cartel: entra rebotando, se queda un momento y se desvanece. Se pone con una clave
/// distinta por acción, así cada jugada lo vuelve a lanzar.
class CartelAnuncio extends StatefulWidget {
  const CartelAnuncio({super.key, required this.anuncio, this.retraso = Duration.zero});

  final Anuncio anuncio;

  /// Espera antes de salir (por ejemplo, a que la pelota llegue).
  final Duration retraso;

  @override
  State<CartelAnuncio> createState() => _CartelAnuncioState();
}

class _CartelAnuncioState extends State<CartelAnuncio> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: widget.retraso + Duration(milliseconds: widget.anuncio.grande ? 2200 : 1500),
  )..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = _c.duration!.inMilliseconds;
    final inicio = widget.retraso.inMilliseconds / total;
    final entrada = CurvedAnimation(
      parent: _c,
      curve: Interval(inicio, inicio + (1 - inicio) * 0.3, curve: Curves.elasticOut),
    );
    final salida = CurvedAnimation(parent: _c, curve: const Interval(0.8, 1, curve: Curves.easeIn));
    final a = widget.anuncio;
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, _) {
          if (_c.value < inicio || _c.isCompleted) return const SizedBox.shrink();
          return Opacity(
            opacity: (1 - salida.value).clamp(0, 1),
            child: Transform.scale(
              scale: 0.3 + 0.7 * entrada.value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.62),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: a.color.withValues(alpha: 0.85), width: 2),
                  boxShadow: [BoxShadow(color: a.color.withValues(alpha: 0.35), blurRadius: 18)],
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    a.titulo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: a.color,
                      fontFamily: FuentesLbc.titular,
                      fontWeight: FontWeight.w900,
                      fontSize: a.grande ? 34 : 26,
                      letterSpacing: 1.5,
                      height: 1.05,
                    ),
                  ),
                  if (a.detalle != null)
                    Text(
                      a.detalle!,
                      style: const TextStyle(
                        color: ColoresMarca.amarillo,
                        fontFamily: FuentesLbc.titular,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Pelota que vuela de [desde] a [hasta] en curva (más alta cuanto mayor [altura]) y gira.
class PelotaEnVuelo extends StatefulWidget {
  const PelotaEnVuelo({
    super.key,
    required this.desde,
    required this.hasta,
    required this.altura,
    required this.duracion,
    this.retraso = Duration.zero,
    this.tamano = 14,
  });

  final Offset desde;
  final Offset hasta;
  final double altura;
  final Duration duracion;
  final Duration retraso;
  final double tamano;

  @override
  State<PelotaEnVuelo> createState() => _PelotaEnVueloState();
}

class _PelotaEnVueloState extends State<PelotaEnVuelo> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: widget.retraso + widget.duracion)..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inicio = widget.retraso.inMilliseconds / _c.duration!.inMilliseconds;
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, _) {
          if (_c.value < inicio || _c.isCompleted) return const SizedBox.shrink();
          final t = Curves.easeOut.transform((_c.value - inicio) / (1 - inicio));
          final recta = Offset.lerp(widget.desde, widget.hasta, t)!;
          // Parábola: sube a la mitad del recorrido y baja al final.
          final p = recta - Offset(0, widget.altura * 4 * t * (1 - t));
          // La sombra se queda en el suelo; la pelota se agranda al subir.
          final s = widget.tamano * (1 + 0.5 * widget.altura / 200 * 4 * t * (1 - t));
          return Stack(clipBehavior: Clip.none, children: [
            if (widget.altura > 0)
              Positioned(
                left: recta.dx - widget.tamano / 2,
                top: recta.dy - widget.tamano / 4,
                child: Container(
                  width: widget.tamano,
                  height: widget.tamano / 2,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(widget.tamano),
                  ),
                ),
              ),
            Positioned(
              left: p.dx - s / 2,
              top: p.dy - s / 2,
              child: Transform.rotate(
                angle: t * math.pi * 6,
                child: Container(
                  width: s,
                  height: s,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: ClipOval(child: CustomPaint(painter: _Costuras())),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

/// Las costuras rojas de la pelota.
class _Costuras extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final pintura = Paint()
      ..color = ColoresMarca.rojo
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, size.width / 12);
    canvas.drawArc(Rect.fromCircle(center: Offset(-r * 0.55, r), radius: r * 0.95), -0.9, 1.8, false, pintura);
    canvas.drawArc(Rect.fromCircle(center: Offset(r * 2.55, r), radius: r * 0.95), math.pi - 0.9, 1.8, false, pintura);
  }

  @override
  bool shouldRepaint(_Costuras old) => false;
}
