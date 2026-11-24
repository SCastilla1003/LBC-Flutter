import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/entorno.dart';
import '../sesion/sesion.dart';
import 'fallo_api.dart';

/// URL de la API (`API_BASE_URL` + `/api/v1`). Solo los tests la sobrescriben.
final urlApiProvider = Provider<String>((ref) => Entorno.apiUrl);

/// Cliente HTTP único de la app. Solo habla con la API de LBC (`API_BASE_URL`).
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ref.watch(urlApiProvider),
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json'},
  ));
  dio.interceptors.add(InterceptorSesion(ref, dio));
  return dio;
});

final clienteApiProvider = Provider<ClienteApi>((ref) => ClienteApi(ref.watch(dioProvider)));

/// Añade el JWT y gestiona los 401: si un token deja de ser válido se cierra la
/// sesión y, si la petición era una lectura, se repite una vez sin token
/// (las lecturas son públicas).
class InterceptorSesion extends Interceptor {
  InterceptorSesion(this._ref, this._dio);

  final Ref _ref;
  final Dio _dio;
  static const _sinToken = 'lbc_sin_token';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sesion = _ref.read(sesionProvider);
    if (options.extra[_sinToken] != true && sesion.token != null) {
      if (sesion.expirada) {
        _ref.read(sesionProvider.notifier).cerrar(motivo: 'Tu sesión expiró. Inicia sesión de nuevo.');
      } else {
        options.headers['Authorization'] = 'Bearer ${sesion.token}';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final req = err.requestOptions;
    final enviabaToken = req.headers.containsKey('Authorization');
    if (err.response?.statusCode == 401 && enviabaToken) {
      await _ref.read(sesionProvider.notifier).cerrar(motivo: 'Tu sesión expiró. Inicia sesión de nuevo.');
      if (req.method == 'GET') {
        try {
          final reintento = req.copyWith(
            headers: Map.of(req.headers)..remove('Authorization'),
            extra: {...req.extra, _sinToken: true},
          );
          return handler.resolve(await _dio.fetch(reintento));
        } on DioException catch (e) {
          return handler.next(e);
        }
      }
    }
    handler.next(err);
  }
}

/// Envoltura de dio que convierte cualquier fallo en [FalloApi].
class ClienteApi {
  ClienteApi(this._dio);

  final Dio _dio;

  Future<dynamic> get(String ruta, {Map<String, dynamic>? query}) =>
      _ejecutar(() => _dio.get(ruta, queryParameters: query));

  Future<dynamic> post(String ruta, [Object? cuerpo]) => _ejecutar(() => _dio.post(ruta, data: cuerpo));

  Future<dynamic> put(String ruta, [Object? cuerpo]) => _ejecutar(() => _dio.put(ruta, data: cuerpo));

  Future<void> delete(String ruta) => _ejecutar(() => _dio.delete(ruta));

  /// Sube un archivo como multipart/form-data en el campo `archivo` (fotos).
  /// El contrato anterior usaba PUT; el v1 usa POST ([post] = true).
  Future<dynamic> subirArchivo(String ruta, List<int> bytes, String nombreArchivo, {bool post = false}) {
    final form = FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes, filename: nombreArchivo)});
    return _ejecutar(() => post ? _dio.post(ruta, data: form) : _dio.put(ruta, data: form));
  }

  Future<dynamic> _ejecutar(Future<Response<dynamic>> Function() llamada) async {
    try {
      final r = await llamada();
      return r.data;
    } catch (e) {
      throw FalloApi.desde(e);
    }
  }
}
