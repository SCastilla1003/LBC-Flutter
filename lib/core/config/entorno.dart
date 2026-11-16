/// Configuración inyectada al compilar con `--dart-define`.
///
/// La URL de la API nunca se escribe en el código:
/// `flutter run --dart-define=API_BASE_URL=https://<app>.up.railway.app`
abstract final class Entorno {
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Client ID web de Google (opcional). En Android se usa como `serverClientId`
  /// para que el ID token vaya dirigido al backend.
  static const String googleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');

  /// true si API_BASE_URL es una URL http(s) válida.
  static bool get configurado {
    final uri = Uri.tryParse(_apiBaseUrl.trim());
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
  }

  /// URL base sin barra final, p. ej. `https://lbc.up.railway.app`.
  static String get baseUrl {
    final url = _apiBaseUrl.trim();
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  /// Valor crudo recibido (para mostrarlo en la pantalla de configuración inválida).
  static String get valorRecibido => _apiBaseUrl;

  static String get apiUrl => '$baseUrl/api/v1';

  /// Convierte una `urlFoto` relativa de la API (`/api/v1/imagenes/..`) en absoluta.
  static String? urlAbsoluta(String? relativa) {
    if (relativa == null || relativa.isEmpty) return null;
    if (relativa.startsWith('http')) return relativa;
    return '$baseUrl$relativa';
  }

  static bool get googleHabilitado => googleClientId.isNotEmpty;
}
