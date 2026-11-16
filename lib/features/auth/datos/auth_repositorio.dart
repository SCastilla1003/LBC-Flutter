import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/cliente_api.dart';
import '../../../core/sesion/sesion.dart';

class AuthRepositorio {
  AuthRepositorio(this._api);

  final ClienteApi _api;

  Future<RespuestaAuth> login(String usuario, String password) async => RespuestaAuth.fromJson(
      await _api.post('/auth/login', {'username': usuario, 'password': password}) as Map<String, dynamic>);

  Future<RespuestaAuth> registro(String usuario, String password) async => RespuestaAuth.fromJson(
      await _api.post('/auth/registro', {'username': usuario, 'password': password}) as Map<String, dynamic>);

  /// Envía el ID token de Google; la API lo verifica y devuelve su propio JWT.
  Future<RespuestaAuth> google(String idToken) async =>
      RespuestaAuth.fromJson(await _api.post('/auth/google', {'idToken': idToken}) as Map<String, dynamic>);

  Future<Usuario> yo() async => Usuario.fromJson(await _api.get('/auth/yo') as Map<String, dynamic>);
}

final authRepositorioProvider = Provider<AuthRepositorio>((ref) => AuthRepositorio(ref.watch(clienteApiProvider)));
