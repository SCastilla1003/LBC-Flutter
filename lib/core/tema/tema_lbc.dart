import 'package:flutter/material.dart';

/// Paleta de marca LBC: amarillo claro (principal), verde claro (secundario),
/// blanco (superficies) y rojo (terciario / acentos).
///
/// El amarillo claro no tiene contraste suficiente como texto sobre blanco, así que
/// se usa como color protagonista de superficies (barra superior, botones,
/// indicadores) y, para texto e iconos sobre blanco, un tono oscuro del mismo amarillo.
abstract final class ColoresMarca {
  static const amarilloClaro = Color(0xFFFFE07A);
  static const amarilloTexto = Color(0xFF6E5600); // amarillo oscuro legible sobre blanco
  static const tintaSobreAmarillo = Color(0xFF2E2600);

  static const verdeClaro = Color(0xFFB8E6AA);
  static const verdeTexto = Color(0xFF2D6A2A);
  static const tintaSobreVerde = Color(0xFF0F2A0C);

  static const rojo = Color(0xFFC62828);
  static const rojoClaro = Color(0xFFFF8A80);
  static const blanco = Color(0xFFFFFFFF);

  static const superficieOscura = Color(0xFF17160F);
}

/// Colores de estado (resultado de un partido). Siempre van con texto o icono.
abstract final class ColoresEstado {
  static const victoria = Color(0xFF0CA30C);
  static const derrota = Color(0xFFD03B3B);
}

abstract final class TemaLbc {
  static ThemeData claro() {
    final esquema = ColorScheme.fromSeed(
      seedColor: ColoresMarca.amarilloClaro,
      brightness: Brightness.light,
    ).copyWith(
      primary: ColoresMarca.amarilloTexto,
      onPrimary: ColoresMarca.blanco,
      primaryContainer: ColoresMarca.amarilloClaro,
      onPrimaryContainer: ColoresMarca.tintaSobreAmarillo,
      secondary: ColoresMarca.verdeTexto,
      onSecondary: ColoresMarca.blanco,
      secondaryContainer: ColoresMarca.verdeClaro,
      onSecondaryContainer: ColoresMarca.tintaSobreVerde,
      tertiary: ColoresMarca.rojo,
      onTertiary: ColoresMarca.blanco,
      tertiaryContainer: const Color(0xFFFFDAD5),
      onTertiaryContainer: const Color(0xFF410002),
      surface: ColoresMarca.blanco,
      surfaceContainerLowest: ColoresMarca.blanco,
      surfaceContainerLow: const Color(0xFFFFFCF3),
      surfaceContainer: const Color(0xFFFBF6E8),
      surfaceContainerHigh: const Color(0xFFF6F0DF),
      surfaceContainerHighest: const Color(0xFFF0EAD8),
      error: ColoresMarca.rojo,
    );
    return _base(esquema, barraSuperior: ColoresMarca.amarilloClaro, tintaBarra: ColoresMarca.tintaSobreAmarillo);
  }

  static ThemeData oscuro() {
    final esquema = ColorScheme.fromSeed(
      seedColor: ColoresMarca.amarilloClaro,
      brightness: Brightness.dark,
    ).copyWith(
      primary: ColoresMarca.amarilloClaro,
      onPrimary: ColoresMarca.tintaSobreAmarillo,
      primaryContainer: const Color(0xFF574500),
      onPrimaryContainer: ColoresMarca.amarilloClaro,
      secondary: ColoresMarca.verdeClaro,
      onSecondary: ColoresMarca.tintaSobreVerde,
      secondaryContainer: const Color(0xFF2D5127),
      onSecondaryContainer: ColoresMarca.verdeClaro,
      tertiary: ColoresMarca.rojoClaro,
      onTertiary: const Color(0xFF690005),
      surface: ColoresMarca.superficieOscura,
      surfaceContainerLowest: const Color(0xFF110F09),
      surfaceContainerLow: const Color(0xFF1F1D15),
      surfaceContainer: const Color(0xFF242219),
      surfaceContainerHigh: const Color(0xFF2E2C22),
      surfaceContainerHighest: const Color(0xFF39372C),
      error: ColoresMarca.rojoClaro,
    );
    return _base(esquema, barraSuperior: const Color(0xFF242219), tintaBarra: ColoresMarca.amarilloClaro);
  }

  static ThemeData _base(ColorScheme esquema, {required Color barraSuperior, required Color tintaBarra}) {
    final claro = esquema.brightness == Brightness.light;
    final texto = Typography.material2021(platform: TargetPlatform.android)
        .black
        .apply(bodyColor: esquema.onSurface, displayColor: esquema.onSurface);
    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      textTheme: texto,
      scaffoldBackgroundColor: claro ? esquema.surfaceContainerLow : esquema.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: barraSuperior,
        foregroundColor: tintaBarra,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        titleTextStyle: texto.titleLarge?.copyWith(color: tintaBarra, fontWeight: FontWeight.w700),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: esquema.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: esquema.outlineVariant.withValues(alpha: 0.6)),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: claro ? ColoresMarca.amarilloClaro : ColoresMarca.amarilloClaro,
          foregroundColor: ColoresMarca.tintaSobreAmarillo,
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: claro ? ColoresMarca.amarilloClaro : const Color(0xFF574500),
        backgroundColor: claro ? ColoresMarca.blanco : esquema.surfaceContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        indicatorColor: claro ? ColoresMarca.amarilloClaro : const Color(0xFF574500),
        backgroundColor: claro ? ColoresMarca.blanco : esquema.surfaceContainer,
        labelType: NavigationRailLabelType.all,
      ),
      chipTheme: ChipThemeData(
        selectedColor: esquema.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: esquema.surfaceContainerLowest,
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      dividerTheme: DividerThemeData(color: esquema.outlineVariant.withValues(alpha: 0.5), space: 1),
    );
  }
}

/// Estilo para cifras: dígitos de ancho fijo para que las columnas no "bailen".
TextStyle? estiloCifra(TextStyle? base) =>
    base?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
