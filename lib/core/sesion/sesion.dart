import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sesion.freezed.dart';
part 'sesion.g.dart';

/// Usuario autenticado tal como lo devuelve la API (`UsuarioDto`).
@freezed
abstract class Usuario with _$Usuario {
  const Usuario._();

  const factory Usuario({
    required String username,
    @Default(<String>[]) List<String> roles,
    @Default('local') String proveedor,
  }) = _Usuario;

  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  bool get esAdmin => roles.contains('ADMIN');

  bool get esAnotador => roles.contains('ANOTADOR');
}

/// Respuesta de login / registro / Google (`AuthResponse`).
@freezed
abstract class RespuestaAuth with _$RespuestaAuth {
  const factory RespuestaAuth({
    required String token,
    @Default('Bearer') String tipo,
    required DateTime expiraEn,
    required Usuario usuario,
  }) = _RespuestaAuth;

  factory RespuestaAuth.fromJson(Map<String, dynamic> json) => _$RespuestaAuthFromJson(json);
}

/// Estado de la sesión. Sin token = visitante (puede ver todo lo público).
class EstadoSesion {
  const EstadoSesion({this.token, this.usuario, this.expiraEn, this.motivoCierre});

  const EstadoSesion.visitante({this.motivoCierre})
      : token = null,
        usuario = null,
        expiraEn = null;

  final String? token;
  final Usuario? usuario;
  final DateTime? expiraEn;

  /// Si la sesión se cerró sola (p. ej. token caducado), por qué.
  final String? motivoCierre;

  bool get autenticado => token != null && usuario != null && !expirada;
  bool get esAdmin => autenticado && usuario!.esAdmin;

  /// Admin o anotador: pueden llevar el marcador en vivo y editar alineaciones.
  bool get puedeAnotar => autenticado && (usuario!.esAdmin || usuario!.esAnotador);
  bool get expirada => expiraEn != null && DateTime.now().isAfter(expiraEn!);
}

/// Guarda el JWT en almacenamiento seguro (Keystore en Android, cifrado en web).
class AlmacenSesion {
  AlmacenSesion([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _clave = 'lbc_sesion';

  Future<EstadoSesion> leer() async {
    try {
      final crudo = await _storage.read(key: _clave);
      if (crudo == null) return const EstadoSesion.visitante();
      final r = RespuestaAuth.fromJson(jsonDecode(crudo) as Map<String, dynamic>);
      final estado = EstadoSesion(token: r.token, usuario: r.usuario, expiraEn: r.expiraEn);
      if (estado.expirada) {
        await borrar();
        return const EstadoSesion.visitante();
      }
      return estado;
    } catch (_) {
      // Datos corruptos o almacenamiento no disponible: empezar sin sesión
      return const EstadoSesion.visitante();
    }
  }

  Future<void> guardar(RespuestaAuth r) => _storage.write(key: _clave, value: jsonEncode(r.toJson()));

  Future<void> borrar() async {
    try {
      await _storage.delete(key: _clave);
    } catch (_) {}
  }
}

final almacenSesionProvider = Provider<AlmacenSesion>((ref) => AlmacenSesion());

/// Sesión leída del almacenamiento antes de arrancar la app (se sobreescribe en main).
final sesionInicialProvider = Provider<EstadoSesion>((ref) => const EstadoSesion.visitante());

class SesionNotifier extends Notifier<EstadoSesion> {
  @override
  EstadoSesion build() => ref.read(sesionInicialProvider);

  Future<void> iniciar(RespuestaAuth respuesta) async {
    await ref.read(almacenSesionProvider).guardar(respuesta);
    state = EstadoSesion(token: respuesta.token, usuario: respuesta.usuario, expiraEn: respuesta.expiraEn);
  }

  Future<void> cerrar({String? motivo}) async {
    await ref.read(almacenSesionProvider).borrar();
    state = EstadoSesion.visitante(motivoCierre: motivo);
  }
}

final sesionProvider = NotifierProvider<SesionNotifier, EstadoSesion>(SesionNotifier.new);
