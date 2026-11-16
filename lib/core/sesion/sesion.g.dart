// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Usuario _$UsuarioFromJson(Map<String, dynamic> json) => _Usuario(
  username: json['username'] as String,
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  proveedor: json['proveedor'] as String? ?? 'local',
);

Map<String, dynamic> _$UsuarioToJson(_Usuario instance) => <String, dynamic>{
  'username': instance.username,
  'roles': instance.roles,
  'proveedor': instance.proveedor,
};

_RespuestaAuth _$RespuestaAuthFromJson(Map<String, dynamic> json) =>
    _RespuestaAuth(
      token: json['token'] as String,
      tipo: json['tipo'] as String? ?? 'Bearer',
      expiraEn: DateTime.parse(json['expiraEn'] as String),
      usuario: Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RespuestaAuthToJson(_RespuestaAuth instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tipo': instance.tipo,
      'expiraEn': instance.expiraEn.toIso8601String(),
      'usuario': instance.usuario.toJson(),
    };
