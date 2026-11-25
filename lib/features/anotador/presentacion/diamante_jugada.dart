import 'package:flutter/material.dart';

import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../liga/datos/juego_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';

/// Diamante para anotar a dónde llega cada corredor: las caras están en su base y se arrastran
/// a la base a la que llegaron (o se toca la cara y luego la base). Abajo a la izquierda está
/// el out y abajo a la derecha las que anotan.
///
/// [destino]: desde (0 = bateador, 1..3 = base) → hasta (1..3 = base, 4 = anota, null = out).
class DiamanteJugada extends StatefulWidget {
  const DiamanteJugada({
    super.key,
    required this.estado,
    required this.destino,
    required this.permitido,
    required this.alMover,
  });

  final EstadoJuego estado;
  final Map<int, int?> destino;
  final bool Function(int desde, int? hasta) permitido;
  final void Function(int desde, int? hasta) alMover;

  @override
  State<DiamanteJugada> createState() => _DiamanteJugadaState();
}

/// Lugar al que se puede llevar a un jugador: una base, home (anota) o el out.
sealed class _Lugar {
  const _Lugar();
  int? get hasta;
}

class _Base extends _Lugar {
  const _Base(this.base);
  final int base;
  @override
  int get hasta => base;
}

class _Out extends _Lugar {
  const _Out();
  @override
  int? get hasta => null;
}

class _DiamanteJugadaState extends State<DiamanteJugada> {
  /// Jugador tocado, a la espera de que se toque su base.
  int? _elegido;

  EstadoJuego get _e => widget.estado;

  int? _id(int desde) => desde == 0 ? _e.partido.situacion?.bateador?.id : _e.bases[desde];

  JugadorResumenLiga? _jugador(int desde) {
    final id = _id(desde);
    return _e.ofensiva.orden.map((t) => t.jugador).whereType<JugadorResumenLiga>().where((j) => j.id == id).firstOrNull;
  }

  String _nombreCorto(int desde) {
    final j = _jugador(desde);
    if (j != null) return j.apellidos.split(' ').first;
    final n = _e.nombre(_id(desde));
    return n.isEmpty ? (desde == 0 ? 'Bateador' : 'Corredor') : n.split(' ').last;
  }

  String _nombre(int desde) {
    final n = _e.nombre(_id(desde));
    return n.isEmpty ? (desde == 0 ? 'Bateador' : 'Corredor') : n;
  }

  void _mover(int desde, int? hasta) {
    if (!widget.permitido(desde, hasta)) return;
    setState(() => _elegido = null);
    widget.alMover(desde, hasta);
  }

  @override
  Widget build(BuildContext context) {
    final color = ColoresEquipo.de(context, _e.ofensiva.equipo.color);
    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth.clamp(260.0, 440.0);
      final h = w * 1.08;
      Offset en(double x, double y) => Offset(w * x, h * y);
      final bases = {1: en(0.84, 0.56), 2: en(0.5, 0.30), 3: en(0.16, 0.56), 4: en(0.5, 0.80)};
      final cara = (w * 0.13).clamp(40.0, 54.0);
      final radio = w * 0.08;
      final altoZona = cara + 36;
      final zonaOut = Rect.fromLTWH(w * 0.02, h - altoZona - 6, w * 0.30, altoZona);
      final zonaAnota = Rect.fromLTWH(w * 0.68, h - altoZona - 6, w * 0.30, altoZona);

      // Dónde va cada cara: encima de su base, o dentro de la zona de out / de anotadas.
      final grupos = <Object, List<int>>{};
      for (final MapEntry(key: desde, value: hasta) in widget.destino.entries) {
        grupos.putIfAbsent(hasta ?? 'out', () => []).add(desde);
      }
      final fichas = <Widget>[];
      grupos.forEach((lugar, quienes) {
        quienes.sort((a, b) => b.compareTo(a));
        for (final (k, desde) in quienes.indexed) {
          final Offset centro;
          if (lugar == 'out' || lugar == 4) {
            final zona = lugar == 'out' ? zonaOut : zonaAnota;
            final paso = zona.width / (quienes.length + 1);
            centro = Offset(zona.left + paso * (k + 1), zona.top + 14 + cara / 2);
          } else {
            final b = bases[lugar]!;
            final desfase = (k - (quienes.length - 1) / 2) * (cara + 6);
            // Encima de la base, sin taparla: así se puede soltar otra cara sobre ella.
            centro = Offset(b.dx + desfase, b.dy - radio - cara / 2 - 20);
          }
          fichas.add(Positioned(
            left: (centro.dx - cara / 2 - 14).clamp(0.0, w - cara - 28),
            top: (centro.dy - cara / 2).clamp(0.0, h - cara - 18),
            width: cara + 28,
            child: _fichaArrastrable(desde, cara, color),
          ));
        }
      });

      final arrastrando = _elegido;
      Widget destinoTocable(_Lugar lugar, Rect zona, Widget dibujo) => Positioned.fromRect(
            rect: zona,
            child: DragTarget<int>(
              onWillAcceptWithDetails: (d) => widget.permitido(d.data, lugar.hasta),
              onAcceptWithDetails: (d) => _mover(d.data, lugar.hasta),
              builder: (context, candidatos, rechazados) {
                final resaltar = candidatos.isNotEmpty ||
                    (arrastrando != null && widget.permitido(arrastrando, lugar.hasta));
                return Semantics(
                  button: arrastrando != null,
                  label: switch (lugar) {
                    _Out() => 'Out',
                    _Base(base: 4) => 'Anota',
                    _Base(:final base) => '$baseª base',
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: arrastrando == null ? null : () => _mover(arrastrando, lugar.hasta),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        shape: lugar is _Base && lugar.base != 4 ? BoxShape.circle : BoxShape.rectangle,
                        borderRadius: lugar is _Base && lugar.base != 4 ? null : BorderRadius.circular(12),
                        color: resaltar ? ColoresMarca.amarillo.withValues(alpha: 0.28) : null,
                        border: resaltar ? Border.all(color: ColoresMarca.amarillo, width: 2) : null,
                      ),
                      child: dibujo,
                    ),
                  ),
                );
              },
            ),
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
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned.fill(
                child: ExcludeSemantics(child: CustomPaint(painter: _Cuadro(bases: bases, escala: w))),
              ),
              // Las bases y home se pueden tocar o recibir una cara.
              for (final MapEntry(key: b, value: p) in bases.entries)
                destinoTocable(
                  _Base(b),
                  b == 4
                      ? Rect.fromCenter(center: p, width: radio * 2.6, height: radio * 2)
                      : Rect.fromCircle(center: p, radius: radio),
                  const SizedBox.expand(),
                ),
              destinoTocable(const _Out(), zonaOut, _rotuloZona('OUT', ColoresMarca.rojoClaro)),
              destinoTocable(const _Base(4), zonaAnota, _rotuloZona('ANOTA', ColoresMarca.amarillo)),
              ...fichas,
            ]),
          ),
        ),
      );
    });
  }

  Widget _rotuloZona(String texto, Color color) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.7), width: 1.5),
          color: Colors.black.withValues(alpha: 0.18),
        ),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 1),
        child: Text(
          texto,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.2),
        ),
      );

  Widget _fichaArrastrable(int desde, double cara, Color color) {
    final elegido = _elegido == desde;
    Widget ficha({bool sombra = true}) => Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: cara,
            height: cara,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: elegido ? ColoresMarca.amarillo : color, width: elegido ? 4 : 3),
              boxShadow: [
                if (sombra) const BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 3)),
                if (elegido) BoxShadow(color: ColoresMarca.amarillo.withValues(alpha: 0.7), blurRadius: 14),
              ],
            ),
            child: ImagenApi(
              urlFoto: _jugador(desde)?.fotoUrl,
              nombre: _nombre(desde),
              tamano: cara - (elegido ? 8 : 6),
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(5)),
            child: Text(
              _nombreCorto(desde),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ]);
    return Semantics(
      button: true,
      selected: elegido,
      label: '${_nombre(desde)} · ${desde == 0 ? 'bateador' : 'en $desdeª'}',
      child: Draggable<int>(
        data: desde,
        feedback: Material(color: Colors.transparent, child: SizedBox(width: cara + 28, child: ficha())),
        childWhenDragging: Opacity(opacity: 0.3, child: ficha(sombra: false)),
        onDragStarted: () => setState(() => _elegido = null),
        child: GestureDetector(
          onTap: () => setState(() => _elegido = elegido ? null : desde),
          child: MouseRegion(cursor: SystemMouseCursors.grab, child: ficha()),
        ),
      ),
    );
  }
}

/// Césped, tierra del cuadro, líneas, montículo y bases.
class _Cuadro extends CustomPainter {
  _Cuadro({required this.bases, required this.escala});

  final Map<int, Offset> bases;
  final double escala;

  @override
  void paint(Canvas canvas, Size size) {
    final w = escala;
    final (primera, segunda, tercera, home) = (bases[1]!, bases[2]!, bases[3]!, bases[4]!);
    final monticulo = Offset(home.dx, (segunda.dy + home.dy) / 2);
    const tierra = Color(0xFFC4935F);
    final abierto = w * 0.07;
    canvas.drawPath(
      Path()
        ..moveTo(home.dx, home.dy + abierto)
        ..lineTo(primera.dx + abierto, primera.dy)
        ..lineTo(segunda.dx, segunda.dy - abierto)
        ..lineTo(tercera.dx - abierto, tercera.dy)
        ..close(),
      Paint()..color = tierra,
    );
    Offset hacia(Offset p) => Offset.lerp(monticulo, p, 0.7)!;
    canvas.drawPath(
      Path()..addPolygon([hacia(home), hacia(primera), hacia(segunda), hacia(tercera)], true),
      Paint()..color = const Color(0xFF11793F),
    );
    canvas.drawCircle(monticulo, w * 0.055, Paint()..color = tierra);
    canvas.drawRect(Rect.fromCenter(center: monticulo, width: w * 0.04, height: w * 0.01), Paint()..color = Colors.white);
    canvas.drawPath(
      Path()..addPolygon([home, primera, segunda, tercera], true),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    final lado = w * 0.03;
    for (final b in [primera, segunda, tercera]) {
      canvas.drawPath(
        Path()..addPolygon([b + Offset(0, -lado), b + Offset(lado, 0), b + Offset(0, lado), b + Offset(-lado, 0)], true),
        Paint()..color = Colors.white,
      );
    }
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
  bool shouldRepaint(_Cuadro old) => old.escala != escala;
}
