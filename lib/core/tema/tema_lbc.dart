import 'package:flutter/material.dart';

/// Identidad LBC: el blanco es la base primaria de la interfaz; el rojo, el
/// amarillo y el verde son los acentos de la liga. El rojo se reserva para
/// acciones y momentos de marca, el amarillo para trofeos y logros, y el verde
/// para datos positivos y el campo.
abstract final class ColoresMarca {
  /// Color primario de la aplicación: superficies limpias y mucho aire.
  static const primario = blanco;

  static const rojo = Color(0xFFB5121B);
  static const rojoOscuro = Color(0xFF8A0D16);
  static const rojoProfundo = Color(0xFF4D0710);
  static const rojoClaro = Color(0xFFFFB4AB);
  static const rojoSuave = Color(0xFFFFDAD6);

  static const dorado = Color(0xFFFFD166);
  static const doradoOscuro = Color(0xFFB8860B);
  static const amarilloClaro = dorado; // nombre histórico conservado
  static const amarilloTexto = Color(0xFF6B4E00);
  static const tintaSobreAmarillo = Color(0xFF2B2100);

  static const verde = Color(0xFF2E9E5B);
  static const verdeClaro = Color(0xFFB8E6AA);
  static const verdeTexto = Color(0xFF2D6A2A);
  static const tintaSobreVerde = Color(0xFF0F2A0C);

  /// Franja institucional para portadas y navegación: rojo, amarillo y verde.
  static const franjaInstitucional = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [rojo, dorado, verde],
    stops: [0.0, 0.58, 1.0],
  );

  /// La misma franja en vertical, para lomos y separadores de sección.
  static const franjaInstitucionalVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [rojo, dorado, verde],
    stops: [0.0, 0.58, 1.0],
  );

  static const crema = Color(0xFFFFF8ED);
  static const blanco = Color(0xFFFFFFFF);
  static const carbon = Color(0xFF151210);
  static const superficieOscura = carbon;
  static const tinta = Color(0xFF231A17);

  /// Texto claro para las cabeceras deportivas oscuras (equipo, jugador, partido).
  static const tintaBarra = Color(0xFFFFF4E6);
}

/// Colores de estado (resultado de un partido). Siempre van con texto o icono.
abstract final class ColoresEstado {
  static const victoria = ColoresMarca.verde;
  static const derrota = ColoresMarca.rojo;
}

abstract final class TemaLbc {
  static ThemeData claro() {
    final esquema =
        ColorScheme.fromSeed(
          seedColor: ColoresMarca.rojo,
          brightness: Brightness.light,
        ).copyWith(
          // La base visual es blanca (surface y AppBar); el rojo queda como
          // acento interactivo de Material (botones, foco, controles).
          primary: ColoresMarca.rojo,
          onPrimary: ColoresMarca.blanco,
          primaryContainer: ColoresMarca.rojoSuave,
          onPrimaryContainer: const Color(0xFF410002),
          secondary: ColoresMarca.amarilloTexto,
          onSecondary: ColoresMarca.blanco,
          secondaryContainer: const Color(0xFFFFE7A3),
          onSecondaryContainer: ColoresMarca.tintaSobreAmarillo,
          tertiary: ColoresMarca.verdeTexto,
          onTertiary: ColoresMarca.blanco,
          tertiaryContainer: ColoresMarca.verdeClaro,
          onTertiaryContainer: ColoresMarca.tintaSobreVerde,
          surface: const Color(0xFFFFFDFA),
          surfaceContainerLowest: ColoresMarca.blanco,
          surfaceContainerLow: const Color(0xFFF8F6F2),
          surfaceContainer: const Color(0xFFF2EFE8),
          surfaceContainerHigh: const Color(0xFFECE7DE),
          surfaceContainerHighest: const Color(0xFFE4DDD2),
          onSurface: ColoresMarca.tinta,
          onSurfaceVariant: const Color(0xFF5F544E),
          outline: const Color(0xFF8C817A),
          outlineVariant: const Color(0xFFE3DBD1),
          error: const Color(0xFFBA1A1A),
          onError: ColoresMarca.blanco,
          errorContainer: ColoresMarca.rojoSuave,
          onErrorContainer: const Color(0xFF410002),
        );
    return _base(
      esquema,
      barraSuperior: ColoresMarca.blanco,
      tintaBarra: ColoresMarca.tinta,
    );
  }

  static ThemeData oscuro() {
    final esquema =
        ColorScheme.fromSeed(
          seedColor: ColoresMarca.rojo,
          brightness: Brightness.dark,
        ).copyWith(
          primary: ColoresMarca.rojoClaro,
          onPrimary: const Color(0xFF690005),
          primaryContainer: const Color(0xFF93000A),
          onPrimaryContainer: ColoresMarca.rojoSuave,
          secondary: ColoresMarca.dorado,
          onSecondary: ColoresMarca.tintaSobreAmarillo,
          secondaryContainer: const Color(0xFF574500),
          onSecondaryContainer: const Color(0xFFFFE08A),
          tertiary: ColoresMarca.verdeClaro,
          onTertiary: ColoresMarca.tintaSobreVerde,
          tertiaryContainer: const Color(0xFF2D5127),
          onTertiaryContainer: const Color(0xFFD4F5C9),
          surface: ColoresMarca.carbon,
          surfaceContainerLowest: const Color(0xFF0E0C0A),
          surfaceContainerLow: const Color(0xFF1D1917),
          surfaceContainer: const Color(0xFF221D1A),
          surfaceContainerHigh: const Color(0xFF2D2623),
          surfaceContainerHighest: const Color(0xFF39302C),
          onSurface: const Color(0xFFF3E7E1),
          onSurfaceVariant: const Color(0xFFD7C2BA),
          outline: const Color(0xFFA08C84),
          outlineVariant: const Color(0xFF52443F),
          error: ColoresMarca.rojoClaro,
          onError: const Color(0xFF690005),
          errorContainer: const Color(0xFF93000A),
          onErrorContainer: ColoresMarca.rojoSuave,
        );
    return _base(
      esquema,
      barraSuperior: const Color(0xFF1D1917),
      tintaBarra: const Color(0xFFF3E7E1),
    );
  }

  static ThemeData _base(
    ColorScheme esquema, {
    required Color barraSuperior,
    required Color tintaBarra,
  }) {
    final claro = esquema.brightness == Brightness.light;
    final base = Typography.material2021(platform: TargetPlatform.android).black
        .apply(bodyColor: esquema.onSurface, displayColor: esquema.onSurface);
    final texto = base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: -1,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: -0.6,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
      ),
    );

    WidgetStateProperty<T> seleccion<T>(T activo, T inactivo) =>
        WidgetStateProperty.resolveWith(
          (estados) =>
              estados.contains(WidgetState.selected) ? activo : inactivo,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      textTheme: texto,
      scaffoldBackgroundColor: claro
          ? esquema.surfaceContainerLow
          : esquema.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: barraSuperior,
        foregroundColor: tintaBarra,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(
            color: ColoresMarca.dorado.withValues(alpha: 0.7),
            width: 1,
          ),
        ),
        iconTheme: IconThemeData(color: tintaBarra, size: 22),
        actionsIconTheme: IconThemeData(color: tintaBarra, size: 22),
        titleTextStyle: texto.titleLarge?.copyWith(
          color: tintaBarra,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.1,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: esquema.outlineVariant.withValues(alpha: 0.8),
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ColoresMarca.rojo,
          foregroundColor: ColoresMarca.blanco,
          disabledBackgroundColor: esquema.onSurface.withValues(alpha: 0.12),
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: claro
              ? ColoresMarca.rojoOscuro
              : ColoresMarca.rojoClaro,
          minimumSize: const Size(64, 48),
          side: BorderSide(
            color: (claro ? ColoresMarca.rojo : ColoresMarca.rojoClaro)
                .withValues(alpha: 0.45),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: claro ? ColoresMarca.rojo : ColoresMarca.rojoClaro,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        indicatorColor: esquema.primaryContainer,
        backgroundColor: claro ? ColoresMarca.blanco : esquema.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        iconTheme: seleccion(
          IconThemeData(color: esquema.onPrimaryContainer),
          IconThemeData(color: esquema.onSurfaceVariant),
        ),
        labelTextStyle: seleccion(
          texto.labelMedium!.copyWith(
            fontWeight: FontWeight.w800,
            color: esquema.onPrimaryContainer,
          ),
          texto.labelMedium!.copyWith(color: esquema.onSurfaceVariant),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        indicatorColor: esquema.primaryContainer,
        backgroundColor: claro ? ColoresMarca.blanco : esquema.surfaceContainer,
        selectedIconTheme: IconThemeData(color: esquema.onPrimaryContainer),
        unselectedIconTheme: IconThemeData(color: esquema.onSurfaceVariant),
        selectedLabelTextStyle: texto.labelMedium!.copyWith(
          fontWeight: FontWeight.w800,
          color: esquema.primary,
        ),
        unselectedLabelTextStyle: texto.labelMedium!.copyWith(
          color: esquema.onSurfaceVariant,
        ),
        labelType: NavigationRailLabelType.all,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: esquema.surfaceContainer,
        selectedColor: esquema.primaryContainer,
        secondarySelectedColor: esquema.secondaryContainer,
        side: BorderSide(color: esquema.outlineVariant.withValues(alpha: 0.8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        labelStyle: texto.labelMedium!.copyWith(fontWeight: FontWeight.w700),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: esquema.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: claro ? ColoresMarca.rojo : ColoresMarca.rojoClaro,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: esquema.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: ColoresMarca.rojo,
        inactiveTrackColor: esquema.primaryContainer,
        thumbColor: ColoresMarca.rojo,
        overlayColor: ColoresMarca.rojo.withValues(alpha: 0.12),
        valueIndicatorColor: ColoresMarca.rojoProfundo,
        valueIndicatorTextStyle: const TextStyle(
          color: ColoresMarca.blanco,
          fontWeight: FontWeight.w700,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: seleccion(
            esquema.primaryContainer,
            Colors.transparent,
          ),
          foregroundColor: seleccion(
            esquema.onPrimaryContainer,
            esquema.onSurfaceVariant,
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: esquema.outlineVariant),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700),
          ),
          visualDensity: VisualDensity.comfortable,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: tintaBarra,
        unselectedLabelColor: tintaBarra.withValues(alpha: 0.62),
        indicatorColor: claro ? ColoresMarca.rojo : ColoresMarca.rojoClaro,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: texto.labelLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: claro
            ? ColoresMarca.rojoProfundo
            : esquema.surfaceContainerHighest,
        contentTextStyle: const TextStyle(color: ColoresMarca.tintaBarra),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dividerTheme: DividerThemeData(
        color: esquema.outlineVariant.withValues(alpha: 0.55),
        space: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: claro ? ColoresMarca.rojo : ColoresMarca.rojoClaro,
        linearTrackColor: esquema.primaryContainer,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: claro
              ? ColoresMarca.rojoProfundo
              : esquema.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          color: ColoresMarca.tintaBarra,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: esquema.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

/// Estilo para cifras: dígitos de ancho fijo para que las columnas no "bailen".
TextStyle? estiloCifra(TextStyle? base) =>
    base?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
