import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'base_graficas.dart';

/// Puesto de un equipo en cada fecha de la temporada (1 = líder).
class SerieBump {
  const SerieBump({
    required this.id,
    required this.nombre,
    required this.color,
    required this.puestos,
  });

  final String id;
  final String nombre;
  final Color color;

  /// Un puesto por fecha; todos los equipos tienen la misma cantidad de puntos.
  final List<int> puestos;

  int get actual => puestos.isEmpty ? 0 : puestos.last;
}

/// Resultado del cálculo del bump chart: series + etiquetas del eje X.
class CarreraLiderato {
  const CarreraLiderato({required this.series, required this.fechas});

  final List<SerieBump> series;
  final List<DateTime> fechas;

  bool get vacia => series.isEmpty || fechas.isEmpty;
}

/// Calcula la evolución de la tabla fecha por fecha.
///
/// [equipos]: (id, nombre, color).
/// [partidos]: (fecha, idLocal, idVisitante, carrerasLocal, carrerasVisitante).
/// Solo se consideran partidos con fecha. El orden de desempate es porcentaje,
/// diferencial de carreras, ganados y nombre (suficiente para una visualización;
/// la tabla oficial siempre viene de la API).
CarreraLiderato calcularCarreraLiderato({
  required List<(String, String, Color)> equipos,
  required List<(DateTime?, String?, String?, int, int)> partidos,
}) {
  if (equipos.isEmpty) return const CarreraLiderato(series: [], fechas: []);

  final nombres = {for (final e in equipos) e.$1: e.$2};
  final registros = {for (final e in equipos) e.$1: _RegistroBump()};

  final porFecha = <DateTime, List<(String?, String?, int, int)>>{};
  for (final (fecha, local, visitante, cl, cv) in partidos) {
    if (fecha == null || local == null || visitante == null) continue;
    if (!registros.containsKey(local) || !registros.containsKey(visitante)) {
      continue;
    }
    final dia = DateTime(fecha.year, fecha.month, fecha.day);
    porFecha.putIfAbsent(dia, () => []).add((local, visitante, cl, cv));
  }
  if (porFecha.isEmpty) return const CarreraLiderato(series: [], fechas: []);

  final fechas = porFecha.keys.toList()..sort();
  final puestos = {for (final e in equipos) e.$1: <int>[]};

  for (final fecha in fechas) {
    for (final (local, visitante, cl, cv) in porFecha[fecha]!) {
      final rl = registros[local!]!;
      final rv = registros[visitante!]!;
      rl.carrerasFavor += cl;
      rl.carrerasContra += cv;
      rv.carrerasFavor += cv;
      rv.carrerasContra += cl;
      if (cl == cv) {
        rl.empates++;
        rv.empates++;
      } else if (cl > cv) {
        rl.ganados++;
        rv.perdidos++;
      } else {
        rl.perdidos++;
        rv.ganados++;
      }
    }

    final orden = registros.keys.toList()
      ..sort((a, b) {
        final ra = registros[a]!;
        final rb = registros[b]!;
        final pct = rb.porcentaje.compareTo(ra.porcentaje);
        if (pct != 0) return pct;
        final dif = rb.diferencial.compareTo(ra.diferencial);
        if (dif != 0) return dif;
        final g = rb.ganados.compareTo(ra.ganados);
        if (g != 0) return g;
        return (nombres[a] ?? a).compareTo(nombres[b] ?? b);
      });

    for (var i = 0; i < orden.length; i++) {
      puestos[orden[i]]!.add(i + 1);
    }
  }

  final series = [
    for (final e in equipos)
      SerieBump(id: e.$1, nombre: e.$2, color: e.$3, puestos: puestos[e.$1]!),
  ]..sort((a, b) => a.actual.compareTo(b.actual));

  return CarreraLiderato(series: series, fechas: fechas);
}

class _RegistroBump {
  int ganados = 0;
  int perdidos = 0;
  int empates = 0;
  int carrerasFavor = 0;
  int carrerasContra = 0;

  double get porcentaje {
    final jugados = ganados + perdidos + empates;
    return jugados == 0 ? 0 : (ganados + empates * 0.5) / jugados;
  }

  int get diferencial => carrerasFavor - carrerasContra;
}

/// Bump chart: la pelea por el liderato. Cada línea es un equipo y su altura es
/// el puesto que ocupaba al terminar cada fecha. Toca la leyenda para aislar a un
/// equipo; volver a tocarlo muestra a todos.
class GraficaBump extends StatefulWidget {
  const GraficaBump({
    super.key,
    required this.carrera,
    this.alto = 280,
    this.onTap,
  });

  final CarreraLiderato carrera;
  final double alto;
  final ValueChanged<String>? onTap;

  @override
  State<GraficaBump> createState() => _GraficaBumpState();
}

class _GraficaBumpState extends State<GraficaBump> {
  String? _resaltado;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    final c = widget.carrera;
    if (c.vacia) {
      return Text('Aún no hay partidos jugados.', style: e.etiquetaSuave);
    }

    final totalEquipos = c.series.length;
    final lider = c.series.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final columnas = constraints.maxWidth < 560 ? 2 : 3;
            final ancho =
                (constraints.maxWidth - (columnas - 1) * 8) / columnas;
            return Wrap(
              spacing: 8,
              runSpacing: 0,
              children: [
                for (final s in c.series)
                  SizedBox(
                    width: ancho,
                    child: ItemLeyenda(
                      color: s.color,
                      texto: '${s.nombre} · ${s.actual}º',
                      linea: true,
                      activo: _resaltado == null || _resaltado == s.id,
                      onTap: () {
                        setState(
                          () => _resaltado = _resaltado == s.id ? null : s.id,
                        );
                        widget.onTap?.call(s.id);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Semantics(
          label:
              'Evolución de la tabla. Líder actual: ${lider.nombre}, '
              '$totalEquipos equipos, ${c.fechas.length} fechas.',
          child: SizedBox(
            height: widget.alto,
            child: EntradaAnimada(
              clave:
                  '${c.series.map((s) => '${s.id}${s.actual}').join()}-${c.fechas.length}-$_resaltado',
              duracion: const Duration(milliseconds: 1000),
              builder: (context, t) => CustomPaint(
                painter: _PintorBump(
                  carrera: c,
                  resaltado: _resaltado,
                  t: t,
                  rejilla: e.rejilla,
                  eje: e.eje,
                  superficie: e.superficie,
                  texto: e.ejeTexto,
                  totalEquipos: totalEquipos,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PintorBump extends CustomPainter {
  _PintorBump({
    required this.carrera,
    required this.resaltado,
    required this.t,
    required this.rejilla,
    required this.eje,
    required this.superficie,
    required this.texto,
    required this.totalEquipos,
  });

  final CarreraLiderato carrera;
  final String? resaltado;
  final double t;
  final Color rejilla;
  final Color eje;
  final Color superficie;
  final TextStyle texto;
  final int totalEquipos;

  static const _izquierda = 34.0;
  static const _derecha = 14.0;
  static const _arriba = 8.0;
  static const _abajo = 24.0;

  @override
  void paint(Canvas canvas, Size size) {
    final ancho = math.max(1.0, size.width - _izquierda - _derecha);
    final alto = math.max(1.0, size.height - _arriba - _abajo);
    final pasoY = totalEquipos > 1 ? alto / (totalEquipos - 1) : 0.0;

    // Rejilla y puestos.
    final linea = Paint()
      ..color = rejilla
      ..strokeWidth = 1;
    for (var i = 0; i < totalEquipos; i++) {
      final y = _arriba + i * pasoY;
      canvas.drawLine(
        Offset(_izquierda, y),
        Offset(_izquierda + ancho, y),
        linea,
      );
      _texto(canvas, '${i + 1}º', Offset(4, y - 6), texto.copyWith(color: eje));
    }

    // Fechas: primera, intermedia y última (sin encimarse).
    final n = carrera.fechas.length;
    final indices = <int>{
      0,
      n ~/ 4,
      n ~/ 2,
      (n * 3) ~/ 4,
      n - 1,
    }.where((i) => i >= 0 && i < n).toList()..sort();
    for (final i in indices) {
      final x = _x(i, ancho);
      final etiqueta = '${carrera.fechas[i].day}/${carrera.fechas[i].month}';
      final tp = TextPainter(
        text: TextSpan(
          text: etiqueta,
          style: texto.copyWith(color: eje),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - _abajo + 7));
    }

    // Líneas: las atenuadas primero y la resaltada al final.
    final orden = [
      ...carrera.series.where((s) => s.id != resaltado),
      ...carrera.series.where((s) => s.id == resaltado),
    ];
    for (final s in orden) {
      final activo = resaltado == null || resaltado == s.id;
      final color = s.color.withValues(
        alpha: activo ? (resaltado == s.id ? 1 : 0.82) : 0.10,
      );
      final path = Path();
      for (var i = 0; i < s.puestos.length; i++) {
        final x = _x(i, ancho);
        final destino = _y(s.puestos[i] - 1, pasoY);
        // Durante la entrada, las líneas suben desde el sótano de la tabla.
        final y = inicioY(alto, pasoY) + (destino - inicioY(alto, pasoY)) * t;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = resaltado == s.id ? 3.4 : 2.1
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );

      // Punto final con anillo de superficie.
      if (s.puestos.isNotEmpty) {
        final x = _x(s.puestos.length - 1, ancho);
        final y = _y(s.puestos.last - 1, pasoY);
        canvas.drawCircle(
          Offset(x, y),
          resaltado == s.id ? 6.2 : 4.6,
          Paint()..color = superficie,
        );
        canvas.drawCircle(
          Offset(x, y),
          resaltado == s.id ? 4.8 : 3.4,
          Paint()..color = color,
        );
      }
    }
  }

  double _x(int i, double ancho) =>
      _izquierda +
      (carrera.fechas.length <= 1
          ? ancho / 2
          : ancho * i / (carrera.fechas.length - 1));

  double _y(double indice, double pasoY) => _arriba + indice * pasoY;

  double inicioY(double alto, double pasoY) => _arriba + alto;

  void _texto(Canvas canvas, String s, Offset offset, TextStyle estilo) {
    final tp = TextPainter(
      text: TextSpan(text: s, style: estilo),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_PintorBump old) =>
      old.t != t ||
      old.resaltado != resaltado ||
      old.carrera != carrera ||
      old.rejilla != rejilla ||
      old.texto != texto;
}
