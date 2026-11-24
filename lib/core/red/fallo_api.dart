import 'package:dio/dio.dart';

/// Error tipado de la API. Toda llamada fallida se convierte en uno de estos,
/// con un mensaje en español listo para mostrar al usuario.
sealed class FalloApi implements Exception {
  const FalloApi(this.mensaje);

  final String mensaje;

  /// true si tiene sentido ofrecer "Reintentar".
  bool get reintentable => true;

  @override
  String toString() => '$runtimeType: $mensaje';

  /// Traduce un error de dio (incluido el cuerpo `{codigo, mensaje, detalles}` de la API).
  factory FalloApi.desde(Object error) {
    if (error is FalloApi) return error;
    if (error is! DioException) {
      return FalloDesconocido('Ocurrió un error inesperado.', error);
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const FalloTiempoAgotado();
      case DioExceptionType.connectionError:
        return const FalloSinConexion();
      case DioExceptionType.cancel:
        return const FalloDesconocido('La solicitud se canceló.');
      case DioExceptionType.badCertificate:
        return const FalloSinConexion('El certificado del servidor no es válido.');
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        break;
    }

    final respuesta = error.response;
    if (respuesta == null) return const FalloSinConexion();

    final cuerpo = respuesta.data;
    String? codigo;
    String? mensaje;
    Map<String, dynamic> detalles = const {};
    if (cuerpo is Map) {
      codigo = cuerpo['codigo'] as String?;
      mensaje = cuerpo['mensaje'] as String?;
      final d = cuerpo['detalles'];
      if (d is Map) detalles = Map<String, dynamic>.from(d);
    }

    final status = respuesta.statusCode ?? 0;
    switch (status) {
      case 400:
        return FalloValidacion(
          mensaje ?? 'Hay datos no válidos en la solicitud.',
          campos: {
            for (final e in detalles.entries)
              if (e.value is String) e.key: e.value as String,
          },
          codigo: codigo,
        );
      case 401:
        return FalloNoAutenticado(mensaje ?? 'Debes iniciar sesión.', codigo: codigo);
      case 403:
        return FalloAccesoDenegado(mensaje ?? 'No tienes permisos para esta acción.');
      case 404:
        return FalloNoEncontrado(mensaje ?? 'No se encontró lo que buscabas.');
      case 409:
        return FalloConflicto(mensaje ?? 'La operación entra en conflicto con los datos actuales.');
      case 413:
      case 415:
        return FalloValidacion(mensaje ?? 'El archivo no es válido.', codigo: codigo);
      default:
        if (status >= 500) {
          return FalloServidor(mensaje ?? 'El servidor tuvo un problema. Inténtalo más tarde.');
        }
        return FalloDesconocido(mensaje ?? 'Respuesta inesperada del servidor.');
    }
  }
}

class FalloSinConexion extends FalloApi {
  const FalloSinConexion([super.mensaje = 'No se pudo conectar con el servidor. Revisa tu conexión a internet.']);
}

class FalloTiempoAgotado extends FalloApi {
  const FalloTiempoAgotado([super.mensaje = 'El servidor tardó demasiado en responder.']);
}

class FalloNoAutenticado extends FalloApi {
  const FalloNoAutenticado(super.mensaje, {this.codigo});

  final String? codigo;

  bool get credencialesInvalidas => codigo == 'CREDENCIALES_INVALIDAS';
}

class FalloAccesoDenegado extends FalloApi {
  const FalloAccesoDenegado(super.mensaje);

  @override
  bool get reintentable => false;
}

class FalloNoEncontrado extends FalloApi {
  const FalloNoEncontrado(super.mensaje);

  @override
  bool get reintentable => false;
}

/// Error de validación (400). [campos] = campo → mensaje, para marcarlos en los formularios.
class FalloValidacion extends FalloApi {
  const FalloValidacion(super.mensaje, {this.campos = const {}, this.codigo});

  final Map<String, String> campos;
  final String? codigo;

  @override
  bool get reintentable => false;
}

class FalloConflicto extends FalloApi {
  const FalloConflicto(super.mensaje);

  @override
  bool get reintentable => false;
}

class FalloServidor extends FalloApi {
  const FalloServidor(super.mensaje);
}

class FalloDesconocido extends FalloApi {
  const FalloDesconocido(super.mensaje, [this.causa]);

  final Object? causa;
}
