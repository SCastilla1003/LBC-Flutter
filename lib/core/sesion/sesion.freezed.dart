// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sesion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Usuario {

 String get username; List<String> get roles; String get proveedor;
/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioCopyWith<Usuario> get copyWith => _$UsuarioCopyWithImpl<Usuario>(this as Usuario, _$identity);

  /// Serializes this Usuario to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Usuario;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Usuario&&(identical(other.username, _this.username) || other.username == _this.username)&&const DeepCollectionEquality().equals(other.roles, _this.roles)&&(identical(other.proveedor, _this.proveedor) || other.proveedor == _this.proveedor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Usuario;
  return Object.hash(runtimeType,_this.username,const DeepCollectionEquality().hash(_this.roles),_this.proveedor);
}

@override
String toString() {
  final _this = this as Usuario;
  return 'Usuario(username: ${_this.username}, roles: ${_this.roles}, proveedor: ${_this.proveedor})';
}


}

/// @nodoc
abstract mixin class $UsuarioCopyWith<$Res>  {
  factory $UsuarioCopyWith(Usuario value, $Res Function(Usuario) _then) = _$UsuarioCopyWithImpl;
@useResult
$Res call({
 String username, List<String> roles, String proveedor
});




}
/// @nodoc
class _$UsuarioCopyWithImpl<$Res>
    implements $UsuarioCopyWith<$Res> {
  _$UsuarioCopyWithImpl(this._self, this._then);

  final Usuario _self;
  final $Res Function(Usuario) _then;

/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? roles = null,Object? proveedor = null,}) {
  return _then(Usuario(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,proveedor: null == proveedor ? _self.proveedor : proveedor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Usuario].
extension UsuarioPatterns on Usuario {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Usuario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Usuario value)  $default,){
final _that = this;
switch (_that) {
case _Usuario():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Usuario value)?  $default,){
final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  List<String> roles,  String proveedor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that.username,_that.roles,_that.proveedor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  List<String> roles,  String proveedor)  $default,) {final _that = this;
switch (_that) {
case _Usuario():
return $default(_that.username,_that.roles,_that.proveedor);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  List<String> roles,  String proveedor)?  $default,) {final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that.username,_that.roles,_that.proveedor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Usuario extends Usuario {
  const _Usuario({required this.username,  List<String> roles = const <String>[], this.proveedor = 'local'}): _roles = roles,super._();
  factory _Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

@override final  String username;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override@JsonKey() final  String proveedor;

/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsuarioCopyWith<_Usuario> get copyWith => __$UsuarioCopyWithImpl<_Usuario>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsuarioToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Usuario&&(identical(other.username, username) || other.username == username)&&const DeepCollectionEquality().equals(other.roles, _roles)&&(identical(other.proveedor, proveedor) || other.proveedor == proveedor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,username,const DeepCollectionEquality().hash(_roles),proveedor);
}

@override
String toString() {
    return 'Usuario(username: $username, roles: $roles, proveedor: $proveedor)';
}


}

/// @nodoc
abstract mixin class _$UsuarioCopyWith<$Res> implements $UsuarioCopyWith<$Res> {
  factory _$UsuarioCopyWith(_Usuario value, $Res Function(_Usuario) _then) = __$UsuarioCopyWithImpl;
@override @useResult
$Res call({
 String username, List<String> roles, String proveedor
});




}
/// @nodoc
class __$UsuarioCopyWithImpl<$Res>
    implements _$UsuarioCopyWith<$Res> {
  __$UsuarioCopyWithImpl(this._self, this._then);

  final _Usuario _self;
  final $Res Function(_Usuario) _then;

/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? roles = null,Object? proveedor = null,}) {
  return _then(_Usuario(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,proveedor: null == proveedor ? _self.proveedor : proveedor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RespuestaAuth {

 String get token; String get tipo; DateTime get expiraEn; Usuario get usuario;
/// Create a copy of RespuestaAuth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RespuestaAuthCopyWith<RespuestaAuth> get copyWith => _$RespuestaAuthCopyWithImpl<RespuestaAuth>(this as RespuestaAuth, _$identity);

  /// Serializes this RespuestaAuth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RespuestaAuth;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RespuestaAuth&&(identical(other.token, _this.token) || other.token == _this.token)&&(identical(other.tipo, _this.tipo) || other.tipo == _this.tipo)&&(identical(other.expiraEn, _this.expiraEn) || other.expiraEn == _this.expiraEn)&&(identical(other.usuario, _this.usuario) || other.usuario == _this.usuario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RespuestaAuth;
  return Object.hash(runtimeType,_this.token,_this.tipo,_this.expiraEn,_this.usuario);
}

@override
String toString() {
  final _this = this as RespuestaAuth;
  return 'RespuestaAuth(token: ${_this.token}, tipo: ${_this.tipo}, expiraEn: ${_this.expiraEn}, usuario: ${_this.usuario})';
}


}

/// @nodoc
abstract mixin class $RespuestaAuthCopyWith<$Res>  {
  factory $RespuestaAuthCopyWith(RespuestaAuth value, $Res Function(RespuestaAuth) _then) = _$RespuestaAuthCopyWithImpl;
@useResult
$Res call({
 String token, String tipo, DateTime expiraEn, Usuario usuario
});


$UsuarioCopyWith<$Res> get usuario;

}
/// @nodoc
class _$RespuestaAuthCopyWithImpl<$Res>
    implements $RespuestaAuthCopyWith<$Res> {
  _$RespuestaAuthCopyWithImpl(this._self, this._then);

  final RespuestaAuth _self;
  final $Res Function(RespuestaAuth) _then;

/// Create a copy of RespuestaAuth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? tipo = null,Object? expiraEn = null,Object? usuario = null,}) {
  return _then(RespuestaAuth(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,expiraEn: null == expiraEn ? _self.expiraEn : expiraEn // ignore: cast_nullable_to_non_nullable
as DateTime,usuario: null == usuario ? _self.usuario : usuario // ignore: cast_nullable_to_non_nullable
as Usuario,
  ));
}
/// Create a copy of RespuestaAuth
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsuarioCopyWith<$Res> get usuario {
  
  return $UsuarioCopyWith<$Res>(_self.usuario, (value) {
    return _then(_self.copyWith(usuario: value));
  });
}
}


/// Adds pattern-matching-related methods to [RespuestaAuth].
extension RespuestaAuthPatterns on RespuestaAuth {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RespuestaAuth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RespuestaAuth() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RespuestaAuth value)  $default,){
final _that = this;
switch (_that) {
case _RespuestaAuth():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RespuestaAuth value)?  $default,){
final _that = this;
switch (_that) {
case _RespuestaAuth() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String tipo,  DateTime expiraEn,  Usuario usuario)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RespuestaAuth() when $default != null:
return $default(_that.token,_that.tipo,_that.expiraEn,_that.usuario);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String tipo,  DateTime expiraEn,  Usuario usuario)  $default,) {final _that = this;
switch (_that) {
case _RespuestaAuth():
return $default(_that.token,_that.tipo,_that.expiraEn,_that.usuario);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String tipo,  DateTime expiraEn,  Usuario usuario)?  $default,) {final _that = this;
switch (_that) {
case _RespuestaAuth() when $default != null:
return $default(_that.token,_that.tipo,_that.expiraEn,_that.usuario);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RespuestaAuth implements RespuestaAuth {
  const _RespuestaAuth({required this.token, this.tipo = 'Bearer', required this.expiraEn, required this.usuario});
  factory _RespuestaAuth.fromJson(Map<String, dynamic> json) => _$RespuestaAuthFromJson(json);

@override final  String token;
@override@JsonKey() final  String tipo;
@override final  DateTime expiraEn;
@override final  Usuario usuario;

/// Create a copy of RespuestaAuth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RespuestaAuthCopyWith<_RespuestaAuth> get copyWith => __$RespuestaAuthCopyWithImpl<_RespuestaAuth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RespuestaAuthToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RespuestaAuth&&(identical(other.token, token) || other.token == token)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.expiraEn, expiraEn) || other.expiraEn == expiraEn)&&(identical(other.usuario, usuario) || other.usuario == usuario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,token,tipo,expiraEn,usuario);
}

@override
String toString() {
    return 'RespuestaAuth(token: $token, tipo: $tipo, expiraEn: $expiraEn, usuario: $usuario)';
}


}

/// @nodoc
abstract mixin class _$RespuestaAuthCopyWith<$Res> implements $RespuestaAuthCopyWith<$Res> {
  factory _$RespuestaAuthCopyWith(_RespuestaAuth value, $Res Function(_RespuestaAuth) _then) = __$RespuestaAuthCopyWithImpl;
@override @useResult
$Res call({
 String token, String tipo, DateTime expiraEn, Usuario usuario
});


@override $UsuarioCopyWith<$Res> get usuario;

}
/// @nodoc
class __$RespuestaAuthCopyWithImpl<$Res>
    implements _$RespuestaAuthCopyWith<$Res> {
  __$RespuestaAuthCopyWithImpl(this._self, this._then);

  final _RespuestaAuth _self;
  final $Res Function(_RespuestaAuth) _then;

/// Create a copy of RespuestaAuth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? tipo = null,Object? expiraEn = null,Object? usuario = null,}) {
  return _then(_RespuestaAuth(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,expiraEn: null == expiraEn ? _self.expiraEn : expiraEn // ignore: cast_nullable_to_non_nullable
as DateTime,usuario: null == usuario ? _self.usuario : usuario // ignore: cast_nullable_to_non_nullable
as Usuario,
  ));
}

/// Create a copy of RespuestaAuth
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsuarioCopyWith<$Res> get usuario {
  
  return $UsuarioCopyWith<$Res>(_self.usuario, (value) {
    return _then(_self.copyWith(usuario: value));
  });
}
}

// dart format on
