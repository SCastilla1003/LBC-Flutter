import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import 'logo_lbc.dart';

/// Portada de marca: tarjeta blanca con un lomo verde-amarillo (como el canto
/// de un cromo), titular condensado de tablero y el campo de béisbol dibujado
/// en líneas muy finas al fondo.
///
/// El blanco domina; el verde aporta la interacción y el amarillo el detalle.
/// En modo oscuro la portada se adapta al tema.
class HeroLbc extends StatelessWidget {
  const HeroLbc({
    super.key,
    required this.etiqueta,
    required this.titulo,
    this.subtitulo,
    this.icono,
    this.marca,
    this.accion,
    this.onTap,
    this.contenido,
    this.compacto = false,
  });

  final String etiqueta;
  final String titulo;
  final String? subtitulo;
  final IconData? icono;

  /// Reemplaza al icono cuando se quiere mostrar una marca (p. ej. el logo).
  final Widget? marca;
  final Widget? accion;
  final VoidCallback? onTap;
  final Widget? contenido;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    final oscuro = tema.brightness == Brightness.dark;
    final tinta = esquema.onSurface;
    final suave = esquema.onSurfaceVariant;
    final acento = esquema.primary;

    final textos = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 7,
                height: 7,
                color: ColoresMarca.amarillo,
              ),
            ),
            const SizedBox(width: 9),
            Flexible(
              child: Text(
                etiqueta.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: estiloEtiqueta(
                  tema.textTheme.labelSmall,
                )?.copyWith(color: acento, fontSize: 11.5, letterSpacing: 1.8),
              ),
            ),
          ],
        ),
        SizedBox(height: compacto ? 8 : 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (marca != null) ...[
              marca!,
              const SizedBox(width: 12),
            ] else if (icono != null) ...[
              _InsigniaIcono(icono: icono!, compacto: compacto),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                titulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    (compacto
                            ? tema.textTheme.headlineSmall
                            : tema.textTheme.headlineMedium)
                        ?.copyWith(color: tinta, height: 1.02),
              ),
            ),
          ],
        ),
        if (subtitulo != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitulo!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: tema.textTheme.bodyMedium?.copyWith(
              color: suave,
              height: 1.35,
            ),
          ),
        ],
        if (contenido != null) ...[
          const SizedBox(height: 14),
          DefaultTextStyle.merge(
            style: tema.textTheme.labelMedium!.copyWith(color: tinta),
            child: contenido!,
          ),
        ],
      ],
    );

    final cuerpo = Stack(
      children: [
        // Lomo del cromo: del verde del campo al amarillo de los trofeos.
        const Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 6,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: ColoresMarca.franjaInstitucionalVertical,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: CustomPaint(
            painter: _PatronEstadio(
              color: oscuro ? ColoresMarca.verdeNeon : ColoresMarca.verdeCampo,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                compacto ? 16 : 20,
                compacto ? 16 : 20,
                compacto ? 16 : 20,
                compacto ? 16 : 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: textos),
                  if (accion != null) ...[
                    const SizedBox(width: 16),
                    accion!,
                  ] else if (onTap != null) ...[
                    const SizedBox(width: 12),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: esquema.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: esquema.onPrimary,
                        size: 19,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: oscuro ? esquema.surfaceContainer : ColoresMarca.blanco,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: esquema.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: oscuro ? 0.28 : 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: acento.withValues(alpha: 0.06),
            highlightColor: acento.withValues(alpha: 0.03),
            child: cuerpo,
          ),
        ),
      ),
    );
  }
}

/// Insignia del icono: placa verde noche con el icono en amarillo.
class _InsigniaIcono extends StatelessWidget {
  const _InsigniaIcono({required this.icono, required this.compacto});

  final IconData icono;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final lado = compacto ? 40.0 : 46.0;
    return Container(
      width: lado,
      height: lado,
      decoration: BoxDecoration(
        gradient: ColoresMarca.tablero,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColoresMarca.verdeNoche.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icono,
        color: ColoresMarca.amarillo,
        size: compacto ? 21 : 24,
      ),
    );
  }
}

/// Logo institucional + nombre. Pensado para la barra superior.
class MarcaTitulo extends StatelessWidget {
  const MarcaTitulo({super.key, this.texto = 'LBC'});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LogoLbc(tamano: 34, radio: 9, sombra: false),
        const SizedBox(width: 10),
        Text(
          texto,
          style: tema.textTheme.titleLarge?.copyWith(
            color: tema.colorScheme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: ColoresMarca.amarillo,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

/// Pastilla para datos dentro de [HeroLbc]. Fondo amarillo suave con texto
/// oscuro para mantener el contraste.
class PastillaHero extends StatelessWidget {
  const PastillaHero({super.key, required this.texto, this.icono});

  final String texto;
  final IconData? icono;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: esquema.secondaryContainer,
        borderRadius: BorderRadius.circular(RadioLbc.pildora),
        border: Border.all(color: esquema.secondary.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icono != null) ...[
            Icon(icono, size: 13, color: esquema.onSecondaryContainer),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              texto,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: esquema.onSecondaryContainer,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Campo de béisbol muy tenue: arcos de outfield, diamante, líneas de foul y
/// las costuras de una pelota. El trazo es bajo para no competir con el texto.
class _PatronEstadio extends CustomPainter {
  _PatronEstadio({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Luz amarilla de estadio en la esquina superior derecha.
    final brillo = Paint()
      ..shader =
          RadialGradient(
            colors: [
              ColoresMarca.amarillo.withValues(alpha: 0.16),
              ColoresMarca.amarillo.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.96, 0),
              radius: size.width * 0.45,
            ),
          );
    canvas.drawRect(Offset.zero & size, brillo);

    final trazo = Paint()
      ..color = color.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    // Arcos de outfield desde home (abajo a la derecha).
    final home = Offset(size.width * 0.86, size.height * 1.05);
    final radio = math.min(size.width * 0.40, size.height * 1.25);
    for (final (f, a) in [(1.0, 0.10), (0.66, 0.07)]) {
      canvas.drawArc(
        Rect.fromCircle(center: home, radius: radio * f),
        math.pi * 1.1,
        math.pi * 0.62,
        false,
        trazo..color = color.withValues(alpha: a),
      );
    }

    // Diamante con sus bases.
    final centro = Offset(size.width * 0.86, size.height * 0.62);
    final d = math.min(size.width, size.height) * 0.17;
    final primera = centro + Offset(d, 0);
    final segunda = centro + Offset(0, -d);
    final tercera = centro + Offset(-d, 0);
    final placa = centro + Offset(0, d);
    final campo = Path()
      ..moveTo(placa.dx, placa.dy)
      ..lineTo(primera.dx, primera.dy)
      ..lineTo(segunda.dx, segunda.dy)
      ..lineTo(tercera.dx, tercera.dy)
      ..close();
    canvas.drawPath(campo, Paint()..color = color.withValues(alpha: 0.035));
    canvas.drawPath(campo, trazo..color = color.withValues(alpha: 0.10));
    for (final base in [primera, segunda, tercera]) {
      canvas.save();
      canvas.translate(base.dx, base.dy);
      canvas.rotate(math.pi / 4);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 6, height: 6),
        Paint()..color = ColoresMarca.amarillo.withValues(alpha: 0.35),
      );
      canvas.restore();
    }

    // Costuras de pelota: dos arcos con puntadas, abajo a la izquierda.
    final costura = Paint()
      ..color = color.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final c = Offset(size.width * 0.02, size.height * 1.15);
    final r = size.height * 0.75;
    for (final signo in [-1.0, 1.0]) {
      final centroArco = c + Offset(signo * r * 0.55, 0);
      final rect = Rect.fromCircle(center: centroArco, radius: r * 0.7);
      final inicio = signo < 0 ? -math.pi * 0.35 : -math.pi * 0.65;
      canvas.drawArc(
        rect,
        inicio,
        signo < 0 ? -math.pi * 0.3 : math.pi * 0.3,
        false,
        costura,
      );
      for (var i = 0; i <= 5; i++) {
        final ang = inicio + (signo < 0 ? -1 : 1) * math.pi * 0.3 * i / 5;
        final p = centroArco + Offset(math.cos(ang), math.sin(ang)) * r * 0.7;
        final n = Offset(math.cos(ang), math.sin(ang));
        final t = Offset(-n.dy, n.dx);
        canvas.drawLine(p - n * 4 - t * 2, p + n * 4 + t * 2, costura);
      }
    }
  }

  @override
  bool shouldRepaint(_PatronEstadio old) => old.color != color;
}
