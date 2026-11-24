import 'package:flutter/material.dart';

/// Logo institucional de la Liga de Béisbol de Cartagena.
///
/// El archivo original viene sobre fondo blanco, así que se presenta como una
/// placa redondeada: luce igual de bien sobre superficies claras y oscuras.
class LogoLbc extends StatelessWidget {
  const LogoLbc({
    super.key,
    this.tamano = 40,
    this.radio,
    this.sombra = true,
  });

  /// Ruta del recurso declarada en `pubspec.yaml`.
  static const ruta = 'assets/imagenes/logo_lbc.png';

  final double tamano;

  /// Radio de las esquinas; por defecto se calcula a partir del tamaño.
  final double? radio;
  final bool sombra;

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: tamano,
      height: tamano,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radio ?? tamano * 0.24),
        border: Border.all(
          color: oscuro
              ? Colors.white.withValues(alpha: 0.18)
              : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: sombra
            ? [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: oscuro ? 0.35 : 0.10,
                  ),
                  blurRadius: tamano * 0.28,
                  offset: Offset(0, tamano * 0.08),
                ),
              ]
            : null,
      ),
      child: Image.asset(
        ruta,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
        semanticLabel: 'Logo de la Liga de Béisbol de Cartagena',
      ),
    );
  }
}
