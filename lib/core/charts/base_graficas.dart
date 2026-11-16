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
  Color get neutro => oscuro ? const Color(0xFF55544F) : const Color(0xFFD6D4CE);
  Color get superficie => _tema.cardTheme.color ?? _tema.colorScheme.surface;
  Color get tooltip => _tema.colorScheme.inverseSurface;
  Color get textoTooltip => _tema.colorScheme.onInverseSurface;
  Color get victoria => ColoresEstado.victoria;
  Color get derrota => ColoresEstado.derrota;
  Color get advertencia => const Color(0xFFFAB219);

  TextStyle get ejeTexto =>
      _tema.textTheme.labelSmall!.copyWith(color: _tema.colorScheme.onSurfaceVariant, fontSize: 10);
  TextStyle get etiqueta => _tema.textTheme.labelMedium!.copyWith(color: _tema.colorScheme.onSurface);
  TextStyle get etiquetaSuave => _tema.textTheme.labelSmall!.copyWith(color: _tema.colorScheme.onSurfaceVariant);
  TextStyle get valor => estiloCifra(_tema.textTheme.labelLarge)!.copyWith(fontWeight: FontWeight.w700);
  TextStyle get tooltipTexto =>
      _tema.textTheme.labelMedium!.copyWith(color: textoTooltip, fontWeight: FontWeight.w600);

  /// Rampa ordinal de un solo tono (azul) para categorías ordenadas (p. ej. tipos de hit).
  List<Color> rampa(int n) {
    const claro = [Color(0xFF86B6EF), Color(0xFF5598E7), Color(0xFF2A78D6), Color(0xFF1C5CAB), Color(0xFF104281)];
    const oscuroR = [Color(0xFF184F95), Color(0xFF256ABF), Color(0xFF3987E5), Color(0xFF6DA7EC), Color(0xFF9EC5F4)];
    final base = oscuro ? oscuroR : claro;
    if (n >= base.length) return base;
    // Reparte n pasos a lo largo de la rampa
    return [for (var i = 0; i < n; i++) base[(i * (base.length - 1) / (n - 1).clamp(1, 99)).round()]];
  }
}

/// Anima de 0 a 1 al aparecer y cada vez que cambia [clave] (filtro, métrica, temporada).
class EntradaAnimada extends StatelessWidget {
  const EntradaAnimada({super.key, required this.clave, required this.builder, this.duracion = Anim.entrada});

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
  const ContadorAnimado({super.key, required this.valor, this.decimales = 0, this.estilo, this.formato});

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

/// Tarjeta de una gráfica: título corto en forma de pregunta, leyenda opcional y la gráfica.
class TarjetaGrafica extends StatelessWidget {
  const TarjetaGrafica({super.key, required this.titulo, required this.child, this.leyenda, this.accion});

  final String titulo;
  final Widget child;
  final List<ItemLeyenda>? leyenda;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Expanded(
                child: Text(titulo, style: tema.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
              ),
              ?accion,
            ]),
            if (leyenda != null && leyenda!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(spacing: 12, runSpacing: 4, children: leyenda!),
            ],
            const SizedBox(height: 12),
            child,
          ]),
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
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (colores != null && colores!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox(
              width: 14,
              height: 10,
              child: Row(children: [for (final c in colores!) Expanded(child: Container(color: c))]),
            ),
          )
        else
          Container(
            width: linea ? 14 : 10,
            height: linea ? 3 : 10,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(linea ? 2 : 3)),
          ),
        const SizedBox(width: 6),
        Flexible(child: Text(texto, style: estilo.etiquetaSuave, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ]),
    );
    if (onTap == null) return contenido;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2), child: contenido),
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
      decoration: BoxDecoration(color: e.tooltip, borderRadius: BorderRadius.circular(8)),
      child: Text(texto, style: e.tooltipTexto),
    );
  }
}
