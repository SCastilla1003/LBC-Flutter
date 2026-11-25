import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/config/entorno.dart';
import 'core/router/router.dart';
import 'core/sesion/sesion.dart';
import 'core/tema/tema_lbc.dart';
import 'core/widgets/animaciones.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es');
  final sesion = await AlmacenSesion().leer();
  runApp(ProviderScope(
    // Sin reintentos automáticos: ante un error la pantalla lo muestra y el usuario decide reintentar.
    retry: (intento, error) => null,
    overrides: [sesionInicialProvider.overrideWithValue(sesion)],
    child: const LbcApp(),
  ));
}

class LbcApp extends ConsumerWidget {
  const LbcApp({super.key});

  static const _localizaciones = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!Entorno.configurado) {
      return MaterialApp(
        title: 'LBC',
        debugShowCheckedModeBanner: false,
        theme: TemaLbc.claro(),
        darkTheme: TemaLbc.oscuro(),
        locale: const Locale('es'),
        supportedLocales: const [Locale('es')],
        localizationsDelegates: _localizaciones,
        home: const _ConfiguracionInvalida(),
      );
    }
    return MaterialApp.router(
      title: 'LBC · Liga de Béisbol de Cartagena',
      debugShowCheckedModeBanner: false,
      theme: TemaLbc.claro(),
      darkTheme: TemaLbc.oscuro(),
      themeMode: ThemeMode.system,
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: _localizaciones,
      routerConfig: ref.watch(routerProvider),
      // Al abrir la app, el escudo entra rebotando y se desvanece hacia el inicio.
      builder: (context, child) => PresentacionLbc(child: child ?? const SizedBox.shrink()),
    );
  }
}

/// Se muestra si la app se compiló sin `--dart-define=API_BASE_URL=...`:
/// no hay URL por defecto ni datos de respaldo.
class _ConfiguracionInvalida extends StatelessWidget {
  const _ConfiguracionInvalida();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.settings_ethernet_rounded, size: 56, color: tema.colorScheme.tertiary),
              const SizedBox(height: 16),
              Text('Falta la URL de la API', style: tema.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'La app solo funciona con los datos de la API de la liga. Compílala indicando su dirección:',
                textAlign: TextAlign.center,
                style: tema.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              const SelectableText('flutter run --dart-define=API_BASE_URL=https://<app>.up.railway.app',
                  style: TextStyle(fontFamily: 'monospace')),
              if (Entorno.valorRecibido.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Valor recibido no válido: "${Entorno.valorRecibido}"', style: tema.textTheme.bodySmall),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}
