// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_temporada.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemporadaResumen {

 String get id; String get nombreTemporada; int get anio; int get totalEquipos; int get totalPartidos; int get partidosFinalizados; EquipoRef? get campeon;
/// Create a copy of TemporadaResumen
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemporadaResumenCopyWith<TemporadaResumen> get copyWith => _$TemporadaResumenCopyWithImpl<TemporadaResumen>(this as TemporadaResumen, _$identity);

  /// Serializes this TemporadaResumen to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TemporadaResumen;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemporadaResumen&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombreTemporada, _this.nombreTemporada) || other.nombreTemporada == _this.nombreTemporada)&&(identical(other.anio, _this.anio) || other.anio == _this.anio)&&(identical(other.totalEquipos, _this.totalEquipos) || other.totalEquipos == _this.totalEquipos)&&(identical(other.totalPartidos, _this.totalPartidos) || other.totalPartidos == _this.totalPartidos)&&(identical(other.partidosFinalizados, _this.partidosFinalizados) || other.partidosFinalizados == _this.partidosFinalizados)&&(identical(other.campeon, _this.campeon) || other.campeon == _this.campeon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TemporadaResumen;
  return Object.hash(runtimeType,_this.id,_this.nombreTemporada,_this.anio,_this.totalEquipos,_this.totalPartidos,_this.partidosFinalizados,_this.campeon);
}

@override
String toString() {
  final _this = this as TemporadaResumen;
  return 'TemporadaResumen(id: ${_this.id}, nombreTemporada: ${_this.nombreTemporada}, anio: ${_this.anio}, totalEquipos: ${_this.totalEquipos}, totalPartidos: ${_this.totalPartidos}, partidosFinalizados: ${_this.partidosFinalizados}, campeon: ${_this.campeon})';
}


}

/// @nodoc
abstract mixin class $TemporadaResumenCopyWith<$Res>  {
  factory $TemporadaResumenCopyWith(TemporadaResumen value, $Res Function(TemporadaResumen) _then) = _$TemporadaResumenCopyWithImpl;
@useResult
$Res call({
 String id, String nombreTemporada, int anio, int totalEquipos, int totalPartidos, int partidosFinalizados, EquipoRef? campeon
});


$EquipoRefCopyWith<$Res>? get campeon;

}
/// @nodoc
class _$TemporadaResumenCopyWithImpl<$Res>
    implements $TemporadaResumenCopyWith<$Res> {
  _$TemporadaResumenCopyWithImpl(this._self, this._then);

  final TemporadaResumen _self;
  final $Res Function(TemporadaResumen) _then;

/// Create a copy of TemporadaResumen
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombreTemporada = null,Object? anio = null,Object? totalEquipos = null,Object? totalPartidos = null,Object? partidosFinalizados = null,Object? campeon = freezed,}) {
  return _then(TemporadaResumen(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreTemporada: null == nombreTemporada ? _self.nombreTemporada : nombreTemporada // ignore: cast_nullable_to_non_nullable
as String,anio: null == anio ? _self.anio : anio // ignore: cast_nullable_to_non_nullable
as int,totalEquipos: null == totalEquipos ? _self.totalEquipos : totalEquipos // ignore: cast_nullable_to_non_nullable
as int,totalPartidos: null == totalPartidos ? _self.totalPartidos : totalPartidos // ignore: cast_nullable_to_non_nullable
as int,partidosFinalizados: null == partidosFinalizados ? _self.partidosFinalizados : partidosFinalizados // ignore: cast_nullable_to_non_nullable
as int,campeon: freezed == campeon ? _self.campeon : campeon // ignore: cast_nullable_to_non_nullable
as EquipoRef?,
  ));
}
/// Create a copy of TemporadaResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get campeon {
    if (_self.campeon == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.campeon!, (value) {
    return _then(_self.copyWith(campeon: value));
  });
}
}


/// Adds pattern-matching-related methods to [TemporadaResumen].
extension TemporadaResumenPatterns on TemporadaResumen {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemporadaResumen value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemporadaResumen() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemporadaResumen value)  $default,){
final _that = this;
switch (_that) {
case _TemporadaResumen():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemporadaResumen value)?  $default,){
final _that = this;
switch (_that) {
case _TemporadaResumen() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombreTemporada,  int anio,  int totalEquipos,  int totalPartidos,  int partidosFinalizados,  EquipoRef? campeon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemporadaResumen() when $default != null:
return $default(_that.id,_that.nombreTemporada,_that.anio,_that.totalEquipos,_that.totalPartidos,_that.partidosFinalizados,_that.campeon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombreTemporada,  int anio,  int totalEquipos,  int totalPartidos,  int partidosFinalizados,  EquipoRef? campeon)  $default,) {final _that = this;
switch (_that) {
case _TemporadaResumen():
return $default(_that.id,_that.nombreTemporada,_that.anio,_that.totalEquipos,_that.totalPartidos,_that.partidosFinalizados,_that.campeon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombreTemporada,  int anio,  int totalEquipos,  int totalPartidos,  int partidosFinalizados,  EquipoRef? campeon)?  $default,) {final _that = this;
switch (_that) {
case _TemporadaResumen() when $default != null:
return $default(_that.id,_that.nombreTemporada,_that.anio,_that.totalEquipos,_that.totalPartidos,_that.partidosFinalizados,_that.campeon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemporadaResumen implements TemporadaResumen {
  const _TemporadaResumen({required this.id, required this.nombreTemporada, required this.anio, this.totalEquipos = 0, this.totalPartidos = 0, this.partidosFinalizados = 0, this.campeon});
  factory _TemporadaResumen.fromJson(Map<String, dynamic> json) => _$TemporadaResumenFromJson(json);

@override final  String id;
@override final  String nombreTemporada;
@override final  int anio;
@override@JsonKey() final  int totalEquipos;
@override@JsonKey() final  int totalPartidos;
@override@JsonKey() final  int partidosFinalizados;
@override final  EquipoRef? campeon;

/// Create a copy of TemporadaResumen
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemporadaResumenCopyWith<_TemporadaResumen> get copyWith => __$TemporadaResumenCopyWithImpl<_TemporadaResumen>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemporadaResumenToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemporadaResumen&&(identical(other.id, id) || other.id == id)&&(identical(other.nombreTemporada, nombreTemporada) || other.nombreTemporada == nombreTemporada)&&(identical(other.anio, anio) || other.anio == anio)&&(identical(other.totalEquipos, totalEquipos) || other.totalEquipos == totalEquipos)&&(identical(other.totalPartidos, totalPartidos) || other.totalPartidos == totalPartidos)&&(identical(other.partidosFinalizados, partidosFinalizados) || other.partidosFinalizados == partidosFinalizados)&&(identical(other.campeon, campeon) || other.campeon == campeon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombreTemporada,anio,totalEquipos,totalPartidos,partidosFinalizados,campeon);
}

@override
String toString() {
    return 'TemporadaResumen(id: $id, nombreTemporada: $nombreTemporada, anio: $anio, totalEquipos: $totalEquipos, totalPartidos: $totalPartidos, partidosFinalizados: $partidosFinalizados, campeon: $campeon)';
}


}

/// @nodoc
abstract mixin class _$TemporadaResumenCopyWith<$Res> implements $TemporadaResumenCopyWith<$Res> {
  factory _$TemporadaResumenCopyWith(_TemporadaResumen value, $Res Function(_TemporadaResumen) _then) = __$TemporadaResumenCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombreTemporada, int anio, int totalEquipos, int totalPartidos, int partidosFinalizados, EquipoRef? campeon
});


@override $EquipoRefCopyWith<$Res>? get campeon;

}
/// @nodoc
class __$TemporadaResumenCopyWithImpl<$Res>
    implements _$TemporadaResumenCopyWith<$Res> {
  __$TemporadaResumenCopyWithImpl(this._self, this._then);

  final _TemporadaResumen _self;
  final $Res Function(_TemporadaResumen) _then;

/// Create a copy of TemporadaResumen
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombreTemporada = null,Object? anio = null,Object? totalEquipos = null,Object? totalPartidos = null,Object? partidosFinalizados = null,Object? campeon = freezed,}) {
  return _then(_TemporadaResumen(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreTemporada: null == nombreTemporada ? _self.nombreTemporada : nombreTemporada // ignore: cast_nullable_to_non_nullable
as String,anio: null == anio ? _self.anio : anio // ignore: cast_nullable_to_non_nullable
as int,totalEquipos: null == totalEquipos ? _self.totalEquipos : totalEquipos // ignore: cast_nullable_to_non_nullable
as int,totalPartidos: null == totalPartidos ? _self.totalPartidos : totalPartidos // ignore: cast_nullable_to_non_nullable
as int,partidosFinalizados: null == partidosFinalizados ? _self.partidosFinalizados : partidosFinalizados // ignore: cast_nullable_to_non_nullable
as int,campeon: freezed == campeon ? _self.campeon : campeon // ignore: cast_nullable_to_non_nullable
as EquipoRef?,
  ));
}

/// Create a copy of TemporadaResumen
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get campeon {
    if (_self.campeon == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.campeon!, (value) {
    return _then(_self.copyWith(campeon: value));
  });
}
}


/// @nodoc
mixin _$TemporadaDetalle {

 String get id; String get nombreTemporada; int get anio; EquipoRef? get campeon; int get totalPartidos; int get partidosFinalizados; int get totalAgentesLibres; List<Equipo> get equipos; List<Estadio> get estadios;
/// Create a copy of TemporadaDetalle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemporadaDetalleCopyWith<TemporadaDetalle> get copyWith => _$TemporadaDetalleCopyWithImpl<TemporadaDetalle>(this as TemporadaDetalle, _$identity);

  /// Serializes this TemporadaDetalle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TemporadaDetalle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemporadaDetalle&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombreTemporada, _this.nombreTemporada) || other.nombreTemporada == _this.nombreTemporada)&&(identical(other.anio, _this.anio) || other.anio == _this.anio)&&(identical(other.campeon, _this.campeon) || other.campeon == _this.campeon)&&(identical(other.totalPartidos, _this.totalPartidos) || other.totalPartidos == _this.totalPartidos)&&(identical(other.partidosFinalizados, _this.partidosFinalizados) || other.partidosFinalizados == _this.partidosFinalizados)&&(identical(other.totalAgentesLibres, _this.totalAgentesLibres) || other.totalAgentesLibres == _this.totalAgentesLibres)&&const DeepCollectionEquality().equals(other.equipos, _this.equipos)&&const DeepCollectionEquality().equals(other.estadios, _this.estadios));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TemporadaDetalle;
  return Object.hash(runtimeType,_this.id,_this.nombreTemporada,_this.anio,_this.campeon,_this.totalPartidos,_this.partidosFinalizados,_this.totalAgentesLibres,const DeepCollectionEquality().hash(_this.equipos),const DeepCollectionEquality().hash(_this.estadios));
}

@override
String toString() {
  final _this = this as TemporadaDetalle;
  return 'TemporadaDetalle(id: ${_this.id}, nombreTemporada: ${_this.nombreTemporada}, anio: ${_this.anio}, campeon: ${_this.campeon}, totalPartidos: ${_this.totalPartidos}, partidosFinalizados: ${_this.partidosFinalizados}, totalAgentesLibres: ${_this.totalAgentesLibres}, equipos: ${_this.equipos}, estadios: ${_this.estadios})';
}


}

/// @nodoc
abstract mixin class $TemporadaDetalleCopyWith<$Res>  {
  factory $TemporadaDetalleCopyWith(TemporadaDetalle value, $Res Function(TemporadaDetalle) _then) = _$TemporadaDetalleCopyWithImpl;
@useResult
$Res call({
 String id, String nombreTemporada, int anio, EquipoRef? campeon, int totalPartidos, int partidosFinalizados, int totalAgentesLibres, List<Equipo> equipos, List<Estadio> estadios
});


$EquipoRefCopyWith<$Res>? get campeon;

}
/// @nodoc
class _$TemporadaDetalleCopyWithImpl<$Res>
    implements $TemporadaDetalleCopyWith<$Res> {
  _$TemporadaDetalleCopyWithImpl(this._self, this._then);

  final TemporadaDetalle _self;
  final $Res Function(TemporadaDetalle) _then;

/// Create a copy of TemporadaDetalle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombreTemporada = null,Object? anio = null,Object? campeon = freezed,Object? totalPartidos = null,Object? partidosFinalizados = null,Object? totalAgentesLibres = null,Object? equipos = null,Object? estadios = null,}) {
  return _then(TemporadaDetalle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreTemporada: null == nombreTemporada ? _self.nombreTemporada : nombreTemporada // ignore: cast_nullable_to_non_nullable
as String,anio: null == anio ? _self.anio : anio // ignore: cast_nullable_to_non_nullable
as int,campeon: freezed == campeon ? _self.campeon : campeon // ignore: cast_nullable_to_non_nullable
as EquipoRef?,totalPartidos: null == totalPartidos ? _self.totalPartidos : totalPartidos // ignore: cast_nullable_to_non_nullable
as int,partidosFinalizados: null == partidosFinalizados ? _self.partidosFinalizados : partidosFinalizados // ignore: cast_nullable_to_non_nullable
as int,totalAgentesLibres: null == totalAgentesLibres ? _self.totalAgentesLibres : totalAgentesLibres // ignore: cast_nullable_to_non_nullable
as int,equipos: null == equipos ? _self.equipos : equipos // ignore: cast_nullable_to_non_nullable
as List<Equipo>,estadios: null == estadios ? _self.estadios : estadios // ignore: cast_nullable_to_non_nullable
as List<Estadio>,
  ));
}
/// Create a copy of TemporadaDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get campeon {
    if (_self.campeon == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.campeon!, (value) {
    return _then(_self.copyWith(campeon: value));
  });
}
}


/// Adds pattern-matching-related methods to [TemporadaDetalle].
extension TemporadaDetallePatterns on TemporadaDetalle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemporadaDetalle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemporadaDetalle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemporadaDetalle value)  $default,){
final _that = this;
switch (_that) {
case _TemporadaDetalle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemporadaDetalle value)?  $default,){
final _that = this;
switch (_that) {
case _TemporadaDetalle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombreTemporada,  int anio,  EquipoRef? campeon,  int totalPartidos,  int partidosFinalizados,  int totalAgentesLibres,  List<Equipo> equipos,  List<Estadio> estadios)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemporadaDetalle() when $default != null:
return $default(_that.id,_that.nombreTemporada,_that.anio,_that.campeon,_that.totalPartidos,_that.partidosFinalizados,_that.totalAgentesLibres,_that.equipos,_that.estadios);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombreTemporada,  int anio,  EquipoRef? campeon,  int totalPartidos,  int partidosFinalizados,  int totalAgentesLibres,  List<Equipo> equipos,  List<Estadio> estadios)  $default,) {final _that = this;
switch (_that) {
case _TemporadaDetalle():
return $default(_that.id,_that.nombreTemporada,_that.anio,_that.campeon,_that.totalPartidos,_that.partidosFinalizados,_that.totalAgentesLibres,_that.equipos,_that.estadios);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombreTemporada,  int anio,  EquipoRef? campeon,  int totalPartidos,  int partidosFinalizados,  int totalAgentesLibres,  List<Equipo> equipos,  List<Estadio> estadios)?  $default,) {final _that = this;
switch (_that) {
case _TemporadaDetalle() when $default != null:
return $default(_that.id,_that.nombreTemporada,_that.anio,_that.campeon,_that.totalPartidos,_that.partidosFinalizados,_that.totalAgentesLibres,_that.equipos,_that.estadios);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemporadaDetalle implements TemporadaDetalle {
  const _TemporadaDetalle({required this.id, required this.nombreTemporada, required this.anio, this.campeon, this.totalPartidos = 0, this.partidosFinalizados = 0, this.totalAgentesLibres = 0,  List<Equipo> equipos = const <Equipo>[],  List<Estadio> estadios = const <Estadio>[]}): _equipos = equipos,_estadios = estadios;
  factory _TemporadaDetalle.fromJson(Map<String, dynamic> json) => _$TemporadaDetalleFromJson(json);

@override final  String id;
@override final  String nombreTemporada;
@override final  int anio;
@override final  EquipoRef? campeon;
@override@JsonKey() final  int totalPartidos;
@override@JsonKey() final  int partidosFinalizados;
@override@JsonKey() final  int totalAgentesLibres;
 final  List<Equipo> _equipos;
@override@JsonKey() List<Equipo> get equipos {
  if (_equipos is EqualUnmodifiableListView) return _equipos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipos);
}

 final  List<Estadio> _estadios;
@override@JsonKey() List<Estadio> get estadios {
  if (_estadios is EqualUnmodifiableListView) return _estadios;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estadios);
}


/// Create a copy of TemporadaDetalle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemporadaDetalleCopyWith<_TemporadaDetalle> get copyWith => __$TemporadaDetalleCopyWithImpl<_TemporadaDetalle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemporadaDetalleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemporadaDetalle&&(identical(other.id, id) || other.id == id)&&(identical(other.nombreTemporada, nombreTemporada) || other.nombreTemporada == nombreTemporada)&&(identical(other.anio, anio) || other.anio == anio)&&(identical(other.campeon, campeon) || other.campeon == campeon)&&(identical(other.totalPartidos, totalPartidos) || other.totalPartidos == totalPartidos)&&(identical(other.partidosFinalizados, partidosFinalizados) || other.partidosFinalizados == partidosFinalizados)&&(identical(other.totalAgentesLibres, totalAgentesLibres) || other.totalAgentesLibres == totalAgentesLibres)&&const DeepCollectionEquality().equals(other.equipos, _equipos)&&const DeepCollectionEquality().equals(other.estadios, _estadios));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombreTemporada,anio,campeon,totalPartidos,partidosFinalizados,totalAgentesLibres,const DeepCollectionEquality().hash(_equipos),const DeepCollectionEquality().hash(_estadios));
}

@override
String toString() {
    return 'TemporadaDetalle(id: $id, nombreTemporada: $nombreTemporada, anio: $anio, campeon: $campeon, totalPartidos: $totalPartidos, partidosFinalizados: $partidosFinalizados, totalAgentesLibres: $totalAgentesLibres, equipos: $equipos, estadios: $estadios)';
}


}

/// @nodoc
abstract mixin class _$TemporadaDetalleCopyWith<$Res> implements $TemporadaDetalleCopyWith<$Res> {
  factory _$TemporadaDetalleCopyWith(_TemporadaDetalle value, $Res Function(_TemporadaDetalle) _then) = __$TemporadaDetalleCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombreTemporada, int anio, EquipoRef? campeon, int totalPartidos, int partidosFinalizados, int totalAgentesLibres, List<Equipo> equipos, List<Estadio> estadios
});


@override $EquipoRefCopyWith<$Res>? get campeon;

}
/// @nodoc
class __$TemporadaDetalleCopyWithImpl<$Res>
    implements _$TemporadaDetalleCopyWith<$Res> {
  __$TemporadaDetalleCopyWithImpl(this._self, this._then);

  final _TemporadaDetalle _self;
  final $Res Function(_TemporadaDetalle) _then;

/// Create a copy of TemporadaDetalle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombreTemporada = null,Object? anio = null,Object? campeon = freezed,Object? totalPartidos = null,Object? partidosFinalizados = null,Object? totalAgentesLibres = null,Object? equipos = null,Object? estadios = null,}) {
  return _then(_TemporadaDetalle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreTemporada: null == nombreTemporada ? _self.nombreTemporada : nombreTemporada // ignore: cast_nullable_to_non_nullable
as String,anio: null == anio ? _self.anio : anio // ignore: cast_nullable_to_non_nullable
as int,campeon: freezed == campeon ? _self.campeon : campeon // ignore: cast_nullable_to_non_nullable
as EquipoRef?,totalPartidos: null == totalPartidos ? _self.totalPartidos : totalPartidos // ignore: cast_nullable_to_non_nullable
as int,partidosFinalizados: null == partidosFinalizados ? _self.partidosFinalizados : partidosFinalizados // ignore: cast_nullable_to_non_nullable
as int,totalAgentesLibres: null == totalAgentesLibres ? _self.totalAgentesLibres : totalAgentesLibres // ignore: cast_nullable_to_non_nullable
as int,equipos: null == equipos ? _self._equipos : equipos // ignore: cast_nullable_to_non_nullable
as List<Equipo>,estadios: null == estadios ? _self._estadios : estadios // ignore: cast_nullable_to_non_nullable
as List<Estadio>,
  ));
}

/// Create a copy of TemporadaDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get campeon {
    if (_self.campeon == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.campeon!, (value) {
    return _then(_self.copyWith(campeon: value));
  });
}
}


/// @nodoc
mixin _$EstadisticasTemporada {

 String get idTemporada; Kpis get kpis; List<CarrerasPartido> get carrerasPorPartido; List<VictoriasEquipo> get victoriasPorEquipo; DistribucionHits get distribucionHits; List<PartidosEstadio> get partidosPorEstadio; Map<String, Referencia> get referenciaBateo; Map<String, Referencia> get referenciaPitcheo;
/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstadisticasTemporadaCopyWith<EstadisticasTemporada> get copyWith => _$EstadisticasTemporadaCopyWithImpl<EstadisticasTemporada>(this as EstadisticasTemporada, _$identity);

  /// Serializes this EstadisticasTemporada to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstadisticasTemporada;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstadisticasTemporada&&(identical(other.idTemporada, _this.idTemporada) || other.idTemporada == _this.idTemporada)&&(identical(other.kpis, _this.kpis) || other.kpis == _this.kpis)&&const DeepCollectionEquality().equals(other.carrerasPorPartido, _this.carrerasPorPartido)&&const DeepCollectionEquality().equals(other.victoriasPorEquipo, _this.victoriasPorEquipo)&&(identical(other.distribucionHits, _this.distribucionHits) || other.distribucionHits == _this.distribucionHits)&&const DeepCollectionEquality().equals(other.partidosPorEstadio, _this.partidosPorEstadio)&&const DeepCollectionEquality().equals(other.referenciaBateo, _this.referenciaBateo)&&const DeepCollectionEquality().equals(other.referenciaPitcheo, _this.referenciaPitcheo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstadisticasTemporada;
  return Object.hash(runtimeType,_this.idTemporada,_this.kpis,const DeepCollectionEquality().hash(_this.carrerasPorPartido),const DeepCollectionEquality().hash(_this.victoriasPorEquipo),_this.distribucionHits,const DeepCollectionEquality().hash(_this.partidosPorEstadio),const DeepCollectionEquality().hash(_this.referenciaBateo),const DeepCollectionEquality().hash(_this.referenciaPitcheo));
}

@override
String toString() {
  final _this = this as EstadisticasTemporada;
  return 'EstadisticasTemporada(idTemporada: ${_this.idTemporada}, kpis: ${_this.kpis}, carrerasPorPartido: ${_this.carrerasPorPartido}, victoriasPorEquipo: ${_this.victoriasPorEquipo}, distribucionHits: ${_this.distribucionHits}, partidosPorEstadio: ${_this.partidosPorEstadio}, referenciaBateo: ${_this.referenciaBateo}, referenciaPitcheo: ${_this.referenciaPitcheo})';
}


}

/// @nodoc
abstract mixin class $EstadisticasTemporadaCopyWith<$Res>  {
  factory $EstadisticasTemporadaCopyWith(EstadisticasTemporada value, $Res Function(EstadisticasTemporada) _then) = _$EstadisticasTemporadaCopyWithImpl;
@useResult
$Res call({
 String idTemporada, Kpis kpis, List<CarrerasPartido> carrerasPorPartido, List<VictoriasEquipo> victoriasPorEquipo, DistribucionHits distribucionHits, List<PartidosEstadio> partidosPorEstadio, Map<String, Referencia> referenciaBateo, Map<String, Referencia> referenciaPitcheo
});


$KpisCopyWith<$Res> get kpis;$DistribucionHitsCopyWith<$Res> get distribucionHits;

}
/// @nodoc
class _$EstadisticasTemporadaCopyWithImpl<$Res>
    implements $EstadisticasTemporadaCopyWith<$Res> {
  _$EstadisticasTemporadaCopyWithImpl(this._self, this._then);

  final EstadisticasTemporada _self;
  final $Res Function(EstadisticasTemporada) _then;

/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idTemporada = null,Object? kpis = null,Object? carrerasPorPartido = null,Object? victoriasPorEquipo = null,Object? distribucionHits = null,Object? partidosPorEstadio = null,Object? referenciaBateo = null,Object? referenciaPitcheo = null,}) {
  return _then(EstadisticasTemporada(
idTemporada: null == idTemporada ? _self.idTemporada : idTemporada // ignore: cast_nullable_to_non_nullable
as String,kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as Kpis,carrerasPorPartido: null == carrerasPorPartido ? _self.carrerasPorPartido : carrerasPorPartido // ignore: cast_nullable_to_non_nullable
as List<CarrerasPartido>,victoriasPorEquipo: null == victoriasPorEquipo ? _self.victoriasPorEquipo : victoriasPorEquipo // ignore: cast_nullable_to_non_nullable
as List<VictoriasEquipo>,distribucionHits: null == distribucionHits ? _self.distribucionHits : distribucionHits // ignore: cast_nullable_to_non_nullable
as DistribucionHits,partidosPorEstadio: null == partidosPorEstadio ? _self.partidosPorEstadio : partidosPorEstadio // ignore: cast_nullable_to_non_nullable
as List<PartidosEstadio>,referenciaBateo: null == referenciaBateo ? _self.referenciaBateo : referenciaBateo // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,referenciaPitcheo: null == referenciaPitcheo ? _self.referenciaPitcheo : referenciaPitcheo // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,
  ));
}
/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpisCopyWith<$Res> get kpis {
  
  return $KpisCopyWith<$Res>(_self.kpis, (value) {
    return _then(_self.copyWith(kpis: value));
  });
}/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistribucionHitsCopyWith<$Res> get distribucionHits {
  
  return $DistribucionHitsCopyWith<$Res>(_self.distribucionHits, (value) {
    return _then(_self.copyWith(distribucionHits: value));
  });
}
}


/// Adds pattern-matching-related methods to [EstadisticasTemporada].
extension EstadisticasTemporadaPatterns on EstadisticasTemporada {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstadisticasTemporada value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstadisticasTemporada() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstadisticasTemporada value)  $default,){
final _that = this;
switch (_that) {
case _EstadisticasTemporada():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstadisticasTemporada value)?  $default,){
final _that = this;
switch (_that) {
case _EstadisticasTemporada() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idTemporada,  Kpis kpis,  List<CarrerasPartido> carrerasPorPartido,  List<VictoriasEquipo> victoriasPorEquipo,  DistribucionHits distribucionHits,  List<PartidosEstadio> partidosPorEstadio,  Map<String, Referencia> referenciaBateo,  Map<String, Referencia> referenciaPitcheo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstadisticasTemporada() when $default != null:
return $default(_that.idTemporada,_that.kpis,_that.carrerasPorPartido,_that.victoriasPorEquipo,_that.distribucionHits,_that.partidosPorEstadio,_that.referenciaBateo,_that.referenciaPitcheo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idTemporada,  Kpis kpis,  List<CarrerasPartido> carrerasPorPartido,  List<VictoriasEquipo> victoriasPorEquipo,  DistribucionHits distribucionHits,  List<PartidosEstadio> partidosPorEstadio,  Map<String, Referencia> referenciaBateo,  Map<String, Referencia> referenciaPitcheo)  $default,) {final _that = this;
switch (_that) {
case _EstadisticasTemporada():
return $default(_that.idTemporada,_that.kpis,_that.carrerasPorPartido,_that.victoriasPorEquipo,_that.distribucionHits,_that.partidosPorEstadio,_that.referenciaBateo,_that.referenciaPitcheo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idTemporada,  Kpis kpis,  List<CarrerasPartido> carrerasPorPartido,  List<VictoriasEquipo> victoriasPorEquipo,  DistribucionHits distribucionHits,  List<PartidosEstadio> partidosPorEstadio,  Map<String, Referencia> referenciaBateo,  Map<String, Referencia> referenciaPitcheo)?  $default,) {final _that = this;
switch (_that) {
case _EstadisticasTemporada() when $default != null:
return $default(_that.idTemporada,_that.kpis,_that.carrerasPorPartido,_that.victoriasPorEquipo,_that.distribucionHits,_that.partidosPorEstadio,_that.referenciaBateo,_that.referenciaPitcheo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstadisticasTemporada implements EstadisticasTemporada {
  const _EstadisticasTemporada({required this.idTemporada, required this.kpis,  List<CarrerasPartido> carrerasPorPartido = const <CarrerasPartido>[],  List<VictoriasEquipo> victoriasPorEquipo = const <VictoriasEquipo>[], this.distribucionHits = const DistribucionHits(),  List<PartidosEstadio> partidosPorEstadio = const <PartidosEstadio>[],  Map<String, Referencia> referenciaBateo = const <String, Referencia>{},  Map<String, Referencia> referenciaPitcheo = const <String, Referencia>{}}): _carrerasPorPartido = carrerasPorPartido,_victoriasPorEquipo = victoriasPorEquipo,_partidosPorEstadio = partidosPorEstadio,_referenciaBateo = referenciaBateo,_referenciaPitcheo = referenciaPitcheo;
  factory _EstadisticasTemporada.fromJson(Map<String, dynamic> json) => _$EstadisticasTemporadaFromJson(json);

@override final  String idTemporada;
@override final  Kpis kpis;
 final  List<CarrerasPartido> _carrerasPorPartido;
@override@JsonKey() List<CarrerasPartido> get carrerasPorPartido {
  if (_carrerasPorPartido is EqualUnmodifiableListView) return _carrerasPorPartido;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_carrerasPorPartido);
}

 final  List<VictoriasEquipo> _victoriasPorEquipo;
@override@JsonKey() List<VictoriasEquipo> get victoriasPorEquipo {
  if (_victoriasPorEquipo is EqualUnmodifiableListView) return _victoriasPorEquipo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_victoriasPorEquipo);
}

@override@JsonKey() final  DistribucionHits distribucionHits;
 final  List<PartidosEstadio> _partidosPorEstadio;
@override@JsonKey() List<PartidosEstadio> get partidosPorEstadio {
  if (_partidosPorEstadio is EqualUnmodifiableListView) return _partidosPorEstadio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partidosPorEstadio);
}

 final  Map<String, Referencia> _referenciaBateo;
@override@JsonKey() Map<String, Referencia> get referenciaBateo {
  if (_referenciaBateo is EqualUnmodifiableMapView) return _referenciaBateo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_referenciaBateo);
}

 final  Map<String, Referencia> _referenciaPitcheo;
@override@JsonKey() Map<String, Referencia> get referenciaPitcheo {
  if (_referenciaPitcheo is EqualUnmodifiableMapView) return _referenciaPitcheo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_referenciaPitcheo);
}


/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstadisticasTemporadaCopyWith<_EstadisticasTemporada> get copyWith => __$EstadisticasTemporadaCopyWithImpl<_EstadisticasTemporada>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstadisticasTemporadaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstadisticasTemporada&&(identical(other.idTemporada, idTemporada) || other.idTemporada == idTemporada)&&(identical(other.kpis, kpis) || other.kpis == kpis)&&const DeepCollectionEquality().equals(other.carrerasPorPartido, _carrerasPorPartido)&&const DeepCollectionEquality().equals(other.victoriasPorEquipo, _victoriasPorEquipo)&&(identical(other.distribucionHits, distribucionHits) || other.distribucionHits == distribucionHits)&&const DeepCollectionEquality().equals(other.partidosPorEstadio, _partidosPorEstadio)&&const DeepCollectionEquality().equals(other.referenciaBateo, _referenciaBateo)&&const DeepCollectionEquality().equals(other.referenciaPitcheo, _referenciaPitcheo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idTemporada,kpis,const DeepCollectionEquality().hash(_carrerasPorPartido),const DeepCollectionEquality().hash(_victoriasPorEquipo),distribucionHits,const DeepCollectionEquality().hash(_partidosPorEstadio),const DeepCollectionEquality().hash(_referenciaBateo),const DeepCollectionEquality().hash(_referenciaPitcheo));
}

@override
String toString() {
    return 'EstadisticasTemporada(idTemporada: $idTemporada, kpis: $kpis, carrerasPorPartido: $carrerasPorPartido, victoriasPorEquipo: $victoriasPorEquipo, distribucionHits: $distribucionHits, partidosPorEstadio: $partidosPorEstadio, referenciaBateo: $referenciaBateo, referenciaPitcheo: $referenciaPitcheo)';
}


}

/// @nodoc
abstract mixin class _$EstadisticasTemporadaCopyWith<$Res> implements $EstadisticasTemporadaCopyWith<$Res> {
  factory _$EstadisticasTemporadaCopyWith(_EstadisticasTemporada value, $Res Function(_EstadisticasTemporada) _then) = __$EstadisticasTemporadaCopyWithImpl;
@override @useResult
$Res call({
 String idTemporada, Kpis kpis, List<CarrerasPartido> carrerasPorPartido, List<VictoriasEquipo> victoriasPorEquipo, DistribucionHits distribucionHits, List<PartidosEstadio> partidosPorEstadio, Map<String, Referencia> referenciaBateo, Map<String, Referencia> referenciaPitcheo
});


@override $KpisCopyWith<$Res> get kpis;@override $DistribucionHitsCopyWith<$Res> get distribucionHits;

}
/// @nodoc
class __$EstadisticasTemporadaCopyWithImpl<$Res>
    implements _$EstadisticasTemporadaCopyWith<$Res> {
  __$EstadisticasTemporadaCopyWithImpl(this._self, this._then);

  final _EstadisticasTemporada _self;
  final $Res Function(_EstadisticasTemporada) _then;

/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idTemporada = null,Object? kpis = null,Object? carrerasPorPartido = null,Object? victoriasPorEquipo = null,Object? distribucionHits = null,Object? partidosPorEstadio = null,Object? referenciaBateo = null,Object? referenciaPitcheo = null,}) {
  return _then(_EstadisticasTemporada(
idTemporada: null == idTemporada ? _self.idTemporada : idTemporada // ignore: cast_nullable_to_non_nullable
as String,kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as Kpis,carrerasPorPartido: null == carrerasPorPartido ? _self._carrerasPorPartido : carrerasPorPartido // ignore: cast_nullable_to_non_nullable
as List<CarrerasPartido>,victoriasPorEquipo: null == victoriasPorEquipo ? _self._victoriasPorEquipo : victoriasPorEquipo // ignore: cast_nullable_to_non_nullable
as List<VictoriasEquipo>,distribucionHits: null == distribucionHits ? _self.distribucionHits : distribucionHits // ignore: cast_nullable_to_non_nullable
as DistribucionHits,partidosPorEstadio: null == partidosPorEstadio ? _self._partidosPorEstadio : partidosPorEstadio // ignore: cast_nullable_to_non_nullable
as List<PartidosEstadio>,referenciaBateo: null == referenciaBateo ? _self._referenciaBateo : referenciaBateo // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,referenciaPitcheo: null == referenciaPitcheo ? _self._referenciaPitcheo : referenciaPitcheo // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,
  ));
}

/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KpisCopyWith<$Res> get kpis {
  
  return $KpisCopyWith<$Res>(_self.kpis, (value) {
    return _then(_self.copyWith(kpis: value));
  });
}/// Create a copy of EstadisticasTemporada
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistribucionHitsCopyWith<$Res> get distribucionHits {
  
  return $DistribucionHitsCopyWith<$Res>(_self.distribucionHits, (value) {
    return _then(_self.copyWith(distribucionHits: value));
  });
}
}


/// @nodoc
mixin _$Kpis {

 int get partidosJugados; int get partidosPendientes; int get carrerasTotales; double? get promedioCarrerasPorPartido; int get totalEquipos; int get totalJugadores; JugadorDestacado? get liderJonrones; EquipoDestacado? get mejorRecord;
/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KpisCopyWith<Kpis> get copyWith => _$KpisCopyWithImpl<Kpis>(this as Kpis, _$identity);

  /// Serializes this Kpis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Kpis;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Kpis&&(identical(other.partidosJugados, _this.partidosJugados) || other.partidosJugados == _this.partidosJugados)&&(identical(other.partidosPendientes, _this.partidosPendientes) || other.partidosPendientes == _this.partidosPendientes)&&(identical(other.carrerasTotales, _this.carrerasTotales) || other.carrerasTotales == _this.carrerasTotales)&&(identical(other.promedioCarrerasPorPartido, _this.promedioCarrerasPorPartido) || other.promedioCarrerasPorPartido == _this.promedioCarrerasPorPartido)&&(identical(other.totalEquipos, _this.totalEquipos) || other.totalEquipos == _this.totalEquipos)&&(identical(other.totalJugadores, _this.totalJugadores) || other.totalJugadores == _this.totalJugadores)&&(identical(other.liderJonrones, _this.liderJonrones) || other.liderJonrones == _this.liderJonrones)&&(identical(other.mejorRecord, _this.mejorRecord) || other.mejorRecord == _this.mejorRecord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Kpis;
  return Object.hash(runtimeType,_this.partidosJugados,_this.partidosPendientes,_this.carrerasTotales,_this.promedioCarrerasPorPartido,_this.totalEquipos,_this.totalJugadores,_this.liderJonrones,_this.mejorRecord);
}

@override
String toString() {
  final _this = this as Kpis;
  return 'Kpis(partidosJugados: ${_this.partidosJugados}, partidosPendientes: ${_this.partidosPendientes}, carrerasTotales: ${_this.carrerasTotales}, promedioCarrerasPorPartido: ${_this.promedioCarrerasPorPartido}, totalEquipos: ${_this.totalEquipos}, totalJugadores: ${_this.totalJugadores}, liderJonrones: ${_this.liderJonrones}, mejorRecord: ${_this.mejorRecord})';
}


}

/// @nodoc
abstract mixin class $KpisCopyWith<$Res>  {
  factory $KpisCopyWith(Kpis value, $Res Function(Kpis) _then) = _$KpisCopyWithImpl;
@useResult
$Res call({
 int partidosJugados, int partidosPendientes, int carrerasTotales, double? promedioCarrerasPorPartido, int totalEquipos, int totalJugadores, JugadorDestacado? liderJonrones, EquipoDestacado? mejorRecord
});


$JugadorDestacadoCopyWith<$Res>? get liderJonrones;$EquipoDestacadoCopyWith<$Res>? get mejorRecord;

}
/// @nodoc
class _$KpisCopyWithImpl<$Res>
    implements $KpisCopyWith<$Res> {
  _$KpisCopyWithImpl(this._self, this._then);

  final Kpis _self;
  final $Res Function(Kpis) _then;

/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partidosJugados = null,Object? partidosPendientes = null,Object? carrerasTotales = null,Object? promedioCarrerasPorPartido = freezed,Object? totalEquipos = null,Object? totalJugadores = null,Object? liderJonrones = freezed,Object? mejorRecord = freezed,}) {
  return _then(Kpis(
partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,partidosPendientes: null == partidosPendientes ? _self.partidosPendientes : partidosPendientes // ignore: cast_nullable_to_non_nullable
as int,carrerasTotales: null == carrerasTotales ? _self.carrerasTotales : carrerasTotales // ignore: cast_nullable_to_non_nullable
as int,promedioCarrerasPorPartido: freezed == promedioCarrerasPorPartido ? _self.promedioCarrerasPorPartido : promedioCarrerasPorPartido // ignore: cast_nullable_to_non_nullable
as double?,totalEquipos: null == totalEquipos ? _self.totalEquipos : totalEquipos // ignore: cast_nullable_to_non_nullable
as int,totalJugadores: null == totalJugadores ? _self.totalJugadores : totalJugadores // ignore: cast_nullable_to_non_nullable
as int,liderJonrones: freezed == liderJonrones ? _self.liderJonrones : liderJonrones // ignore: cast_nullable_to_non_nullable
as JugadorDestacado?,mejorRecord: freezed == mejorRecord ? _self.mejorRecord : mejorRecord // ignore: cast_nullable_to_non_nullable
as EquipoDestacado?,
  ));
}
/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorDestacadoCopyWith<$Res>? get liderJonrones {
    if (_self.liderJonrones == null) {
    return null;
  }

  return $JugadorDestacadoCopyWith<$Res>(_self.liderJonrones!, (value) {
    return _then(_self.copyWith(liderJonrones: value));
  });
}/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoDestacadoCopyWith<$Res>? get mejorRecord {
    if (_self.mejorRecord == null) {
    return null;
  }

  return $EquipoDestacadoCopyWith<$Res>(_self.mejorRecord!, (value) {
    return _then(_self.copyWith(mejorRecord: value));
  });
}
}


/// Adds pattern-matching-related methods to [Kpis].
extension KpisPatterns on Kpis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Kpis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Kpis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Kpis value)  $default,){
final _that = this;
switch (_that) {
case _Kpis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Kpis value)?  $default,){
final _that = this;
switch (_that) {
case _Kpis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int partidosJugados,  int partidosPendientes,  int carrerasTotales,  double? promedioCarrerasPorPartido,  int totalEquipos,  int totalJugadores,  JugadorDestacado? liderJonrones,  EquipoDestacado? mejorRecord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Kpis() when $default != null:
return $default(_that.partidosJugados,_that.partidosPendientes,_that.carrerasTotales,_that.promedioCarrerasPorPartido,_that.totalEquipos,_that.totalJugadores,_that.liderJonrones,_that.mejorRecord);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int partidosJugados,  int partidosPendientes,  int carrerasTotales,  double? promedioCarrerasPorPartido,  int totalEquipos,  int totalJugadores,  JugadorDestacado? liderJonrones,  EquipoDestacado? mejorRecord)  $default,) {final _that = this;
switch (_that) {
case _Kpis():
return $default(_that.partidosJugados,_that.partidosPendientes,_that.carrerasTotales,_that.promedioCarrerasPorPartido,_that.totalEquipos,_that.totalJugadores,_that.liderJonrones,_that.mejorRecord);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int partidosJugados,  int partidosPendientes,  int carrerasTotales,  double? promedioCarrerasPorPartido,  int totalEquipos,  int totalJugadores,  JugadorDestacado? liderJonrones,  EquipoDestacado? mejorRecord)?  $default,) {final _that = this;
switch (_that) {
case _Kpis() when $default != null:
return $default(_that.partidosJugados,_that.partidosPendientes,_that.carrerasTotales,_that.promedioCarrerasPorPartido,_that.totalEquipos,_that.totalJugadores,_that.liderJonrones,_that.mejorRecord);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Kpis implements Kpis {
  const _Kpis({this.partidosJugados = 0, this.partidosPendientes = 0, this.carrerasTotales = 0, this.promedioCarrerasPorPartido, this.totalEquipos = 0, this.totalJugadores = 0, this.liderJonrones, this.mejorRecord});
  factory _Kpis.fromJson(Map<String, dynamic> json) => _$KpisFromJson(json);

@override@JsonKey() final  int partidosJugados;
@override@JsonKey() final  int partidosPendientes;
@override@JsonKey() final  int carrerasTotales;
@override final  double? promedioCarrerasPorPartido;
@override@JsonKey() final  int totalEquipos;
@override@JsonKey() final  int totalJugadores;
@override final  JugadorDestacado? liderJonrones;
@override final  EquipoDestacado? mejorRecord;

/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KpisCopyWith<_Kpis> get copyWith => __$KpisCopyWithImpl<_Kpis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KpisToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Kpis&&(identical(other.partidosJugados, partidosJugados) || other.partidosJugados == partidosJugados)&&(identical(other.partidosPendientes, partidosPendientes) || other.partidosPendientes == partidosPendientes)&&(identical(other.carrerasTotales, carrerasTotales) || other.carrerasTotales == carrerasTotales)&&(identical(other.promedioCarrerasPorPartido, promedioCarrerasPorPartido) || other.promedioCarrerasPorPartido == promedioCarrerasPorPartido)&&(identical(other.totalEquipos, totalEquipos) || other.totalEquipos == totalEquipos)&&(identical(other.totalJugadores, totalJugadores) || other.totalJugadores == totalJugadores)&&(identical(other.liderJonrones, liderJonrones) || other.liderJonrones == liderJonrones)&&(identical(other.mejorRecord, mejorRecord) || other.mejorRecord == mejorRecord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,partidosJugados,partidosPendientes,carrerasTotales,promedioCarrerasPorPartido,totalEquipos,totalJugadores,liderJonrones,mejorRecord);
}

@override
String toString() {
    return 'Kpis(partidosJugados: $partidosJugados, partidosPendientes: $partidosPendientes, carrerasTotales: $carrerasTotales, promedioCarrerasPorPartido: $promedioCarrerasPorPartido, totalEquipos: $totalEquipos, totalJugadores: $totalJugadores, liderJonrones: $liderJonrones, mejorRecord: $mejorRecord)';
}


}

/// @nodoc
abstract mixin class _$KpisCopyWith<$Res> implements $KpisCopyWith<$Res> {
  factory _$KpisCopyWith(_Kpis value, $Res Function(_Kpis) _then) = __$KpisCopyWithImpl;
@override @useResult
$Res call({
 int partidosJugados, int partidosPendientes, int carrerasTotales, double? promedioCarrerasPorPartido, int totalEquipos, int totalJugadores, JugadorDestacado? liderJonrones, EquipoDestacado? mejorRecord
});


@override $JugadorDestacadoCopyWith<$Res>? get liderJonrones;@override $EquipoDestacadoCopyWith<$Res>? get mejorRecord;

}
/// @nodoc
class __$KpisCopyWithImpl<$Res>
    implements _$KpisCopyWith<$Res> {
  __$KpisCopyWithImpl(this._self, this._then);

  final _Kpis _self;
  final $Res Function(_Kpis) _then;

/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partidosJugados = null,Object? partidosPendientes = null,Object? carrerasTotales = null,Object? promedioCarrerasPorPartido = freezed,Object? totalEquipos = null,Object? totalJugadores = null,Object? liderJonrones = freezed,Object? mejorRecord = freezed,}) {
  return _then(_Kpis(
partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,partidosPendientes: null == partidosPendientes ? _self.partidosPendientes : partidosPendientes // ignore: cast_nullable_to_non_nullable
as int,carrerasTotales: null == carrerasTotales ? _self.carrerasTotales : carrerasTotales // ignore: cast_nullable_to_non_nullable
as int,promedioCarrerasPorPartido: freezed == promedioCarrerasPorPartido ? _self.promedioCarrerasPorPartido : promedioCarrerasPorPartido // ignore: cast_nullable_to_non_nullable
as double?,totalEquipos: null == totalEquipos ? _self.totalEquipos : totalEquipos // ignore: cast_nullable_to_non_nullable
as int,totalJugadores: null == totalJugadores ? _self.totalJugadores : totalJugadores // ignore: cast_nullable_to_non_nullable
as int,liderJonrones: freezed == liderJonrones ? _self.liderJonrones : liderJonrones // ignore: cast_nullable_to_non_nullable
as JugadorDestacado?,mejorRecord: freezed == mejorRecord ? _self.mejorRecord : mejorRecord // ignore: cast_nullable_to_non_nullable
as EquipoDestacado?,
  ));
}

/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JugadorDestacadoCopyWith<$Res>? get liderJonrones {
    if (_self.liderJonrones == null) {
    return null;
  }

  return $JugadorDestacadoCopyWith<$Res>(_self.liderJonrones!, (value) {
    return _then(_self.copyWith(liderJonrones: value));
  });
}/// Create a copy of Kpis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoDestacadoCopyWith<$Res>? get mejorRecord {
    if (_self.mejorRecord == null) {
    return null;
  }

  return $EquipoDestacadoCopyWith<$Res>(_self.mejorRecord!, (value) {
    return _then(_self.copyWith(mejorRecord: value));
  });
}
}


/// @nodoc
mixin _$JugadorDestacado {

 String get idJugador; String get nombre; String? get idEquipo; String? get nombreEquipo; String? get urlFoto; double get valor;
/// Create a copy of JugadorDestacado
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JugadorDestacadoCopyWith<JugadorDestacado> get copyWith => _$JugadorDestacadoCopyWithImpl<JugadorDestacado>(this as JugadorDestacado, _$identity);

  /// Serializes this JugadorDestacado to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JugadorDestacado;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JugadorDestacado&&(identical(other.idJugador, _this.idJugador) || other.idJugador == _this.idJugador)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombreEquipo, _this.nombreEquipo) || other.nombreEquipo == _this.nombreEquipo)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.valor, _this.valor) || other.valor == _this.valor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JugadorDestacado;
  return Object.hash(runtimeType,_this.idJugador,_this.nombre,_this.idEquipo,_this.nombreEquipo,_this.urlFoto,_this.valor);
}

@override
String toString() {
  final _this = this as JugadorDestacado;
  return 'JugadorDestacado(idJugador: ${_this.idJugador}, nombre: ${_this.nombre}, idEquipo: ${_this.idEquipo}, nombreEquipo: ${_this.nombreEquipo}, urlFoto: ${_this.urlFoto}, valor: ${_this.valor})';
}


}

/// @nodoc
abstract mixin class $JugadorDestacadoCopyWith<$Res>  {
  factory $JugadorDestacadoCopyWith(JugadorDestacado value, $Res Function(JugadorDestacado) _then) = _$JugadorDestacadoCopyWithImpl;
@useResult
$Res call({
 String idJugador, String nombre, String? idEquipo, String? nombreEquipo, String? urlFoto, double valor
});




}
/// @nodoc
class _$JugadorDestacadoCopyWithImpl<$Res>
    implements $JugadorDestacadoCopyWith<$Res> {
  _$JugadorDestacadoCopyWithImpl(this._self, this._then);

  final JugadorDestacado _self;
  final $Res Function(JugadorDestacado) _then;

/// Create a copy of JugadorDestacado
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idJugador = null,Object? nombre = null,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? urlFoto = freezed,Object? valor = null,}) {
  return _then(JugadorDestacado(
idJugador: null == idJugador ? _self.idJugador : idJugador // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [JugadorDestacado].
extension JugadorDestacadoPatterns on JugadorDestacado {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JugadorDestacado value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JugadorDestacado() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JugadorDestacado value)  $default,){
final _that = this;
switch (_that) {
case _JugadorDestacado():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JugadorDestacado value)?  $default,){
final _that = this;
switch (_that) {
case _JugadorDestacado() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idJugador,  String nombre,  String? idEquipo,  String? nombreEquipo,  String? urlFoto,  double valor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JugadorDestacado() when $default != null:
return $default(_that.idJugador,_that.nombre,_that.idEquipo,_that.nombreEquipo,_that.urlFoto,_that.valor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idJugador,  String nombre,  String? idEquipo,  String? nombreEquipo,  String? urlFoto,  double valor)  $default,) {final _that = this;
switch (_that) {
case _JugadorDestacado():
return $default(_that.idJugador,_that.nombre,_that.idEquipo,_that.nombreEquipo,_that.urlFoto,_that.valor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idJugador,  String nombre,  String? idEquipo,  String? nombreEquipo,  String? urlFoto,  double valor)?  $default,) {final _that = this;
switch (_that) {
case _JugadorDestacado() when $default != null:
return $default(_that.idJugador,_that.nombre,_that.idEquipo,_that.nombreEquipo,_that.urlFoto,_that.valor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JugadorDestacado implements JugadorDestacado {
  const _JugadorDestacado({required this.idJugador, required this.nombre, this.idEquipo, this.nombreEquipo, this.urlFoto, required this.valor});
  factory _JugadorDestacado.fromJson(Map<String, dynamic> json) => _$JugadorDestacadoFromJson(json);

@override final  String idJugador;
@override final  String nombre;
@override final  String? idEquipo;
@override final  String? nombreEquipo;
@override final  String? urlFoto;
@override final  double valor;

/// Create a copy of JugadorDestacado
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JugadorDestacadoCopyWith<_JugadorDestacado> get copyWith => __$JugadorDestacadoCopyWithImpl<_JugadorDestacado>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JugadorDestacadoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JugadorDestacado&&(identical(other.idJugador, idJugador) || other.idJugador == idJugador)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombreEquipo, nombreEquipo) || other.nombreEquipo == nombreEquipo)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.valor, valor) || other.valor == valor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idJugador,nombre,idEquipo,nombreEquipo,urlFoto,valor);
}

@override
String toString() {
    return 'JugadorDestacado(idJugador: $idJugador, nombre: $nombre, idEquipo: $idEquipo, nombreEquipo: $nombreEquipo, urlFoto: $urlFoto, valor: $valor)';
}


}

/// @nodoc
abstract mixin class _$JugadorDestacadoCopyWith<$Res> implements $JugadorDestacadoCopyWith<$Res> {
  factory _$JugadorDestacadoCopyWith(_JugadorDestacado value, $Res Function(_JugadorDestacado) _then) = __$JugadorDestacadoCopyWithImpl;
@override @useResult
$Res call({
 String idJugador, String nombre, String? idEquipo, String? nombreEquipo, String? urlFoto, double valor
});




}
/// @nodoc
class __$JugadorDestacadoCopyWithImpl<$Res>
    implements _$JugadorDestacadoCopyWith<$Res> {
  __$JugadorDestacadoCopyWithImpl(this._self, this._then);

  final _JugadorDestacado _self;
  final $Res Function(_JugadorDestacado) _then;

/// Create a copy of JugadorDestacado
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idJugador = null,Object? nombre = null,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? urlFoto = freezed,Object? valor = null,}) {
  return _then(_JugadorDestacado(
idJugador: null == idJugador ? _self.idJugador : idJugador // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EquipoDestacado {

 String get idEquipo; String get nombre; String? get urlFoto; int get ganados; int get perdidos; double? get porcentajeVictorias;
/// Create a copy of EquipoDestacado
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoDestacadoCopyWith<EquipoDestacado> get copyWith => _$EquipoDestacadoCopyWithImpl<EquipoDestacado>(this as EquipoDestacado, _$identity);

  /// Serializes this EquipoDestacado to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoDestacado;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoDestacado&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.ganados, _this.ganados) || other.ganados == _this.ganados)&&(identical(other.perdidos, _this.perdidos) || other.perdidos == _this.perdidos)&&(identical(other.porcentajeVictorias, _this.porcentajeVictorias) || other.porcentajeVictorias == _this.porcentajeVictorias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoDestacado;
  return Object.hash(runtimeType,_this.idEquipo,_this.nombre,_this.urlFoto,_this.ganados,_this.perdidos,_this.porcentajeVictorias);
}

@override
String toString() {
  final _this = this as EquipoDestacado;
  return 'EquipoDestacado(idEquipo: ${_this.idEquipo}, nombre: ${_this.nombre}, urlFoto: ${_this.urlFoto}, ganados: ${_this.ganados}, perdidos: ${_this.perdidos}, porcentajeVictorias: ${_this.porcentajeVictorias})';
}


}

/// @nodoc
abstract mixin class $EquipoDestacadoCopyWith<$Res>  {
  factory $EquipoDestacadoCopyWith(EquipoDestacado value, $Res Function(EquipoDestacado) _then) = _$EquipoDestacadoCopyWithImpl;
@useResult
$Res call({
 String idEquipo, String nombre, String? urlFoto, int ganados, int perdidos, double? porcentajeVictorias
});




}
/// @nodoc
class _$EquipoDestacadoCopyWithImpl<$Res>
    implements $EquipoDestacadoCopyWith<$Res> {
  _$EquipoDestacadoCopyWithImpl(this._self, this._then);

  final EquipoDestacado _self;
  final $Res Function(EquipoDestacado) _then;

/// Create a copy of EquipoDestacado
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idEquipo = null,Object? nombre = null,Object? urlFoto = freezed,Object? ganados = null,Object? perdidos = null,Object? porcentajeVictorias = freezed,}) {
  return _then(EquipoDestacado(
idEquipo: null == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [EquipoDestacado].
extension EquipoDestacadoPatterns on EquipoDestacado {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoDestacado value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoDestacado() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoDestacado value)  $default,){
final _that = this;
switch (_that) {
case _EquipoDestacado():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoDestacado value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoDestacado() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idEquipo,  String nombre,  String? urlFoto,  int ganados,  int perdidos,  double? porcentajeVictorias)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoDestacado() when $default != null:
return $default(_that.idEquipo,_that.nombre,_that.urlFoto,_that.ganados,_that.perdidos,_that.porcentajeVictorias);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idEquipo,  String nombre,  String? urlFoto,  int ganados,  int perdidos,  double? porcentajeVictorias)  $default,) {final _that = this;
switch (_that) {
case _EquipoDestacado():
return $default(_that.idEquipo,_that.nombre,_that.urlFoto,_that.ganados,_that.perdidos,_that.porcentajeVictorias);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idEquipo,  String nombre,  String? urlFoto,  int ganados,  int perdidos,  double? porcentajeVictorias)?  $default,) {final _that = this;
switch (_that) {
case _EquipoDestacado() when $default != null:
return $default(_that.idEquipo,_that.nombre,_that.urlFoto,_that.ganados,_that.perdidos,_that.porcentajeVictorias);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoDestacado implements EquipoDestacado {
  const _EquipoDestacado({required this.idEquipo, required this.nombre, this.urlFoto, this.ganados = 0, this.perdidos = 0, this.porcentajeVictorias});
  factory _EquipoDestacado.fromJson(Map<String, dynamic> json) => _$EquipoDestacadoFromJson(json);

@override final  String idEquipo;
@override final  String nombre;
@override final  String? urlFoto;
@override@JsonKey() final  int ganados;
@override@JsonKey() final  int perdidos;
@override final  double? porcentajeVictorias;

/// Create a copy of EquipoDestacado
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoDestacadoCopyWith<_EquipoDestacado> get copyWith => __$EquipoDestacadoCopyWithImpl<_EquipoDestacado>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoDestacadoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoDestacado&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.ganados, ganados) || other.ganados == ganados)&&(identical(other.perdidos, perdidos) || other.perdidos == perdidos)&&(identical(other.porcentajeVictorias, porcentajeVictorias) || other.porcentajeVictorias == porcentajeVictorias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idEquipo,nombre,urlFoto,ganados,perdidos,porcentajeVictorias);
}

@override
String toString() {
    return 'EquipoDestacado(idEquipo: $idEquipo, nombre: $nombre, urlFoto: $urlFoto, ganados: $ganados, perdidos: $perdidos, porcentajeVictorias: $porcentajeVictorias)';
}


}

/// @nodoc
abstract mixin class _$EquipoDestacadoCopyWith<$Res> implements $EquipoDestacadoCopyWith<$Res> {
  factory _$EquipoDestacadoCopyWith(_EquipoDestacado value, $Res Function(_EquipoDestacado) _then) = __$EquipoDestacadoCopyWithImpl;
@override @useResult
$Res call({
 String idEquipo, String nombre, String? urlFoto, int ganados, int perdidos, double? porcentajeVictorias
});




}
/// @nodoc
class __$EquipoDestacadoCopyWithImpl<$Res>
    implements _$EquipoDestacadoCopyWith<$Res> {
  __$EquipoDestacadoCopyWithImpl(this._self, this._then);

  final _EquipoDestacado _self;
  final $Res Function(_EquipoDestacado) _then;

/// Create a copy of EquipoDestacado
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idEquipo = null,Object? nombre = null,Object? urlFoto = freezed,Object? ganados = null,Object? perdidos = null,Object? porcentajeVictorias = freezed,}) {
  return _then(_EquipoDestacado(
idEquipo: null == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$CarrerasPartido {

 String get idPartido; DateTime? get fecha; EquipoRef? get local; EquipoRef? get visitante; int get carrerasLocal; int get carrerasVisitante; int get carrerasTotales; int get hits; int get errores;
/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarrerasPartidoCopyWith<CarrerasPartido> get copyWith => _$CarrerasPartidoCopyWithImpl<CarrerasPartido>(this as CarrerasPartido, _$identity);

  /// Serializes this CarrerasPartido to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CarrerasPartido;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarrerasPartido&&(identical(other.idPartido, _this.idPartido) || other.idPartido == _this.idPartido)&&(identical(other.fecha, _this.fecha) || other.fecha == _this.fecha)&&(identical(other.local, _this.local) || other.local == _this.local)&&(identical(other.visitante, _this.visitante) || other.visitante == _this.visitante)&&(identical(other.carrerasLocal, _this.carrerasLocal) || other.carrerasLocal == _this.carrerasLocal)&&(identical(other.carrerasVisitante, _this.carrerasVisitante) || other.carrerasVisitante == _this.carrerasVisitante)&&(identical(other.carrerasTotales, _this.carrerasTotales) || other.carrerasTotales == _this.carrerasTotales)&&(identical(other.hits, _this.hits) || other.hits == _this.hits)&&(identical(other.errores, _this.errores) || other.errores == _this.errores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CarrerasPartido;
  return Object.hash(runtimeType,_this.idPartido,_this.fecha,_this.local,_this.visitante,_this.carrerasLocal,_this.carrerasVisitante,_this.carrerasTotales,_this.hits,_this.errores);
}

@override
String toString() {
  final _this = this as CarrerasPartido;
  return 'CarrerasPartido(idPartido: ${_this.idPartido}, fecha: ${_this.fecha}, local: ${_this.local}, visitante: ${_this.visitante}, carrerasLocal: ${_this.carrerasLocal}, carrerasVisitante: ${_this.carrerasVisitante}, carrerasTotales: ${_this.carrerasTotales}, hits: ${_this.hits}, errores: ${_this.errores})';
}


}

/// @nodoc
abstract mixin class $CarrerasPartidoCopyWith<$Res>  {
  factory $CarrerasPartidoCopyWith(CarrerasPartido value, $Res Function(CarrerasPartido) _then) = _$CarrerasPartidoCopyWithImpl;
@useResult
$Res call({
 String idPartido, DateTime? fecha, EquipoRef? local, EquipoRef? visitante, int carrerasLocal, int carrerasVisitante, int carrerasTotales, int hits, int errores
});


$EquipoRefCopyWith<$Res>? get local;$EquipoRefCopyWith<$Res>? get visitante;

}
/// @nodoc
class _$CarrerasPartidoCopyWithImpl<$Res>
    implements $CarrerasPartidoCopyWith<$Res> {
  _$CarrerasPartidoCopyWithImpl(this._self, this._then);

  final CarrerasPartido _self;
  final $Res Function(CarrerasPartido) _then;

/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idPartido = null,Object? fecha = freezed,Object? local = freezed,Object? visitante = freezed,Object? carrerasLocal = null,Object? carrerasVisitante = null,Object? carrerasTotales = null,Object? hits = null,Object? errores = null,}) {
  return _then(CarrerasPartido(
idPartido: null == idPartido ? _self.idPartido : idPartido // ignore: cast_nullable_to_non_nullable
as String,fecha: freezed == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime?,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as EquipoRef?,visitante: freezed == visitante ? _self.visitante : visitante // ignore: cast_nullable_to_non_nullable
as EquipoRef?,carrerasLocal: null == carrerasLocal ? _self.carrerasLocal : carrerasLocal // ignore: cast_nullable_to_non_nullable
as int,carrerasVisitante: null == carrerasVisitante ? _self.carrerasVisitante : carrerasVisitante // ignore: cast_nullable_to_non_nullable
as int,carrerasTotales: null == carrerasTotales ? _self.carrerasTotales : carrerasTotales // ignore: cast_nullable_to_non_nullable
as int,hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as int,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get local {
    if (_self.local == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.local!, (value) {
    return _then(_self.copyWith(local: value));
  });
}/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get visitante {
    if (_self.visitante == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.visitante!, (value) {
    return _then(_self.copyWith(visitante: value));
  });
}
}


/// Adds pattern-matching-related methods to [CarrerasPartido].
extension CarrerasPartidoPatterns on CarrerasPartido {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarrerasPartido value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarrerasPartido() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarrerasPartido value)  $default,){
final _that = this;
switch (_that) {
case _CarrerasPartido():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarrerasPartido value)?  $default,){
final _that = this;
switch (_that) {
case _CarrerasPartido() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idPartido,  DateTime? fecha,  EquipoRef? local,  EquipoRef? visitante,  int carrerasLocal,  int carrerasVisitante,  int carrerasTotales,  int hits,  int errores)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarrerasPartido() when $default != null:
return $default(_that.idPartido,_that.fecha,_that.local,_that.visitante,_that.carrerasLocal,_that.carrerasVisitante,_that.carrerasTotales,_that.hits,_that.errores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idPartido,  DateTime? fecha,  EquipoRef? local,  EquipoRef? visitante,  int carrerasLocal,  int carrerasVisitante,  int carrerasTotales,  int hits,  int errores)  $default,) {final _that = this;
switch (_that) {
case _CarrerasPartido():
return $default(_that.idPartido,_that.fecha,_that.local,_that.visitante,_that.carrerasLocal,_that.carrerasVisitante,_that.carrerasTotales,_that.hits,_that.errores);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idPartido,  DateTime? fecha,  EquipoRef? local,  EquipoRef? visitante,  int carrerasLocal,  int carrerasVisitante,  int carrerasTotales,  int hits,  int errores)?  $default,) {final _that = this;
switch (_that) {
case _CarrerasPartido() when $default != null:
return $default(_that.idPartido,_that.fecha,_that.local,_that.visitante,_that.carrerasLocal,_that.carrerasVisitante,_that.carrerasTotales,_that.hits,_that.errores);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarrerasPartido implements CarrerasPartido {
  const _CarrerasPartido({required this.idPartido, this.fecha, this.local, this.visitante, this.carrerasLocal = 0, this.carrerasVisitante = 0, this.carrerasTotales = 0, this.hits = 0, this.errores = 0});
  factory _CarrerasPartido.fromJson(Map<String, dynamic> json) => _$CarrerasPartidoFromJson(json);

@override final  String idPartido;
@override final  DateTime? fecha;
@override final  EquipoRef? local;
@override final  EquipoRef? visitante;
@override@JsonKey() final  int carrerasLocal;
@override@JsonKey() final  int carrerasVisitante;
@override@JsonKey() final  int carrerasTotales;
@override@JsonKey() final  int hits;
@override@JsonKey() final  int errores;

/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarrerasPartidoCopyWith<_CarrerasPartido> get copyWith => __$CarrerasPartidoCopyWithImpl<_CarrerasPartido>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarrerasPartidoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarrerasPartido&&(identical(other.idPartido, idPartido) || other.idPartido == idPartido)&&(identical(other.fecha, fecha) || other.fecha == fecha)&&(identical(other.local, local) || other.local == local)&&(identical(other.visitante, visitante) || other.visitante == visitante)&&(identical(other.carrerasLocal, carrerasLocal) || other.carrerasLocal == carrerasLocal)&&(identical(other.carrerasVisitante, carrerasVisitante) || other.carrerasVisitante == carrerasVisitante)&&(identical(other.carrerasTotales, carrerasTotales) || other.carrerasTotales == carrerasTotales)&&(identical(other.hits, hits) || other.hits == hits)&&(identical(other.errores, errores) || other.errores == errores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idPartido,fecha,local,visitante,carrerasLocal,carrerasVisitante,carrerasTotales,hits,errores);
}

@override
String toString() {
    return 'CarrerasPartido(idPartido: $idPartido, fecha: $fecha, local: $local, visitante: $visitante, carrerasLocal: $carrerasLocal, carrerasVisitante: $carrerasVisitante, carrerasTotales: $carrerasTotales, hits: $hits, errores: $errores)';
}


}

/// @nodoc
abstract mixin class _$CarrerasPartidoCopyWith<$Res> implements $CarrerasPartidoCopyWith<$Res> {
  factory _$CarrerasPartidoCopyWith(_CarrerasPartido value, $Res Function(_CarrerasPartido) _then) = __$CarrerasPartidoCopyWithImpl;
@override @useResult
$Res call({
 String idPartido, DateTime? fecha, EquipoRef? local, EquipoRef? visitante, int carrerasLocal, int carrerasVisitante, int carrerasTotales, int hits, int errores
});


@override $EquipoRefCopyWith<$Res>? get local;@override $EquipoRefCopyWith<$Res>? get visitante;

}
/// @nodoc
class __$CarrerasPartidoCopyWithImpl<$Res>
    implements _$CarrerasPartidoCopyWith<$Res> {
  __$CarrerasPartidoCopyWithImpl(this._self, this._then);

  final _CarrerasPartido _self;
  final $Res Function(_CarrerasPartido) _then;

/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idPartido = null,Object? fecha = freezed,Object? local = freezed,Object? visitante = freezed,Object? carrerasLocal = null,Object? carrerasVisitante = null,Object? carrerasTotales = null,Object? hits = null,Object? errores = null,}) {
  return _then(_CarrerasPartido(
idPartido: null == idPartido ? _self.idPartido : idPartido // ignore: cast_nullable_to_non_nullable
as String,fecha: freezed == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime?,local: freezed == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as EquipoRef?,visitante: freezed == visitante ? _self.visitante : visitante // ignore: cast_nullable_to_non_nullable
as EquipoRef?,carrerasLocal: null == carrerasLocal ? _self.carrerasLocal : carrerasLocal // ignore: cast_nullable_to_non_nullable
as int,carrerasVisitante: null == carrerasVisitante ? _self.carrerasVisitante : carrerasVisitante // ignore: cast_nullable_to_non_nullable
as int,carrerasTotales: null == carrerasTotales ? _self.carrerasTotales : carrerasTotales // ignore: cast_nullable_to_non_nullable
as int,hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as int,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get local {
    if (_self.local == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.local!, (value) {
    return _then(_self.copyWith(local: value));
  });
}/// Create a copy of CarrerasPartido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get visitante {
    if (_self.visitante == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.visitante!, (value) {
    return _then(_self.copyWith(visitante: value));
  });
}
}


/// @nodoc
mixin _$VictoriasEquipo {

 String get idEquipo; String get nombre; int get ganados; int get perdidos; int get empates; double? get porcentajeVictorias;
/// Create a copy of VictoriasEquipo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VictoriasEquipoCopyWith<VictoriasEquipo> get copyWith => _$VictoriasEquipoCopyWithImpl<VictoriasEquipo>(this as VictoriasEquipo, _$identity);

  /// Serializes this VictoriasEquipo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VictoriasEquipo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VictoriasEquipo&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ganados, _this.ganados) || other.ganados == _this.ganados)&&(identical(other.perdidos, _this.perdidos) || other.perdidos == _this.perdidos)&&(identical(other.empates, _this.empates) || other.empates == _this.empates)&&(identical(other.porcentajeVictorias, _this.porcentajeVictorias) || other.porcentajeVictorias == _this.porcentajeVictorias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VictoriasEquipo;
  return Object.hash(runtimeType,_this.idEquipo,_this.nombre,_this.ganados,_this.perdidos,_this.empates,_this.porcentajeVictorias);
}

@override
String toString() {
  final _this = this as VictoriasEquipo;
  return 'VictoriasEquipo(idEquipo: ${_this.idEquipo}, nombre: ${_this.nombre}, ganados: ${_this.ganados}, perdidos: ${_this.perdidos}, empates: ${_this.empates}, porcentajeVictorias: ${_this.porcentajeVictorias})';
}


}

/// @nodoc
abstract mixin class $VictoriasEquipoCopyWith<$Res>  {
  factory $VictoriasEquipoCopyWith(VictoriasEquipo value, $Res Function(VictoriasEquipo) _then) = _$VictoriasEquipoCopyWithImpl;
@useResult
$Res call({
 String idEquipo, String nombre, int ganados, int perdidos, int empates, double? porcentajeVictorias
});




}
/// @nodoc
class _$VictoriasEquipoCopyWithImpl<$Res>
    implements $VictoriasEquipoCopyWith<$Res> {
  _$VictoriasEquipoCopyWithImpl(this._self, this._then);

  final VictoriasEquipo _self;
  final $Res Function(VictoriasEquipo) _then;

/// Create a copy of VictoriasEquipo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idEquipo = null,Object? nombre = null,Object? ganados = null,Object? perdidos = null,Object? empates = null,Object? porcentajeVictorias = freezed,}) {
  return _then(VictoriasEquipo(
idEquipo: null == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,empates: null == empates ? _self.empates : empates // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [VictoriasEquipo].
extension VictoriasEquipoPatterns on VictoriasEquipo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VictoriasEquipo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VictoriasEquipo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VictoriasEquipo value)  $default,){
final _that = this;
switch (_that) {
case _VictoriasEquipo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VictoriasEquipo value)?  $default,){
final _that = this;
switch (_that) {
case _VictoriasEquipo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idEquipo,  String nombre,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VictoriasEquipo() when $default != null:
return $default(_that.idEquipo,_that.nombre,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idEquipo,  String nombre,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias)  $default,) {final _that = this;
switch (_that) {
case _VictoriasEquipo():
return $default(_that.idEquipo,_that.nombre,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idEquipo,  String nombre,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias)?  $default,) {final _that = this;
switch (_that) {
case _VictoriasEquipo() when $default != null:
return $default(_that.idEquipo,_that.nombre,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VictoriasEquipo implements VictoriasEquipo {
  const _VictoriasEquipo({required this.idEquipo, required this.nombre, this.ganados = 0, this.perdidos = 0, this.empates = 0, this.porcentajeVictorias});
  factory _VictoriasEquipo.fromJson(Map<String, dynamic> json) => _$VictoriasEquipoFromJson(json);

@override final  String idEquipo;
@override final  String nombre;
@override@JsonKey() final  int ganados;
@override@JsonKey() final  int perdidos;
@override@JsonKey() final  int empates;
@override final  double? porcentajeVictorias;

/// Create a copy of VictoriasEquipo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VictoriasEquipoCopyWith<_VictoriasEquipo> get copyWith => __$VictoriasEquipoCopyWithImpl<_VictoriasEquipo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VictoriasEquipoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VictoriasEquipo&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ganados, ganados) || other.ganados == ganados)&&(identical(other.perdidos, perdidos) || other.perdidos == perdidos)&&(identical(other.empates, empates) || other.empates == empates)&&(identical(other.porcentajeVictorias, porcentajeVictorias) || other.porcentajeVictorias == porcentajeVictorias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idEquipo,nombre,ganados,perdidos,empates,porcentajeVictorias);
}

@override
String toString() {
    return 'VictoriasEquipo(idEquipo: $idEquipo, nombre: $nombre, ganados: $ganados, perdidos: $perdidos, empates: $empates, porcentajeVictorias: $porcentajeVictorias)';
}


}

/// @nodoc
abstract mixin class _$VictoriasEquipoCopyWith<$Res> implements $VictoriasEquipoCopyWith<$Res> {
  factory _$VictoriasEquipoCopyWith(_VictoriasEquipo value, $Res Function(_VictoriasEquipo) _then) = __$VictoriasEquipoCopyWithImpl;
@override @useResult
$Res call({
 String idEquipo, String nombre, int ganados, int perdidos, int empates, double? porcentajeVictorias
});




}
/// @nodoc
class __$VictoriasEquipoCopyWithImpl<$Res>
    implements _$VictoriasEquipoCopyWith<$Res> {
  __$VictoriasEquipoCopyWithImpl(this._self, this._then);

  final _VictoriasEquipo _self;
  final $Res Function(_VictoriasEquipo) _then;

/// Create a copy of VictoriasEquipo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idEquipo = null,Object? nombre = null,Object? ganados = null,Object? perdidos = null,Object? empates = null,Object? porcentajeVictorias = freezed,}) {
  return _then(_VictoriasEquipo(
idEquipo: null == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,empates: null == empates ? _self.empates : empates // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$DistribucionHits {

 int get sencillos; int get dobles; int get triples; int get homeRuns; int get total;
/// Create a copy of DistribucionHits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistribucionHitsCopyWith<DistribucionHits> get copyWith => _$DistribucionHitsCopyWithImpl<DistribucionHits>(this as DistribucionHits, _$identity);

  /// Serializes this DistribucionHits to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DistribucionHits;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DistribucionHits&&(identical(other.sencillos, _this.sencillos) || other.sencillos == _this.sencillos)&&(identical(other.dobles, _this.dobles) || other.dobles == _this.dobles)&&(identical(other.triples, _this.triples) || other.triples == _this.triples)&&(identical(other.homeRuns, _this.homeRuns) || other.homeRuns == _this.homeRuns)&&(identical(other.total, _this.total) || other.total == _this.total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DistribucionHits;
  return Object.hash(runtimeType,_this.sencillos,_this.dobles,_this.triples,_this.homeRuns,_this.total);
}

@override
String toString() {
  final _this = this as DistribucionHits;
  return 'DistribucionHits(sencillos: ${_this.sencillos}, dobles: ${_this.dobles}, triples: ${_this.triples}, homeRuns: ${_this.homeRuns}, total: ${_this.total})';
}


}

/// @nodoc
abstract mixin class $DistribucionHitsCopyWith<$Res>  {
  factory $DistribucionHitsCopyWith(DistribucionHits value, $Res Function(DistribucionHits) _then) = _$DistribucionHitsCopyWithImpl;
@useResult
$Res call({
 int sencillos, int dobles, int triples, int homeRuns, int total
});




}
/// @nodoc
class _$DistribucionHitsCopyWithImpl<$Res>
    implements $DistribucionHitsCopyWith<$Res> {
  _$DistribucionHitsCopyWithImpl(this._self, this._then);

  final DistribucionHits _self;
  final $Res Function(DistribucionHits) _then;

/// Create a copy of DistribucionHits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sencillos = null,Object? dobles = null,Object? triples = null,Object? homeRuns = null,Object? total = null,}) {
  return _then(DistribucionHits(
sencillos: null == sencillos ? _self.sencillos : sencillos // ignore: cast_nullable_to_non_nullable
as int,dobles: null == dobles ? _self.dobles : dobles // ignore: cast_nullable_to_non_nullable
as int,triples: null == triples ? _self.triples : triples // ignore: cast_nullable_to_non_nullable
as int,homeRuns: null == homeRuns ? _self.homeRuns : homeRuns // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DistribucionHits].
extension DistribucionHitsPatterns on DistribucionHits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DistribucionHits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DistribucionHits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DistribucionHits value)  $default,){
final _that = this;
switch (_that) {
case _DistribucionHits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DistribucionHits value)?  $default,){
final _that = this;
switch (_that) {
case _DistribucionHits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sencillos,  int dobles,  int triples,  int homeRuns,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DistribucionHits() when $default != null:
return $default(_that.sencillos,_that.dobles,_that.triples,_that.homeRuns,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sencillos,  int dobles,  int triples,  int homeRuns,  int total)  $default,) {final _that = this;
switch (_that) {
case _DistribucionHits():
return $default(_that.sencillos,_that.dobles,_that.triples,_that.homeRuns,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sencillos,  int dobles,  int triples,  int homeRuns,  int total)?  $default,) {final _that = this;
switch (_that) {
case _DistribucionHits() when $default != null:
return $default(_that.sencillos,_that.dobles,_that.triples,_that.homeRuns,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DistribucionHits implements DistribucionHits {
  const _DistribucionHits({this.sencillos = 0, this.dobles = 0, this.triples = 0, this.homeRuns = 0, this.total = 0});
  factory _DistribucionHits.fromJson(Map<String, dynamic> json) => _$DistribucionHitsFromJson(json);

@override@JsonKey() final  int sencillos;
@override@JsonKey() final  int dobles;
@override@JsonKey() final  int triples;
@override@JsonKey() final  int homeRuns;
@override@JsonKey() final  int total;

/// Create a copy of DistribucionHits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistribucionHitsCopyWith<_DistribucionHits> get copyWith => __$DistribucionHitsCopyWithImpl<_DistribucionHits>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DistribucionHitsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DistribucionHits&&(identical(other.sencillos, sencillos) || other.sencillos == sencillos)&&(identical(other.dobles, dobles) || other.dobles == dobles)&&(identical(other.triples, triples) || other.triples == triples)&&(identical(other.homeRuns, homeRuns) || other.homeRuns == homeRuns)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sencillos,dobles,triples,homeRuns,total);
}

@override
String toString() {
    return 'DistribucionHits(sencillos: $sencillos, dobles: $dobles, triples: $triples, homeRuns: $homeRuns, total: $total)';
}


}

/// @nodoc
abstract mixin class _$DistribucionHitsCopyWith<$Res> implements $DistribucionHitsCopyWith<$Res> {
  factory _$DistribucionHitsCopyWith(_DistribucionHits value, $Res Function(_DistribucionHits) _then) = __$DistribucionHitsCopyWithImpl;
@override @useResult
$Res call({
 int sencillos, int dobles, int triples, int homeRuns, int total
});




}
/// @nodoc
class __$DistribucionHitsCopyWithImpl<$Res>
    implements _$DistribucionHitsCopyWith<$Res> {
  __$DistribucionHitsCopyWithImpl(this._self, this._then);

  final _DistribucionHits _self;
  final $Res Function(_DistribucionHits) _then;

/// Create a copy of DistribucionHits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sencillos = null,Object? dobles = null,Object? triples = null,Object? homeRuns = null,Object? total = null,}) {
  return _then(_DistribucionHits(
sencillos: null == sencillos ? _self.sencillos : sencillos // ignore: cast_nullable_to_non_nullable
as int,dobles: null == dobles ? _self.dobles : dobles // ignore: cast_nullable_to_non_nullable
as int,triples: null == triples ? _self.triples : triples // ignore: cast_nullable_to_non_nullable
as int,homeRuns: null == homeRuns ? _self.homeRuns : homeRuns // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PartidosEstadio {

 String get idEstadio; String get nombre; String? get ubicacion; int get partidosJugados; int get partidosProgramados;
/// Create a copy of PartidosEstadio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartidosEstadioCopyWith<PartidosEstadio> get copyWith => _$PartidosEstadioCopyWithImpl<PartidosEstadio>(this as PartidosEstadio, _$identity);

  /// Serializes this PartidosEstadio to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PartidosEstadio;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartidosEstadio&&(identical(other.idEstadio, _this.idEstadio) || other.idEstadio == _this.idEstadio)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ubicacion, _this.ubicacion) || other.ubicacion == _this.ubicacion)&&(identical(other.partidosJugados, _this.partidosJugados) || other.partidosJugados == _this.partidosJugados)&&(identical(other.partidosProgramados, _this.partidosProgramados) || other.partidosProgramados == _this.partidosProgramados));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PartidosEstadio;
  return Object.hash(runtimeType,_this.idEstadio,_this.nombre,_this.ubicacion,_this.partidosJugados,_this.partidosProgramados);
}

@override
String toString() {
  final _this = this as PartidosEstadio;
  return 'PartidosEstadio(idEstadio: ${_this.idEstadio}, nombre: ${_this.nombre}, ubicacion: ${_this.ubicacion}, partidosJugados: ${_this.partidosJugados}, partidosProgramados: ${_this.partidosProgramados})';
}


}

/// @nodoc
abstract mixin class $PartidosEstadioCopyWith<$Res>  {
  factory $PartidosEstadioCopyWith(PartidosEstadio value, $Res Function(PartidosEstadio) _then) = _$PartidosEstadioCopyWithImpl;
@useResult
$Res call({
 String idEstadio, String nombre, String? ubicacion, int partidosJugados, int partidosProgramados
});




}
/// @nodoc
class _$PartidosEstadioCopyWithImpl<$Res>
    implements $PartidosEstadioCopyWith<$Res> {
  _$PartidosEstadioCopyWithImpl(this._self, this._then);

  final PartidosEstadio _self;
  final $Res Function(PartidosEstadio) _then;

/// Create a copy of PartidosEstadio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idEstadio = null,Object? nombre = null,Object? ubicacion = freezed,Object? partidosJugados = null,Object? partidosProgramados = null,}) {
  return _then(PartidosEstadio(
idEstadio: null == idEstadio ? _self.idEstadio : idEstadio // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,partidosProgramados: null == partidosProgramados ? _self.partidosProgramados : partidosProgramados // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PartidosEstadio].
extension PartidosEstadioPatterns on PartidosEstadio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartidosEstadio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartidosEstadio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartidosEstadio value)  $default,){
final _that = this;
switch (_that) {
case _PartidosEstadio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartidosEstadio value)?  $default,){
final _that = this;
switch (_that) {
case _PartidosEstadio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idEstadio,  String nombre,  String? ubicacion,  int partidosJugados,  int partidosProgramados)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartidosEstadio() when $default != null:
return $default(_that.idEstadio,_that.nombre,_that.ubicacion,_that.partidosJugados,_that.partidosProgramados);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idEstadio,  String nombre,  String? ubicacion,  int partidosJugados,  int partidosProgramados)  $default,) {final _that = this;
switch (_that) {
case _PartidosEstadio():
return $default(_that.idEstadio,_that.nombre,_that.ubicacion,_that.partidosJugados,_that.partidosProgramados);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idEstadio,  String nombre,  String? ubicacion,  int partidosJugados,  int partidosProgramados)?  $default,) {final _that = this;
switch (_that) {
case _PartidosEstadio() when $default != null:
return $default(_that.idEstadio,_that.nombre,_that.ubicacion,_that.partidosJugados,_that.partidosProgramados);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartidosEstadio implements PartidosEstadio {
  const _PartidosEstadio({required this.idEstadio, required this.nombre, this.ubicacion, this.partidosJugados = 0, this.partidosProgramados = 0});
  factory _PartidosEstadio.fromJson(Map<String, dynamic> json) => _$PartidosEstadioFromJson(json);

@override final  String idEstadio;
@override final  String nombre;
@override final  String? ubicacion;
@override@JsonKey() final  int partidosJugados;
@override@JsonKey() final  int partidosProgramados;

/// Create a copy of PartidosEstadio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartidosEstadioCopyWith<_PartidosEstadio> get copyWith => __$PartidosEstadioCopyWithImpl<_PartidosEstadio>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartidosEstadioToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartidosEstadio&&(identical(other.idEstadio, idEstadio) || other.idEstadio == idEstadio)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ubicacion, ubicacion) || other.ubicacion == ubicacion)&&(identical(other.partidosJugados, partidosJugados) || other.partidosJugados == partidosJugados)&&(identical(other.partidosProgramados, partidosProgramados) || other.partidosProgramados == partidosProgramados));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idEstadio,nombre,ubicacion,partidosJugados,partidosProgramados);
}

@override
String toString() {
    return 'PartidosEstadio(idEstadio: $idEstadio, nombre: $nombre, ubicacion: $ubicacion, partidosJugados: $partidosJugados, partidosProgramados: $partidosProgramados)';
}


}

/// @nodoc
abstract mixin class _$PartidosEstadioCopyWith<$Res> implements $PartidosEstadioCopyWith<$Res> {
  factory _$PartidosEstadioCopyWith(_PartidosEstadio value, $Res Function(_PartidosEstadio) _then) = __$PartidosEstadioCopyWithImpl;
@override @useResult
$Res call({
 String idEstadio, String nombre, String? ubicacion, int partidosJugados, int partidosProgramados
});




}
/// @nodoc
class __$PartidosEstadioCopyWithImpl<$Res>
    implements _$PartidosEstadioCopyWith<$Res> {
  __$PartidosEstadioCopyWithImpl(this._self, this._then);

  final _PartidosEstadio _self;
  final $Res Function(_PartidosEstadio) _then;

/// Create a copy of PartidosEstadio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idEstadio = null,Object? nombre = null,Object? ubicacion = freezed,Object? partidosJugados = null,Object? partidosProgramados = null,}) {
  return _then(_PartidosEstadio(
idEstadio: null == idEstadio ? _self.idEstadio : idEstadio // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,partidosProgramados: null == partidosProgramados ? _self.partidosProgramados : partidosProgramados // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
