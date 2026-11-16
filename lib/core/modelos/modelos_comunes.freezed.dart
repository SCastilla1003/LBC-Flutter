// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_comunes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EquipoRef {

 String? get id; String? get nombre; String? get urlFoto; String? get color;
/// Create a copy of EquipoRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<EquipoRef> get copyWith => _$EquipoRefCopyWithImpl<EquipoRef>(this as EquipoRef, _$identity);

  /// Serializes this EquipoRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoRef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoRef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoRef;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.urlFoto,_this.color);
}

@override
String toString() {
  final _this = this as EquipoRef;
  return 'EquipoRef(id: ${_this.id}, nombre: ${_this.nombre}, urlFoto: ${_this.urlFoto}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $EquipoRefCopyWith<$Res>  {
  factory $EquipoRefCopyWith(EquipoRef value, $Res Function(EquipoRef) _then) = _$EquipoRefCopyWithImpl;
@useResult
$Res call({
 String? id, String? nombre, String? urlFoto, String? color
});




}
/// @nodoc
class _$EquipoRefCopyWithImpl<$Res>
    implements $EquipoRefCopyWith<$Res> {
  _$EquipoRefCopyWithImpl(this._self, this._then);

  final EquipoRef _self;
  final $Res Function(EquipoRef) _then;

/// Create a copy of EquipoRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? nombre = freezed,Object? urlFoto = freezed,Object? color = freezed,}) {
  return _then(EquipoRef(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EquipoRef].
extension EquipoRefPatterns on EquipoRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoRef value)  $default,){
final _that = this;
switch (_that) {
case _EquipoRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoRef value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? nombre,  String? urlFoto,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoRef() when $default != null:
return $default(_that.id,_that.nombre,_that.urlFoto,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? nombre,  String? urlFoto,  String? color)  $default,) {final _that = this;
switch (_that) {
case _EquipoRef():
return $default(_that.id,_that.nombre,_that.urlFoto,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? nombre,  String? urlFoto,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _EquipoRef() when $default != null:
return $default(_that.id,_that.nombre,_that.urlFoto,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoRef implements EquipoRef {
  const _EquipoRef({this.id, this.nombre, this.urlFoto, this.color});
  factory _EquipoRef.fromJson(Map<String, dynamic> json) => _$EquipoRefFromJson(json);

@override final  String? id;
@override final  String? nombre;
@override final  String? urlFoto;
@override final  String? color;

/// Create a copy of EquipoRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoRefCopyWith<_EquipoRef> get copyWith => __$EquipoRefCopyWithImpl<_EquipoRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoRefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoRef&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,urlFoto,color);
}

@override
String toString() {
    return 'EquipoRef(id: $id, nombre: $nombre, urlFoto: $urlFoto, color: $color)';
}


}

/// @nodoc
abstract mixin class _$EquipoRefCopyWith<$Res> implements $EquipoRefCopyWith<$Res> {
  factory _$EquipoRefCopyWith(_EquipoRef value, $Res Function(_EquipoRef) _then) = __$EquipoRefCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? nombre, String? urlFoto, String? color
});




}
/// @nodoc
class __$EquipoRefCopyWithImpl<$Res>
    implements _$EquipoRefCopyWith<$Res> {
  __$EquipoRefCopyWithImpl(this._self, this._then);

  final _EquipoRef _self;
  final $Res Function(_EquipoRef) _then;

/// Create a copy of EquipoRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? nombre = freezed,Object? urlFoto = freezed,Object? color = freezed,}) {
  return _then(_EquipoRef(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EstadioRef {

 String? get id; String? get nombre; String? get ubicacion;
/// Create a copy of EstadioRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstadioRefCopyWith<EstadioRef> get copyWith => _$EstadioRefCopyWithImpl<EstadioRef>(this as EstadioRef, _$identity);

  /// Serializes this EstadioRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstadioRef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstadioRef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ubicacion, _this.ubicacion) || other.ubicacion == _this.ubicacion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstadioRef;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.ubicacion);
}

@override
String toString() {
  final _this = this as EstadioRef;
  return 'EstadioRef(id: ${_this.id}, nombre: ${_this.nombre}, ubicacion: ${_this.ubicacion})';
}


}

/// @nodoc
abstract mixin class $EstadioRefCopyWith<$Res>  {
  factory $EstadioRefCopyWith(EstadioRef value, $Res Function(EstadioRef) _then) = _$EstadioRefCopyWithImpl;
@useResult
$Res call({
 String? id, String? nombre, String? ubicacion
});




}
/// @nodoc
class _$EstadioRefCopyWithImpl<$Res>
    implements $EstadioRefCopyWith<$Res> {
  _$EstadioRefCopyWithImpl(this._self, this._then);

  final EstadioRef _self;
  final $Res Function(EstadioRef) _then;

/// Create a copy of EstadioRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? nombre = freezed,Object? ubicacion = freezed,}) {
  return _then(EstadioRef(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EstadioRef].
extension EstadioRefPatterns on EstadioRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstadioRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstadioRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstadioRef value)  $default,){
final _that = this;
switch (_that) {
case _EstadioRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstadioRef value)?  $default,){
final _that = this;
switch (_that) {
case _EstadioRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? nombre,  String? ubicacion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstadioRef() when $default != null:
return $default(_that.id,_that.nombre,_that.ubicacion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? nombre,  String? ubicacion)  $default,) {final _that = this;
switch (_that) {
case _EstadioRef():
return $default(_that.id,_that.nombre,_that.ubicacion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? nombre,  String? ubicacion)?  $default,) {final _that = this;
switch (_that) {
case _EstadioRef() when $default != null:
return $default(_that.id,_that.nombre,_that.ubicacion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstadioRef implements EstadioRef {
  const _EstadioRef({this.id, this.nombre, this.ubicacion});
  factory _EstadioRef.fromJson(Map<String, dynamic> json) => _$EstadioRefFromJson(json);

@override final  String? id;
@override final  String? nombre;
@override final  String? ubicacion;

/// Create a copy of EstadioRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstadioRefCopyWith<_EstadioRef> get copyWith => __$EstadioRefCopyWithImpl<_EstadioRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstadioRefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstadioRef&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ubicacion, ubicacion) || other.ubicacion == ubicacion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,ubicacion);
}

@override
String toString() {
    return 'EstadioRef(id: $id, nombre: $nombre, ubicacion: $ubicacion)';
}


}

/// @nodoc
abstract mixin class _$EstadioRefCopyWith<$Res> implements $EstadioRefCopyWith<$Res> {
  factory _$EstadioRefCopyWith(_EstadioRef value, $Res Function(_EstadioRef) _then) = __$EstadioRefCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? nombre, String? ubicacion
});




}
/// @nodoc
class __$EstadioRefCopyWithImpl<$Res>
    implements _$EstadioRefCopyWith<$Res> {
  __$EstadioRefCopyWithImpl(this._self, this._then);

  final _EstadioRef _self;
  final $Res Function(_EstadioRef) _then;

/// Create a copy of EstadioRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? nombre = freezed,Object? ubicacion = freezed,}) {
  return _then(_EstadioRef(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Referencia {

 double? get promedio; double? get minimo; double? get maximo; int get muestras;
/// Create a copy of Referencia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenciaCopyWith<Referencia> get copyWith => _$ReferenciaCopyWithImpl<Referencia>(this as Referencia, _$identity);

  /// Serializes this Referencia to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Referencia;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Referencia&&(identical(other.promedio, _this.promedio) || other.promedio == _this.promedio)&&(identical(other.minimo, _this.minimo) || other.minimo == _this.minimo)&&(identical(other.maximo, _this.maximo) || other.maximo == _this.maximo)&&(identical(other.muestras, _this.muestras) || other.muestras == _this.muestras));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Referencia;
  return Object.hash(runtimeType,_this.promedio,_this.minimo,_this.maximo,_this.muestras);
}

@override
String toString() {
  final _this = this as Referencia;
  return 'Referencia(promedio: ${_this.promedio}, minimo: ${_this.minimo}, maximo: ${_this.maximo}, muestras: ${_this.muestras})';
}


}

/// @nodoc
abstract mixin class $ReferenciaCopyWith<$Res>  {
  factory $ReferenciaCopyWith(Referencia value, $Res Function(Referencia) _then) = _$ReferenciaCopyWithImpl;
@useResult
$Res call({
 double? promedio, double? minimo, double? maximo, int muestras
});




}
/// @nodoc
class _$ReferenciaCopyWithImpl<$Res>
    implements $ReferenciaCopyWith<$Res> {
  _$ReferenciaCopyWithImpl(this._self, this._then);

  final Referencia _self;
  final $Res Function(Referencia) _then;

/// Create a copy of Referencia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? promedio = freezed,Object? minimo = freezed,Object? maximo = freezed,Object? muestras = null,}) {
  return _then(Referencia(
promedio: freezed == promedio ? _self.promedio : promedio // ignore: cast_nullable_to_non_nullable
as double?,minimo: freezed == minimo ? _self.minimo : minimo // ignore: cast_nullable_to_non_nullable
as double?,maximo: freezed == maximo ? _self.maximo : maximo // ignore: cast_nullable_to_non_nullable
as double?,muestras: null == muestras ? _self.muestras : muestras // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Referencia].
extension ReferenciaPatterns on Referencia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Referencia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Referencia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Referencia value)  $default,){
final _that = this;
switch (_that) {
case _Referencia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Referencia value)?  $default,){
final _that = this;
switch (_that) {
case _Referencia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? promedio,  double? minimo,  double? maximo,  int muestras)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Referencia() when $default != null:
return $default(_that.promedio,_that.minimo,_that.maximo,_that.muestras);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? promedio,  double? minimo,  double? maximo,  int muestras)  $default,) {final _that = this;
switch (_that) {
case _Referencia():
return $default(_that.promedio,_that.minimo,_that.maximo,_that.muestras);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? promedio,  double? minimo,  double? maximo,  int muestras)?  $default,) {final _that = this;
switch (_that) {
case _Referencia() when $default != null:
return $default(_that.promedio,_that.minimo,_that.maximo,_that.muestras);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Referencia implements Referencia {
  const _Referencia({this.promedio, this.minimo, this.maximo, this.muestras = 0});
  factory _Referencia.fromJson(Map<String, dynamic> json) => _$ReferenciaFromJson(json);

@override final  double? promedio;
@override final  double? minimo;
@override final  double? maximo;
@override@JsonKey() final  int muestras;

/// Create a copy of Referencia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenciaCopyWith<_Referencia> get copyWith => __$ReferenciaCopyWithImpl<_Referencia>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenciaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Referencia&&(identical(other.promedio, promedio) || other.promedio == promedio)&&(identical(other.minimo, minimo) || other.minimo == minimo)&&(identical(other.maximo, maximo) || other.maximo == maximo)&&(identical(other.muestras, muestras) || other.muestras == muestras));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,promedio,minimo,maximo,muestras);
}

@override
String toString() {
    return 'Referencia(promedio: $promedio, minimo: $minimo, maximo: $maximo, muestras: $muestras)';
}


}

/// @nodoc
abstract mixin class _$ReferenciaCopyWith<$Res> implements $ReferenciaCopyWith<$Res> {
  factory _$ReferenciaCopyWith(_Referencia value, $Res Function(_Referencia) _then) = __$ReferenciaCopyWithImpl;
@override @useResult
$Res call({
 double? promedio, double? minimo, double? maximo, int muestras
});




}
/// @nodoc
class __$ReferenciaCopyWithImpl<$Res>
    implements _$ReferenciaCopyWith<$Res> {
  __$ReferenciaCopyWithImpl(this._self, this._then);

  final _Referencia _self;
  final $Res Function(_Referencia) _then;

/// Create a copy of Referencia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? promedio = freezed,Object? minimo = freezed,Object? maximo = freezed,Object? muestras = null,}) {
  return _then(_Referencia(
promedio: freezed == promedio ? _self.promedio : promedio // ignore: cast_nullable_to_non_nullable
as double?,minimo: freezed == minimo ? _self.minimo : minimo // ignore: cast_nullable_to_non_nullable
as double?,maximo: freezed == maximo ? _self.maximo : maximo // ignore: cast_nullable_to_non_nullable
as double?,muestras: null == muestras ? _self.muestras : muestras // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Foto {

 String get fotoId; String get urlFoto;
/// Create a copy of Foto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FotoCopyWith<Foto> get copyWith => _$FotoCopyWithImpl<Foto>(this as Foto, _$identity);

  /// Serializes this Foto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Foto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Foto&&(identical(other.fotoId, _this.fotoId) || other.fotoId == _this.fotoId)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Foto;
  return Object.hash(runtimeType,_this.fotoId,_this.urlFoto);
}

@override
String toString() {
  final _this = this as Foto;
  return 'Foto(fotoId: ${_this.fotoId}, urlFoto: ${_this.urlFoto})';
}


}

/// @nodoc
abstract mixin class $FotoCopyWith<$Res>  {
  factory $FotoCopyWith(Foto value, $Res Function(Foto) _then) = _$FotoCopyWithImpl;
@useResult
$Res call({
 String fotoId, String urlFoto
});




}
/// @nodoc
class _$FotoCopyWithImpl<$Res>
    implements $FotoCopyWith<$Res> {
  _$FotoCopyWithImpl(this._self, this._then);

  final Foto _self;
  final $Res Function(Foto) _then;

/// Create a copy of Foto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fotoId = null,Object? urlFoto = null,}) {
  return _then(Foto(
fotoId: null == fotoId ? _self.fotoId : fotoId // ignore: cast_nullable_to_non_nullable
as String,urlFoto: null == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Foto].
extension FotoPatterns on Foto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Foto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Foto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Foto value)  $default,){
final _that = this;
switch (_that) {
case _Foto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Foto value)?  $default,){
final _that = this;
switch (_that) {
case _Foto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fotoId,  String urlFoto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Foto() when $default != null:
return $default(_that.fotoId,_that.urlFoto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fotoId,  String urlFoto)  $default,) {final _that = this;
switch (_that) {
case _Foto():
return $default(_that.fotoId,_that.urlFoto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fotoId,  String urlFoto)?  $default,) {final _that = this;
switch (_that) {
case _Foto() when $default != null:
return $default(_that.fotoId,_that.urlFoto);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Foto implements Foto {
  const _Foto({required this.fotoId, required this.urlFoto});
  factory _Foto.fromJson(Map<String, dynamic> json) => _$FotoFromJson(json);

@override final  String fotoId;
@override final  String urlFoto;

/// Create a copy of Foto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FotoCopyWith<_Foto> get copyWith => __$FotoCopyWithImpl<_Foto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FotoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Foto&&(identical(other.fotoId, fotoId) || other.fotoId == fotoId)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,fotoId,urlFoto);
}

@override
String toString() {
    return 'Foto(fotoId: $fotoId, urlFoto: $urlFoto)';
}


}

/// @nodoc
abstract mixin class _$FotoCopyWith<$Res> implements $FotoCopyWith<$Res> {
  factory _$FotoCopyWith(_Foto value, $Res Function(_Foto) _then) = __$FotoCopyWithImpl;
@override @useResult
$Res call({
 String fotoId, String urlFoto
});




}
/// @nodoc
class __$FotoCopyWithImpl<$Res>
    implements _$FotoCopyWith<$Res> {
  __$FotoCopyWithImpl(this._self, this._then);

  final _Foto _self;
  final $Res Function(_Foto) _then;

/// Create a copy of Foto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fotoId = null,Object? urlFoto = null,}) {
  return _then(_Foto(
fotoId: null == fotoId ? _self.fotoId : fotoId // ignore: cast_nullable_to_non_nullable
as String,urlFoto: null == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
