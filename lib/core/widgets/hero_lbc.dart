import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import 'logo_lbc.dart';

/// Portada de marca sobre superficie blanca, con una franja tricolor
/// (rojo, amarillo y verde) y el diamante dibujado en líneas finas.
///
/// El blanco es la base; el color aparece en la franja, el icono, las
/// pastillas y los detalles. En modo oscuro la portada se adapta al tema.
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
    final oscuro = tema.brightness == Brightness.dark;
    final tinta = tema.colorScheme.onSurface;
    final suave = tema.colorScheme.onSurfaceVariant;
    final cuerpo = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // La franja institucional es el acento de color de toda portada.
        Container(
          height: 5,
          decoration: const BoxDecoration(
            gradient: ColoresMarca.franjaInstitucional,
          ),
        ),
        CustomPaint(
          painter: _PatronEstadio(
            color: oscuro ? ColoresMarca.tintaBarra : ColoresMarca.rojo,
          ),
          child: Padding(
            padding: EdgeInsets.all(compacto ? 18 : 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 26,
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: ColoresMarca.franjaInstitucional,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              etiqueta.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: tema.textTheme.labelSmall?.copyWith(
                                color: oscuro
                                    ? ColoresMarca.rojoClaro
                                    : ColoresMarca.rojo,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (marca != null) ...[
                            marca!,
                            const SizedBox(width: 12),
                          ] else if (icono != null) ...[
                            Container(
                              width: compacto ? 38 : 44,
                              height: compacto ? 38 : 44,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColoresMarca.rojo,
                                    ColoresMarca.rojoOscuro,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: ColoresMarca.dorado.withValues(
                                    alpha: 0.8,
                                  ),
                                  width: 1.4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColoresMarca.rojo.withValues(
                                      alpha: oscuro ? 0.30 : 0.18,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                icono,
                                color: ColoresMarca.blanco,
                                size: compacto ? 21 : 25,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Text(
                              titulo,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  (compacto
                                          ? tema.textTheme.titleLarge
                                          : tema.textTheme.headlineMedium)
                                      ?.copyWith(
                                        color: tinta,
                                        fontWeight: FontWeight.w900,
                                        height: 1.04,
                                        letterSpacing: -0.5,
                                      ),
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
                          style: tema.textTheme.labelMedium!.copyWith(
                            color: tinta,
                          ),
                          child: contenido!,
                        ),
                      ],
                    ],
                  ),
                ),
                if (accion != null) ...[
                  const SizedBox(width: 16),
                  accion!,
                ] else if (onTap != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ColoresMarca.rojoSuave.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColoresMarca.rojo.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: ColoresMarca.rojoOscuro,
                      size: 18,
                    ),
                  ),
                ],
              ],
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: oscuro
                ? const [Color(0xFF251E1B), Color(0xFF2D2420)]
                : const [
                    ColoresMarca.blanco,
                    Color(0xFFFFFCF6),
                    Color(0xFFFFF7EA),
                  ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: oscuro
                ? tema.colorScheme.outlineVariant
                : ColoresMarca.rojo.withValues(alpha: 0.13),
          ),
          boxShadow: [
            BoxShadow(
              color: oscuro
                  ? Colors.black.withValues(alpha: 0.30)
                  : ColoresMarca.rojoProfundo.withValues(alpha: 0.07),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: ColoresMarca.rojo.withValues(alpha: 0.06),
            highlightColor: ColoresMarca.rojo.withValues(alpha: 0.03),
            child: cuerpo,
          ),
        ),
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
        const LogoLbc(tamano: 36, radio: 11, sombra: false),
        const SizedBox(width: 10),
        Text(
          texto,
          style: tema.textTheme.titleLarge?.copyWith(
            color: tema.colorScheme.onSurface,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

/// Pastilla suave para datos dentro de [HeroLbc]. Usa el amarillo de la liga
/// como fondo y deja el texto oscuro para mantener el contraste.
class PastillaHero extends StatelessWidget {
  const PastillaHero({super.key, required this.texto, this.icono});

  final String texto;
  final IconData? icono;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: esquema.secondaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: ColoresMarca.dorado.withValues(alpha: 0.45)),
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
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Campo de béisbol muy tenue: diamante, líneas de foul y arcos de outfield.
/// El trazo es intencionalmente bajo para que nunca compita con el texto.
class _PatronEstadio extends CustomPainter {
  _PatronEstadio({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Resplandor dorado en la esquina superior derecha.
    final brillo = Paint()
      ..shader =
          RadialGradient(
            colors: [
              ColoresMarca.dorado.withValues(alpha: 0.18),
              ColoresMarca.dorado.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.92, size.height * 0.05),
              radius: size.width * 0.52,
            ),
          );
    canvas.drawRect(Offset.zero & size, brillo);

    // Un halo verde de campo en la esquina inferior izquierda.
    final verdeCampo = Paint()
      ..shader =
          RadialGradient(
            colors: [
              ColoresMarca.verde.withValues(alpha: 0.08),
              ColoresMarca.verde.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.04, size.height * 1.02),
              radius: size.width * 0.52,
            ),
          );
    canvas.drawRect(Offset.zero & size, verdeCampo);

    final trazo = Paint()
      ..color = color.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final home = Offset(size.width * 0.84, size.height * 0.78);
    final radio = math.min(size.width * 0.42, size.height * 1.15);
    // Arcos de outfield.
    canvas.drawArc(
      Rect.fromCircle(center: home, radius: radio),
      math.pi * 1.06,
      math.pi * 0.68,
      false,
      trazo,
    );
    canvas.drawArc(
      Rect.fromCircle(center: home, radius: radio * 0.62),
      math.pi * 1.06,
      math.pi * 0.68,
      false,
      trazo..color = color.withValues(alpha: 0.06),
    );

    // Diamante.
    final centro = Offset(size.width * 0.86, size.height * 0.28);
    final d = math.min(size.width, size.height) * 0.19;
    final primera = centro + Offset(d, 0);
    final segunda = centro + Offset(0, -d);
    final tercera = centro + Offset(-d, 0);
    final homePlaca = centro + Offset(0, d);
    final campo = Path()
      ..moveTo(homePlaca.dx, homePlaca.dy)
      ..lineTo(primera.dx, primera.dy)
      ..lineTo(segunda.dx, segunda.dy)
      ..lineTo(tercera.dx, tercera.dy)
      ..close();
    canvas.drawPath(campo, Paint()..color = color.withValues(alpha: 0.03));
    canvas.drawPath(campo, trazo..color = color.withValues(alpha: 0.09));

    // Bases como pequeños cuadros.
    for (final base in [primera, segunda, tercera, homePlaca]) {
      canvas.save();
      canvas.translate(base.dx, base.dy);
      canvas.rotate(math.pi / 4);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 7, height: 7),
        trazo,
      );
      canvas.restore();
    }

    // Líneas de foul desde home.
    canvas.drawLine(
      homePlaca,
      homePlaca + Offset(size.width * 0.30, -size.height * 0.65),
      trazo,
    );
    canvas.drawLine(
      homePlaca,
      homePlaca + Offset(-size.width * 0.14, -size.height * 0.72),
      trazo,
    );

    // Costuras de béisbol en diagonal.
    final costura = Paint()
      ..color = color.withValues(alpha: 0.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final x = size.width * (0.08 + i * 0.12);
      final path = Path()
        ..moveTo(x, size.height)
        ..quadraticBezierTo(
          x + 24,
          size.height * 0.66,
          x + 8,
          size.height * 0.46,
        );
      canvas.drawPath(path, costura);
    }
  }

  @override
  bool shouldRepaint(_PatronEstadio old) => old.color != color;
}
