import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/config/entorno.dart';

/// Inicio de sesión con Google: obtiene el ID token que luego se envía a la API
/// (`POST /auth/google`), que lo verifica y emite su propio JWT.
///
/// Solo se activa si la app se compila con `--dart-define=GOOGLE_CLIENT_ID=<client id web>`.
class ServicioGoogle {
  Future<void>? _inicio;

  Future<void> iniciar() => _inicio ??= GoogleSignIn.instance.initialize(
        // En web el client ID identifica a la app; en Android se pide el token para el backend
        clientId: kIsWeb ? Entorno.googleClientId : null,
        serverClientId: kIsWeb ? null : Entorno.googleClientId,
      );

  /// ID tokens de cada inicio de sesión completado (botón oficial en web o flujo nativo en Android).
  Stream<String> get idTokens => GoogleSignIn.instance.authenticationEvents
      .where((e) => e is GoogleSignInAuthenticationEventSignIn)
      .map((e) => (e as GoogleSignInAuthenticationEventSignIn).user.authentication.idToken)
      .where((t) => t != null)
      .cast<String>();

  /// En Android se usa un botón propio; en web hay que usar el botón oficial de Google.
  bool get usaBotonPropio => GoogleSignIn.instance.supportsAuthenticate();

  Future<void> autenticar() => GoogleSignIn.instance.authenticate();

  Future<void> cerrar() async {
    if (_inicio == null) return;
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}

final servicioGoogleProvider = Provider<ServicioGoogle>((ref) => ServicioGoogle());
