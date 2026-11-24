import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';

/// Duraciones y curvas comunes: todas las gráficas entran y cambian igual.
abstract final class Anim {
  static const entrada = Duration(milliseconds: 900);
  static const cambio = Duration(milliseconds: 450);
  static const curva = Curves.easeOutCubic;
}

/// Colores y estilos de las gráficas (ejes y rejilla recesivos; texto nunca en color de serie).
class EstiloGrafica {
  EstiloGrafica(BuildContext context)
    : _tema = Theme.of(context),
      oscuro = Theme.of(context).brightness == Brightness.dark;

  final ThemeData _tema;
  final bool oscuro;

  Color get rejilla => _tema.colorScheme.outlineVariant.withValues(alpha: 0.5);
  Color get eje => _tema.colorScheme.outline;
  Color get neutro =>
      oscuro ? const Color(0xFF4A5750) : const Color(0xFFD5DBD6);
  Color get superficie => _tema.cardTheme.color ?? _tema.colorScheme.surface;
  Color get tooltip => _tema.colorScheme.inverseSurface;
  Color get textoTooltip => _tema.colorScheme.onInverseSurface;
  Color get victoria => ColoresEstado.victoria;
  Color get derrota => ColoresEstado.derrota;
  Color get advertencia => ColoresMarca.doradoOscuro;
  Color get acento => _tema.colorScheme.primary;

  TextStyle get ejeTexto => _tema.textTheme.labelSmall!.copyWith(
    color: _tema.colorScheme.onSurfaceVariant,
    fontSize: 10,
  );
  TextStyle get etiqueta =>
      _tema.textTheme.labelMedium!.copyWith(color: _tema.colorScheme.onSurface);
  TextStyle get etiquetaSuave => _tema.textTheme.labelSmall!.copyWith(
    color: _tema.colorScheme.onSurfaceVariant,
  );
  TextStyle get valor => estiloMarcador(
    _tema.textTheme.labelLarge,
  )!.copyWith(fontSize: 16, color: _tema.colorScheme.onSurface);
  TextStyle get tooltipTexto => _tema.textTheme.labelMedium!.copyWith(
    color: textoTooltip,
    fontWeight: FontWeight.w600,
  );

  /// Rampa ordinal de la marca (amarillo → verde campo) para categorías
  /// ordenadas, p. ej. sencillo → doble → triple → jonrón.
  List<Color> rampa(int n) {
    const claro = [
      Color(0xFFFFC629),
      Color(0xFFB5C13A),
      Color(0xFF5DAF4E),
      Color(0xFF17894A),
      Color(0xFF0B5A31),
    ];
    const oscuroR = [
      Color(0xFFFFD54F),
      Color(0xFFC9D65B),
      Color(0xFF8FD66E),
      Color(0xFF52C47C),
      Color(0xFF2FA866),
    ];
    final base = oscuro ? oscuroR : claro;
    if (n >= base.length) return base;
    // Reparte n pasos a lo largo de la rampa
    return [
      for (var i = 0; i < n; i++)
        base[(i * (base.length - 1) / (n - 1).clamp(1, 99)).round()],
    ];
  }
}

/// Anima de 0 a 1 al aparecer y cada vez que cambia [clave] (filtro, métrica, temporada).
class EntradaAnimada extends StatelessWidget {
  const EntradaAnimada({
    super.key,
    required this.clave,
    required this.builder,
    this.duracion = Anim.entrada,
  });

  final Object clave;
  final Widget Function(BuildContext context, double t) builder;
  final Duration duracion;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(clave),
      tween: Tween(begin: 0, end: 1),
      duration: duracion,
      curve: Anim.curva,
      builder: (context, t, _) => builder(context, t),
    );
  }
}

/// Número que sube hasta su valor al aparecer.
class ContadorAnimado extends StatelessWidget {
  const ContadorAnimado({
    super.key,
    required this.valor,
    this.decimales = 0,
    this.estilo,
    this.formato,
  });

  final num valor;
  final int decimales;
  final TextStyle? estilo;
  final String Function(double v)? formato;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: valor.toDouble()),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutExpo,
      builder: (context, v, _) => Text(
        formato?.call(v) ?? v.toStringAsFixed(decimales).replaceAll('.', ','),
        style: estiloCifra(estilo ?? Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}

/// Tarjeta de una gráfica: filo tricolor (rojo, amarillo y verde), icono,
/// título corto en forma de pregunta, leyenda opcional y la gráfica.
class TarjetaGrafica extends StatelessWidget {
  const TarjetaGrafica({
    super.key,
    required this.titulo,
    required this.child,
    this.subtitulo,
    this.icono = Icons.insights_rounded,
    this.leyenda,
    this.accion,
    this.acento,
  });

  final String titulo;
  final String? subtitulo;
  final IconData icono;
  final Widget child;
  final List<ItemLeyenda>? leyenda;
  final Widget? accion;
  final Color? acento;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final color = acento ?? tema.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icono, size: 18, color: color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titulo,
                              style: tema.textTheme.titleLarge?.copyWith(
                                fontSize: 20,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 22,
                              height: 3,
                              decoration: BoxDecoration(
                                color: ColoresMarca.amarillo,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            if (subtitulo != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  subtitulo!,
                                  style: tema.textTheme.labelSmall?.copyWith(
                                    color: tema.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      ?accion,
                    ],
                  ),
                  if (leyenda != null && leyenda!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(spacing: 12, runSpacing: 4, children: leyenda!),
                  ],
                  const SizedBox(height: 12),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Muestra de color + texto. Si [onTap] no es null, sirve para resaltar una serie.
class ItemLeyenda extends StatelessWidget {
  const ItemLeyenda({
    super.key,
    required this.color,
    required this.texto,
    this.activo = true,
    this.onTap,
    this.linea = false,
    this.colores,
  });

  final Color color;

  /// Si se indica, la muestra se dibuja con franjas de estos colores (p. ej. "color de cada equipo").
  final List<Color>? colores;
  final String texto;
  final bool activo;
  final bool linea;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final estilo = EstiloGrafica(context);
    final contenido = Opacity(
      opacity: activo ? 1 : 0.35,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (colores != null && colores!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: SizedBox(
                width: 14,
                height: 10,
                child: Row(
                  children: [
                    for (final c in colores!)
                      Expanded(child: Container(color: c)),
                  ],
                ),
              ),
            )
          else
            Container(
              width: linea ? 14 : 10,
              height: linea ? 3 : 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(linea ? 2 : 3),
              ),
            ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              texto,
              style: estilo.etiquetaSuave,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return contenido;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: contenido,
      ),
    );
  }
}

/// Burbuja de tooltip para las gráficas dibujadas a mano.
class BurbujaTooltip extends StatelessWidget {
  const BurbujaTooltip({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final e = EstiloGrafica(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: e.tooltip,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(texto, style: e.tooltipTexto),
    );
  }
}
