// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_liga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemporadaLiga {

 int get id; String get nombre; int get anio; EstadoTemporadaLiga get estado; DateTime? get fechaInicio; DateTime? get fechaFin;/// Bases (1..3) con corredor automático en cada entrada extra (muerte súbita).
 List<int> get basesMuerteSubita;
/// Create a copy of TemporadaLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemporadaLigaCopyWith<TemporadaLiga> get copyWith => _$TemporadaLigaCopyWithImpl<TemporadaLiga>(this as TemporadaLiga, _$identity);

  /// Serializes this TemporadaLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TemporadaLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemporadaLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.anio, _this.anio) || other.anio == _this.anio)&&(identical(other.estado, _this.estado) || other.estado == _this.estado)&&(identical(other.fechaInicio, _this.fechaInicio) || other.fechaInicio == _this.fechaInicio)&&(identical(other.fechaFin, _this.fechaFin) || other.fechaFin == _this.fechaFin)&&const DeepCollectionEquality().equals(other.basesMuerteSubita, _this.basesMuerteSubita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TemporadaLiga;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.anio,_this.estado,_this.fechaInicio,_this.fechaFin,const DeepCollectionEquality().hash(_this.basesMuerteSubita));
}

@override
String toString() {
  final _this = this as TemporadaLiga;
  return 'TemporadaLiga(id: ${_this.id}, nombre: ${_this.nombre}, anio: ${_this.anio}, estado: ${_this.estado}, fechaInicio: ${_this.fechaInicio}, fechaFin: ${_this.fechaFin}, basesMuerteSubita: ${_this.basesMuerteSubita})';
}


}

/// @nodoc
abstract mixin class $TemporadaLigaCopyWith<$Res>  {
  factory $TemporadaLigaCopyWith(TemporadaLiga value, $Res Function(TemporadaLiga) _then) = _$TemporadaLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombre, int anio, EstadoTemporadaLiga estado, DateTime? fechaInicio, DateTime? fechaFin, List<int> basesMuerteSubita
});




}
/// @nodoc
class _$TemporadaLigaCopyWithImpl<$Res>
    implements $TemporadaLigaCopyWith<$Res> {
  _$TemporadaLigaCopyWithImpl(this._self, this._then);

  final TemporadaLiga _self;
  final $Res Function(TemporadaLiga) _then;

/// Create a copy of TemporadaLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? anio = null,Object? estado = null,Object? fechaInicio = freezed,Object? fechaFin = freezed,Object? basesMuerteSubita = null,}) {
  return _then(TemporadaLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,anio: null == anio ? _self.anio : anio // ignore: cast_nullable_to_non_nullable
as int,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoTemporadaLiga,fechaInicio: freezed == fechaInicio ? _self.fechaInicio : fechaInicio // ignore: cast_nullable_to_non_nullable
as DateTime?,fechaFin: freezed == fechaFin ? _self.fechaFin : fechaFin // ignore: cast_nullable_to_non_nullable
as DateTime?,basesMuerteSubita: null == basesMuerteSubita ? _self.basesMuerteSubita : basesMuerteSubita // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [TemporadaLiga].
extension TemporadaLigaPatterns on TemporadaLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemporadaLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemporadaLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemporadaLiga value)  $default,){
final _that = this;
switch (_that) {
case _TemporadaLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemporadaLiga value)?  $default,){
final _that = this;
switch (_that) {
case _TemporadaLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre,  int anio,  EstadoTemporadaLiga estado,  DateTime? fechaInicio,  DateTime? fechaFin,  List<int> basesMuerteSubita)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemporadaLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.anio,_that.estado,_that.fechaInicio,_that.fechaFin,_that.basesMuerteSubita);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre,  int anio,  EstadoTemporadaLiga estado,  DateTime? fechaInicio,  DateTime? fechaFin,  List<int> basesMuerteSubita)  $default,) {final _that = this;
switch (_that) {
case _TemporadaLiga():
return $default(_that.id,_that.nombre,_that.anio,_that.estado,_that.fechaInicio,_that.fechaFin,_that.basesMuerteSubita);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre,  int anio,  EstadoTemporadaLiga estado,  DateTime? fechaInicio,  DateTime? fechaFin,  List<int> basesMuerteSubita)?  $default,) {final _that = this;
switch (_that) {
case _TemporadaLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.anio,_that.estado,_that.fechaInicio,_that.fechaFin,_that.basesMuerteSubita);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemporadaLiga implements TemporadaLiga {
  const _TemporadaLiga({required this.id, required this.nombre, required this.anio, this.estado = EstadoTemporadaLiga.borrador, this.fechaInicio, this.fechaFin,  List<int> basesMuerteSubita = const <int>[2]}): _basesMuerteSubita = basesMuerteSubita;
  factory _TemporadaLiga.fromJson(Map<String, dynamic> json) => _$TemporadaLigaFromJson(json);

@override final  int id;
@override final  String nombre;
@override final  int anio;
@override@JsonKey() final  EstadoTemporadaLiga estado;
@override final  DateTime? fechaInicio;
@override final  DateTime? fechaFin;
/// Bases (1..3) con corredor automático en cada entrada extra (muerte súbita).
 final  List<int> _basesMuerteSubita;
/// Bases (1..3) con corredor automático en cada entrada extra (muerte súbita).
@override@JsonKey() List<int> get basesMuerteSubita {
  if (_basesMuerteSubita is EqualUnmodifiableListView) return _basesMuerteSubita;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_basesMuerteSubita);
}


/// Create a copy of TemporadaLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemporadaLigaCopyWith<_TemporadaLiga> get copyWith => __$TemporadaLigaCopyWithImpl<_TemporadaLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemporadaLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemporadaLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.anio, anio) || other.anio == anio)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.fechaInicio, fechaInicio) || other.fechaInicio == fechaInicio)&&(identical(other.fechaFin, fechaFin) || other.fechaFin == fechaFin)&&const DeepCollectionEquality().equals(other.basesMuerteSubita, _basesMuerteSubita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,anio,estado,fechaInicio,fechaFin,const DeepCollectionEquality().hash(_basesMuerteSubita));
}

@override
String toString() {
    return 'TemporadaLiga(id: $id, nombre: $nombre, anio: $anio, estado: $estado, fechaInicio: $fechaInicio, fechaFin: $fechaFin, basesMuerteSubita: $basesMuerteSubita)';
}


}

/// @nodoc
abstract mixin class _$TemporadaLigaCopyWith<$Res> implements $TemporadaLigaCopyWith<$Res> {
  factory _$TemporadaLigaCopyWith(_TemporadaLiga value, $Res Function(_TemporadaLiga) _then) = __$TemporadaLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre, int anio, EstadoTemporadaLiga estado, DateTime? fechaInicio, DateTime? fechaFin, List<int> basesMuerteSubita
});




}
/// @nodoc
class __$TemporadaLigaCopyWithImpl<$Res>
    implements _$TemporadaLigaCopyWith<$Res> {
  __$TemporadaLigaCopyWithImpl(this._self, this._then);

  final _TemporadaLiga _self;
  final $Res Function(_TemporadaLiga) _then;

/// Create a copy of TemporadaLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? anio = null,Object? estado = null,Object? fechaInicio = freezed,Object? fechaFin = freezed,Object? basesMuerteSubita = null,}) {
  return _then(_TemporadaLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,anio: null == anio ? _self.anio : anio // ignore: cast_nullable_to_non_nullable
as int,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoTemporadaLiga,fechaInicio: freezed == fechaInicio ? _self.fechaInicio : fechaInicio // ignore: cast_nullable_to_non_nullable
as DateTime?,fechaFin: freezed == fechaFin ? _self.fechaFin : fechaFin // ignore: cast_nullable_to_non_nullable
as DateTime?,basesMuerteSubita: null == basesMuerteSubita ? _self._basesMuerteSubita : basesMuerteSubita // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$EquipoRefLiga {

 int get id; String get nombre; String get abreviatura; String? get color; String? get escudoUrl;
/// Create a copy of EquipoRefLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<EquipoRefLiga> get copyWith => _$EquipoRefLigaCopyWithImpl<EquipoRefLiga>(this as EquipoRefLiga, _$identity);

  /// Serializes this EquipoRefLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoRefLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoRefLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.abreviatura, _this.abreviatura) || other.abreviatura == _this.abreviatura)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.escudoUrl, _this.escudoUrl) || other.escudoUrl == _this.escudoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoRefLiga;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.abreviatura,_this.color,_this.escudoUrl);
}

@override
String toString() {
  final _this = this as EquipoRefLiga;
  return 'EquipoRefLiga(id: ${_this.id}, nombre: ${_this.nombre}, abreviatura: ${_this.abreviatura}, color: ${_this.color}, escudoUrl: ${_this.escudoUrl})';
}


}

/// @nodoc
abstract mixin class $EquipoRefLigaCopyWith<$Res>  {
  factory $EquipoRefLigaCopyWith(EquipoRefLiga value, $Res Function(EquipoRefLiga) _then) = _$EquipoRefLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombre, String abreviatura, String? color, String? escudoUrl
});




}
/// @nodoc
class _$EquipoRefLigaCopyWithImpl<$Res>
    implements $EquipoRefLigaCopyWith<$Res> {
  _$EquipoRefLigaCopyWithImpl(this._self, this._then);

  final EquipoRefLiga _self;
  final $Res Function(EquipoRefLiga) _then;

/// Create a copy of EquipoRefLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? abreviatura = null,Object? color = freezed,Object? escudoUrl = freezed,}) {
  return _then(EquipoRefLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,abreviatura: null == abreviatura ? _self.abreviatura : abreviatura // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,escudoUrl: freezed == escudoUrl ? _self.escudoUrl : escudoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EquipoRefLiga].
extension EquipoRefLigaPatterns on EquipoRefLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoRefLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoRefLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoRefLiga value)  $default,){
final _that = this;
switch (_that) {
case _EquipoRefLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoRefLiga value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoRefLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre,  String abreviatura,  String? color,  String? escudoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoRefLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.abreviatura,_that.color,_that.escudoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre,  String abreviatura,  String? color,  String? escudoUrl)  $default,) {final _that = this;
switch (_that) {
case _EquipoRefLiga():
return $default(_that.id,_that.nombre,_that.abreviatura,_that.color,_that.escudoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre,  String abreviatura,  String? color,  String? escudoUrl)?  $default,) {final _that = this;
switch (_that) {
case _EquipoRefLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.abreviatura,_that.color,_that.escudoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoRefLiga implements EquipoRefLiga {
  const _EquipoRefLiga({required this.id, required this.nombre, required this.abreviatura, this.color, this.escudoUrl});
  factory _EquipoRefLiga.fromJson(Map<String, dynamic> json) => _$EquipoRefLigaFromJson(json);

@override final  int id;
@override final  String nombre;
@override final  String abreviatura;
@override final  String? color;
@override final  String? escudoUrl;

/// Create a copy of EquipoRefLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoRefLigaCopyWith<_EquipoRefLiga> get copyWith => __$EquipoRefLigaCopyWithImpl<_EquipoRefLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoRefLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoRefLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.abreviatura, abreviatura) || other.abreviatura == abreviatura)&&(identical(other.color, color) || other.color == color)&&(identical(other.escudoUrl, escudoUrl) || other.escudoUrl == escudoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,abreviatura,color,escudoUrl);
}

@override
String toString() {
    return 'EquipoRefLiga(id: $id, nombre: $nombre, abreviatura: $abreviatura, color: $color, escudoUrl: $escudoUrl)';
}


}

/// @nodoc
abstract mixin class _$EquipoRefLigaCopyWith<$Res> implements $EquipoRefLigaCopyWith<$Res> {
  factory _$EquipoRefLigaCopyWith(_EquipoRefLiga value, $Res Function(_EquipoRefLiga) _then) = __$EquipoRefLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre, String abreviatura, String? color, String? escudoUrl
});




}
/// @nodoc
class __$EquipoRefLigaCopyWithImpl<$Res>
    implements _$EquipoRefLigaCopyWith<$Res> {
  __$EquipoRefLigaCopyWithImpl(this._self, this._then);

  final _EquipoRefLiga _self;
  final $Res Function(_EquipoRefLiga) _then;

/// Create a copy of EquipoRefLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? abreviatura = null,Object? color = freezed,Object? escudoUrl = freezed,}) {
  return _then(_EquipoRefLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,abreviatura: null == abreviatura ? _self.abreviatura : abreviatura // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,escudoUrl: freezed == escudoUrl ? _self.escudoUrl : escudoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EquipoLiga {

 int get id; String get nombre; String get abreviatura; String? get ciudad; String? get color; String? get escudoUrl;
/// Create a copy of EquipoLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoLigaCopyWith<EquipoLiga> get copyWith => _$EquipoLigaCopyWithImpl<EquipoLiga>(this as EquipoLiga, _$identity);

  /// Serializes this EquipoLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.abreviatura, _this.abreviatura) || other.abreviatura == _this.abreviatura)&&(identical(other.ciudad, _this.ciudad) || other.ciudad == _this.ciudad)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.escudoUrl, _this.escudoUrl) || other.escudoUrl == _this.escudoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoLiga;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.abreviatura,_this.ciudad,_this.color,_this.escudoUrl);
}

@override
String toString() {
  final _this = this as EquipoLiga;
  return 'EquipoLiga(id: ${_this.id}, nombre: ${_this.nombre}, abreviatura: ${_this.abreviatura}, ciudad: ${_this.ciudad}, color: ${_this.color}, escudoUrl: ${_this.escudoUrl})';
}


}

/// @nodoc
abstract mixin class $EquipoLigaCopyWith<$Res>  {
  factory $EquipoLigaCopyWith(EquipoLiga value, $Res Function(EquipoLiga) _then) = _$EquipoLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombre, String abreviatura, String? ciudad, String? color, String? escudoUrl
});




}
/// @nodoc
class _$EquipoLigaCopyWithImpl<$Res>
    implements $EquipoLigaCopyWith<$Res> {
  _$EquipoLigaCopyWithImpl(this._self, this._then);

  final EquipoLiga _self;
  final $Res Function(EquipoLiga) _then;

/// Create a copy of EquipoLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? abreviatura = null,Object? ciudad = freezed,Object? color = freezed,Object? escudoUrl = freezed,}) {
  return _then(EquipoLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,abreviatura: null == abreviatura ? _self.abreviatura : abreviatura // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,escudoUrl: freezed == escudoUrl ? _self.escudoUrl : escudoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EquipoLiga].
extension EquipoLigaPatterns on EquipoLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoLiga value)  $default,){
final _that = this;
switch (_that) {
case _EquipoLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoLiga value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre,  String abreviatura,  String? ciudad,  String? color,  String? escudoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.abreviatura,_that.ciudad,_that.color,_that.escudoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre,  String abreviatura,  String? ciudad,  String? color,  String? escudoUrl)  $default,) {final _that = this;
switch (_that) {
case _EquipoLiga():
return $default(_that.id,_that.nombre,_that.abreviatura,_that.ciudad,_that.color,_that.escudoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre,  String abreviatura,  String? ciudad,  String? color,  String? escudoUrl)?  $default,) {final _that = this;
switch (_that) {
case _EquipoLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.abreviatura,_that.ciudad,_that.color,_that.escudoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoLiga implements EquipoLiga {
  const _EquipoLiga({required this.id, required this.nombre, required this.abreviatura, this.ciudad, this.color, this.escudoUrl});
  factory _EquipoLiga.fromJson(Map<String, dynamic> json) => _$EquipoLigaFromJson(json);

@override final  int id;
@override final  String nombre;
@override final  String abreviatura;
@override final  String? ciudad;
@override final  String? color;
@override final  String? escudoUrl;

/// Create a copy of EquipoLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoLigaCopyWith<_EquipoLiga> get copyWith => __$EquipoLigaCopyWithImpl<_EquipoLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.abreviatura, abreviatura) || other.abreviatura == abreviatura)&&(identical(other.ciudad, ciudad) || other.ciudad == ciudad)&&(identical(other.color, color) || other.color == color)&&(identical(other.escudoUrl, escudoUrl) || other.escudoUrl == escudoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,abreviatura,ciudad,color,escudoUrl);
}

@override
String toString() {
    return 'EquipoLiga(id: $id, nombre: $nombre, abreviatura: $abreviatura, ciudad: $ciudad, color: $color, escudoUrl: $escudoUrl)';
}


}

/// @nodoc
abstract mixin class _$EquipoLigaCopyWith<$Res> implements $EquipoLigaCopyWith<$Res> {
  factory _$EquipoLigaCopyWith(_EquipoLiga value, $Res Function(_EquipoLiga) _then) = __$EquipoLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre, String abreviatura, String? ciudad, String? color, String? escudoUrl
});




}
/// @nodoc
class __$EquipoLigaCopyWithImpl<$Res>
    implements _$EquipoLigaCopyWith<$Res> {
  __$EquipoLigaCopyWithImpl(this._self, this._then);

  final _EquipoLiga _self;
  final $Res Function(_EquipoLiga) _then;

/// Create a copy of EquipoLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? abreviatura = null,Object? ciudad = freezed,Object? color = freezed,Object? escudoUrl = freezed,}) {
  return _then(_EquipoLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,abreviatura: null == abreviatura ? _self.abreviatura : abreviatura // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,escudoUrl: freezed == escudoUrl ? _self.escudoUrl : escudoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EstadioLiga {

 int get id; String get nombre; String? get ubicacion;
/// Create a copy of EstadioLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstadioLigaCopyWith<EstadioLiga> get copyWith => _$EstadioLigaCopyWithImpl<EstadioLiga>(this as EstadioLiga, _$identity);

  /// Serializes this EstadioLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstadioLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstadioLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ubicacion, _this.ubicacion) || other.ubicacion == _this.ubicacion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstadioLiga;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.ubicacion);
}

@override
String toString() {
  final _this = this as EstadioLiga;
  return 'EstadioLiga(id: ${_this.id}, nombre: ${_this.nombre}, ubicacion: ${_this.ubicacion})';
}


}

/// @nodoc
abstract mixin class $EstadioLigaCopyWith<$Res>  {
  factory $EstadioLigaCopyWith(EstadioLiga value, $Res Function(EstadioLiga) _then) = _$EstadioLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombre, String? ubicacion
});




}
/// @nodoc
class _$EstadioLigaCopyWithImpl<$Res>
    implements $EstadioLigaCopyWith<$Res> {
  _$EstadioLigaCopyWithImpl(this._self, this._then);

  final EstadioLiga _self;
  final $Res Function(EstadioLiga) _then;

/// Create a copy of EstadioLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? ubicacion = freezed,}) {
  return _then(EstadioLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EstadioLiga].
extension EstadioLigaPatterns on EstadioLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstadioLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstadioLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstadioLiga value)  $default,){
final _that = this;
switch (_that) {
case _EstadioLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstadioLiga value)?  $default,){
final _that = this;
switch (_that) {
case _EstadioLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre,  String? ubicacion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstadioLiga() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre,  String? ubicacion)  $default,) {final _that = this;
switch (_that) {
case _EstadioLiga():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre,  String? ubicacion)?  $default,) {final _that = this;
switch (_that) {
case _EstadioLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.ubicacion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstadioLiga implements EstadioLiga {
  const _EstadioLiga({required this.id, required this.nombre, this.ubicacion});
  factory _EstadioLiga.fromJson(Map<String, dynamic> json) => _$EstadioLigaFromJson(json);

@override final  int id;
@override final  String nombre;
@override final  String? ubicacion;

/// Create a copy of EstadioLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstadioLigaCopyWith<_EstadioLiga> get copyWith => __$EstadioLigaCopyWithImpl<_EstadioLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstadioLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstadioLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ubicacion, ubicacion) || other.ubicacion == ubicacion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,ubicacion);
}

@override
String toString() {
    return 'EstadioLiga(id: $id, nombre: $nombre, ubicacion: $ubicacion)';
}


}

/// @nodoc
abstract mixin class _$EstadioLigaCopyWith<$Res> implements $EstadioLigaCopyWith<$Res> {
  factory _$EstadioLigaCopyWith(_EstadioLiga value, $Res Function(_EstadioLiga) _then) = __$EstadioLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre, String? ubicacion
});




}
/// @nodoc
class __$EstadioLigaCopyWithImpl<$Res>
    implements _$EstadioLigaCopyWith<$Res> {
  __$EstadioLigaCopyWithImpl(this._self, this._then);

  final _EstadioLiga _self;
  final $Res Function(_EstadioLiga) _then;

/// Create a copy of EstadioLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? ubicacion = freezed,}) {
  return _then(_EstadioLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JugadorResumenLiga {

 int get id; String get nombres; String get apellidos; LadoBateo? get batea; LadoLanzamiento? get lanza; String? get fotoUrl; bool get esLanzador;
/// Create a copy of JugadorResumenLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<JugadorResumenLiga> get copyWith => _$JugadorResumenLigaCopyWithImpl<JugadorResumenLiga>(this as JugadorResumenLiga, _$identity);

  /// Serializes this JugadorResumenLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JugadorResumenLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JugadorResumenLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombres, _this.nombres) || other.nombres == _this.nombres)&&(identical(other.apellidos, _this.apellidos) || other.apellidos == _this.apellidos)&&(identical(other.batea, _this.batea) || other.batea == _this.batea)&&(identical(other.lanza, _this.lanza) || other.lanza == _this.lanza)&&(identical(other.fotoUrl, _this.fotoUrl) || other.fotoUrl == _this.fotoUrl)&&(identical(other.esLanzador, _this.esLanzador) || other.esLanzador == _this.esLanzador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JugadorResumenLiga;
  return Object.hash(runtimeType,_this.id,_this.nombres,_this.apellidos,_this.batea,_this.lanza,_this.fotoUrl,_this.esLanzador);
}

@override
String toString() {
  final _this = this as JugadorResumenLiga;
  return 'JugadorResumenLiga(id: ${_this.id}, nombres: ${_this.nombres}, apellidos: ${_this.apellidos}, batea: ${_this.batea}, lanza: ${_this.lanza}, fotoUrl: ${_this.fotoUrl}, esLanzador: ${_this.esLanzador})';
}


}

/// @nodoc
abstract mixin class $JugadorResumenLigaCopyWith<$Res>  {
  factory $JugadorResumenLigaCopyWith(JugadorResumenLiga value, $Res Function(JugadorResumenLiga) _then) = _$JugadorResumenLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombres, String apellidos, LadoBateo? batea, LadoLanzamiento? lanza, String? fotoUrl, bool esLanzador
});




}
/// @nodoc
class _$JugadorResumenLigaCopyWithImpl<$Res>
    implements $JugadorResumenLigaCopyWith<$Res> {
  _$JugadorResumenLigaCopyWithImpl(this._self, this._then);

  final JugadorResumenLiga _self;
  final $Res Function(JugadorResumenLiga) _then;

/// Create a copy of JugadorResumenLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombres = null,Object? apellidos = null,Object? batea = freezed,Object? lanza = freezed,Object? fotoUrl = freezed,Object? esLanzador = null,}) {
  return _then(JugadorResumenLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombres: null == nombres ? _self.nombres : nombres // ignore: cast_nullable_to_non_nullable
as String,apellidos: null == apellidos ? _self.apellidos : apellidos // ignore: cast_nullable_to_non_nullable
as String,batea: freezed == batea ? _self.batea : batea // ignore: cast_nullable_to_non_nullable
as LadoBateo?,lanza: freezed == lanza ? _self.lanza : lanza // ignore: cast_nullable_to_non_nullable
as LadoLanzamiento?,fotoUrl: freezed == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String?,esLanzador: null == esLanzador ? _self.esLanzador : esLanzador // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [JugadorResumenLiga].
extension JugadorResumenLigaPatterns on JugadorResumenLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JugadorResumenLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JugadorResumenLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JugadorResumenLiga value)  $default,){
final _that = this;
switch (_that) {
case _JugadorResumenLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JugadorResumenLiga value)?  $default,){
final _that = this;
switch (_that) {
case _JugadorResumenLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombres,  String apellidos,  LadoBateo? batea,  LadoLanzamiento? lanza,  String? fotoUrl,  bool esLanzador)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JugadorResumenLiga() when $default != null:
return $default(_that.id,_that.nombres,_that.apellidos,_that.batea,_that.lanza,_that.fotoUrl,_that.esLanzador);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombres,  String apellidos,  LadoBateo? batea,  LadoLanzamiento? lanza,  String? fotoUrl,  bool esLanzador)  $default,) {final _that = this;
switch (_that) {
case _JugadorResumenLiga():
return $default(_that.id,_that.nombres,_that.apellidos,_that.batea,_that.lanza,_that.fotoUrl,_that.esLanzador);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombres,  String apellidos,  LadoBateo? batea,  LadoLanzamiento? lanza,  String? fotoUrl,  bool esLanzador)?  $default,) {final _that = this;
switch (_that) {
case _JugadorResumenLiga() when $default != null:
return $default(_that.id,_that.nombres,_that.apellidos,_that.batea,_that.lanza,_that.fotoUrl,_that.esLanzador);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JugadorResumenLiga implements JugadorResumenLiga {
  const _JugadorResumenLiga({required this.id, required this.nombres, required this.apellidos, this.batea, this.lanza, this.fotoUrl, this.esLanzador = false});
  factory _JugadorResumenLiga.fromJson(Map<String, dynamic> json) => _$JugadorResumenLigaFromJson(json);

@override final  int id;
@override final  String nombres;
@override final  String apellidos;
@override final  LadoBateo? batea;
@override final  LadoLanzamiento? lanza;
@override final  String? fotoUrl;
@override@JsonKey() final  bool esLanzador;

/// Create a copy of JugadorResumenLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JugadorResumenLigaCopyWith<_JugadorResumenLiga> get copyWith => __$JugadorResumenLigaCopyWithImpl<_JugadorResumenLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JugadorResumenLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JugadorResumenLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombres, nombres) || other.nombres == nombres)&&(identical(other.apellidos, apellidos) || other.apellidos == apellidos)&&(identical(other.batea, batea) || other.batea == batea)&&(identical(other.lanza, lanza) || other.lanza == lanza)&&(identical(other.fotoUrl, fotoUrl) || other.fotoUrl == fotoUrl)&&(identical(other.esLanzador, esLanzador) || other.esLanzador == esLanzador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombres,apellidos,batea,lanza,fotoUrl,esLanzador);
}

@override
String toString() {
    return 'JugadorResumenLiga(id: $id, nombres: $nombres, apellidos: $apellidos, batea: $batea, lanza: $lanza, fotoUrl: $fotoUrl, esLanzador: $esLanzador)';
}


}

/// @nodoc
abstract mixin class _$JugadorResumenLigaCopyWith<$Res> implements $JugadorResumenLigaCopyWith<$Res> {
  factory _$JugadorResumenLigaCopyWith(_JugadorResumenLiga value, $Res Function(_JugadorResumenLiga) _then) = __$JugadorResumenLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombres, String apellidos, LadoBateo? batea, LadoLanzamiento? lanza, String? fotoUrl, bool esLanzador
});




}
/// @nodoc
class __$JugadorResumenLigaCopyWithImpl<$Res>
    implements _$JugadorResumenLigaCopyWith<$Res> {
  __$JugadorResumenLigaCopyWithImpl(this._self, this._then);

  final _JugadorResumenLiga _self;
  final $Res Function(_JugadorResumenLiga) _then;

/// Create a copy of JugadorResumenLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombres = null,Object? apellidos = null,Object? batea = freezed,Object? lanza = freezed,Object? fotoUrl = freezed,Object? esLanzador = null,}) {
  return _then(_JugadorResumenLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombres: null == nombres ? _self.nombres : nombres // ignore: cast_nullable_to_non_nullable
as String,apellidos: null == apellidos ? _self.apellidos : apellidos // ignore: cast_nullable_to_non_nullable
as String,batea: freezed == batea ? _self.batea : batea // ignore: cast_nullable_to_non_nullable
as LadoBateo?,lanza: freezed == lanza ? _self.lanza : lanza // ignore: cast_nullable_to_non_nullable
as LadoLanzamiento?,fotoUrl: freezed == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String?,esLanzador: null == esLanzador ? _self.esLanzador : esLanzador // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$JugadorLiga {

 int get id; String get nombres; String get apellidos; DateTime? get fechaNacimiento; int? get edad; LadoBateo? get batea;/// Mano con la que lanza (la tienen todos los jugadores).
 LadoLanzamiento? get lanza; String? get fotoUrl;/// Es pitcher.
 bool get esLanzador;
/// Create a copy of JugadorLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JugadorLigaCopyWith<JugadorLiga> get copyWith => _$JugadorLigaCopyWithImpl<JugadorLiga>(this as JugadorLiga, _$identity);

  /// Serializes this JugadorLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JugadorLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JugadorLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombres, _this.nombres) || other.nombres == _this.nombres)&&(identical(other.apellidos, _this.apellidos) || other.apellidos == _this.apellidos)&&(identical(other.fechaNacimiento, _this.fechaNacimiento) || other.fechaNacimiento == _this.fechaNacimiento)&&(identical(other.edad, _this.edad) || other.edad == _this.edad)&&(identical(other.batea, _this.batea) || other.batea == _this.batea)&&(identical(other.lanza, _this.lanza) || other.lanza == _this.lanza)&&(identical(other.fotoUrl, _this.fotoUrl) || other.fotoUrl == _this.fotoUrl)&&(identical(other.esLanzador, _this.esLanzador) || other.esLanzador == _this.esLanzador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JugadorLiga;
  return Object.hash(runtimeType,_this.id,_this.nombres,_this.apellidos,_this.fechaNacimiento,_this.edad,_this.batea,_this.lanza,_this.fotoUrl,_this.esLanzador);
}

@override
String toString() {
  final _this = this as JugadorLiga;
  return 'JugadorLiga(id: ${_this.id}, nombres: ${_this.nombres}, apellidos: ${_this.apellidos}, fechaNacimiento: ${_this.fechaNacimiento}, edad: ${_this.edad}, batea: ${_this.batea}, lanza: ${_this.lanza}, fotoUrl: ${_this.fotoUrl}, esLanzador: ${_this.esLanzador})';
}


}

/// @nodoc
abstract mixin class $JugadorLigaCopyWith<$Res>  {
  factory $JugadorLigaCopyWith(JugadorLiga value, $Res Function(JugadorLiga) _then) = _$JugadorLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombres, String apellidos, DateTime? fechaNacimiento, int? edad, LadoBateo? batea, LadoLanzamiento? lanza, String? fotoUrl, bool esLanzador
});




}
/// @nodoc
class _$JugadorLigaCopyWithImpl<$Res>
    implements $JugadorLigaCopyWith<$Res> {
  _$JugadorLigaCopyWithImpl(this._self, this._then);

  final JugadorLiga _self;
  final $Res Function(JugadorLiga) _then;

/// Create a copy of JugadorLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombres = null,Object? apellidos = null,Object? fechaNacimiento = freezed,Object? edad = freezed,Object? batea = freezed,Object? lanza = freezed,Object? fotoUrl = freezed,Object? esLanzador = null,}) {
  return _then(JugadorLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombres: null == nombres ? _self.nombres : nombres // ignore: cast_nullable_to_non_nullable
as String,apellidos: null == apellidos ? _self.apellidos : apellidos // ignore: cast_nullable_to_non_nullable
as String,fechaNacimiento: freezed == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime?,edad: freezed == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int?,batea: freezed == batea ? _self.batea : batea // ignore: cast_nullable_to_non_nullable
as LadoBateo?,lanza: freezed == lanza ? _self.lanza : lanza // ignore: cast_nullable_to_non_nullable
as LadoLanzamiento?,fotoUrl: freezed == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String?,esLanzador: null == esLanzador ? _self.esLanzador : esLanzador // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [JugadorLiga].
extension JugadorLigaPatterns on JugadorLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JugadorLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JugadorLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JugadorLiga value)  $default,){
final _that = this;
switch (_that) {
case _JugadorLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JugadorLiga value)?  $default,){
final _that = this;
switch (_that) {
case _JugadorLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombres,  String apellidos,  DateTime? fechaNacimiento,  int? edad,  LadoBateo? batea,  LadoLanzamiento? lanza,  String? fotoUrl,  bool esLanzador)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JugadorLiga() when $default != null:
return $default(_that.id,_that.nombres,_that.apellidos,_that.fechaNacimiento,_that.edad,_that.batea,_that.lanza,_that.fotoUrl,_that.esLanzador);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombres,  String apellidos,  DateTime? fechaNacimiento,  int? edad,  LadoBateo? batea,  LadoLanzamiento? lanza,  String? fotoUrl,  bool esLanzador)  $default,) {final _that = this;
switch (_that) {
case _JugadorLiga():
return $default(_that.id,_that.nombres,_that.apellidos,_that.fechaNacimiento,_that.edad,_that.batea,_that.lanza,_that.fotoUrl,_that.esLanzador);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombres,  String apellidos,  DateTime? fechaNacimiento,  int? edad,  LadoBateo? batea,  LadoLanzamiento? lanza,  String? fotoUrl,  bool esLanzador)?  $default,) {final _that = this;
switch (_that) {
case _JugadorLiga() when $default != null:
return $default(_that.id,_that.nombres,_that.apellidos,_that.fechaNacimiento,_that.edad,_that.batea,_that.lanza,_that.fotoUrl,_that.esLanzador);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JugadorLiga implements JugadorLiga {
  const _JugadorLiga({required this.id, required this.nombres, required this.apellidos, this.fechaNacimiento, this.edad, this.batea, this.lanza, this.fotoUrl, this.esLanzador = false});
  factory _JugadorLiga.fromJson(Map<String, dynamic> json) => _$JugadorLigaFromJson(json);

@override final  int id;
@override final  String nombres;
@override final  String apellidos;
@override final  DateTime? fechaNacimiento;
@override final  int? edad;
@override final  LadoBateo? batea;
/// Mano con la que lanza (la tienen todos los jugadores).
@override final  LadoLanzamiento? lanza;
@override final  String? fotoUrl;
/// Es pitcher.
@override@JsonKey() final  bool esLanzador;

/// Create a copy of JugadorLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JugadorLigaCopyWith<_JugadorLiga> get copyWith => __$JugadorLigaCopyWithImpl<_JugadorLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JugadorLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JugadorLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombres, nombres) || other.nombres == nombres)&&(identical(other.apellidos, apellidos) || other.apellidos == apellidos)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento)&&(identical(other.edad, edad) || other.edad == edad)&&(identical(other.batea, batea) || other.batea == batea)&&(identical(other.lanza, lanza) || other.lanza == lanza)&&(identical(other.fotoUrl, fotoUrl) || other.fotoUrl == fotoUrl)&&(identical(other.esLanzador, esLanzador) || other.esLanzador == esLanzador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombres,apellidos,fechaNacimiento,edad,batea,lanza,fotoUrl,esLanzador);
}

@override
String toString() {
    return 'JugadorLiga(id: $id, nombres: $nombres, apellidos: $apellidos, fechaNacimiento: $fechaNacimiento, edad: $edad, batea: $batea, lanza: $lanza, fotoUrl: $fotoUrl, esLanzador: $esLanzador)';
}


}

/// @nodoc
abstract mixin class _$JugadorLigaCopyWith<$Res> implements $JugadorLigaCopyWith<$Res> {
  factory _$JugadorLigaCopyWith(_JugadorLiga value, $Res Function(_JugadorLiga) _then) = __$JugadorLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombres, String apellidos, DateTime? fechaNacimiento, int? edad, LadoBateo? batea, LadoLanzamiento? lanza, String? fotoUrl, bool esLanzador
});




}
/// @nodoc
class __$JugadorLigaCopyWithImpl<$Res>
    implements _$JugadorLigaCopyWith<$Res> {
  __$JugadorLigaCopyWithImpl(this._self, this._then);

  final _JugadorLiga _self;
  final $Res Function(_JugadorLiga) _then;

/// Create a copy of JugadorLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombres = null,Object? apellidos = null,Object? fechaNacimiento = freezed,Object? edad = freezed,Object? batea = freezed,Object? lanza = freezed,Object? fotoUrl = freezed,Object? esLanzador = null,}) {
  return _then(_JugadorLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombres: null == nombres ? _self.nombres : nombres // ignore: cast_nullable_to_non_nullable
as String,apellidos: null == apellidos ? _self.apellidos : apellidos // ignore: cast_nullable_to_non_nullable
as String,fechaNacimiento: freezed == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime?,edad: freezed == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int?,batea: freezed == batea ? _self.batea : batea // ignore: cast_nullable_to_non_nullable
as LadoBateo?,lanza: freezed == lanza ? _self.lanza : lanza // ignore: cast_nullable_to_non_nullable
as LadoLanzamiento?,fotoUrl: freezed == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String?,esLanzador: null == esLanzador ? _self.esLanzador : esLanzador // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PlantillaLiga {

 int get id; JugadorResumenLiga get jugador; EquipoRefLiga? get equipo; int? get numero; String? get posicion;
/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlantillaLigaCopyWith<PlantillaLiga> get copyWith => _$PlantillaLigaCopyWithImpl<PlantillaLiga>(this as PlantillaLiga, _$identity);

  /// Serializes this PlantillaLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlantillaLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlantillaLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.jugador, _this.jugador) || other.jugador == _this.jugador)&&(identical(other.equipo, _this.equipo) || other.equipo == _this.equipo)&&(identical(other.numero, _this.numero) || other.numero == _this.numero)&&(identical(other.posicion, _this.posicion) || other.posicion == _this.posicion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlantillaLiga;
  return Object.hash(runtimeType,_this.id,_this.jugador,_this.equipo,_this.numero,_this.posicion);
}

@override
String toString() {
  final _this = this as PlantillaLiga;
  return 'PlantillaLiga(id: ${_this.id}, jugador: ${_this.jugador}, equipo: ${_this.equipo}, numero: ${_this.numero}, posicion: ${_this.posicion})';
}


}

/// @nodoc
abstract mixin class $PlantillaLigaCopyWith<$Res>  {
  factory $PlantillaLigaCopyWith(PlantillaLiga value, $Res Function(PlantillaLiga) _then) = _$PlantillaLigaCopyWithImpl;
@useResult
$Res call({
 int id, JugadorResumenLiga jugador, EquipoRefLiga? equipo, int? numero, String? posicion
});


$JugadorResumenLigaCopyWith<$Res> get jugador;$EquipoRefLigaCopyWith<$Res>? get equipo;

}
/// @nodoc
class _$PlantillaLigaCopyWithImpl<$Res>
    implements $PlantillaLigaCopyWith<$Res> {
  _$PlantillaLigaCopyWithImpl(this._self, this._then);

  final PlantillaLiga _self;
  final $Res Function(PlantillaLiga) _then;

/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jugador = null,Object? equipo = freezed,Object? numero = freezed,Object? posicion = freezed,}) {
  return _then(PlantillaLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga,equipo: freezed == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga?,numero: freezed == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as int?,posicion: freezed == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res> get jugador {
  
  return $JugadorResumenLigaCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res>? get equipo {
    if (_self.equipo == null) {
    return null;
  }

  return $EquipoRefLigaCopyWith<$Res>(_self.equipo!, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlantillaLiga].
extension PlantillaLigaPatterns on PlantillaLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlantillaLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlantillaLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlantillaLiga value)  $default,){
final _that = this;
switch (_that) {
case _PlantillaLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlantillaLiga value)?  $default,){
final _that = this;
switch (_that) {
case _PlantillaLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  JugadorResumenLiga jugador,  EquipoRefLiga? equipo,  int? numero,  String? posicion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlantillaLiga() when $default != null:
return $default(_that.id,_that.jugador,_that.equipo,_that.numero,_that.posicion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  JugadorResumenLiga jugador,  EquipoRefLiga? equipo,  int? numero,  String? posicion)  $default,) {final _that = this;
switch (_that) {
case _PlantillaLiga():
return $default(_that.id,_that.jugador,_that.equipo,_that.numero,_that.posicion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  JugadorResumenLiga jugador,  EquipoRefLiga? equipo,  int? numero,  String? posicion)?  $default,) {final _that = this;
switch (_that) {
case _PlantillaLiga() when $default != null:
return $default(_that.id,_that.jugador,_that.equipo,_that.numero,_that.posicion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlantillaLiga implements PlantillaLiga {
  const _PlantillaLiga({required this.id, required this.jugador, this.equipo, this.numero, this.posicion});
  factory _PlantillaLiga.fromJson(Map<String, dynamic> json) => _$PlantillaLigaFromJson(json);

@override final  int id;
@override final  JugadorResumenLiga jugador;
@override final  EquipoRefLiga? equipo;
@override final  int? numero;
@override final  String? posicion;

/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlantillaLigaCopyWith<_PlantillaLiga> get copyWith => __$PlantillaLigaCopyWithImpl<_PlantillaLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlantillaLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlantillaLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.jugador, jugador) || other.jugador == jugador)&&(identical(other.equipo, equipo) || other.equipo == equipo)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.posicion, posicion) || other.posicion == posicion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,jugador,equipo,numero,posicion);
}

@override
String toString() {
    return 'PlantillaLiga(id: $id, jugador: $jugador, equipo: $equipo, numero: $numero, posicion: $posicion)';
}


}

/// @nodoc
abstract mixin class _$PlantillaLigaCopyWith<$Res> implements $PlantillaLigaCopyWith<$Res> {
  factory _$PlantillaLigaCopyWith(_PlantillaLiga value, $Res Function(_PlantillaLiga) _then) = __$PlantillaLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, JugadorResumenLiga jugador, EquipoRefLiga? equipo, int? numero, String? posicion
});


@override $JugadorResumenLigaCopyWith<$Res> get jugador;@override $EquipoRefLigaCopyWith<$Res>? get equipo;

}
/// @nodoc
class __$PlantillaLigaCopyWithImpl<$Res>
    implements _$PlantillaLigaCopyWith<$Res> {
  __$PlantillaLigaCopyWithImpl(this._self, this._then);

  final _PlantillaLiga _self;
  final $Res Function(_PlantillaLiga) _then;

/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jugador = null,Object? equipo = freezed,Object? numero = freezed,Object? posicion = freezed,}) {
  return _then(_PlantillaLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga,equipo: freezed == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga?,numero: freezed == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as int?,posicion: freezed == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res> get jugador {
  
  return $JugadorResumenLigaCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}/// Create a copy of PlantillaLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res>? get equipo {
    if (_self.equipo == null) {
    return null;
  }

  return $EquipoRefLigaCopyWith<$Res>(_self.equipo!, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}
}


/// @nodoc
mixin _$JugadorRefLiga {

 int get id; String get nombre;
/// Create a copy of JugadorRefLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<JugadorRefLiga> get copyWith => _$JugadorRefLigaCopyWithImpl<JugadorRefLiga>(this as JugadorRefLiga, _$identity);

  /// Serializes this JugadorRefLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JugadorRefLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JugadorRefLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JugadorRefLiga;
  return Object.hash(runtimeType,_this.id,_this.nombre);
}

@override
String toString() {
  final _this = this as JugadorRefLiga;
  return 'JugadorRefLiga(id: ${_this.id}, nombre: ${_this.nombre})';
}


}

/// @nodoc
abstract mixin class $JugadorRefLigaCopyWith<$Res>  {
  factory $JugadorRefLigaCopyWith(JugadorRefLiga value, $Res Function(JugadorRefLiga) _then) = _$JugadorRefLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombre
});




}
/// @nodoc
class _$JugadorRefLigaCopyWithImpl<$Res>
    implements $JugadorRefLigaCopyWith<$Res> {
  _$JugadorRefLigaCopyWithImpl(this._self, this._then);

  final JugadorRefLiga _self;
  final $Res Function(JugadorRefLiga) _then;

/// Create a copy of JugadorRefLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,}) {
  return _then(JugadorRefLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JugadorRefLiga].
extension JugadorRefLigaPatterns on JugadorRefLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JugadorRefLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JugadorRefLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JugadorRefLiga value)  $default,){
final _that = this;
switch (_that) {
case _JugadorRefLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JugadorRefLiga value)?  $default,){
final _that = this;
switch (_that) {
case _JugadorRefLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JugadorRefLiga() when $default != null:
return $default(_that.id,_that.nombre);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre)  $default,) {final _that = this;
switch (_that) {
case _JugadorRefLiga():
return $default(_that.id,_that.nombre);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre)?  $default,) {final _that = this;
switch (_that) {
case _JugadorRefLiga() when $default != null:
return $default(_that.id,_that.nombre);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JugadorRefLiga implements JugadorRefLiga {
  const _JugadorRefLiga({required this.id, required this.nombre});
  factory _JugadorRefLiga.fromJson(Map<String, dynamic> json) => _$JugadorRefLigaFromJson(json);

@override final  int id;
@override final  String nombre;

/// Create a copy of JugadorRefLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JugadorRefLigaCopyWith<_JugadorRefLiga> get copyWith => __$JugadorRefLigaCopyWithImpl<_JugadorRefLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JugadorRefLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JugadorRefLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre);
}

@override
String toString() {
    return 'JugadorRefLiga(id: $id, nombre: $nombre)';
}


}

/// @nodoc
abstract mixin class _$JugadorRefLigaCopyWith<$Res> implements $JugadorRefLigaCopyWith<$Res> {
  factory _$JugadorRefLigaCopyWith(_JugadorRefLiga value, $Res Function(_JugadorRefLiga) _then) = __$JugadorRefLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre
});




}
/// @nodoc
class __$JugadorRefLigaCopyWithImpl<$Res>
    implements _$JugadorRefLigaCopyWith<$Res> {
  __$JugadorRefLigaCopyWithImpl(this._self, this._then);

  final _JugadorRefLiga _self;
  final $Res Function(_JugadorRefLiga) _then;

/// Create a copy of JugadorRefLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,}) {
  return _then(_JugadorRefLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ParLocalVisita {

 int get local; int get visita;
/// Create a copy of ParLocalVisita
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<ParLocalVisita> get copyWith => _$ParLocalVisitaCopyWithImpl<ParLocalVisita>(this as ParLocalVisita, _$identity);

  /// Serializes this ParLocalVisita to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParLocalVisita;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParLocalVisita&&(identical(other.local, _this.local) || other.local == _this.local)&&(identical(other.visita, _this.visita) || other.visita == _this.visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParLocalVisita;
  return Object.hash(runtimeType,_this.local,_this.visita);
}

@override
String toString() {
  final _this = this as ParLocalVisita;
  return 'ParLocalVisita(local: ${_this.local}, visita: ${_this.visita})';
}


}

/// @nodoc
abstract mixin class $ParLocalVisitaCopyWith<$Res>  {
  factory $ParLocalVisitaCopyWith(ParLocalVisita value, $Res Function(ParLocalVisita) _then) = _$ParLocalVisitaCopyWithImpl;
@useResult
$Res call({
 int local, int visita
});




}
/// @nodoc
class _$ParLocalVisitaCopyWithImpl<$Res>
    implements $ParLocalVisitaCopyWith<$Res> {
  _$ParLocalVisitaCopyWithImpl(this._self, this._then);

  final ParLocalVisita _self;
  final $Res Function(ParLocalVisita) _then;

/// Create a copy of ParLocalVisita
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? local = null,Object? visita = null,}) {
  return _then(ParLocalVisita(
local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as int,visita: null == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ParLocalVisita].
extension ParLocalVisitaPatterns on ParLocalVisita {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParLocalVisita value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParLocalVisita() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParLocalVisita value)  $default,){
final _that = this;
switch (_that) {
case _ParLocalVisita():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParLocalVisita value)?  $default,){
final _that = this;
switch (_that) {
case _ParLocalVisita() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int local,  int visita)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParLocalVisita() when $default != null:
return $default(_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int local,  int visita)  $default,) {final _that = this;
switch (_that) {
case _ParLocalVisita():
return $default(_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int local,  int visita)?  $default,) {final _that = this;
switch (_that) {
case _ParLocalVisita() when $default != null:
return $default(_that.local,_that.visita);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParLocalVisita implements ParLocalVisita {
  const _ParLocalVisita({this.local = 0, this.visita = 0});
  factory _ParLocalVisita.fromJson(Map<String, dynamic> json) => _$ParLocalVisitaFromJson(json);

@override@JsonKey() final  int local;
@override@JsonKey() final  int visita;

/// Create a copy of ParLocalVisita
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParLocalVisitaCopyWith<_ParLocalVisita> get copyWith => __$ParLocalVisitaCopyWithImpl<_ParLocalVisita>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParLocalVisitaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParLocalVisita&&(identical(other.local, local) || other.local == local)&&(identical(other.visita, visita) || other.visita == visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,local,visita);
}

@override
String toString() {
    return 'ParLocalVisita(local: $local, visita: $visita)';
}


}

/// @nodoc
abstract mixin class _$ParLocalVisitaCopyWith<$Res> implements $ParLocalVisitaCopyWith<$Res> {
  factory _$ParLocalVisitaCopyWith(_ParLocalVisita value, $Res Function(_ParLocalVisita) _then) = __$ParLocalVisitaCopyWithImpl;
@override @useResult
$Res call({
 int local, int visita
});




}
/// @nodoc
class __$ParLocalVisitaCopyWithImpl<$Res>
    implements _$ParLocalVisitaCopyWith<$Res> {
  __$ParLocalVisitaCopyWithImpl(this._self, this._then);

  final _ParLocalVisita _self;
  final $Res Function(_ParLocalVisita) _then;

/// Create a copy of ParLocalVisita
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? local = null,Object? visita = null,}) {
  return _then(_ParLocalVisita(
local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as int,visita: null == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EntradaLineScore {

 int get numero; int? get local; int? get visita;
/// Create a copy of EntradaLineScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntradaLineScoreCopyWith<EntradaLineScore> get copyWith => _$EntradaLineScoreCopyWithImpl<EntradaLineScore>(this as EntradaLineScore, _$identity);

  /// Serializes this EntradaLineScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EntradaLineScore;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntradaLineScore&&(identical(other.numero, _this.numero) || other.numero == _this.numero)&&(identical(other.local, _this.local) || other.local == _this.local)&&(identical(other.visita, _this.visita) || other.visita == _this.visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EntradaLineScore;
  return Object.hash(runtimeType,_this.numero,_this.local,_this.visita);
}

@override
String toString() {
  final _this = this as EntradaLineScore;
  return 'EntradaLineScore(numero: ${_this.numero}, local: ${_this.local}, visita: ${_this.visita})';
}


}

/// @nodoc
abstract mixin class $EntradaLineScoreCopyWith<$Res>  {
  factory $EntradaLineScoreCopyWith(EntradaLineScore value, $Res Function(EntradaLineScore) _then) = _$EntradaLineScoreCopyWithImpl;
@useResult
$Res call({
 int numero, int? local, int? visita
});




}
/// @nodoc
class _$EntradaLineScoreCopyWithImpl<$Res>
    implements $EntradaLineScoreCopyWith<$Res> {
  _$EntradaLineScoreCopyWithImpl(this._self, this._then);

  final EntradaLineScore _self;
  final $Res Function(EntradaLineScore) _then;

/// Create a copy of EntradaLineScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? numero = null,Object? local = freezed,Object? visita = freezed,}) {
  return _then(EntradaLineScore(
numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as int,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as int?,visita: freezed == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EntradaLineScore].
extension EntradaLineScorePatterns on EntradaLineScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntradaLineScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntradaLineScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntradaLineScore value)  $default,){
final _that = this;
switch (_that) {
case _EntradaLineScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntradaLineScore value)?  $default,){
final _that = this;
switch (_that) {
case _EntradaLineScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int numero,  int? local,  int? visita)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntradaLineScore() when $default != null:
return $default(_that.numero,_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int numero,  int? local,  int? visita)  $default,) {final _that = this;
switch (_that) {
case _EntradaLineScore():
return $default(_that.numero,_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int numero,  int? local,  int? visita)?  $default,) {final _that = this;
switch (_that) {
case _EntradaLineScore() when $default != null:
return $default(_that.numero,_that.local,_that.visita);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntradaLineScore implements EntradaLineScore {
  const _EntradaLineScore({required this.numero, this.local, this.visita});
  factory _EntradaLineScore.fromJson(Map<String, dynamic> json) => _$EntradaLineScoreFromJson(json);

@override final  int numero;
@override final  int? local;
@override final  int? visita;

/// Create a copy of EntradaLineScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntradaLineScoreCopyWith<_EntradaLineScore> get copyWith => __$EntradaLineScoreCopyWithImpl<_EntradaLineScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntradaLineScoreToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntradaLineScore&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.local, local) || other.local == local)&&(identical(other.visita, visita) || other.visita == visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,numero,local,visita);
}

@override
String toString() {
    return 'EntradaLineScore(numero: $numero, local: $local, visita: $visita)';
}


}

/// @nodoc
abstract mixin class _$EntradaLineScoreCopyWith<$Res> implements $EntradaLineScoreCopyWith<$Res> {
  factory _$EntradaLineScoreCopyWith(_EntradaLineScore value, $Res Function(_EntradaLineScore) _then) = __$EntradaLineScoreCopyWithImpl;
@override @useResult
$Res call({
 int numero, int? local, int? visita
});




}
/// @nodoc
class __$EntradaLineScoreCopyWithImpl<$Res>
    implements _$EntradaLineScoreCopyWith<$Res> {
  __$EntradaLineScoreCopyWithImpl(this._self, this._then);

  final _EntradaLineScore _self;
  final $Res Function(_EntradaLineScore) _then;

/// Create a copy of EntradaLineScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? numero = null,Object? local = freezed,Object? visita = freezed,}) {
  return _then(_EntradaLineScore(
numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as int,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as int?,visita: freezed == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$LineScore {

 int get entradasProgramadas; bool get entradasExtra; List<EntradaLineScore> get entradas;
/// Create a copy of LineScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineScoreCopyWith<LineScore> get copyWith => _$LineScoreCopyWithImpl<LineScore>(this as LineScore, _$identity);

  /// Serializes this LineScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LineScore;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineScore&&(identical(other.entradasProgramadas, _this.entradasProgramadas) || other.entradasProgramadas == _this.entradasProgramadas)&&(identical(other.entradasExtra, _this.entradasExtra) || other.entradasExtra == _this.entradasExtra)&&const DeepCollectionEquality().equals(other.entradas, _this.entradas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LineScore;
  return Object.hash(runtimeType,_this.entradasProgramadas,_this.entradasExtra,const DeepCollectionEquality().hash(_this.entradas));
}

@override
String toString() {
  final _this = this as LineScore;
  return 'LineScore(entradasProgramadas: ${_this.entradasProgramadas}, entradasExtra: ${_this.entradasExtra}, entradas: ${_this.entradas})';
}


}

/// @nodoc
abstract mixin class $LineScoreCopyWith<$Res>  {
  factory $LineScoreCopyWith(LineScore value, $Res Function(LineScore) _then) = _$LineScoreCopyWithImpl;
@useResult
$Res call({
 int entradasProgramadas, bool entradasExtra, List<EntradaLineScore> entradas
});




}
/// @nodoc
class _$LineScoreCopyWithImpl<$Res>
    implements $LineScoreCopyWith<$Res> {
  _$LineScoreCopyWithImpl(this._self, this._then);

  final LineScore _self;
  final $Res Function(LineScore) _then;

/// Create a copy of LineScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entradasProgramadas = null,Object? entradasExtra = null,Object? entradas = null,}) {
  return _then(LineScore(
entradasProgramadas: null == entradasProgramadas ? _self.entradasProgramadas : entradasProgramadas // ignore: cast_nullable_to_non_nullable
as int,entradasExtra: null == entradasExtra ? _self.entradasExtra : entradasExtra // ignore: cast_nullable_to_non_nullable
as bool,entradas: null == entradas ? _self.entradas : entradas // ignore: cast_nullable_to_non_nullable
as List<EntradaLineScore>,
  ));
}

}


/// Adds pattern-matching-related methods to [LineScore].
extension LineScorePatterns on LineScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineScore value)  $default,){
final _that = this;
switch (_that) {
case _LineScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineScore value)?  $default,){
final _that = this;
switch (_that) {
case _LineScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int entradasProgramadas,  bool entradasExtra,  List<EntradaLineScore> entradas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineScore() when $default != null:
return $default(_that.entradasProgramadas,_that.entradasExtra,_that.entradas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int entradasProgramadas,  bool entradasExtra,  List<EntradaLineScore> entradas)  $default,) {final _that = this;
switch (_that) {
case _LineScore():
return $default(_that.entradasProgramadas,_that.entradasExtra,_that.entradas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int entradasProgramadas,  bool entradasExtra,  List<EntradaLineScore> entradas)?  $default,) {final _that = this;
switch (_that) {
case _LineScore() when $default != null:
return $default(_that.entradasProgramadas,_that.entradasExtra,_that.entradas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineScore implements LineScore {
  const _LineScore({required this.entradasProgramadas, this.entradasExtra = false,  List<EntradaLineScore> entradas = const <EntradaLineScore>[]}): _entradas = entradas;
  factory _LineScore.fromJson(Map<String, dynamic> json) => _$LineScoreFromJson(json);

@override final  int entradasProgramadas;
@override@JsonKey() final  bool entradasExtra;
 final  List<EntradaLineScore> _entradas;
@override@JsonKey() List<EntradaLineScore> get entradas {
  if (_entradas is EqualUnmodifiableListView) return _entradas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entradas);
}


/// Create a copy of LineScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineScoreCopyWith<_LineScore> get copyWith => __$LineScoreCopyWithImpl<_LineScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineScoreToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineScore&&(identical(other.entradasProgramadas, entradasProgramadas) || other.entradasProgramadas == entradasProgramadas)&&(identical(other.entradasExtra, entradasExtra) || other.entradasExtra == entradasExtra)&&const DeepCollectionEquality().equals(other.entradas, _entradas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,entradasProgramadas,entradasExtra,const DeepCollectionEquality().hash(_entradas));
}

@override
String toString() {
    return 'LineScore(entradasProgramadas: $entradasProgramadas, entradasExtra: $entradasExtra, entradas: $entradas)';
}


}

/// @nodoc
abstract mixin class _$LineScoreCopyWith<$Res> implements $LineScoreCopyWith<$Res> {
  factory _$LineScoreCopyWith(_LineScore value, $Res Function(_LineScore) _then) = __$LineScoreCopyWithImpl;
@override @useResult
$Res call({
 int entradasProgramadas, bool entradasExtra, List<EntradaLineScore> entradas
});




}
/// @nodoc
class __$LineScoreCopyWithImpl<$Res>
    implements _$LineScoreCopyWith<$Res> {
  __$LineScoreCopyWithImpl(this._self, this._then);

  final _LineScore _self;
  final $Res Function(_LineScore) _then;

/// Create a copy of LineScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entradasProgramadas = null,Object? entradasExtra = null,Object? entradas = null,}) {
  return _then(_LineScore(
entradasProgramadas: null == entradasProgramadas ? _self.entradasProgramadas : entradasProgramadas // ignore: cast_nullable_to_non_nullable
as int,entradasExtra: null == entradasExtra ? _self.entradasExtra : entradasExtra // ignore: cast_nullable_to_non_nullable
as bool,entradas: null == entradas ? _self._entradas : entradas // ignore: cast_nullable_to_non_nullable
as List<EntradaLineScore>,
  ));
}


}


/// @nodoc
mixin _$EstadioRefLiga {

 int get id; String get nombre; String? get ubicacion;
/// Create a copy of EstadioRefLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstadioRefLigaCopyWith<EstadioRefLiga> get copyWith => _$EstadioRefLigaCopyWithImpl<EstadioRefLiga>(this as EstadioRefLiga, _$identity);

  /// Serializes this EstadioRefLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstadioRefLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstadioRefLiga&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ubicacion, _this.ubicacion) || other.ubicacion == _this.ubicacion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstadioRefLiga;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.ubicacion);
}

@override
String toString() {
  final _this = this as EstadioRefLiga;
  return 'EstadioRefLiga(id: ${_this.id}, nombre: ${_this.nombre}, ubicacion: ${_this.ubicacion})';
}


}

/// @nodoc
abstract mixin class $EstadioRefLigaCopyWith<$Res>  {
  factory $EstadioRefLigaCopyWith(EstadioRefLiga value, $Res Function(EstadioRefLiga) _then) = _$EstadioRefLigaCopyWithImpl;
@useResult
$Res call({
 int id, String nombre, String? ubicacion
});




}
/// @nodoc
class _$EstadioRefLigaCopyWithImpl<$Res>
    implements $EstadioRefLigaCopyWith<$Res> {
  _$EstadioRefLigaCopyWithImpl(this._self, this._then);

  final EstadioRefLiga _self;
  final $Res Function(EstadioRefLiga) _then;

/// Create a copy of EstadioRefLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? ubicacion = freezed,}) {
  return _then(EstadioRefLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EstadioRefLiga].
extension EstadioRefLigaPatterns on EstadioRefLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstadioRefLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstadioRefLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstadioRefLiga value)  $default,){
final _that = this;
switch (_that) {
case _EstadioRefLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstadioRefLiga value)?  $default,){
final _that = this;
switch (_that) {
case _EstadioRefLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre,  String? ubicacion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstadioRefLiga() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre,  String? ubicacion)  $default,) {final _that = this;
switch (_that) {
case _EstadioRefLiga():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre,  String? ubicacion)?  $default,) {final _that = this;
switch (_that) {
case _EstadioRefLiga() when $default != null:
return $default(_that.id,_that.nombre,_that.ubicacion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstadioRefLiga implements EstadioRefLiga {
  const _EstadioRefLiga({required this.id, required this.nombre, this.ubicacion});
  factory _EstadioRefLiga.fromJson(Map<String, dynamic> json) => _$EstadioRefLigaFromJson(json);

@override final  int id;
@override final  String nombre;
@override final  String? ubicacion;

/// Create a copy of EstadioRefLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstadioRefLigaCopyWith<_EstadioRefLiga> get copyWith => __$EstadioRefLigaCopyWithImpl<_EstadioRefLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstadioRefLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstadioRefLiga&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ubicacion, ubicacion) || other.ubicacion == ubicacion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,ubicacion);
}

@override
String toString() {
    return 'EstadioRefLiga(id: $id, nombre: $nombre, ubicacion: $ubicacion)';
}


}

/// @nodoc
abstract mixin class _$EstadioRefLigaCopyWith<$Res> implements $EstadioRefLigaCopyWith<$Res> {
  factory _$EstadioRefLigaCopyWith(_EstadioRefLiga value, $Res Function(_EstadioRefLiga) _then) = __$EstadioRefLigaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre, String? ubicacion
});




}
/// @nodoc
class __$EstadioRefLigaCopyWithImpl<$Res>
    implements _$EstadioRefLigaCopyWith<$Res> {
  __$EstadioRefLigaCopyWithImpl(this._self, this._then);

  final _EstadioRefLiga _self;
  final $Res Function(_EstadioRefLiga) _then;

/// Create a copy of EstadioRefLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? ubicacion = freezed,}) {
  return _then(_EstadioRefLiga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PartidoResumen {

 int get id; int get temporadaId; DateTime get fechaHora; EstadoPartidoLiga get estado; EstadioRefLiga? get estadio; EquipoRefLiga get equipoLocal; EquipoRefLiga get equipoVisita; ParLocalVisita get marcador; int? get ganadorId;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MotivoDetencion? get motivo;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) FinalEspecial? get finalEspecial;
/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartidoResumenCopyWith<PartidoResumen> get copyWith => _$PartidoResumenCopyWithImpl<PartidoResumen>(this as PartidoResumen, _$identity);

  /// Serializes this PartidoResumen to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PartidoResumen;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartidoResumen&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.temporadaId, _this.temporadaId) || other.temporadaId == _this.temporadaId)&&(identical(other.fechaHora, _this.fechaHora) || other.fechaHora == _this.fechaHora)&&(identical(other.estado, _this.estado) || other.estado == _this.estado)&&(identical(other.estadio, _this.estadio) || other.estadio == _this.estadio)&&(identical(other.equipoLocal, _this.equipoLocal) || other.equipoLocal == _this.equipoLocal)&&(identical(other.equipoVisita, _this.equipoVisita) || other.equipoVisita == _this.equipoVisita)&&(identical(other.marcador, _this.marcador) || other.marcador == _this.marcador)&&(identical(other.ganadorId, _this.ganadorId) || other.ganadorId == _this.ganadorId)&&(identical(other.motivo, _this.motivo) || other.motivo == _this.motivo)&&(identical(other.finalEspecial, _this.finalEspecial) || other.finalEspecial == _this.finalEspecial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PartidoResumen;
  return Object.hash(runtimeType,_this.id,_this.temporadaId,_this.fechaHora,_this.estado,_this.estadio,_this.equipoLocal,_this.equipoVisita,_this.marcador,_this.ganadorId,_this.motivo,_this.finalEspecial);
}

@override
String toString() {
  final _this = this as PartidoResumen;
  return 'PartidoResumen(id: ${_this.id}, temporadaId: ${_this.temporadaId}, fechaHora: ${_this.fechaHora}, estado: ${_this.estado}, estadio: ${_this.estadio}, equipoLocal: ${_this.equipoLocal}, equipoVisita: ${_this.equipoVisita}, marcador: ${_this.marcador}, ganadorId: ${_this.ganadorId}, motivo: ${_this.motivo}, finalEspecial: ${_this.finalEspecial})';
}


}

/// @nodoc
abstract mixin class $PartidoResumenCopyWith<$Res>  {
  factory $PartidoResumenCopyWith(PartidoResumen value, $Res Function(PartidoResumen) _then) = _$PartidoResumenCopyWithImpl;
@useResult
$Res call({
 int id, int temporadaId, DateTime fechaHora, EstadoPartidoLiga estado, EstadioRefLiga? estadio, EquipoRefLiga equipoLocal, EquipoRefLiga equipoVisita, ParLocalVisita marcador, int? ganadorId,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MotivoDetencion? motivo,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) FinalEspecial? finalEspecial
});


$EstadioRefLigaCopyWith<$Res>? get estadio;$EquipoRefLigaCopyWith<$Res> get equipoLocal;$EquipoRefLigaCopyWith<$Res> get equipoVisita;$ParLocalVisitaCopyWith<$Res> get marcador;

}
/// @nodoc
class _$PartidoResumenCopyWithImpl<$Res>
    implements $PartidoResumenCopyWith<$Res> {
  _$PartidoResumenCopyWithImpl(this._self, this._then);

  final PartidoResumen _self;
  final $Res Function(PartidoResumen) _then;

/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? temporadaId = null,Object? fechaHora = null,Object? estado = null,Object? estadio = freezed,Object? equipoLocal = null,Object? equipoVisita = null,Object? marcador = null,Object? ganadorId = freezed,Object? motivo = freezed,Object? finalEspecial = freezed,}) {
  return _then(PartidoResumen(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,temporadaId: null == temporadaId ? _self.temporadaId : temporadaId // ignore: cast_nullable_to_non_nullable
as int,fechaHora: null == fechaHora ? _self.fechaHora : fechaHora // ignore: cast_nullable_to_non_nullable
as DateTime,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoPartidoLiga,estadio: freezed == estadio ? _self.estadio : estadio // ignore: cast_nullable_to_non_nullable
as EstadioRefLiga?,equipoLocal: null == equipoLocal ? _self.equipoLocal : equipoLocal // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,equipoVisita: null == equipoVisita ? _self.equipoVisita : equipoVisita // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,marcador: null == marcador ? _self.marcador : marcador // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,ganadorId: freezed == ganadorId ? _self.ganadorId : ganadorId // ignore: cast_nullable_to_non_nullable
as int?,motivo: freezed == motivo ? _self.motivo : motivo // ignore: cast_nullable_to_non_nullable
as MotivoDetencion?,finalEspecial: freezed == finalEspecial ? _self.finalEspecial : finalEspecial // ignore: cast_nullable_to_non_nullable
as FinalEspecial?,
  ));
}
/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstadioRefLigaCopyWith<$Res>? get estadio {
    if (_self.estadio == null) {
    return null;
  }

  return $EstadioRefLigaCopyWith<$Res>(_self.estadio!, (value) {
    return _then(_self.copyWith(estadio: value));
  });
}/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoLocal {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoLocal, (value) {
    return _then(_self.copyWith(equipoLocal: value));
  });
}/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoVisita {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoVisita, (value) {
    return _then(_self.copyWith(equipoVisita: value));
  });
}/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get marcador {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.marcador, (value) {
    return _then(_self.copyWith(marcador: value));
  });
}
}


/// Adds pattern-matching-related methods to [PartidoResumen].
extension PartidoResumenPatterns on PartidoResumen {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartidoResumen value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartidoResumen() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartidoResumen value)  $default,){
final _that = this;
switch (_that) {
case _PartidoResumen():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartidoResumen value)?  $default,){
final _that = this;
switch (_that) {
case _PartidoResumen() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int temporadaId,  DateTime fechaHora,  EstadoPartidoLiga estado,  EstadioRefLiga? estadio,  EquipoRefLiga equipoLocal,  EquipoRefLiga equipoVisita,  ParLocalVisita marcador,  int? ganadorId, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MotivoDetencion? motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  FinalEspecial? finalEspecial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartidoResumen() when $default != null:
return $default(_that.id,_that.temporadaId,_that.fechaHora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisita,_that.marcador,_that.ganadorId,_that.motivo,_that.finalEspecial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int temporadaId,  DateTime fechaHora,  EstadoPartidoLiga estado,  EstadioRefLiga? estadio,  EquipoRefLiga equipoLocal,  EquipoRefLiga equipoVisita,  ParLocalVisita marcador,  int? ganadorId, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MotivoDetencion? motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  FinalEspecial? finalEspecial)  $default,) {final _that = this;
switch (_that) {
case _PartidoResumen():
return $default(_that.id,_that.temporadaId,_that.fechaHora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisita,_that.marcador,_that.ganadorId,_that.motivo,_that.finalEspecial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int temporadaId,  DateTime fechaHora,  EstadoPartidoLiga estado,  EstadioRefLiga? estadio,  EquipoRefLiga equipoLocal,  EquipoRefLiga equipoVisita,  ParLocalVisita marcador,  int? ganadorId, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MotivoDetencion? motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  FinalEspecial? finalEspecial)?  $default,) {final _that = this;
switch (_that) {
case _PartidoResumen() when $default != null:
return $default(_that.id,_that.temporadaId,_that.fechaHora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisita,_that.marcador,_that.ganadorId,_that.motivo,_that.finalEspecial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartidoResumen implements PartidoResumen {
  const _PartidoResumen({required this.id, required this.temporadaId, required this.fechaHora, required this.estado, this.estadio, required this.equipoLocal, required this.equipoVisita, required this.marcador, this.ganadorId, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.finalEspecial});
  factory _PartidoResumen.fromJson(Map<String, dynamic> json) => _$PartidoResumenFromJson(json);

@override final  int id;
@override final  int temporadaId;
@override final  DateTime fechaHora;
@override final  EstadoPartidoLiga estado;
@override final  EstadioRefLiga? estadio;
@override final  EquipoRefLiga equipoLocal;
@override final  EquipoRefLiga equipoVisita;
@override final  ParLocalVisita marcador;
@override final  int? ganadorId;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  MotivoDetencion? motivo;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  FinalEspecial? finalEspecial;

/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartidoResumenCopyWith<_PartidoResumen> get copyWith => __$PartidoResumenCopyWithImpl<_PartidoResumen>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartidoResumenToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartidoResumen&&(identical(other.id, id) || other.id == id)&&(identical(other.temporadaId, temporadaId) || other.temporadaId == temporadaId)&&(identical(other.fechaHora, fechaHora) || other.fechaHora == fechaHora)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.estadio, estadio) || other.estadio == estadio)&&(identical(other.equipoLocal, equipoLocal) || other.equipoLocal == equipoLocal)&&(identical(other.equipoVisita, equipoVisita) || other.equipoVisita == equipoVisita)&&(identical(other.marcador, marcador) || other.marcador == marcador)&&(identical(other.ganadorId, ganadorId) || other.ganadorId == ganadorId)&&(identical(other.motivo, motivo) || other.motivo == motivo)&&(identical(other.finalEspecial, finalEspecial) || other.finalEspecial == finalEspecial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,temporadaId,fechaHora,estado,estadio,equipoLocal,equipoVisita,marcador,ganadorId,motivo,finalEspecial);
}

@override
String toString() {
    return 'PartidoResumen(id: $id, temporadaId: $temporadaId, fechaHora: $fechaHora, estado: $estado, estadio: $estadio, equipoLocal: $equipoLocal, equipoVisita: $equipoVisita, marcador: $marcador, ganadorId: $ganadorId, motivo: $motivo, finalEspecial: $finalEspecial)';
}


}

/// @nodoc
abstract mixin class _$PartidoResumenCopyWith<$Res> implements $PartidoResumenCopyWith<$Res> {
  factory _$PartidoResumenCopyWith(_PartidoResumen value, $Res Function(_PartidoResumen) _then) = __$PartidoResumenCopyWithImpl;
@override @useResult
$Res call({
 int id, int temporadaId, DateTime fechaHora, EstadoPartidoLiga estado, EstadioRefLiga? estadio, EquipoRefLiga equipoLocal, EquipoRefLiga equipoVisita, ParLocalVisita marcador, int? ganadorId,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MotivoDetencion? motivo,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) FinalEspecial? finalEspecial
});


@override $EstadioRefLigaCopyWith<$Res>? get estadio;@override $EquipoRefLigaCopyWith<$Res> get equipoLocal;@override $EquipoRefLigaCopyWith<$Res> get equipoVisita;@override $ParLocalVisitaCopyWith<$Res> get marcador;

}
/// @nodoc
class __$PartidoResumenCopyWithImpl<$Res>
    implements _$PartidoResumenCopyWith<$Res> {
  __$PartidoResumenCopyWithImpl(this._self, this._then);

  final _PartidoResumen _self;
  final $Res Function(_PartidoResumen) _then;

/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? temporadaId = null,Object? fechaHora = null,Object? estado = null,Object? estadio = freezed,Object? equipoLocal = null,Object? equipoVisita = null,Object? marcador = null,Object? ganadorId = freezed,Object? motivo = freezed,Object? finalEspecial = freezed,}) {
  return _then(_PartidoResumen(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,temporadaId: null == temporadaId ? _self.temporadaId : temporadaId // ignore: cast_nullable_to_non_nullable
as int,fechaHora: null == fechaHora ? _self.fechaHora : fechaHora // ignore: cast_nullable_to_non_nullable
as DateTime,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoPartidoLiga,estadio: freezed == estadio ? _self.estadio : estadio // ignore: cast_nullable_to_non_nullable
as EstadioRefLiga?,equipoLocal: null == equipoLocal ? _self.equipoLocal : equipoLocal // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,equipoVisita: null == equipoVisita ? _self.equipoVisita : equipoVisita // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,marcador: null == marcador ? _self.marcador : marcador // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,ganadorId: freezed == ganadorId ? _self.ganadorId : ganadorId // ignore: cast_nullable_to_non_nullable
as int?,motivo: freezed == motivo ? _self.motivo : motivo // ignore: cast_nullable_to_non_nullable
as MotivoDetencion?,finalEspecial: freezed == finalEspecial ? _self.finalEspecial : finalEspecial // ignore: cast_nullable_to_non_nullable
as FinalEspecial?,
  ));
}

/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstadioRefLigaCopyWith<$Res>? get estadio {
    if (_self.estadio == null) {
    return null;
  }

  return $EstadioRefLigaCopyWith<$Res>(_self.estadio!, (value) {
    return _then(_self.copyWith(estadio: value));
  });
}/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoLocal {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoLocal, (value) {
    return _then(_self.copyWith(equipoLocal: value));
  });
}/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoVisita {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoVisita, (value) {
    return _then(_self.copyWith(equipoVisita: value));
  });
}/// Create a copy of PartidoResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get marcador {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.marcador, (value) {
    return _then(_self.copyWith(marcador: value));
  });
}
}


/// @nodoc
mixin _$CorredoresLiga {

 JugadorRefLiga? get primera; JugadorRefLiga? get segunda; JugadorRefLiga? get tercera;
/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CorredoresLigaCopyWith<CorredoresLiga> get copyWith => _$CorredoresLigaCopyWithImpl<CorredoresLiga>(this as CorredoresLiga, _$identity);

  /// Serializes this CorredoresLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CorredoresLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CorredoresLiga&&(identical(other.primera, _this.primera) || other.primera == _this.primera)&&(identical(other.segunda, _this.segunda) || other.segunda == _this.segunda)&&(identical(other.tercera, _this.tercera) || other.tercera == _this.tercera));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CorredoresLiga;
  return Object.hash(runtimeType,_this.primera,_this.segunda,_this.tercera);
}

@override
String toString() {
  final _this = this as CorredoresLiga;
  return 'CorredoresLiga(primera: ${_this.primera}, segunda: ${_this.segunda}, tercera: ${_this.tercera})';
}


}

/// @nodoc
abstract mixin class $CorredoresLigaCopyWith<$Res>  {
  factory $CorredoresLigaCopyWith(CorredoresLiga value, $Res Function(CorredoresLiga) _then) = _$CorredoresLigaCopyWithImpl;
@useResult
$Res call({
 JugadorRefLiga? primera, JugadorRefLiga? segunda, JugadorRefLiga? tercera
});


$JugadorRefLigaCopyWith<$Res>? get primera;$JugadorRefLigaCopyWith<$Res>? get segunda;$JugadorRefLigaCopyWith<$Res>? get tercera;

}
/// @nodoc
class _$CorredoresLigaCopyWithImpl<$Res>
    implements $CorredoresLigaCopyWith<$Res> {
  _$CorredoresLigaCopyWithImpl(this._self, this._then);

  final CorredoresLiga _self;
  final $Res Function(CorredoresLiga) _then;

/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primera = freezed,Object? segunda = freezed,Object? tercera = freezed,}) {
  return _then(CorredoresLiga(
primera: freezed == primera ? _self.primera : primera // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,segunda: freezed == segunda ? _self.segunda : segunda // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,tercera: freezed == tercera ? _self.tercera : tercera // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,
  ));
}
/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get primera {
    if (_self.primera == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.primera!, (value) {
    return _then(_self.copyWith(primera: value));
  });
}/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get segunda {
    if (_self.segunda == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.segunda!, (value) {
    return _then(_self.copyWith(segunda: value));
  });
}/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get tercera {
    if (_self.tercera == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.tercera!, (value) {
    return _then(_self.copyWith(tercera: value));
  });
}
}


/// Adds pattern-matching-related methods to [CorredoresLiga].
extension CorredoresLigaPatterns on CorredoresLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CorredoresLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CorredoresLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CorredoresLiga value)  $default,){
final _that = this;
switch (_that) {
case _CorredoresLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CorredoresLiga value)?  $default,){
final _that = this;
switch (_that) {
case _CorredoresLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JugadorRefLiga? primera,  JugadorRefLiga? segunda,  JugadorRefLiga? tercera)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CorredoresLiga() when $default != null:
return $default(_that.primera,_that.segunda,_that.tercera);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JugadorRefLiga? primera,  JugadorRefLiga? segunda,  JugadorRefLiga? tercera)  $default,) {final _that = this;
switch (_that) {
case _CorredoresLiga():
return $default(_that.primera,_that.segunda,_that.tercera);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JugadorRefLiga? primera,  JugadorRefLiga? segunda,  JugadorRefLiga? tercera)?  $default,) {final _that = this;
switch (_that) {
case _CorredoresLiga() when $default != null:
return $default(_that.primera,_that.segunda,_that.tercera);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CorredoresLiga implements CorredoresLiga {
  const _CorredoresLiga({this.primera, this.segunda, this.tercera});
  factory _CorredoresLiga.fromJson(Map<String, dynamic> json) => _$CorredoresLigaFromJson(json);

@override final  JugadorRefLiga? primera;
@override final  JugadorRefLiga? segunda;
@override final  JugadorRefLiga? tercera;

/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CorredoresLigaCopyWith<_CorredoresLiga> get copyWith => __$CorredoresLigaCopyWithImpl<_CorredoresLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CorredoresLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CorredoresLiga&&(identical(other.primera, primera) || other.primera == primera)&&(identical(other.segunda, segunda) || other.segunda == segunda)&&(identical(other.tercera, tercera) || other.tercera == tercera));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,primera,segunda,tercera);
}

@override
String toString() {
    return 'CorredoresLiga(primera: $primera, segunda: $segunda, tercera: $tercera)';
}


}

/// @nodoc
abstract mixin class _$CorredoresLigaCopyWith<$Res> implements $CorredoresLigaCopyWith<$Res> {
  factory _$CorredoresLigaCopyWith(_CorredoresLiga value, $Res Function(_CorredoresLiga) _then) = __$CorredoresLigaCopyWithImpl;
@override @useResult
$Res call({
 JugadorRefLiga? primera, JugadorRefLiga? segunda, JugadorRefLiga? tercera
});


@override $JugadorRefLigaCopyWith<$Res>? get primera;@override $JugadorRefLigaCopyWith<$Res>? get segunda;@override $JugadorRefLigaCopyWith<$Res>? get tercera;

}
/// @nodoc
class __$CorredoresLigaCopyWithImpl<$Res>
    implements _$CorredoresLigaCopyWith<$Res> {
  __$CorredoresLigaCopyWithImpl(this._self, this._then);

  final _CorredoresLiga _self;
  final $Res Function(_CorredoresLiga) _then;

/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primera = freezed,Object? segunda = freezed,Object? tercera = freezed,}) {
  return _then(_CorredoresLiga(
primera: freezed == primera ? _self.primera : primera // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,segunda: freezed == segunda ? _self.segunda : segunda // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,tercera: freezed == tercera ? _self.tercera : tercera // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,
  ));
}

/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get primera {
    if (_self.primera == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.primera!, (value) {
    return _then(_self.copyWith(primera: value));
  });
}/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get segunda {
    if (_self.segunda == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.segunda!, (value) {
    return _then(_self.copyWith(segunda: value));
  });
}/// Create a copy of CorredoresLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get tercera {
    if (_self.tercera == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.tercera!, (value) {
    return _then(_self.copyWith(tercera: value));
  });
}
}


/// @nodoc
mixin _$SituacionLiga {

 int get outs; int get bolas; int get strikes; JugadorRefLiga? get bateador; JugadorRefLiga? get lanzador; CorredoresLiga? get corredores;
/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SituacionLigaCopyWith<SituacionLiga> get copyWith => _$SituacionLigaCopyWithImpl<SituacionLiga>(this as SituacionLiga, _$identity);

  /// Serializes this SituacionLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SituacionLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SituacionLiga&&(identical(other.outs, _this.outs) || other.outs == _this.outs)&&(identical(other.bolas, _this.bolas) || other.bolas == _this.bolas)&&(identical(other.strikes, _this.strikes) || other.strikes == _this.strikes)&&(identical(other.bateador, _this.bateador) || other.bateador == _this.bateador)&&(identical(other.lanzador, _this.lanzador) || other.lanzador == _this.lanzador)&&(identical(other.corredores, _this.corredores) || other.corredores == _this.corredores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SituacionLiga;
  return Object.hash(runtimeType,_this.outs,_this.bolas,_this.strikes,_this.bateador,_this.lanzador,_this.corredores);
}

@override
String toString() {
  final _this = this as SituacionLiga;
  return 'SituacionLiga(outs: ${_this.outs}, bolas: ${_this.bolas}, strikes: ${_this.strikes}, bateador: ${_this.bateador}, lanzador: ${_this.lanzador}, corredores: ${_this.corredores})';
}


}

/// @nodoc
abstract mixin class $SituacionLigaCopyWith<$Res>  {
  factory $SituacionLigaCopyWith(SituacionLiga value, $Res Function(SituacionLiga) _then) = _$SituacionLigaCopyWithImpl;
@useResult
$Res call({
 int outs, int bolas, int strikes, JugadorRefLiga? bateador, JugadorRefLiga? lanzador, CorredoresLiga? corredores
});


$JugadorRefLigaCopyWith<$Res>? get bateador;$JugadorRefLigaCopyWith<$Res>? get lanzador;$CorredoresLigaCopyWith<$Res>? get corredores;

}
/// @nodoc
class _$SituacionLigaCopyWithImpl<$Res>
    implements $SituacionLigaCopyWith<$Res> {
  _$SituacionLigaCopyWithImpl(this._self, this._then);

  final SituacionLiga _self;
  final $Res Function(SituacionLiga) _then;

/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? outs = null,Object? bolas = null,Object? strikes = null,Object? bateador = freezed,Object? lanzador = freezed,Object? corredores = freezed,}) {
  return _then(SituacionLiga(
outs: null == outs ? _self.outs : outs // ignore: cast_nullable_to_non_nullable
as int,bolas: null == bolas ? _self.bolas : bolas // ignore: cast_nullable_to_non_nullable
as int,strikes: null == strikes ? _self.strikes : strikes // ignore: cast_nullable_to_non_nullable
as int,bateador: freezed == bateador ? _self.bateador : bateador // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,lanzador: freezed == lanzador ? _self.lanzador : lanzador // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,corredores: freezed == corredores ? _self.corredores : corredores // ignore: cast_nullable_to_non_nullable
as CorredoresLiga?,
  ));
}
/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get bateador {
    if (_self.bateador == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.bateador!, (value) {
    return _then(_self.copyWith(bateador: value));
  });
}/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get lanzador {
    if (_self.lanzador == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.lanzador!, (value) {
    return _then(_self.copyWith(lanzador: value));
  });
}/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CorredoresLigaCopyWith<$Res>? get corredores {
    if (_self.corredores == null) {
    return null;
  }

  return $CorredoresLigaCopyWith<$Res>(_self.corredores!, (value) {
    return _then(_self.copyWith(corredores: value));
  });
}
}


/// Adds pattern-matching-related methods to [SituacionLiga].
extension SituacionLigaPatterns on SituacionLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SituacionLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SituacionLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SituacionLiga value)  $default,){
final _that = this;
switch (_that) {
case _SituacionLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SituacionLiga value)?  $default,){
final _that = this;
switch (_that) {
case _SituacionLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int outs,  int bolas,  int strikes,  JugadorRefLiga? bateador,  JugadorRefLiga? lanzador,  CorredoresLiga? corredores)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SituacionLiga() when $default != null:
return $default(_that.outs,_that.bolas,_that.strikes,_that.bateador,_that.lanzador,_that.corredores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int outs,  int bolas,  int strikes,  JugadorRefLiga? bateador,  JugadorRefLiga? lanzador,  CorredoresLiga? corredores)  $default,) {final _that = this;
switch (_that) {
case _SituacionLiga():
return $default(_that.outs,_that.bolas,_that.strikes,_that.bateador,_that.lanzador,_that.corredores);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int outs,  int bolas,  int strikes,  JugadorRefLiga? bateador,  JugadorRefLiga? lanzador,  CorredoresLiga? corredores)?  $default,) {final _that = this;
switch (_that) {
case _SituacionLiga() when $default != null:
return $default(_that.outs,_that.bolas,_that.strikes,_that.bateador,_that.lanzador,_that.corredores);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SituacionLiga implements SituacionLiga {
  const _SituacionLiga({this.outs = 0, this.bolas = 0, this.strikes = 0, this.bateador, this.lanzador, this.corredores});
  factory _SituacionLiga.fromJson(Map<String, dynamic> json) => _$SituacionLigaFromJson(json);

@override@JsonKey() final  int outs;
@override@JsonKey() final  int bolas;
@override@JsonKey() final  int strikes;
@override final  JugadorRefLiga? bateador;
@override final  JugadorRefLiga? lanzador;
@override final  CorredoresLiga? corredores;

/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SituacionLigaCopyWith<_SituacionLiga> get copyWith => __$SituacionLigaCopyWithImpl<_SituacionLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SituacionLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SituacionLiga&&(identical(other.outs, outs) || other.outs == outs)&&(identical(other.bolas, bolas) || other.bolas == bolas)&&(identical(other.strikes, strikes) || other.strikes == strikes)&&(identical(other.bateador, bateador) || other.bateador == bateador)&&(identical(other.lanzador, lanzador) || other.lanzador == lanzador)&&(identical(other.corredores, corredores) || other.corredores == corredores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,outs,bolas,strikes,bateador,lanzador,corredores);
}

@override
String toString() {
    return 'SituacionLiga(outs: $outs, bolas: $bolas, strikes: $strikes, bateador: $bateador, lanzador: $lanzador, corredores: $corredores)';
}


}

/// @nodoc
abstract mixin class _$SituacionLigaCopyWith<$Res> implements $SituacionLigaCopyWith<$Res> {
  factory _$SituacionLigaCopyWith(_SituacionLiga value, $Res Function(_SituacionLiga) _then) = __$SituacionLigaCopyWithImpl;
@override @useResult
$Res call({
 int outs, int bolas, int strikes, JugadorRefLiga? bateador, JugadorRefLiga? lanzador, CorredoresLiga? corredores
});


@override $JugadorRefLigaCopyWith<$Res>? get bateador;@override $JugadorRefLigaCopyWith<$Res>? get lanzador;@override $CorredoresLigaCopyWith<$Res>? get corredores;

}
/// @nodoc
class __$SituacionLigaCopyWithImpl<$Res>
    implements _$SituacionLigaCopyWith<$Res> {
  __$SituacionLigaCopyWithImpl(this._self, this._then);

  final _SituacionLiga _self;
  final $Res Function(_SituacionLiga) _then;

/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? outs = null,Object? bolas = null,Object? strikes = null,Object? bateador = freezed,Object? lanzador = freezed,Object? corredores = freezed,}) {
  return _then(_SituacionLiga(
outs: null == outs ? _self.outs : outs // ignore: cast_nullable_to_non_nullable
as int,bolas: null == bolas ? _self.bolas : bolas // ignore: cast_nullable_to_non_nullable
as int,strikes: null == strikes ? _self.strikes : strikes // ignore: cast_nullable_to_non_nullable
as int,bateador: freezed == bateador ? _self.bateador : bateador // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,lanzador: freezed == lanzador ? _self.lanzador : lanzador // ignore: cast_nullable_to_non_nullable
as JugadorRefLiga?,corredores: freezed == corredores ? _self.corredores : corredores // ignore: cast_nullable_to_non_nullable
as CorredoresLiga?,
  ));
}

/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get bateador {
    if (_self.bateador == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.bateador!, (value) {
    return _then(_self.copyWith(bateador: value));
  });
}/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorRefLigaCopyWith<$Res>? get lanzador {
    if (_self.lanzador == null) {
    return null;
  }

  return $JugadorRefLigaCopyWith<$Res>(_self.lanzador!, (value) {
    return _then(_self.copyWith(lanzador: value));
  });
}/// Create a copy of SituacionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CorredoresLigaCopyWith<$Res>? get corredores {
    if (_self.corredores == null) {
    return null;
  }

  return $CorredoresLigaCopyWith<$Res>(_self.corredores!, (value) {
    return _then(_self.copyWith(corredores: value));
  });
}
}


/// @nodoc
mixin _$PartidoDetalle {

 int get id; int get temporadaId; DateTime get fechaHora; EstadoPartidoLiga get estado; EstadioRefLiga? get estadio; EquipoRefLiga get equipoLocal; EquipoRefLiga get equipoVisita; ParLocalVisita get marcador; int? get ganadorId; int get entradasProgramadas; int get entradaActual; MitadEntrada get mitad; SituacionLiga? get situacion; ParLocalVisita get hits; ParLocalVisita get errores; LineScore get lineScore; int? get version;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MotivoDetencion? get motivo;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) FinalEspecial? get finalEspecial;
/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartidoDetalleCopyWith<PartidoDetalle> get copyWith => _$PartidoDetalleCopyWithImpl<PartidoDetalle>(this as PartidoDetalle, _$identity);

  /// Serializes this PartidoDetalle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PartidoDetalle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartidoDetalle&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.temporadaId, _this.temporadaId) || other.temporadaId == _this.temporadaId)&&(identical(other.fechaHora, _this.fechaHora) || other.fechaHora == _this.fechaHora)&&(identical(other.estado, _this.estado) || other.estado == _this.estado)&&(identical(other.estadio, _this.estadio) || other.estadio == _this.estadio)&&(identical(other.equipoLocal, _this.equipoLocal) || other.equipoLocal == _this.equipoLocal)&&(identical(other.equipoVisita, _this.equipoVisita) || other.equipoVisita == _this.equipoVisita)&&(identical(other.marcador, _this.marcador) || other.marcador == _this.marcador)&&(identical(other.ganadorId, _this.ganadorId) || other.ganadorId == _this.ganadorId)&&(identical(other.entradasProgramadas, _this.entradasProgramadas) || other.entradasProgramadas == _this.entradasProgramadas)&&(identical(other.entradaActual, _this.entradaActual) || other.entradaActual == _this.entradaActual)&&(identical(other.mitad, _this.mitad) || other.mitad == _this.mitad)&&(identical(other.situacion, _this.situacion) || other.situacion == _this.situacion)&&(identical(other.hits, _this.hits) || other.hits == _this.hits)&&(identical(other.errores, _this.errores) || other.errores == _this.errores)&&(identical(other.lineScore, _this.lineScore) || other.lineScore == _this.lineScore)&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.motivo, _this.motivo) || other.motivo == _this.motivo)&&(identical(other.finalEspecial, _this.finalEspecial) || other.finalEspecial == _this.finalEspecial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PartidoDetalle;
  return Object.hashAll([runtimeType,_this.id,_this.temporadaId,_this.fechaHora,_this.estado,_this.estadio,_this.equipoLocal,_this.equipoVisita,_this.marcador,_this.ganadorId,_this.entradasProgramadas,_this.entradaActual,_this.mitad,_this.situacion,_this.hits,_this.errores,_this.lineScore,_this.version,_this.motivo,_this.finalEspecial]);
}

@override
String toString() {
  final _this = this as PartidoDetalle;
  return 'PartidoDetalle(id: ${_this.id}, temporadaId: ${_this.temporadaId}, fechaHora: ${_this.fechaHora}, estado: ${_this.estado}, estadio: ${_this.estadio}, equipoLocal: ${_this.equipoLocal}, equipoVisita: ${_this.equipoVisita}, marcador: ${_this.marcador}, ganadorId: ${_this.ganadorId}, entradasProgramadas: ${_this.entradasProgramadas}, entradaActual: ${_this.entradaActual}, mitad: ${_this.mitad}, situacion: ${_this.situacion}, hits: ${_this.hits}, errores: ${_this.errores}, lineScore: ${_this.lineScore}, version: ${_this.version}, motivo: ${_this.motivo}, finalEspecial: ${_this.finalEspecial})';
}


}

/// @nodoc
abstract mixin class $PartidoDetalleCopyWith<$Res>  {
  factory $PartidoDetalleCopyWith(PartidoDetalle value, $Res Function(PartidoDetalle) _then) = _$PartidoDetalleCopyWithImpl;
@useResult
$Res call({
 int id, int temporadaId, DateTime fechaHora, EstadoPartidoLiga estado, EstadioRefLiga? estadio, EquipoRefLiga equipoLocal, EquipoRefLiga equipoVisita, ParLocalVisita marcador, int? ganadorId, int entradasProgramadas, int entradaActual, MitadEntrada mitad, SituacionLiga? situacion, ParLocalVisita hits, ParLocalVisita errores, LineScore lineScore, int? version,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MotivoDetencion? motivo,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) FinalEspecial? finalEspecial
});


$EstadioRefLigaCopyWith<$Res>? get estadio;$EquipoRefLigaCopyWith<$Res> get equipoLocal;$EquipoRefLigaCopyWith<$Res> get equipoVisita;$ParLocalVisitaCopyWith<$Res> get marcador;$SituacionLigaCopyWith<$Res>? get situacion;$ParLocalVisitaCopyWith<$Res> get hits;$ParLocalVisitaCopyWith<$Res> get errores;$LineScoreCopyWith<$Res> get lineScore;

}
/// @nodoc
class _$PartidoDetalleCopyWithImpl<$Res>
    implements $PartidoDetalleCopyWith<$Res> {
  _$PartidoDetalleCopyWithImpl(this._self, this._then);

  final PartidoDetalle _self;
  final $Res Function(PartidoDetalle) _then;

/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? temporadaId = null,Object? fechaHora = null,Object? estado = null,Object? estadio = freezed,Object? equipoLocal = null,Object? equipoVisita = null,Object? marcador = null,Object? ganadorId = freezed,Object? entradasProgramadas = null,Object? entradaActual = null,Object? mitad = null,Object? situacion = freezed,Object? hits = null,Object? errores = null,Object? lineScore = null,Object? version = freezed,Object? motivo = freezed,Object? finalEspecial = freezed,}) {
  return _then(PartidoDetalle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,temporadaId: null == temporadaId ? _self.temporadaId : temporadaId // ignore: cast_nullable_to_non_nullable
as int,fechaHora: null == fechaHora ? _self.fechaHora : fechaHora // ignore: cast_nullable_to_non_nullable
as DateTime,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoPartidoLiga,estadio: freezed == estadio ? _self.estadio : estadio // ignore: cast_nullable_to_non_nullable
as EstadioRefLiga?,equipoLocal: null == equipoLocal ? _self.equipoLocal : equipoLocal // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,equipoVisita: null == equipoVisita ? _self.equipoVisita : equipoVisita // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,marcador: null == marcador ? _self.marcador : marcador // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,ganadorId: freezed == ganadorId ? _self.ganadorId : ganadorId // ignore: cast_nullable_to_non_nullable
as int?,entradasProgramadas: null == entradasProgramadas ? _self.entradasProgramadas : entradasProgramadas // ignore: cast_nullable_to_non_nullable
as int,entradaActual: null == entradaActual ? _self.entradaActual : entradaActual // ignore: cast_nullable_to_non_nullable
as int,mitad: null == mitad ? _self.mitad : mitad // ignore: cast_nullable_to_non_nullable
as MitadEntrada,situacion: freezed == situacion ? _self.situacion : situacion // ignore: cast_nullable_to_non_nullable
as SituacionLiga?,hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,lineScore: null == lineScore ? _self.lineScore : lineScore // ignore: cast_nullable_to_non_nullable
as LineScore,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,motivo: freezed == motivo ? _self.motivo : motivo // ignore: cast_nullable_to_non_nullable
as MotivoDetencion?,finalEspecial: freezed == finalEspecial ? _self.finalEspecial : finalEspecial // ignore: cast_nullable_to_non_nullable
as FinalEspecial?,
  ));
}
/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstadioRefLigaCopyWith<$Res>? get estadio {
    if (_self.estadio == null) {
    return null;
  }

  return $EstadioRefLigaCopyWith<$Res>(_self.estadio!, (value) {
    return _then(_self.copyWith(estadio: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoLocal {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoLocal, (value) {
    return _then(_self.copyWith(equipoLocal: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoVisita {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoVisita, (value) {
    return _then(_self.copyWith(equipoVisita: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get marcador {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.marcador, (value) {
    return _then(_self.copyWith(marcador: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SituacionLigaCopyWith<$Res>? get situacion {
    if (_self.situacion == null) {
    return null;
  }

  return $SituacionLigaCopyWith<$Res>(_self.situacion!, (value) {
    return _then(_self.copyWith(situacion: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get hits {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.hits, (value) {
    return _then(_self.copyWith(hits: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get errores {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.errores, (value) {
    return _then(_self.copyWith(errores: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineScoreCopyWith<$Res> get lineScore {
  
  return $LineScoreCopyWith<$Res>(_self.lineScore, (value) {
    return _then(_self.copyWith(lineScore: value));
  });
}
}


/// Adds pattern-matching-related methods to [PartidoDetalle].
extension PartidoDetallePatterns on PartidoDetalle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartidoDetalle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartidoDetalle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartidoDetalle value)  $default,){
final _that = this;
switch (_that) {
case _PartidoDetalle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartidoDetalle value)?  $default,){
final _that = this;
switch (_that) {
case _PartidoDetalle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int temporadaId,  DateTime fechaHora,  EstadoPartidoLiga estado,  EstadioRefLiga? estadio,  EquipoRefLiga equipoLocal,  EquipoRefLiga equipoVisita,  ParLocalVisita marcador,  int? ganadorId,  int entradasProgramadas,  int entradaActual,  MitadEntrada mitad,  SituacionLiga? situacion,  ParLocalVisita hits,  ParLocalVisita errores,  LineScore lineScore,  int? version, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MotivoDetencion? motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  FinalEspecial? finalEspecial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartidoDetalle() when $default != null:
return $default(_that.id,_that.temporadaId,_that.fechaHora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisita,_that.marcador,_that.ganadorId,_that.entradasProgramadas,_that.entradaActual,_that.mitad,_that.situacion,_that.hits,_that.errores,_that.lineScore,_that.version,_that.motivo,_that.finalEspecial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int temporadaId,  DateTime fechaHora,  EstadoPartidoLiga estado,  EstadioRefLiga? estadio,  EquipoRefLiga equipoLocal,  EquipoRefLiga equipoVisita,  ParLocalVisita marcador,  int? ganadorId,  int entradasProgramadas,  int entradaActual,  MitadEntrada mitad,  SituacionLiga? situacion,  ParLocalVisita hits,  ParLocalVisita errores,  LineScore lineScore,  int? version, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MotivoDetencion? motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  FinalEspecial? finalEspecial)  $default,) {final _that = this;
switch (_that) {
case _PartidoDetalle():
return $default(_that.id,_that.temporadaId,_that.fechaHora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisita,_that.marcador,_that.ganadorId,_that.entradasProgramadas,_that.entradaActual,_that.mitad,_that.situacion,_that.hits,_that.errores,_that.lineScore,_that.version,_that.motivo,_that.finalEspecial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int temporadaId,  DateTime fechaHora,  EstadoPartidoLiga estado,  EstadioRefLiga? estadio,  EquipoRefLiga equipoLocal,  EquipoRefLiga equipoVisita,  ParLocalVisita marcador,  int? ganadorId,  int entradasProgramadas,  int entradaActual,  MitadEntrada mitad,  SituacionLiga? situacion,  ParLocalVisita hits,  ParLocalVisita errores,  LineScore lineScore,  int? version, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MotivoDetencion? motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  FinalEspecial? finalEspecial)?  $default,) {final _that = this;
switch (_that) {
case _PartidoDetalle() when $default != null:
return $default(_that.id,_that.temporadaId,_that.fechaHora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisita,_that.marcador,_that.ganadorId,_that.entradasProgramadas,_that.entradaActual,_that.mitad,_that.situacion,_that.hits,_that.errores,_that.lineScore,_that.version,_that.motivo,_that.finalEspecial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartidoDetalle implements PartidoDetalle {
  const _PartidoDetalle({required this.id, required this.temporadaId, required this.fechaHora, required this.estado, this.estadio, required this.equipoLocal, required this.equipoVisita, required this.marcador, this.ganadorId, required this.entradasProgramadas, required this.entradaActual, this.mitad = MitadEntrada.alta, this.situacion, this.hits = const ParLocalVisita(), this.errores = const ParLocalVisita(), required this.lineScore, this.version, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.motivo, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.finalEspecial});
  factory _PartidoDetalle.fromJson(Map<String, dynamic> json) => _$PartidoDetalleFromJson(json);

@override final  int id;
@override final  int temporadaId;
@override final  DateTime fechaHora;
@override final  EstadoPartidoLiga estado;
@override final  EstadioRefLiga? estadio;
@override final  EquipoRefLiga equipoLocal;
@override final  EquipoRefLiga equipoVisita;
@override final  ParLocalVisita marcador;
@override final  int? ganadorId;
@override final  int entradasProgramadas;
@override final  int entradaActual;
@override@JsonKey() final  MitadEntrada mitad;
@override final  SituacionLiga? situacion;
@override@JsonKey() final  ParLocalVisita hits;
@override@JsonKey() final  ParLocalVisita errores;
@override final  LineScore lineScore;
@override final  int? version;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  MotivoDetencion? motivo;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  FinalEspecial? finalEspecial;

/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartidoDetalleCopyWith<_PartidoDetalle> get copyWith => __$PartidoDetalleCopyWithImpl<_PartidoDetalle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartidoDetalleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartidoDetalle&&(identical(other.id, id) || other.id == id)&&(identical(other.temporadaId, temporadaId) || other.temporadaId == temporadaId)&&(identical(other.fechaHora, fechaHora) || other.fechaHora == fechaHora)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.estadio, estadio) || other.estadio == estadio)&&(identical(other.equipoLocal, equipoLocal) || other.equipoLocal == equipoLocal)&&(identical(other.equipoVisita, equipoVisita) || other.equipoVisita == equipoVisita)&&(identical(other.marcador, marcador) || other.marcador == marcador)&&(identical(other.ganadorId, ganadorId) || other.ganadorId == ganadorId)&&(identical(other.entradasProgramadas, entradasProgramadas) || other.entradasProgramadas == entradasProgramadas)&&(identical(other.entradaActual, entradaActual) || other.entradaActual == entradaActual)&&(identical(other.mitad, mitad) || other.mitad == mitad)&&(identical(other.situacion, situacion) || other.situacion == situacion)&&(identical(other.hits, hits) || other.hits == hits)&&(identical(other.errores, errores) || other.errores == errores)&&(identical(other.lineScore, lineScore) || other.lineScore == lineScore)&&(identical(other.version, version) || other.version == version)&&(identical(other.motivo, motivo) || other.motivo == motivo)&&(identical(other.finalEspecial, finalEspecial) || other.finalEspecial == finalEspecial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,temporadaId,fechaHora,estado,estadio,equipoLocal,equipoVisita,marcador,ganadorId,entradasProgramadas,entradaActual,mitad,situacion,hits,errores,lineScore,version,motivo,finalEspecial]);
}

@override
String toString() {
    return 'PartidoDetalle(id: $id, temporadaId: $temporadaId, fechaHora: $fechaHora, estado: $estado, estadio: $estadio, equipoLocal: $equipoLocal, equipoVisita: $equipoVisita, marcador: $marcador, ganadorId: $ganadorId, entradasProgramadas: $entradasProgramadas, entradaActual: $entradaActual, mitad: $mitad, situacion: $situacion, hits: $hits, errores: $errores, lineScore: $lineScore, version: $version, motivo: $motivo, finalEspecial: $finalEspecial)';
}


}

/// @nodoc
abstract mixin class _$PartidoDetalleCopyWith<$Res> implements $PartidoDetalleCopyWith<$Res> {
  factory _$PartidoDetalleCopyWith(_PartidoDetalle value, $Res Function(_PartidoDetalle) _then) = __$PartidoDetalleCopyWithImpl;
@override @useResult
$Res call({
 int id, int temporadaId, DateTime fechaHora, EstadoPartidoLiga estado, EstadioRefLiga? estadio, EquipoRefLiga equipoLocal, EquipoRefLiga equipoVisita, ParLocalVisita marcador, int? ganadorId, int entradasProgramadas, int entradaActual, MitadEntrada mitad, SituacionLiga? situacion, ParLocalVisita hits, ParLocalVisita errores, LineScore lineScore, int? version,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MotivoDetencion? motivo,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) FinalEspecial? finalEspecial
});


@override $EstadioRefLigaCopyWith<$Res>? get estadio;@override $EquipoRefLigaCopyWith<$Res> get equipoLocal;@override $EquipoRefLigaCopyWith<$Res> get equipoVisita;@override $ParLocalVisitaCopyWith<$Res> get marcador;@override $SituacionLigaCopyWith<$Res>? get situacion;@override $ParLocalVisitaCopyWith<$Res> get hits;@override $ParLocalVisitaCopyWith<$Res> get errores;@override $LineScoreCopyWith<$Res> get lineScore;

}
/// @nodoc
class __$PartidoDetalleCopyWithImpl<$Res>
    implements _$PartidoDetalleCopyWith<$Res> {
  __$PartidoDetalleCopyWithImpl(this._self, this._then);

  final _PartidoDetalle _self;
  final $Res Function(_PartidoDetalle) _then;

/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? temporadaId = null,Object? fechaHora = null,Object? estado = null,Object? estadio = freezed,Object? equipoLocal = null,Object? equipoVisita = null,Object? marcador = null,Object? ganadorId = freezed,Object? entradasProgramadas = null,Object? entradaActual = null,Object? mitad = null,Object? situacion = freezed,Object? hits = null,Object? errores = null,Object? lineScore = null,Object? version = freezed,Object? motivo = freezed,Object? finalEspecial = freezed,}) {
  return _then(_PartidoDetalle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,temporadaId: null == temporadaId ? _self.temporadaId : temporadaId // ignore: cast_nullable_to_non_nullable
as int,fechaHora: null == fechaHora ? _self.fechaHora : fechaHora // ignore: cast_nullable_to_non_nullable
as DateTime,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoPartidoLiga,estadio: freezed == estadio ? _self.estadio : estadio // ignore: cast_nullable_to_non_nullable
as EstadioRefLiga?,equipoLocal: null == equipoLocal ? _self.equipoLocal : equipoLocal // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,equipoVisita: null == equipoVisita ? _self.equipoVisita : equipoVisita // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,marcador: null == marcador ? _self.marcador : marcador // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,ganadorId: freezed == ganadorId ? _self.ganadorId : ganadorId // ignore: cast_nullable_to_non_nullable
as int?,entradasProgramadas: null == entradasProgramadas ? _self.entradasProgramadas : entradasProgramadas // ignore: cast_nullable_to_non_nullable
as int,entradaActual: null == entradaActual ? _self.entradaActual : entradaActual // ignore: cast_nullable_to_non_nullable
as int,mitad: null == mitad ? _self.mitad : mitad // ignore: cast_nullable_to_non_nullable
as MitadEntrada,situacion: freezed == situacion ? _self.situacion : situacion // ignore: cast_nullable_to_non_nullable
as SituacionLiga?,hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as ParLocalVisita,lineScore: null == lineScore ? _self.lineScore : lineScore // ignore: cast_nullable_to_non_nullable
as LineScore,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,motivo: freezed == motivo ? _self.motivo : motivo // ignore: cast_nullable_to_non_nullable
as MotivoDetencion?,finalEspecial: freezed == finalEspecial ? _self.finalEspecial : finalEspecial // ignore: cast_nullable_to_non_nullable
as FinalEspecial?,
  ));
}

/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstadioRefLigaCopyWith<$Res>? get estadio {
    if (_self.estadio == null) {
    return null;
  }

  return $EstadioRefLigaCopyWith<$Res>(_self.estadio!, (value) {
    return _then(_self.copyWith(estadio: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoLocal {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoLocal, (value) {
    return _then(_self.copyWith(equipoLocal: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipoVisita {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipoVisita, (value) {
    return _then(_self.copyWith(equipoVisita: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get marcador {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.marcador, (value) {
    return _then(_self.copyWith(marcador: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SituacionLigaCopyWith<$Res>? get situacion {
    if (_self.situacion == null) {
    return null;
  }

  return $SituacionLigaCopyWith<$Res>(_self.situacion!, (value) {
    return _then(_self.copyWith(situacion: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get hits {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.hits, (value) {
    return _then(_self.copyWith(hits: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParLocalVisitaCopyWith<$Res> get errores {
  
  return $ParLocalVisitaCopyWith<$Res>(_self.errores, (value) {
    return _then(_self.copyWith(errores: value));
  });
}/// Create a copy of PartidoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineScoreCopyWith<$Res> get lineScore {
  
  return $LineScoreCopyWith<$Res>(_self.lineScore, (value) {
    return _then(_self.copyWith(lineScore: value));
  });
}
}


/// @nodoc
mixin _$PosicionLiga {

 EquipoRefLiga get equipo; int get juegos; int get ganados; int get perdidos; double get pct; int get carrerasFavor; int get carrerasContra;
/// Create a copy of PosicionLiga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosicionLigaCopyWith<PosicionLiga> get copyWith => _$PosicionLigaCopyWithImpl<PosicionLiga>(this as PosicionLiga, _$identity);

  /// Serializes this PosicionLiga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PosicionLiga;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosicionLiga&&(identical(other.equipo, _this.equipo) || other.equipo == _this.equipo)&&(identical(other.juegos, _this.juegos) || other.juegos == _this.juegos)&&(identical(other.ganados, _this.ganados) || other.ganados == _this.ganados)&&(identical(other.perdidos, _this.perdidos) || other.perdidos == _this.perdidos)&&(identical(other.pct, _this.pct) || other.pct == _this.pct)&&(identical(other.carrerasFavor, _this.carrerasFavor) || other.carrerasFavor == _this.carrerasFavor)&&(identical(other.carrerasContra, _this.carrerasContra) || other.carrerasContra == _this.carrerasContra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PosicionLiga;
  return Object.hash(runtimeType,_this.equipo,_this.juegos,_this.ganados,_this.perdidos,_this.pct,_this.carrerasFavor,_this.carrerasContra);
}

@override
String toString() {
  final _this = this as PosicionLiga;
  return 'PosicionLiga(equipo: ${_this.equipo}, juegos: ${_this.juegos}, ganados: ${_this.ganados}, perdidos: ${_this.perdidos}, pct: ${_this.pct}, carrerasFavor: ${_this.carrerasFavor}, carrerasContra: ${_this.carrerasContra})';
}


}

/// @nodoc
abstract mixin class $PosicionLigaCopyWith<$Res>  {
  factory $PosicionLigaCopyWith(PosicionLiga value, $Res Function(PosicionLiga) _then) = _$PosicionLigaCopyWithImpl;
@useResult
$Res call({
 EquipoRefLiga equipo, int juegos, int ganados, int perdidos, double pct, int carrerasFavor, int carrerasContra
});


$EquipoRefLigaCopyWith<$Res> get equipo;

}
/// @nodoc
class _$PosicionLigaCopyWithImpl<$Res>
    implements $PosicionLigaCopyWith<$Res> {
  _$PosicionLigaCopyWithImpl(this._self, this._then);

  final PosicionLiga _self;
  final $Res Function(PosicionLiga) _then;

/// Create a copy of PosicionLiga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? equipo = null,Object? juegos = null,Object? ganados = null,Object? perdidos = null,Object? pct = null,Object? carrerasFavor = null,Object? carrerasContra = null,}) {
  return _then(PosicionLiga(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,juegos: null == juegos ? _self.juegos : juegos // ignore: cast_nullable_to_non_nullable
as int,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as double,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PosicionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipo {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}
}


/// Adds pattern-matching-related methods to [PosicionLiga].
extension PosicionLigaPatterns on PosicionLiga {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosicionLiga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosicionLiga() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosicionLiga value)  $default,){
final _that = this;
switch (_that) {
case _PosicionLiga():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosicionLiga value)?  $default,){
final _that = this;
switch (_that) {
case _PosicionLiga() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EquipoRefLiga equipo,  int juegos,  int ganados,  int perdidos,  double pct,  int carrerasFavor,  int carrerasContra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosicionLiga() when $default != null:
return $default(_that.equipo,_that.juegos,_that.ganados,_that.perdidos,_that.pct,_that.carrerasFavor,_that.carrerasContra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EquipoRefLiga equipo,  int juegos,  int ganados,  int perdidos,  double pct,  int carrerasFavor,  int carrerasContra)  $default,) {final _that = this;
switch (_that) {
case _PosicionLiga():
return $default(_that.equipo,_that.juegos,_that.ganados,_that.perdidos,_that.pct,_that.carrerasFavor,_that.carrerasContra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EquipoRefLiga equipo,  int juegos,  int ganados,  int perdidos,  double pct,  int carrerasFavor,  int carrerasContra)?  $default,) {final _that = this;
switch (_that) {
case _PosicionLiga() when $default != null:
return $default(_that.equipo,_that.juegos,_that.ganados,_that.perdidos,_that.pct,_that.carrerasFavor,_that.carrerasContra);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosicionLiga implements PosicionLiga {
  const _PosicionLiga({required this.equipo, this.juegos = 0, this.ganados = 0, this.perdidos = 0, this.pct = 0, this.carrerasFavor = 0, this.carrerasContra = 0});
  factory _PosicionLiga.fromJson(Map<String, dynamic> json) => _$PosicionLigaFromJson(json);

@override final  EquipoRefLiga equipo;
@override@JsonKey() final  int juegos;
@override@JsonKey() final  int ganados;
@override@JsonKey() final  int perdidos;
@override@JsonKey() final  double pct;
@override@JsonKey() final  int carrerasFavor;
@override@JsonKey() final  int carrerasContra;

/// Create a copy of PosicionLiga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosicionLigaCopyWith<_PosicionLiga> get copyWith => __$PosicionLigaCopyWithImpl<_PosicionLiga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosicionLigaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosicionLiga&&(identical(other.equipo, equipo) || other.equipo == equipo)&&(identical(other.juegos, juegos) || other.juegos == juegos)&&(identical(other.ganados, ganados) || other.ganados == ganados)&&(identical(other.perdidos, perdidos) || other.perdidos == perdidos)&&(identical(other.pct, pct) || other.pct == pct)&&(identical(other.carrerasFavor, carrerasFavor) || other.carrerasFavor == carrerasFavor)&&(identical(other.carrerasContra, carrerasContra) || other.carrerasContra == carrerasContra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,equipo,juegos,ganados,perdidos,pct,carrerasFavor,carrerasContra);
}

@override
String toString() {
    return 'PosicionLiga(equipo: $equipo, juegos: $juegos, ganados: $ganados, perdidos: $perdidos, pct: $pct, carrerasFavor: $carrerasFavor, carrerasContra: $carrerasContra)';
}


}

/// @nodoc
abstract mixin class _$PosicionLigaCopyWith<$Res> implements $PosicionLigaCopyWith<$Res> {
  factory _$PosicionLigaCopyWith(_PosicionLiga value, $Res Function(_PosicionLiga) _then) = __$PosicionLigaCopyWithImpl;
@override @useResult
$Res call({
 EquipoRefLiga equipo, int juegos, int ganados, int perdidos, double pct, int carrerasFavor, int carrerasContra
});


@override $EquipoRefLigaCopyWith<$Res> get equipo;

}
/// @nodoc
class __$PosicionLigaCopyWithImpl<$Res>
    implements _$PosicionLigaCopyWith<$Res> {
  __$PosicionLigaCopyWithImpl(this._self, this._then);

  final _PosicionLiga _self;
  final $Res Function(_PosicionLiga) _then;

/// Create a copy of PosicionLiga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equipo = null,Object? juegos = null,Object? ganados = null,Object? perdidos = null,Object? pct = null,Object? carrerasFavor = null,Object? carrerasContra = null,}) {
  return _then(_PosicionLiga(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,juegos: null == juegos ? _self.juegos : juegos // ignore: cast_nullable_to_non_nullable
as int,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,pct: null == pct ? _self.pct : pct // ignore: cast_nullable_to_non_nullable
as double,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PosicionLiga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipo {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}
}


/// @nodoc
mixin _$BateadorAlineacion {

 int get orden; String get posicion; JugadorResumenLiga get jugador;
/// Create a copy of BateadorAlineacion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BateadorAlineacionCopyWith<BateadorAlineacion> get copyWith => _$BateadorAlineacionCopyWithImpl<BateadorAlineacion>(this as BateadorAlineacion, _$identity);

  /// Serializes this BateadorAlineacion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BateadorAlineacion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BateadorAlineacion&&(identical(other.orden, _this.orden) || other.orden == _this.orden)&&(identical(other.posicion, _this.posicion) || other.posicion == _this.posicion)&&(identical(other.jugador, _this.jugador) || other.jugador == _this.jugador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BateadorAlineacion;
  return Object.hash(runtimeType,_this.orden,_this.posicion,_this.jugador);
}

@override
String toString() {
  final _this = this as BateadorAlineacion;
  return 'BateadorAlineacion(orden: ${_this.orden}, posicion: ${_this.posicion}, jugador: ${_this.jugador})';
}


}

/// @nodoc
abstract mixin class $BateadorAlineacionCopyWith<$Res>  {
  factory $BateadorAlineacionCopyWith(BateadorAlineacion value, $Res Function(BateadorAlineacion) _then) = _$BateadorAlineacionCopyWithImpl;
@useResult
$Res call({
 int orden, String posicion, JugadorResumenLiga jugador
});


$JugadorResumenLigaCopyWith<$Res> get jugador;

}
/// @nodoc
class _$BateadorAlineacionCopyWithImpl<$Res>
    implements $BateadorAlineacionCopyWith<$Res> {
  _$BateadorAlineacionCopyWithImpl(this._self, this._then);

  final BateadorAlineacion _self;
  final $Res Function(BateadorAlineacion) _then;

/// Create a copy of BateadorAlineacion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orden = null,Object? posicion = null,Object? jugador = null,}) {
  return _then(BateadorAlineacion(
orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,posicion: null == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String,jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga,
  ));
}
/// Create a copy of BateadorAlineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res> get jugador {
  
  return $JugadorResumenLigaCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}
}


/// Adds pattern-matching-related methods to [BateadorAlineacion].
extension BateadorAlineacionPatterns on BateadorAlineacion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BateadorAlineacion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BateadorAlineacion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BateadorAlineacion value)  $default,){
final _that = this;
switch (_that) {
case _BateadorAlineacion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BateadorAlineacion value)?  $default,){
final _that = this;
switch (_that) {
case _BateadorAlineacion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orden,  String posicion,  JugadorResumenLiga jugador)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BateadorAlineacion() when $default != null:
return $default(_that.orden,_that.posicion,_that.jugador);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orden,  String posicion,  JugadorResumenLiga jugador)  $default,) {final _that = this;
switch (_that) {
case _BateadorAlineacion():
return $default(_that.orden,_that.posicion,_that.jugador);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orden,  String posicion,  JugadorResumenLiga jugador)?  $default,) {final _that = this;
switch (_that) {
case _BateadorAlineacion() when $default != null:
return $default(_that.orden,_that.posicion,_that.jugador);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BateadorAlineacion implements BateadorAlineacion {
  const _BateadorAlineacion({required this.orden, required this.posicion, required this.jugador});
  factory _BateadorAlineacion.fromJson(Map<String, dynamic> json) => _$BateadorAlineacionFromJson(json);

@override final  int orden;
@override final  String posicion;
@override final  JugadorResumenLiga jugador;

/// Create a copy of BateadorAlineacion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BateadorAlineacionCopyWith<_BateadorAlineacion> get copyWith => __$BateadorAlineacionCopyWithImpl<_BateadorAlineacion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BateadorAlineacionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BateadorAlineacion&&(identical(other.orden, orden) || other.orden == orden)&&(identical(other.posicion, posicion) || other.posicion == posicion)&&(identical(other.jugador, jugador) || other.jugador == jugador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orden,posicion,jugador);
}

@override
String toString() {
    return 'BateadorAlineacion(orden: $orden, posicion: $posicion, jugador: $jugador)';
}


}

/// @nodoc
abstract mixin class _$BateadorAlineacionCopyWith<$Res> implements $BateadorAlineacionCopyWith<$Res> {
  factory _$BateadorAlineacionCopyWith(_BateadorAlineacion value, $Res Function(_BateadorAlineacion) _then) = __$BateadorAlineacionCopyWithImpl;
@override @useResult
$Res call({
 int orden, String posicion, JugadorResumenLiga jugador
});


@override $JugadorResumenLigaCopyWith<$Res> get jugador;

}
/// @nodoc
class __$BateadorAlineacionCopyWithImpl<$Res>
    implements _$BateadorAlineacionCopyWith<$Res> {
  __$BateadorAlineacionCopyWithImpl(this._self, this._then);

  final _BateadorAlineacion _self;
  final $Res Function(_BateadorAlineacion) _then;

/// Create a copy of BateadorAlineacion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orden = null,Object? posicion = null,Object? jugador = null,}) {
  return _then(_BateadorAlineacion(
orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,posicion: null == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String,jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga,
  ));
}

/// Create a copy of BateadorAlineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res> get jugador {
  
  return $JugadorResumenLigaCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}
}


/// @nodoc
mixin _$EquipoAlineacion {

 EquipoRefLiga get equipo; JugadorResumenLiga? get lanzadorInicial; List<BateadorAlineacion> get bateo; List<JugadorResumenLiga> get banca;
/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoAlineacionCopyWith<EquipoAlineacion> get copyWith => _$EquipoAlineacionCopyWithImpl<EquipoAlineacion>(this as EquipoAlineacion, _$identity);

  /// Serializes this EquipoAlineacion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoAlineacion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoAlineacion&&(identical(other.equipo, _this.equipo) || other.equipo == _this.equipo)&&(identical(other.lanzadorInicial, _this.lanzadorInicial) || other.lanzadorInicial == _this.lanzadorInicial)&&const DeepCollectionEquality().equals(other.bateo, _this.bateo)&&const DeepCollectionEquality().equals(other.banca, _this.banca));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoAlineacion;
  return Object.hash(runtimeType,_this.equipo,_this.lanzadorInicial,const DeepCollectionEquality().hash(_this.bateo),const DeepCollectionEquality().hash(_this.banca));
}

@override
String toString() {
  final _this = this as EquipoAlineacion;
  return 'EquipoAlineacion(equipo: ${_this.equipo}, lanzadorInicial: ${_this.lanzadorInicial}, bateo: ${_this.bateo}, banca: ${_this.banca})';
}


}

/// @nodoc
abstract mixin class $EquipoAlineacionCopyWith<$Res>  {
  factory $EquipoAlineacionCopyWith(EquipoAlineacion value, $Res Function(EquipoAlineacion) _then) = _$EquipoAlineacionCopyWithImpl;
@useResult
$Res call({
 EquipoRefLiga equipo, JugadorResumenLiga? lanzadorInicial, List<BateadorAlineacion> bateo, List<JugadorResumenLiga> banca
});


$EquipoRefLigaCopyWith<$Res> get equipo;$JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial;

}
/// @nodoc
class _$EquipoAlineacionCopyWithImpl<$Res>
    implements $EquipoAlineacionCopyWith<$Res> {
  _$EquipoAlineacionCopyWithImpl(this._self, this._then);

  final EquipoAlineacion _self;
  final $Res Function(EquipoAlineacion) _then;

/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? equipo = null,Object? lanzadorInicial = freezed,Object? bateo = null,Object? banca = null,}) {
  return _then(EquipoAlineacion(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,lanzadorInicial: freezed == lanzadorInicial ? _self.lanzadorInicial : lanzadorInicial // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga?,bateo: null == bateo ? _self.bateo : bateo // ignore: cast_nullable_to_non_nullable
as List<BateadorAlineacion>,banca: null == banca ? _self.banca : banca // ignore: cast_nullable_to_non_nullable
as List<JugadorResumenLiga>,
  ));
}
/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipo {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial {
    if (_self.lanzadorInicial == null) {
    return null;
  }

  return $JugadorResumenLigaCopyWith<$Res>(_self.lanzadorInicial!, (value) {
    return _then(_self.copyWith(lanzadorInicial: value));
  });
}
}


/// Adds pattern-matching-related methods to [EquipoAlineacion].
extension EquipoAlineacionPatterns on EquipoAlineacion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoAlineacion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoAlineacion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoAlineacion value)  $default,){
final _that = this;
switch (_that) {
case _EquipoAlineacion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoAlineacion value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoAlineacion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EquipoRefLiga equipo,  JugadorResumenLiga? lanzadorInicial,  List<BateadorAlineacion> bateo,  List<JugadorResumenLiga> banca)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoAlineacion() when $default != null:
return $default(_that.equipo,_that.lanzadorInicial,_that.bateo,_that.banca);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EquipoRefLiga equipo,  JugadorResumenLiga? lanzadorInicial,  List<BateadorAlineacion> bateo,  List<JugadorResumenLiga> banca)  $default,) {final _that = this;
switch (_that) {
case _EquipoAlineacion():
return $default(_that.equipo,_that.lanzadorInicial,_that.bateo,_that.banca);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EquipoRefLiga equipo,  JugadorResumenLiga? lanzadorInicial,  List<BateadorAlineacion> bateo,  List<JugadorResumenLiga> banca)?  $default,) {final _that = this;
switch (_that) {
case _EquipoAlineacion() when $default != null:
return $default(_that.equipo,_that.lanzadorInicial,_that.bateo,_that.banca);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoAlineacion implements EquipoAlineacion {
  const _EquipoAlineacion({required this.equipo, this.lanzadorInicial,  List<BateadorAlineacion> bateo = const <BateadorAlineacion>[],  List<JugadorResumenLiga> banca = const <JugadorResumenLiga>[]}): _bateo = bateo,_banca = banca;
  factory _EquipoAlineacion.fromJson(Map<String, dynamic> json) => _$EquipoAlineacionFromJson(json);

@override final  EquipoRefLiga equipo;
@override final  JugadorResumenLiga? lanzadorInicial;
 final  List<BateadorAlineacion> _bateo;
@override@JsonKey() List<BateadorAlineacion> get bateo {
  if (_bateo is EqualUnmodifiableListView) return _bateo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bateo);
}

 final  List<JugadorResumenLiga> _banca;
@override@JsonKey() List<JugadorResumenLiga> get banca {
  if (_banca is EqualUnmodifiableListView) return _banca;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_banca);
}


/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoAlineacionCopyWith<_EquipoAlineacion> get copyWith => __$EquipoAlineacionCopyWithImpl<_EquipoAlineacion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoAlineacionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoAlineacion&&(identical(other.equipo, equipo) || other.equipo == equipo)&&(identical(other.lanzadorInicial, lanzadorInicial) || other.lanzadorInicial == lanzadorInicial)&&const DeepCollectionEquality().equals(other.bateo, _bateo)&&const DeepCollectionEquality().equals(other.banca, _banca));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,equipo,lanzadorInicial,const DeepCollectionEquality().hash(_bateo),const DeepCollectionEquality().hash(_banca));
}

@override
String toString() {
    return 'EquipoAlineacion(equipo: $equipo, lanzadorInicial: $lanzadorInicial, bateo: $bateo, banca: $banca)';
}


}

/// @nodoc
abstract mixin class _$EquipoAlineacionCopyWith<$Res> implements $EquipoAlineacionCopyWith<$Res> {
  factory _$EquipoAlineacionCopyWith(_EquipoAlineacion value, $Res Function(_EquipoAlineacion) _then) = __$EquipoAlineacionCopyWithImpl;
@override @useResult
$Res call({
 EquipoRefLiga equipo, JugadorResumenLiga? lanzadorInicial, List<BateadorAlineacion> bateo, List<JugadorResumenLiga> banca
});


@override $EquipoRefLigaCopyWith<$Res> get equipo;@override $JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial;

}
/// @nodoc
class __$EquipoAlineacionCopyWithImpl<$Res>
    implements _$EquipoAlineacionCopyWith<$Res> {
  __$EquipoAlineacionCopyWithImpl(this._self, this._then);

  final _EquipoAlineacion _self;
  final $Res Function(_EquipoAlineacion) _then;

/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equipo = null,Object? lanzadorInicial = freezed,Object? bateo = null,Object? banca = null,}) {
  return _then(_EquipoAlineacion(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,lanzadorInicial: freezed == lanzadorInicial ? _self.lanzadorInicial : lanzadorInicial // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga?,bateo: null == bateo ? _self._bateo : bateo // ignore: cast_nullable_to_non_nullable
as List<BateadorAlineacion>,banca: null == banca ? _self._banca : banca // ignore: cast_nullable_to_non_nullable
as List<JugadorResumenLiga>,
  ));
}

/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipo {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}/// Create a copy of EquipoAlineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial {
    if (_self.lanzadorInicial == null) {
    return null;
  }

  return $JugadorResumenLigaCopyWith<$Res>(_self.lanzadorInicial!, (value) {
    return _then(_self.copyWith(lanzadorInicial: value));
  });
}
}


/// @nodoc
mixin _$Alineacion {

 bool get publicada; EquipoAlineacion? get local; EquipoAlineacion? get visita;
/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlineacionCopyWith<Alineacion> get copyWith => _$AlineacionCopyWithImpl<Alineacion>(this as Alineacion, _$identity);

  /// Serializes this Alineacion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Alineacion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Alineacion&&(identical(other.publicada, _this.publicada) || other.publicada == _this.publicada)&&(identical(other.local, _this.local) || other.local == _this.local)&&(identical(other.visita, _this.visita) || other.visita == _this.visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Alineacion;
  return Object.hash(runtimeType,_this.publicada,_this.local,_this.visita);
}

@override
String toString() {
  final _this = this as Alineacion;
  return 'Alineacion(publicada: ${_this.publicada}, local: ${_this.local}, visita: ${_this.visita})';
}


}

/// @nodoc
abstract mixin class $AlineacionCopyWith<$Res>  {
  factory $AlineacionCopyWith(Alineacion value, $Res Function(Alineacion) _then) = _$AlineacionCopyWithImpl;
@useResult
$Res call({
 bool publicada, EquipoAlineacion? local, EquipoAlineacion? visita
});


$EquipoAlineacionCopyWith<$Res>? get local;$EquipoAlineacionCopyWith<$Res>? get visita;

}
/// @nodoc
class _$AlineacionCopyWithImpl<$Res>
    implements $AlineacionCopyWith<$Res> {
  _$AlineacionCopyWithImpl(this._self, this._then);

  final Alineacion _self;
  final $Res Function(Alineacion) _then;

/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicada = null,Object? local = freezed,Object? visita = freezed,}) {
  return _then(Alineacion(
publicada: null == publicada ? _self.publicada : publicada // ignore: cast_nullable_to_non_nullable
as bool,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as EquipoAlineacion?,visita: freezed == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as EquipoAlineacion?,
  ));
}
/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoAlineacionCopyWith<$Res>? get local {
    if (_self.local == null) {
    return null;
  }

  return $EquipoAlineacionCopyWith<$Res>(_self.local!, (value) {
    return _then(_self.copyWith(local: value));
  });
}/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoAlineacionCopyWith<$Res>? get visita {
    if (_self.visita == null) {
    return null;
  }

  return $EquipoAlineacionCopyWith<$Res>(_self.visita!, (value) {
    return _then(_self.copyWith(visita: value));
  });
}
}


/// Adds pattern-matching-related methods to [Alineacion].
extension AlineacionPatterns on Alineacion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Alineacion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Alineacion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Alineacion value)  $default,){
final _that = this;
switch (_that) {
case _Alineacion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Alineacion value)?  $default,){
final _that = this;
switch (_that) {
case _Alineacion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool publicada,  EquipoAlineacion? local,  EquipoAlineacion? visita)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Alineacion() when $default != null:
return $default(_that.publicada,_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool publicada,  EquipoAlineacion? local,  EquipoAlineacion? visita)  $default,) {final _that = this;
switch (_that) {
case _Alineacion():
return $default(_that.publicada,_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool publicada,  EquipoAlineacion? local,  EquipoAlineacion? visita)?  $default,) {final _that = this;
switch (_that) {
case _Alineacion() when $default != null:
return $default(_that.publicada,_that.local,_that.visita);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Alineacion implements Alineacion {
  const _Alineacion({this.publicada = false, this.local, this.visita});
  factory _Alineacion.fromJson(Map<String, dynamic> json) => _$AlineacionFromJson(json);

@override@JsonKey() final  bool publicada;
@override final  EquipoAlineacion? local;
@override final  EquipoAlineacion? visita;

/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlineacionCopyWith<_Alineacion> get copyWith => __$AlineacionCopyWithImpl<_Alineacion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlineacionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Alineacion&&(identical(other.publicada, publicada) || other.publicada == publicada)&&(identical(other.local, local) || other.local == local)&&(identical(other.visita, visita) || other.visita == visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,publicada,local,visita);
}

@override
String toString() {
    return 'Alineacion(publicada: $publicada, local: $local, visita: $visita)';
}


}

/// @nodoc
abstract mixin class _$AlineacionCopyWith<$Res> implements $AlineacionCopyWith<$Res> {
  factory _$AlineacionCopyWith(_Alineacion value, $Res Function(_Alineacion) _then) = __$AlineacionCopyWithImpl;
@override @useResult
$Res call({
 bool publicada, EquipoAlineacion? local, EquipoAlineacion? visita
});


@override $EquipoAlineacionCopyWith<$Res>? get local;@override $EquipoAlineacionCopyWith<$Res>? get visita;

}
/// @nodoc
class __$AlineacionCopyWithImpl<$Res>
    implements _$AlineacionCopyWith<$Res> {
  __$AlineacionCopyWithImpl(this._self, this._then);

  final _Alineacion _self;
  final $Res Function(_Alineacion) _then;

/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicada = null,Object? local = freezed,Object? visita = freezed,}) {
  return _then(_Alineacion(
publicada: null == publicada ? _self.publicada : publicada // ignore: cast_nullable_to_non_nullable
as bool,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as EquipoAlineacion?,visita: freezed == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as EquipoAlineacion?,
  ));
}

/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoAlineacionCopyWith<$Res>? get local {
    if (_self.local == null) {
    return null;
  }

  return $EquipoAlineacionCopyWith<$Res>(_self.local!, (value) {
    return _then(_self.copyWith(local: value));
  });
}/// Create a copy of Alineacion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoAlineacionCopyWith<$Res>? get visita {
    if (_self.visita == null) {
    return null;
  }

  return $EquipoAlineacionCopyWith<$Res>(_self.visita!, (value) {
    return _then(_self.copyWith(visita: value));
  });
}
}


/// @nodoc
mixin _$EquipoPitcheo {

 EquipoRefLiga get equipo; JugadorResumenLiga? get lanzadorInicial; List<JugadorResumenLiga> get relevistas;
/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoPitcheoCopyWith<EquipoPitcheo> get copyWith => _$EquipoPitcheoCopyWithImpl<EquipoPitcheo>(this as EquipoPitcheo, _$identity);

  /// Serializes this EquipoPitcheo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoPitcheo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoPitcheo&&(identical(other.equipo, _this.equipo) || other.equipo == _this.equipo)&&(identical(other.lanzadorInicial, _this.lanzadorInicial) || other.lanzadorInicial == _this.lanzadorInicial)&&const DeepCollectionEquality().equals(other.relevistas, _this.relevistas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoPitcheo;
  return Object.hash(runtimeType,_this.equipo,_this.lanzadorInicial,const DeepCollectionEquality().hash(_this.relevistas));
}

@override
String toString() {
  final _this = this as EquipoPitcheo;
  return 'EquipoPitcheo(equipo: ${_this.equipo}, lanzadorInicial: ${_this.lanzadorInicial}, relevistas: ${_this.relevistas})';
}


}

/// @nodoc
abstract mixin class $EquipoPitcheoCopyWith<$Res>  {
  factory $EquipoPitcheoCopyWith(EquipoPitcheo value, $Res Function(EquipoPitcheo) _then) = _$EquipoPitcheoCopyWithImpl;
@useResult
$Res call({
 EquipoRefLiga equipo, JugadorResumenLiga? lanzadorInicial, List<JugadorResumenLiga> relevistas
});


$EquipoRefLigaCopyWith<$Res> get equipo;$JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial;

}
/// @nodoc
class _$EquipoPitcheoCopyWithImpl<$Res>
    implements $EquipoPitcheoCopyWith<$Res> {
  _$EquipoPitcheoCopyWithImpl(this._self, this._then);

  final EquipoPitcheo _self;
  final $Res Function(EquipoPitcheo) _then;

/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? equipo = null,Object? lanzadorInicial = freezed,Object? relevistas = null,}) {
  return _then(EquipoPitcheo(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,lanzadorInicial: freezed == lanzadorInicial ? _self.lanzadorInicial : lanzadorInicial // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga?,relevistas: null == relevistas ? _self.relevistas : relevistas // ignore: cast_nullable_to_non_nullable
as List<JugadorResumenLiga>,
  ));
}
/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipo {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial {
    if (_self.lanzadorInicial == null) {
    return null;
  }

  return $JugadorResumenLigaCopyWith<$Res>(_self.lanzadorInicial!, (value) {
    return _then(_self.copyWith(lanzadorInicial: value));
  });
}
}


/// Adds pattern-matching-related methods to [EquipoPitcheo].
extension EquipoPitcheoPatterns on EquipoPitcheo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoPitcheo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoPitcheo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoPitcheo value)  $default,){
final _that = this;
switch (_that) {
case _EquipoPitcheo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoPitcheo value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoPitcheo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EquipoRefLiga equipo,  JugadorResumenLiga? lanzadorInicial,  List<JugadorResumenLiga> relevistas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoPitcheo() when $default != null:
return $default(_that.equipo,_that.lanzadorInicial,_that.relevistas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EquipoRefLiga equipo,  JugadorResumenLiga? lanzadorInicial,  List<JugadorResumenLiga> relevistas)  $default,) {final _that = this;
switch (_that) {
case _EquipoPitcheo():
return $default(_that.equipo,_that.lanzadorInicial,_that.relevistas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EquipoRefLiga equipo,  JugadorResumenLiga? lanzadorInicial,  List<JugadorResumenLiga> relevistas)?  $default,) {final _that = this;
switch (_that) {
case _EquipoPitcheo() when $default != null:
return $default(_that.equipo,_that.lanzadorInicial,_that.relevistas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoPitcheo implements EquipoPitcheo {
  const _EquipoPitcheo({required this.equipo, this.lanzadorInicial,  List<JugadorResumenLiga> relevistas = const <JugadorResumenLiga>[]}): _relevistas = relevistas;
  factory _EquipoPitcheo.fromJson(Map<String, dynamic> json) => _$EquipoPitcheoFromJson(json);

@override final  EquipoRefLiga equipo;
@override final  JugadorResumenLiga? lanzadorInicial;
 final  List<JugadorResumenLiga> _relevistas;
@override@JsonKey() List<JugadorResumenLiga> get relevistas {
  if (_relevistas is EqualUnmodifiableListView) return _relevistas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relevistas);
}


/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoPitcheoCopyWith<_EquipoPitcheo> get copyWith => __$EquipoPitcheoCopyWithImpl<_EquipoPitcheo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoPitcheoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoPitcheo&&(identical(other.equipo, equipo) || other.equipo == equipo)&&(identical(other.lanzadorInicial, lanzadorInicial) || other.lanzadorInicial == lanzadorInicial)&&const DeepCollectionEquality().equals(other.relevistas, _relevistas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,equipo,lanzadorInicial,const DeepCollectionEquality().hash(_relevistas));
}

@override
String toString() {
    return 'EquipoPitcheo(equipo: $equipo, lanzadorInicial: $lanzadorInicial, relevistas: $relevistas)';
}


}

/// @nodoc
abstract mixin class _$EquipoPitcheoCopyWith<$Res> implements $EquipoPitcheoCopyWith<$Res> {
  factory _$EquipoPitcheoCopyWith(_EquipoPitcheo value, $Res Function(_EquipoPitcheo) _then) = __$EquipoPitcheoCopyWithImpl;
@override @useResult
$Res call({
 EquipoRefLiga equipo, JugadorResumenLiga? lanzadorInicial, List<JugadorResumenLiga> relevistas
});


@override $EquipoRefLigaCopyWith<$Res> get equipo;@override $JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial;

}
/// @nodoc
class __$EquipoPitcheoCopyWithImpl<$Res>
    implements _$EquipoPitcheoCopyWith<$Res> {
  __$EquipoPitcheoCopyWithImpl(this._self, this._then);

  final _EquipoPitcheo _self;
  final $Res Function(_EquipoPitcheo) _then;

/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equipo = null,Object? lanzadorInicial = freezed,Object? relevistas = null,}) {
  return _then(_EquipoPitcheo(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as EquipoRefLiga,lanzadorInicial: freezed == lanzadorInicial ? _self.lanzadorInicial : lanzadorInicial // ignore: cast_nullable_to_non_nullable
as JugadorResumenLiga?,relevistas: null == relevistas ? _self._relevistas : relevistas // ignore: cast_nullable_to_non_nullable
as List<JugadorResumenLiga>,
  ));
}

/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefLigaCopyWith<$Res> get equipo {
  
  return $EquipoRefLigaCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}/// Create a copy of EquipoPitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorResumenLigaCopyWith<$Res>? get lanzadorInicial {
    if (_self.lanzadorInicial == null) {
    return null;
  }

  return $JugadorResumenLigaCopyWith<$Res>(_self.lanzadorInicial!, (value) {
    return _then(_self.copyWith(lanzadorInicial: value));
  });
}
}


/// @nodoc
mixin _$Pitcheo {

 bool get publicada; EquipoPitcheo? get local; EquipoPitcheo? get visita;
/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PitcheoCopyWith<Pitcheo> get copyWith => _$PitcheoCopyWithImpl<Pitcheo>(this as Pitcheo, _$identity);

  /// Serializes this Pitcheo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Pitcheo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pitcheo&&(identical(other.publicada, _this.publicada) || other.publicada == _this.publicada)&&(identical(other.local, _this.local) || other.local == _this.local)&&(identical(other.visita, _this.visita) || other.visita == _this.visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Pitcheo;
  return Object.hash(runtimeType,_this.publicada,_this.local,_this.visita);
}

@override
String toString() {
  final _this = this as Pitcheo;
  return 'Pitcheo(publicada: ${_this.publicada}, local: ${_this.local}, visita: ${_this.visita})';
}


}

/// @nodoc
abstract mixin class $PitcheoCopyWith<$Res>  {
  factory $PitcheoCopyWith(Pitcheo value, $Res Function(Pitcheo) _then) = _$PitcheoCopyWithImpl;
@useResult
$Res call({
 bool publicada, EquipoPitcheo? local, EquipoPitcheo? visita
});


$EquipoPitcheoCopyWith<$Res>? get local;$EquipoPitcheoCopyWith<$Res>? get visita;

}
/// @nodoc
class _$PitcheoCopyWithImpl<$Res>
    implements $PitcheoCopyWith<$Res> {
  _$PitcheoCopyWithImpl(this._self, this._then);

  final Pitcheo _self;
  final $Res Function(Pitcheo) _then;

/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicada = null,Object? local = freezed,Object? visita = freezed,}) {
  return _then(Pitcheo(
publicada: null == publicada ? _self.publicada : publicada // ignore: cast_nullable_to_non_nullable
as bool,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as EquipoPitcheo?,visita: freezed == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as EquipoPitcheo?,
  ));
}
/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoPitcheoCopyWith<$Res>? get local {
    if (_self.local == null) {
    return null;
  }

  return $EquipoPitcheoCopyWith<$Res>(_self.local!, (value) {
    return _then(_self.copyWith(local: value));
  });
}/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoPitcheoCopyWith<$Res>? get visita {
    if (_self.visita == null) {
    return null;
  }

  return $EquipoPitcheoCopyWith<$Res>(_self.visita!, (value) {
    return _then(_self.copyWith(visita: value));
  });
}
}


/// Adds pattern-matching-related methods to [Pitcheo].
extension PitcheoPatterns on Pitcheo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pitcheo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pitcheo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pitcheo value)  $default,){
final _that = this;
switch (_that) {
case _Pitcheo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pitcheo value)?  $default,){
final _that = this;
switch (_that) {
case _Pitcheo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool publicada,  EquipoPitcheo? local,  EquipoPitcheo? visita)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pitcheo() when $default != null:
return $default(_that.publicada,_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool publicada,  EquipoPitcheo? local,  EquipoPitcheo? visita)  $default,) {final _that = this;
switch (_that) {
case _Pitcheo():
return $default(_that.publicada,_that.local,_that.visita);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool publicada,  EquipoPitcheo? local,  EquipoPitcheo? visita)?  $default,) {final _that = this;
switch (_that) {
case _Pitcheo() when $default != null:
return $default(_that.publicada,_that.local,_that.visita);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pitcheo implements Pitcheo {
  const _Pitcheo({this.publicada = false, this.local, this.visita});
  factory _Pitcheo.fromJson(Map<String, dynamic> json) => _$PitcheoFromJson(json);

@override@JsonKey() final  bool publicada;
@override final  EquipoPitcheo? local;
@override final  EquipoPitcheo? visita;

/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PitcheoCopyWith<_Pitcheo> get copyWith => __$PitcheoCopyWithImpl<_Pitcheo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PitcheoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pitcheo&&(identical(other.publicada, publicada) || other.publicada == publicada)&&(identical(other.local, local) || other.local == local)&&(identical(other.visita, visita) || other.visita == visita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,publicada,local,visita);
}

@override
String toString() {
    return 'Pitcheo(publicada: $publicada, local: $local, visita: $visita)';
}


}

/// @nodoc
abstract mixin class _$PitcheoCopyWith<$Res> implements $PitcheoCopyWith<$Res> {
  factory _$PitcheoCopyWith(_Pitcheo value, $Res Function(_Pitcheo) _then) = __$PitcheoCopyWithImpl;
@override @useResult
$Res call({
 bool publicada, EquipoPitcheo? local, EquipoPitcheo? visita
});


@override $EquipoPitcheoCopyWith<$Res>? get local;@override $EquipoPitcheoCopyWith<$Res>? get visita;

}
/// @nodoc
class __$PitcheoCopyWithImpl<$Res>
    implements _$PitcheoCopyWith<$Res> {
  __$PitcheoCopyWithImpl(this._self, this._then);

  final _Pitcheo _self;
  final $Res Function(_Pitcheo) _then;

/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicada = null,Object? local = freezed,Object? visita = freezed,}) {
  return _then(_Pitcheo(
publicada: null == publicada ? _self.publicada : publicada // ignore: cast_nullable_to_non_nullable
as bool,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as EquipoPitcheo?,visita: freezed == visita ? _self.visita : visita // ignore: cast_nullable_to_non_nullable
as EquipoPitcheo?,
  ));
}

/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoPitcheoCopyWith<$Res>? get local {
    if (_self.local == null) {
    return null;
  }

  return $EquipoPitcheoCopyWith<$Res>(_self.local!, (value) {
    return _then(_self.copyWith(local: value));
  });
}/// Create a copy of Pitcheo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoPitcheoCopyWith<$Res>? get visita {
    if (_self.visita == null) {
    return null;
  }

  return $EquipoPitcheoCopyWith<$Res>(_self.visita!, (value) {
    return _then(_self.copyWith(visita: value));
  });
}
}

// dart format on
