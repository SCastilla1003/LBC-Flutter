import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import 'base_graficas.dart';

class ZonaMedidor {
  const ZonaMedidor({required this.hasta, required this.color, required this.nombre});

  final double hasta;
  final Color color;
  final String nombre;
}

/// Medidor semicircular con zonas de color y aguja animada.
/// [zonas] van de [minimo] en adelante, cada una hasta su [ZonaMedidor.hasta].
/// Si [zonas] está vacío, el arco se rellena hasta el valor con [colorRelleno].
class Medidor extends StatelessWidget {
  const Medidor({
    super.key,
    required this.valor,
    required this.minimo,
    required this.maximo,
    required this.etiqueta,
    required this.formato,
    this.zonas = const [],
    this.colorRelleno,
    this.referencia,
    this.ancho = 180,
  });

  final double? valor;
  final double minimo;
  final double maximo;
  final String etiqueta;
  final String Function(double v) formato;
  final List<ZonaMedidor> zonas;
  final Color? colorRelleno;

  /// Marca opcional (p. ej. el promedio de la liga).
  final double? referencia;
  final double ancho;

  ZonaMedidor? get _zonaActual {
    if (valor == null) return null;
    for (final z in zonas) {
      if (valor! <= z.hasta) return z;
    }
    return zonas.isEmpty ? null : zonas.last;
  }

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final tema = Theme.of(context);
    final zona = _zonaActual;
    return Semantics(
      label: '$etiqueta ${valor == null ? 'sin dato' : formato(valor!)}${zona != null ? ', ${zona.nombre}' : ''}',
      child: EntradaAnimada(
        clave: '$valor-$maximo',
        duracion: const Duration(milliseconds: 1300),
        builder: (context, t) => SizedBox(
          width: ancho,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              width: ancho,
              height: ancho * 0.58,
              child: CustomPaint(
                painter: _PintorMedidor(
                  valor: valor == null ? null : minimo + (valor!.clamp(minimo, maximo) - minimo) * t,
                  minimo: minimo,
                  maximo: maximo,
                  zonas: zonas,
                  relleno: colorRelleno,
                  fondo: e.neutro.withValues(alpha: 0.5),
                  aguja: tema.colorScheme.onSurface,
                  referencia: referencia,
                  colorReferencia: e.eje,
                  superficie: e.superficie,
                ),
                child: Align(
                  alignment: const Alignment(0, 0.75),
                  child: Text(
                    valor == null ? '—' : formato(valor! * t),
                    style: estiloCifra(tema.textTheme.titleLarge)?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(etiqueta, style: e.etiqueta),
            if (zona != null)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: zona.color.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(8)),
                child: Text(zona.nombre, style: e.etiquetaSuave.copyWith(fontWeight: FontWeight.w700)),
              ),
          ]),
        ),
      ),
    );
  }
}

class _PintorMedidor extends CustomPainter {
  _PintorMedidor({
    required this.valor,
    required this.minimo,
    required this.maximo,
    required this.zonas,
    required this.relleno,
    required this.fondo,
    required this.aguja,
    required this.referencia,
    required this.colorReferencia,
    required this.superficie,
  });

  final Color superficie;
  final double? valor;
  final double minimo;
  final double maximo;
  final List<ZonaMedidor> zonas;
  final Color? relleno;
  final Color fondo;
  final Color aguja;
  final double? referencia;
  final Color colorReferencia;

  double _angulo(double v) => math.pi + math.pi * ((v - minimo) / (maximo - minimo)).clamp(0.0, 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    final grosor = size.width * 0.09;
    final radio = size.width / 2 - grosor / 2;
    final centro = Offset(size.width / 2, size.height - 4);
    final rect = Rect.fromCircle(center: centro, radius: radio);
    final pincel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = grosor;

    canvas.drawArc(rect, math.pi, math.pi, false, pincel..color = fondo);
    if (zonas.isNotEmpty) {
      var desde = minimo;
      for (final z in zonas) {
        final hasta = z.hasta.clamp(minimo, maximo);
        if (hasta > desde) {
          canvas.drawArc(rect, _angulo(desde) + 0.015, _angulo(hasta) - _angulo(desde) - 0.03, false,
              pincel..color = z.color.withValues(alpha: 0.85));
        }
        desde = hasta;
      }
    } else if (relleno != null && valor != null) {
      canvas.drawArc(rect, math.pi, _angulo(valor!) - math.pi, false, pincel..color = relleno!..strokeCap = StrokeCap.round);
    }

    if (referencia != null) {
      final a = _angulo(referencia!);
      final p1 = centro + Offset(math.cos(a), math.sin(a)) * (radio - grosor / 2 - 2);
      final p2 = centro + Offset(math.cos(a), math.sin(a)) * (radio + grosor / 2 + 2);
      canvas.drawLine(p1, p2, Paint()..color = colorReferencia..strokeWidth = 2);
    }

    if (valor != null && zonas.isNotEmpty) {
      final a = _angulo(valor!);
      final punto = centro + Offset(math.cos(a), math.sin(a)) * radio;
      canvas.drawCircle(punto, grosor * 0.75, Paint()..color = superficie);
      canvas.drawCircle(punto, grosor * 0.55, Paint()..color = aguja);
    }
  }

  @override
  bool shouldRepaint(_PintorMedidor old) => old.valor != valor || old.maximo != maximo;
}

/// Zonas buena / media / mala a partir de la referencia de la liga (mín., promedio, máx.)
/// para métricas donde menos es mejor (ERA, WHIP).
List<ZonaMedidor> zonasMenorEsMejor(BuildContext context, {required double minimo, required double promedio, required double maximo}) {
  final e = EstiloGrafica(context);
  final corteBueno = minimo + (promedio - minimo) * 0.6;
  final corteMalo = promedio + (maximo - promedio) * 0.4;
  return [
    ZonaMedidor(hasta: corteBueno, color: e.victoria, nombre: 'Élite'),
    ZonaMedidor(hasta: corteMalo, color: e.advertencia, nombre: 'Promedio'),
    ZonaMedidor(hasta: double.infinity, color: ColoresEstado.derrota, nombre: 'Alta'),
  ];
}
