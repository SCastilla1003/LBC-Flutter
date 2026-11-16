import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../tema/tema_lbc.dart';

/// Sección con título escrito como pregunta ("¿Quién lidera la liga?") y contenido.
class Seccion extends StatelessWidget {
  const Seccion({super.key, required this.titulo, required this.child, this.subtitulo, this.accion});

  final String titulo;
  final String? subtitulo;
  final Widget child;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titulo, style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                    if (subtitulo != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(subtitulo!,
                            style: tema.textTheme.bodySmall?.copyWith(color: tema.colorScheme.onSurfaceVariant)),
                      ),
                  ],
                ),
              ),
              ?accion,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Cifra con etiqueta (p. ej. "12" / "Jonrones"). [referencia] = texto de contexto opcional.
class Cifra extends StatelessWidget {
  const Cifra({super.key, required this.valor, required this.etiqueta, this.referencia, this.destacada = false});

  final String valor;
  final String etiqueta;
  final String? referencia;
  final bool destacada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: destacada ? tema.colorScheme.primaryContainer : tema.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(valor,
              style: estiloCifra(tema.textTheme.titleLarge)?.copyWith(
                fontWeight: FontWeight.w800,
                color: destacada ? tema.colorScheme.onPrimaryContainer : null,
              )),
          Text(etiqueta,
              style: tema.textTheme.labelMedium?.copyWith(
                  color: destacada ? tema.colorScheme.onPrimaryContainer : tema.colorScheme.onSurfaceVariant)),
          if (referencia != null)
            Text(referencia!,
                style: tema.textTheme.labelSmall?.copyWith(color: tema.colorScheme.onSurfaceVariant)),
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
    return LayoutBuilder(builder: (context, c) {
      final columnas = (c.maxWidth / anchoMinimo).floor().clamp(2, 6);
      final ancho = (c.maxWidth - (columnas - 1) * 8) / columnas;
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (final h in hijos) SizedBox(width: ancho, child: h)],
      );
    });
  }
}

/// Franja vertical con el color del equipo (identidad que no depende solo del color:
/// siempre va junto al nombre).
class FranjaColor extends StatelessWidget {
  const FranjaColor({super.key, required this.color, this.alto = 36});

  final Color color;
  final double alto;

  @override
  Widget build(BuildContext context) =>
      Container(width: 4, height: alto, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)));
}

/// Contenedor centrado con ancho máximo para que en web/tablet no se estire.
class AnchoMaximo extends StatelessWidget {
  const AnchoMaximo({super.key, required this.child, this.ancho = 1000});

  final Widget child;
  final double ancho;

  @override
  Widget build(BuildContext context) =>
      Center(child: ConstrainedBox(constraints: BoxConstraints(maxWidth: ancho), child: child));
}

/// Formatos en español.
abstract final class Formato {
  static final _fecha = DateFormat("EEE d 'de' MMM", 'es');
  static final _fechaLarga = DateFormat("EEEE d 'de' MMMM 'de' y", 'es');
  static final _decimal = NumberFormat('0.00', 'es');
  static final _pct = NumberFormat('.000', 'es');

  static String fecha(DateTime? f) => f == null ? 'Sin fecha' : _fecha.format(f);
  static String fechaLarga(DateTime? f) => f == null ? 'Sin fecha' : _fechaLarga.format(f);

  /// "14:30" desde "14:30:00".
  static String hora(String? h) => h == null || h.length < 5 ? '' : h.substring(0, 5);

  static String decimal(num? v) => v == null ? '—' : _decimal.format(v);

  /// Porcentaje de victorias al estilo béisbol: ",625".
  static String promedio(num? v) => v == null ? '—' : (v >= 1 ? '1,000' : _pct.format(v));

  static String porcentaje(num? v) => v == null ? '—' : '${(v * 100).round()} %';

  static String conSigno(int v) => v > 0 ? '+$v' : '$v';
}
