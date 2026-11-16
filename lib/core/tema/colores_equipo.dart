import 'package:flutter/material.dart';

/// Color de identidad de cada equipo en todas las gráficas.
///
/// La API guarda una clave (`azul`, `naranja`...). Cada clave tiene un tono para
/// modo claro y otro para oscuro: paleta categórica de 8 tonos validada para
/// daltonismo (en este orden) contra la superficie clara y la oscura.
abstract final class ColoresEquipo {
  static const Map<String, (Color claro, Color oscuro)> paleta = {
    'azul': (Color(0xFF2A78D6), Color(0xFF3987E5)),
    'naranja': (Color(0xFFEB6834), Color(0xFFD95926)),
    'aguamarina': (Color(0xFF1BAF7A), Color(0xFF199E70)),
    'amarillo': (Color(0xFFEDA100), Color(0xFFC98500)),
    'magenta': (Color(0xFFE87BA4), Color(0xFFD55181)),
    'verde': (Color(0xFF008300), Color(0xFF0CA30C)),
    'violeta': (Color(0xFF6250D6), Color(0xFF9085E9)),
    'rojo': (Color(0xFFE34948), Color(0xFFE66767)),
  };

  /// Nombre para mostrar en el selector del panel de administración.
  static const Map<String, String> nombres = {
    'azul': 'Azul',
    'naranja': 'Naranja',
    'aguamarina': 'Aguamarina',
    'amarillo': 'Amarillo',
    'magenta': 'Magenta',
    'verde': 'Verde',
    'violeta': 'Violeta',
    'rojo': 'Rojo',
  };

  static const _neutroClaro = Color(0xFF8F8E88);
  static const _neutroOscuro = Color(0xFF7D7C76);

  /// Color del equipo según el modo actual; gris neutro si no tiene color asignado.
  static Color de(BuildContext context, String? clave) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    final par = clave == null ? null : paleta[clave];
    if (par == null) return oscuro ? _neutroOscuro : _neutroClaro;
    return oscuro ? par.$2 : par.$1;
  }
}
