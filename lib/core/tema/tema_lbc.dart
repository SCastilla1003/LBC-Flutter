import 'package:flutter/material.dart';

/// Identidad "Diamante LBC".
///
/// - Primario: BLANCO. Es la base dominante: fondos, tarjetas y barra superior.
/// - Secundarios: VERDE (interacción principal, campo de juego, victorias) y
///   AMARILLO (protagonismo: líderes, récords, trofeos, top).
/// - Terciario: ROJO, con moderación: en vivo, alertas, errores, derrotas y
///   acciones destructivas.
///
/// Sobre amarillo el texto va SIEMPRE en tinta oscura; el texto verde sobre
/// blanco usa [verdeCampo] (6,6:1). [verdeVivo] solo para rellenos y gráficas.
abstract final class ColoresMarca {
  /// Color primario de la aplicación: superficies limpias y mucho aire.
  static const primario = blanco;

  // ── Blancos y tintas ──────────────────────────────────────────────────────
  static const blanco = Color(0xFFFFFFFF);

  /// Fondo general: blanco hueso con un matiz de césped.
  static const fondo = Color(0xFFF5F7F4);
  static const tinta = Color(0xFF0E1A13);
  static const tintaSuave = Color(0xFF5B6B61);
  static const borde = Color(0xFFDDE3DE);

  // ── Verde (secundario: interacción y campo) ───────────────────────────────
  static const verdeCampo = Color(0xFF0B6B3A);
  static const verdeVivo = Color(0xFF17A158);
  static const verdeSuave = Color(0xFFE3F4E8);

  /// Verde de tablero de estadio: marcadores y cabeceras deportivas.
  static const verdeNoche = Color(0xFF0B3D24);
  static const verdeNocheProfundo = Color(0xFF072916);
  static const verdeNeon = Color(0xFF6EE29A);

  // ── Amarillo (secundario: protagonismo) ───────────────────────────────────
  static const amarillo = Color(0xFFFFC629);
  static const amarilloSuave = Color(0xFFFFF4CC);
  static const amarilloTexto = Color(0xFF7A5A00);
  static const tintaSobreAmarillo = Color(0xFF14110A);

  // ── Rojo (terciario: en vivo, alertas, derrotas) ──────────────────────────
  static const rojo = Color(0xFFC8102E);
  static const rojoOscuro = Color(0xFF8E0B21);
  static const rojoProfundo = Color(0xFF4A0712);
  static const rojoClaro = Color(0xFFFF8A80);
  static const rojoSuave = Color(0xFFFFE1DE);

  // ── Nombres históricos conservados (apuntan a la paleta nueva) ────────────
  static const verde = verdeVivo;
  static const verdeClaro = Color(0xFFB7F2CB);
  static const verdeTexto = verdeCampo;
  static const tintaSobreVerde = Color(0xFF00210F);
  static const dorado = amarillo;
  static const doradoOscuro = Color(0xFFB98900);
  static const amarilloClaro = amarillo;
  static const crema = amarilloSuave;
  static const carbon = Color(0xFF0B1410);
  static const superficieOscura = carbon;

  /// Texto claro sobre las cabeceras deportivas oscuras (verde noche).
  static const tintaBarra = Color(0xFFF2F7F3);

  /// Franja de marca: del verde del campo al amarillo de los trofeos.
  static const franjaInstitucional = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [verdeCampo, verdeVivo, amarillo],
    stops: [0.0, 0.55, 1.0],
  );

  /// La misma franja en vertical, para lomos y separadores de sección.
  static const franjaInstitucionalVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [verdeCampo, verdeVivo, amarillo],
    stops: [0.0, 0.55, 1.0],
  );

  /// Fondo de tablero: verde noche con una ligera caída de luz.
  static const tablero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [verdeNoche, verdeNocheProfundo],
  );
}

/// Colores de estado (resultado de un partido). Siempre van con texto o icono.
abstract final class ColoresEstado {
  static const victoria = ColoresMarca.verdeCampo;
  static const derrota = ColoresMarca.rojo;
}

/// Familias tipográficas empaquetadas en assets/fuentes (SIL OFL 1.1).
abstract final class FuentesLbc {
  /// Texto corrido, etiquetas y controles.
  static const texto = 'Barlow';

  /// Titulares, marcadores y cifras grandes (estilo tablero deportivo).
  static const titular = 'BarlowCondensed';
}

/// Escala de espaciado (base 4).
abstract final class EspacioLbc {
  static const xs = 4.0;
  static const s = 8.0;
  static const m = 12.0;
  static const l = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

/// Radios de la marca: tarjetas sobrias, botones firmes y píldoras redondas.
abstract final class RadioLbc {
  static const tarjeta = 12.0;
  static const boton = 10.0;
  static const campo = 10.0;
  static const hoja = 20.0;
  static const pildora = 999.0;
}

abstract final class TemaLbc {
  static ThemeData claro() {
    const esquema = ColorScheme(
      brightness: Brightness.light,
      primary: ColoresMarca.verdeCampo,
      onPrimary: ColoresMarca.blanco,
      primaryContainer: ColoresMarca.verdeSuave,
      onPrimaryContainer: Color(0xFF00391C),
      secondary: ColoresMarca.amarillo,
      onSecondary: ColoresMarca.tintaSobreAmarillo,
      secondaryContainer: ColoresMarca.amarilloSuave,
      onSecondaryContainer: Color(0xFF3D2E00),
      tertiary: ColoresMarca.rojo,
      onTertiary: ColoresMarca.blanco,
      tertiaryContainer: ColoresMarca.rojoSuave,
      onTertiaryContainer: Color(0xFF410009),
      error: ColoresMarca.rojo,
      onError: ColoresMarca.blanco,
      errorContainer: ColoresMarca.rojoSuave,
      onErrorContainer: Color(0xFF410009),
      surface: ColoresMarca.blanco,
      onSurface: ColoresMarca.tinta,
      surfaceContainerLowest: ColoresMarca.blanco,
      surfaceContainerLow: ColoresMarca.fondo,
      surfaceContainer: Color(0xFFEEF2EE),
      surfaceContainerHigh: Color(0xFFE7ECE8),
      surfaceContainerHighest: Color(0xFFDFE5E0),
      onSurfaceVariant: ColoresMarca.tintaSuave,
      outline: Color(0xFF7B8A80),
      outlineVariant: ColoresMarca.borde,
      inverseSurface: ColoresMarca.verdeNoche,
      onInverseSurface: ColoresMarca.tintaBarra,
      inversePrimary: ColoresMarca.verdeNeon,
      shadow: Colors.black,
      scrim: Colors.black,
      surfaceTint: Colors.transparent,
    );
    return _base(esquema);
  }

  static ThemeData oscuro() {
    const esquema = ColorScheme(
      brightness: Brightness.dark,
      primary: ColoresMarca.verdeNeon,
      onPrimary: Color(0xFF00391C),
      primaryContainer: Color(0xFF0F5130),
      onPrimaryContainer: Color(0xFFB7F2CB),
      secondary: Color(0xFFFFD54F),
      onSecondary: Color(0xFF2B2100),
      secondaryContainer: Color(0xFF4A3B00),
      onSecondaryContainer: Color(0xFFFFE599),
      tertiary: ColoresMarca.rojoClaro,
      onTertiary: Color(0xFF5F0010),
      tertiaryContainer: Color(0xFF8E0B21),
      onTertiaryContainer: ColoresMarca.rojoSuave,
      error: ColoresMarca.rojoClaro,
      onError: Color(0xFF5F0010),
      errorContainer: Color(0xFF8E0B21),
      onErrorContainer: ColoresMarca.rojoSuave,
      surface: ColoresMarca.carbon,
      onSurface: Color(0xFFE6EEE8),
      surfaceContainerLowest: Color(0xFF070D0A),
      surfaceContainerLow: Color(0xFF121C17),
      surfaceContainer: Color(0xFF17221C),
      surfaceContainerHigh: Color(0xFF1E2A23),
      surfaceContainerHighest: Color(0xFF26332B),
      onSurfaceVariant: Color(0xFFA9B8AE),
      outline: Color(0xFF7C8C82),
      outlineVariant: Color(0xFF2E3B33),
      inverseSurface: Color(0xFFE6EEE8),
      onInverseSurface: ColoresMarca.tinta,
      inversePrimary: ColoresMarca.verdeCampo,
      shadow: Colors.black,
      scrim: Colors.black,
      surfaceTint: Colors.transparent,
    );
    return _base(esquema);
  }

  static TextTheme _texto(ColorScheme esquema) {
    final base = Typography.material2021(platform: TargetPlatform.android).black
        .apply(
          fontFamily: FuentesLbc.texto,
          bodyColor: esquema.onSurface,
          displayColor: esquema.onSurface,
        );
    TextStyle? titular(
      TextStyle? s,
      double tam, {
      FontWeight peso = FontWeight.w800,
      double tracking = 0,
    }) => s?.copyWith(
      fontFamily: FuentesLbc.titular,
      fontSize: tam,
      fontWeight: peso,
      letterSpacing: tracking,
      height: 1.05,
    );
    return base.copyWith(
      displayLarge: titular(base.displayLarge, 60),
      displayMedium: titular(base.displayMedium, 50),
      displaySmall: titular(base.displaySmall, 42),
      headlineLarge: titular(base.headlineLarge, 36),
      headlineMedium: titular(base.headlineMedium, 31),
      headlineSmall: titular(base.headlineSmall, 26, tracking: 0.2),
      titleLarge: titular(
        base.titleLarge,
        23,
        peso: FontWeight.w700,
        tracking: 0.3,
      ),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 16, height: 1.45),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 15, height: 1.4),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }

  static ThemeData _base(ColorScheme esquema) {
    final claro = esquema.brightness == Brightness.light;
    final texto = _texto(esquema);
    final barra = claro ? ColoresMarca.blanco : esquema.surfaceContainerLow;

    WidgetStateProperty<T> seleccion<T>(T activo, T inactivo) =>
        WidgetStateProperty.resolveWith(
          (estados) =>
              estados.contains(WidgetState.selected) ? activo : inactivo,
        );

    final formaBoton = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RadioLbc.boton),
    );
    final textoBoton = texto.labelLarge?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      fontSize: 15,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      fontFamily: FuentesLbc.texto,
      textTheme: texto,
      scaffoldBackgroundColor: esquema.surfaceContainerLow,
      appBarTheme: AppBarTheme(
        backgroundColor: barra,
        foregroundColor: esquema.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(color: esquema.outlineVariant, width: 1),
        ),
        iconTheme: IconThemeData(color: esquema.onSurface, size: 22),
        actionsIconTheme: IconThemeData(color: esquema.onSurface, size: 22),
        titleTextStyle: texto.titleLarge?.copyWith(
          color: esquema.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadioLbc.tarjeta),
          side: BorderSide(color: esquema.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: esquema.primary,
          foregroundColor: esquema.onPrimary,
          disabledBackgroundColor: esquema.onSurface.withValues(alpha: 0.12),
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          shape: formaBoton,
          textStyle: textoBoton,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: esquema.surfaceContainerLowest,
          foregroundColor: esquema.primary,
          minimumSize: const Size(64, 48),
          shape: formaBoton.copyWith(
            side: BorderSide(color: esquema.outlineVariant),
          ),
          textStyle: textoBoton,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: esquema.primary,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          side: BorderSide(color: esquema.primary.withValues(alpha: 0.5)),
          shape: formaBoton,
          textStyle: textoBoton,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: esquema.primary,
          shape: formaBoton,
          textStyle: textoBoton,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(shape: formaBoton),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: esquema.primary,
        foregroundColor: esquema.onPrimary,
        elevation: 2,
        highlightElevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        extendedTextStyle: textoBoton,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        elevation: 0,
        indicatorColor: esquema.primaryContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadioLbc.boton),
        ),
        backgroundColor: barra,
        surfaceTintColor: Colors.transparent,
        iconTheme: seleccion(
          IconThemeData(color: esquema.primary, size: 24),
          IconThemeData(color: esquema.onSurfaceVariant, size: 24),
        ),
        labelTextStyle: seleccion(
          texto.labelMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0,
            color: esquema.primary,
          ),
          texto.labelMedium!.copyWith(
            fontSize: 12,
            letterSpacing: 0,
            color: esquema.onSurfaceVariant,
          ),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        indicatorColor: esquema.primaryContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadioLbc.boton),
        ),
        backgroundColor: barra,
        selectedIconTheme: IconThemeData(color: esquema.primary),
        unselectedIconTheme: IconThemeData(color: esquema.onSurfaceVariant),
        selectedLabelTextStyle: texto.labelMedium!.copyWith(
          fontWeight: FontWeight.w700,
          color: esquema.primary,
        ),
        unselectedLabelTextStyle: texto.labelMedium!.copyWith(
          color: esquema.onSurfaceVariant,
        ),
        labelType: NavigationRailLabelType.all,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: esquema.surfaceContainerLowest,
        selectedColor: esquema.primaryContainer,
        secondarySelectedColor: esquema.secondaryContainer,
        checkmarkColor: esquema.primary,
        side: BorderSide(color: esquema.outlineVariant),
        shape: const StadiumBorder(),
        labelStyle: texto.labelMedium!.copyWith(fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadioLbc.campo),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadioLbc.campo),
          borderSide: BorderSide(color: esquema.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadioLbc.campo),
          borderSide: BorderSide(color: esquema.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadioLbc.campo),
          borderSide: BorderSide(color: esquema.error),
        ),
        filled: true,
        fillColor: esquema.surfaceContainerLowest,
        floatingLabelStyle: TextStyle(
          color: esquema.primary,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: esquema.primary,
        inactiveTrackColor: esquema.primaryContainer,
        thumbColor: esquema.primary,
        overlayColor: esquema.primary.withValues(alpha: 0.12),
        valueIndicatorColor: ColoresMarca.verdeNoche,
        valueIndicatorTextStyle: const TextStyle(
          color: ColoresMarca.tintaBarra,
          fontWeight: FontWeight.w700,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: seleccion(esquema.onPrimary, esquema.outline),
        trackColor: seleccion(esquema.primary, esquema.surfaceContainerHighest),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: seleccion(esquema.primary, Colors.transparent),
        checkColor: WidgetStatePropertyAll(esquema.onPrimary),
      ),
      radioTheme: RadioThemeData(
        fillColor: seleccion(esquema.primary, esquema.onSurfaceVariant),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: seleccion(
            esquema.primaryContainer,
            esquema.surfaceContainerLowest,
          ),
          foregroundColor: seleccion(
            esquema.onPrimaryContainer,
            esquema.onSurfaceVariant,
          ),
          iconColor: seleccion(esquema.primary, esquema.onSurfaceVariant),
          side: WidgetStatePropertyAll(
            BorderSide(color: esquema.outlineVariant),
          ),
          shape: WidgetStatePropertyAll(formaBoton),
          textStyle: WidgetStatePropertyAll(
            texto.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          visualDensity: VisualDensity.comfortable,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: esquema.onSurface,
        unselectedLabelColor: esquema.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: esquema.primary, width: 3),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: texto.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
        unselectedLabelStyle: texto.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: claro
            ? ColoresMarca.verdeNoche
            : esquema.surfaceContainerHighest,
        contentTextStyle: texto.bodyMedium?.copyWith(
          color: claro ? ColoresMarca.tintaBarra : esquema.onSurface,
          fontWeight: FontWeight.w600,
        ),
        actionTextColor: ColoresMarca.amarillo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadioLbc.boton),
        ),
      ),
      // En oscuro, el diálogo va un tono por encima del fondo para que se distinga.
      dialogTheme: DialogThemeData(
        backgroundColor: claro
            ? esquema.surfaceContainerLowest
            : esquema.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadioLbc.hoja),
        ),
        titleTextStyle: texto.headlineSmall,
      ),
      dividerTheme: DividerThemeData(color: esquema.outlineVariant, space: 1),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: esquema.primary,
        linearTrackColor: esquema.primaryContainer,
        circularTrackColor: Colors.transparent,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: claro
              ? ColoresMarca.verdeNoche
              : esquema.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: claro ? ColoresMarca.tintaBarra : esquema.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: claro
            ? esquema.surfaceContainerLowest
            : esquema.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RadioLbc.hoja),
          ),
        ),
        showDragHandle: true,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: esquema.onSurfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadioLbc.boton),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: esquema.primary,
        shape: const Border(),
        collapsedShape: const Border(),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: esquema.secondary,
        textColor: esquema.onSecondary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

/// Estilo para cifras: dígitos de ancho fijo para que las columnas no "bailen".
TextStyle? estiloCifra(TextStyle? base) =>
    base?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]);

/// Cifra de tablero: condensada, pesada y tabular (marcadores, KPIs, líderes).
TextStyle? estiloMarcador(TextStyle? base) => base?.copyWith(
  fontFamily: FuentesLbc.titular,
  fontWeight: FontWeight.w800,
  height: 1,
  letterSpacing: 0,
  fontFeatures: const [FontFeature.tabularFigures()],
);

/// Etiqueta de sección: mayúsculas con tracking amplio.
TextStyle? estiloEtiqueta(TextStyle? base) =>
    base?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 1.4);
