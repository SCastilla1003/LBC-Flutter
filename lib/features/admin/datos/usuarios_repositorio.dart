import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/cliente_api.dart';

/// Rol de una cuenta en la API (`ADMIN`, `ANOTADOR`, `FAN`).
enum RolUsuario {
  aficionado('FAN', 'Aficionado', 'Ve la liga y hace predicciones.'),
  anotador(
    'ANOTADOR',
    'Anotador',
    'Publica las alineaciones de los partidos (y los anotará en vivo).',
  ),
  admin(
    'ADMIN',
    'Administrador',
    'Acceso completo al panel de administración.',
  );

  const RolUsuario(this.api, this.etiqueta, this.descripcion);

  final String api;
  final String etiqueta;
  final String descripcion;

  static RolUsuario desde(String? valor) => values.firstWhere(
    (r) => r.api == valor,
    orElse: () => RolUsuario.aficionado,
  );
}

/// Cuenta registrada, tal como la devuelve `GET /usuarios` (solo ADMIN).
class UsuarioAdmin {
  const UsuarioAdmin({
    required this.id,
    required this.username,
    this.email,
    required this.rol,
    required this.proveedor,
    this.activa = true,
    this.creadoEn,
  });

  factory UsuarioAdmin.fromJson(Map<String, dynamic> j) => UsuarioAdmin(
    id: (j['id'] as num).toInt(),
    username: j['username'] as String,
    email: j['email'] as String?,
    rol: RolUsuario.desde(j['rol'] as String?),
    proveedor: (j['proveedor'] as String?) ?? 'local',
    activa: (j['activa'] as bool?) ?? true,
    creadoEn: DateTime.tryParse((j['creadoEn'] as String?) ?? ''),
  );

  final int id;
  final String username;
  final String? email;
  final RolUsuario rol;

  /// `local` (usuario y contraseña) o `google`.
  final String proveedor;
  final bool activa;
  final DateTime? creadoEn;

  bool get esGoogle => proveedor == 'google';
}

class UsuariosRepositorio {
  UsuariosRepositorio(this._api);

  final ClienteApi _api;

  Future<List<UsuarioAdmin>> usuarios() async => [
    for (final j in await _api.get('/usuarios') as List)
      UsuarioAdmin.fromJson(j as Map<String, dynamic>),
  ];

  Future<UsuarioAdmin> cambiarRol(int id, RolUsuario rol) async =>
      UsuarioAdmin.fromJson(
        await _api.put('/usuarios/$id/rol', {'rol': rol.api})
            as Map<String, dynamic>,
      );
}

final usuariosRepositorioProvider = Provider<UsuariosRepositorio>(
  (ref) => UsuariosRepositorio(ref.watch(clienteApiProvider)),
);

final usuariosAdminProvider = FutureProvider.autoDispose<List<UsuarioAdmin>>(
  (ref) => ref.watch(usuariosRepositorioProvider).usuarios(),
);
