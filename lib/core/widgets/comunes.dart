import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../tema/tema_lbc.dart';

/// Sección con título escrito como pregunta ("¿Quién lidera la liga?") y contenido.
class Seccion extends StatelessWidget {
  const Seccion({
    super.key,
    required this.titulo,
    required this.child,
    this.subtitulo,
    this.accion,
    this.icono,
  });

  final String titulo;
  final String? subtitulo;
  final Widget child;
  final Widget? accion;
  final IconData? icono;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (icono != null) ...[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: esquema.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icono, size: 17, color: esquema.primary),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: tema.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    if (subtitulo != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          subtitulo!,
                          style: tema.textTheme.bodySmall?.copyWith(
                            color: esquema.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              ?accion,
            ],
          ),
          const SizedBox(height: 8),
          // Subrayado de marca: trazo amarillo corto sobre una regla fina.
          Row(
            children: [
              Container(
                width: 28,
                height: 3,
                decoration: BoxDecoration(
                  color: ColoresMarca.amarillo,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: Container(height: 1, color: esquema.outlineVariant),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

/// Cifra con etiqueta (p. ej. "12" / "Jonrones"). [referencia] = texto de contexto opcional.
class Cifra extends StatelessWidget {
  const Cifra({
    super.key,
    required this.valor,
    required this.etiqueta,
    this.referencia,
    this.destacada = false,
  });

  final String valor;
  final String etiqueta;
  final String? referencia;
  final bool destacada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    // La cifra destacada es una placa de tablero: verde noche con el valor en
    // amarillo. Las demás, tarjetas blancas con borde fino.
    final colorValor = destacada ? ColoresMarca.amarillo : esquema.onSurface;
    final colorEtiqueta = destacada
        ? ColoresMarca.tintaBarra
        : esquema.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
      decoration: BoxDecoration(
        color: destacada ? null : esquema.surfaceContainerLowest,
        gradient: destacada ? ColoresMarca.tablero : null,
        borderRadius: BorderRadius.circular(RadioLbc.tarjeta),
        border: destacada ? null : Border.all(color: esquema.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            valor,
            style: estiloMarcador(tema.textTheme.headlineMedium)
                ?.copyWith(fontSize: 30, color: colorValor),
          ),
          const SizedBox(height: 4),
          Text(
            etiqueta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: estiloEtiqueta(tema.textTheme.labelMedium)
                ?.copyWith(color: colorEtiqueta, letterSpacing: 0.6),
          ),
          if (referencia != null)
            Text(
              referencia!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: tema.textTheme.labelSmall?.copyWith(
                color: destacada
                    ? ColoresMarca.tintaBarra.withValues(alpha: 0.75)
                    : esquema.onSurfaceVariant,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

/// Rejilla adaptable de cifras: 2 columnas en móvil, más en pantallas anchas.
class RejillaCifras extends StatelessWidget {
  const RejillaCifras({super.key, required this.hijos, this.anchoMinimo = 140});

  final List<Widget> hijos;
  final double anchoMinimo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final columnas = (c.maxWidth / anchoMinimo).floor().clamp(2, 6);
        final ancho = (c.maxWidth - (columnas - 1) * 8) / columnas;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final h in hijos) SizedBox(width: ancho, child: h)],
        );
      },
    );
  }
}

/// Franja vertical con el color del equipo (identidad que no depende solo del color:
/// siempre va junto al nombre).
class FranjaColor extends StatelessWidget {
  const FranjaColor({super.key, required this.color, this.alto = 36});

  final Color color;
  final double alto;

  @override
  Widget build(BuildContext context) => Container(
    width: 5,
    height: alto,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

/// Contenedor centrado con ancho máximo para que en web/tablet no se estire.
class AnchoMaximo extends StatelessWidget {
  const AnchoMaximo({super.key, required this.child, this.ancho = 1000});

  final Widget child;
  final double ancho;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ancho),
      child: child,
    ),
  );
}

/// Formatos en español.
abstract final class Formato {
  static final _fecha = DateFormat("EEE d 'de' MMM", 'es');
  static final _fechaLarga = DateFormat("EEEE d 'de' MMMM 'de' y", 'es');
  static final _decimal = NumberFormat('0.00', 'es');
  static final _pct = NumberFormat('.000', 'es');

  static String fecha(DateTime? f) =>
      f == null ? 'Sin fecha' : _fecha.format(f);
  static String fechaLarga(DateTime? f) =>
      f == null ? 'Sin fecha' : _fechaLarga.format(f);

  /// "14:30" desde "14:30:00".
  static String hora(String? h) =>
      h == null || h.length < 5 ? '' : h.substring(0, 5);

  static String decimal(num? v) => v == null ? '—' : _decimal.format(v);

  /// Porcentaje de victorias al estilo béisbol: ",625".
  static String promedio(num? v) =>
      v == null ? '—' : (v >= 1 ? '1,000' : _pct.format(v));

  static String porcentaje(num? v) =>
      v == null ? '—' : '${(v * 100).round()} %';

  static String conSigno(int v) => v > 0 ? '+$v' : '$v';
}
