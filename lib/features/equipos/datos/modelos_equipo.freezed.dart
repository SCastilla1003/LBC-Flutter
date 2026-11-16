// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_equipo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Registro {

 int get partidosJugados; int get ganados; int get perdidos; int get empates; double? get porcentajeVictorias; int get carrerasFavor; int get carrerasContra; int get diferencial;
/// Create a copy of Registro
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistroCopyWith<Registro> get copyWith => _$RegistroCopyWithImpl<Registro>(this as Registro, _$identity);

  /// Serializes this Registro to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Registro;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Registro&&(identical(other.partidosJugados, _this.partidosJugados) || other.partidosJugados == _this.partidosJugados)&&(identical(other.ganados, _this.ganados) || other.ganados == _this.ganados)&&(identical(other.perdidos, _this.perdidos) || other.perdidos == _this.perdidos)&&(identical(other.empates, _this.empates) || other.empates == _this.empates)&&(identical(other.porcentajeVictorias, _this.porcentajeVictorias) || other.porcentajeVictorias == _this.porcentajeVictorias)&&(identical(other.carrerasFavor, _this.carrerasFavor) || other.carrerasFavor == _this.carrerasFavor)&&(identical(other.carrerasContra, _this.carrerasContra) || other.carrerasContra == _this.carrerasContra)&&(identical(other.diferencial, _this.diferencial) || other.diferencial == _this.diferencial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Registro;
  return Object.hash(runtimeType,_this.partidosJugados,_this.ganados,_this.perdidos,_this.empates,_this.porcentajeVictorias,_this.carrerasFavor,_this.carrerasContra,_this.diferencial);
}

@override
String toString() {
  final _this = this as Registro;
  return 'Registro(partidosJugados: ${_this.partidosJugados}, ganados: ${_this.ganados}, perdidos: ${_this.perdidos}, empates: ${_this.empates}, porcentajeVictorias: ${_this.porcentajeVictorias}, carrerasFavor: ${_this.carrerasFavor}, carrerasContra: ${_this.carrerasContra}, diferencial: ${_this.diferencial})';
}


}

/// @nodoc
abstract mixin class $RegistroCopyWith<$Res>  {
  factory $RegistroCopyWith(Registro value, $Res Function(Registro) _then) = _$RegistroCopyWithImpl;
@useResult
$Res call({
 int partidosJugados, int ganados, int perdidos, int empates, double? porcentajeVictorias, int carrerasFavor, int carrerasContra, int diferencial
});




}
/// @nodoc
class _$RegistroCopyWithImpl<$Res>
    implements $RegistroCopyWith<$Res> {
  _$RegistroCopyWithImpl(this._self, this._then);

  final Registro _self;
  final $Res Function(Registro) _then;

/// Create a copy of Registro
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partidosJugados = null,Object? ganados = null,Object? perdidos = null,Object? empates = null,Object? porcentajeVictorias = freezed,Object? carrerasFavor = null,Object? carrerasContra = null,Object? diferencial = null,}) {
  return _then(Registro(
partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,empates: null == empates ? _self.empates : empates // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,diferencial: null == diferencial ? _self.diferencial : diferencial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Registro].
extension RegistroPatterns on Registro {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Registro value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Registro() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Registro value)  $default,){
final _that = this;
switch (_that) {
case _Registro():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Registro value)?  $default,){
final _that = this;
switch (_that) {
case _Registro() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int partidosJugados,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias,  int carrerasFavor,  int carrerasContra,  int diferencial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Registro() when $default != null:
return $default(_that.partidosJugados,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias,_that.carrerasFavor,_that.carrerasContra,_that.diferencial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int partidosJugados,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias,  int carrerasFavor,  int carrerasContra,  int diferencial)  $default,) {final _that = this;
switch (_that) {
case _Registro():
return $default(_that.partidosJugados,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias,_that.carrerasFavor,_that.carrerasContra,_that.diferencial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int partidosJugados,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias,  int carrerasFavor,  int carrerasContra,  int diferencial)?  $default,) {final _that = this;
switch (_that) {
case _Registro() when $default != null:
return $default(_that.partidosJugados,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias,_that.carrerasFavor,_that.carrerasContra,_that.diferencial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Registro implements Registro {
  const _Registro({this.partidosJugados = 0, this.ganados = 0, this.perdidos = 0, this.empates = 0, this.porcentajeVictorias, this.carrerasFavor = 0, this.carrerasContra = 0, this.diferencial = 0});
  factory _Registro.fromJson(Map<String, dynamic> json) => _$RegistroFromJson(json);

@override@JsonKey() final  int partidosJugados;
@override@JsonKey() final  int ganados;
@override@JsonKey() final  int perdidos;
@override@JsonKey() final  int empates;
@override final  double? porcentajeVictorias;
@override@JsonKey() final  int carrerasFavor;
@override@JsonKey() final  int carrerasContra;
@override@JsonKey() final  int diferencial;

/// Create a copy of Registro
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistroCopyWith<_Registro> get copyWith => __$RegistroCopyWithImpl<_Registro>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistroToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Registro&&(identical(other.partidosJugados, partidosJugados) || other.partidosJugados == partidosJugados)&&(identical(other.ganados, ganados) || other.ganados == ganados)&&(identical(other.perdidos, perdidos) || other.perdidos == perdidos)&&(identical(other.empates, empates) || other.empates == empates)&&(identical(other.porcentajeVictorias, porcentajeVictorias) || other.porcentajeVictorias == porcentajeVictorias)&&(identical(other.carrerasFavor, carrerasFavor) || other.carrerasFavor == carrerasFavor)&&(identical(other.carrerasContra, carrerasContra) || other.carrerasContra == carrerasContra)&&(identical(other.diferencial, diferencial) || other.diferencial == diferencial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,partidosJugados,ganados,perdidos,empates,porcentajeVictorias,carrerasFavor,carrerasContra,diferencial);
}

@override
String toString() {
    return 'Registro(partidosJugados: $partidosJugados, ganados: $ganados, perdidos: $perdidos, empates: $empates, porcentajeVictorias: $porcentajeVictorias, carrerasFavor: $carrerasFavor, carrerasContra: $carrerasContra, diferencial: $diferencial)';
}


}

/// @nodoc
abstract mixin class _$RegistroCopyWith<$Res> implements $RegistroCopyWith<$Res> {
  factory _$RegistroCopyWith(_Registro value, $Res Function(_Registro) _then) = __$RegistroCopyWithImpl;
@override @useResult
$Res call({
 int partidosJugados, int ganados, int perdidos, int empates, double? porcentajeVictorias, int carrerasFavor, int carrerasContra, int diferencial
});




}
/// @nodoc
class __$RegistroCopyWithImpl<$Res>
    implements _$RegistroCopyWith<$Res> {
  __$RegistroCopyWithImpl(this._self, this._then);

  final _Registro _self;
  final $Res Function(_Registro) _then;

/// Create a copy of Registro
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partidosJugados = null,Object? ganados = null,Object? perdidos = null,Object? empates = null,Object? porcentajeVictorias = freezed,Object? carrerasFavor = null,Object? carrerasContra = null,Object? diferencial = null,}) {
  return _then(_Registro(
partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,empates: null == empates ? _self.empates : empates // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,diferencial: null == diferencial ? _self.diferencial : diferencial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Equipo {

 String get id; String get nombre; String? get ciudad; String? get urlFoto; String? get color; int get totalBateadores; int get totalLanzadores; Registro get registro;
/// Create a copy of Equipo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoCopyWith<Equipo> get copyWith => _$EquipoCopyWithImpl<Equipo>(this as Equipo, _$identity);

  /// Serializes this Equipo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Equipo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Equipo&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ciudad, _this.ciudad) || other.ciudad == _this.ciudad)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.totalBateadores, _this.totalBateadores) || other.totalBateadores == _this.totalBateadores)&&(identical(other.totalLanzadores, _this.totalLanzadores) || other.totalLanzadores == _this.totalLanzadores)&&(identical(other.registro, _this.registro) || other.registro == _this.registro));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Equipo;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.ciudad,_this.urlFoto,_this.color,_this.totalBateadores,_this.totalLanzadores,_this.registro);
}

@override
String toString() {
  final _this = this as Equipo;
  return 'Equipo(id: ${_this.id}, nombre: ${_this.nombre}, ciudad: ${_this.ciudad}, urlFoto: ${_this.urlFoto}, color: ${_this.color}, totalBateadores: ${_this.totalBateadores}, totalLanzadores: ${_this.totalLanzadores}, registro: ${_this.registro})';
}


}

/// @nodoc
abstract mixin class $EquipoCopyWith<$Res>  {
  factory $EquipoCopyWith(Equipo value, $Res Function(Equipo) _then) = _$EquipoCopyWithImpl;
@useResult
$Res call({
 String id, String nombre, String? ciudad, String? urlFoto, String? color, int totalBateadores, int totalLanzadores, Registro registro
});


$RegistroCopyWith<$Res> get registro;

}
/// @nodoc
class _$EquipoCopyWithImpl<$Res>
    implements $EquipoCopyWith<$Res> {
  _$EquipoCopyWithImpl(this._self, this._then);

  final Equipo _self;
  final $Res Function(Equipo) _then;

/// Create a copy of Equipo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? ciudad = freezed,Object? urlFoto = freezed,Object? color = freezed,Object? totalBateadores = null,Object? totalLanzadores = null,Object? registro = null,}) {
  return _then(Equipo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,totalBateadores: null == totalBateadores ? _self.totalBateadores : totalBateadores // ignore: cast_nullable_to_non_nullable
as int,totalLanzadores: null == totalLanzadores ? _self.totalLanzadores : totalLanzadores // ignore: cast_nullable_to_non_nullable
as int,registro: null == registro ? _self.registro : registro // ignore: cast_nullable_to_non_nullable
as Registro,
  ));
}
/// Create a copy of Equipo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistroCopyWith<$Res> get registro {
  
  return $RegistroCopyWith<$Res>(_self.registro, (value) {
    return _then(_self.copyWith(registro: value));
  });
}
}


/// Adds pattern-matching-related methods to [Equipo].
extension EquipoPatterns on Equipo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Equipo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Equipo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Equipo value)  $default,){
final _that = this;
switch (_that) {
case _Equipo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Equipo value)?  $default,){
final _that = this;
switch (_that) {
case _Equipo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  int totalBateadores,  int totalLanzadores,  Registro registro)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Equipo() when $default != null:
return $default(_that.id,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.totalBateadores,_that.totalLanzadores,_that.registro);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  int totalBateadores,  int totalLanzadores,  Registro registro)  $default,) {final _that = this;
switch (_that) {
case _Equipo():
return $default(_that.id,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.totalBateadores,_that.totalLanzadores,_that.registro);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  int totalBateadores,  int totalLanzadores,  Registro registro)?  $default,) {final _that = this;
switch (_that) {
case _Equipo() when $default != null:
return $default(_that.id,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.totalBateadores,_that.totalLanzadores,_that.registro);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Equipo implements Equipo {
  const _Equipo({required this.id, required this.nombre, this.ciudad, this.urlFoto, this.color, this.totalBateadores = 0, this.totalLanzadores = 0, this.registro = const Registro()});
  factory _Equipo.fromJson(Map<String, dynamic> json) => _$EquipoFromJson(json);

@override final  String id;
@override final  String nombre;
@override final  String? ciudad;
@override final  String? urlFoto;
@override final  String? color;
@override@JsonKey() final  int totalBateadores;
@override@JsonKey() final  int totalLanzadores;
@override@JsonKey() final  Registro registro;

/// Create a copy of Equipo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoCopyWith<_Equipo> get copyWith => __$EquipoCopyWithImpl<_Equipo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Equipo&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ciudad, ciudad) || other.ciudad == ciudad)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.color, color) || other.color == color)&&(identical(other.totalBateadores, totalBateadores) || other.totalBateadores == totalBateadores)&&(identical(other.totalLanzadores, totalLanzadores) || other.totalLanzadores == totalLanzadores)&&(identical(other.registro, registro) || other.registro == registro));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,ciudad,urlFoto,color,totalBateadores,totalLanzadores,registro);
}

@override
String toString() {
    return 'Equipo(id: $id, nombre: $nombre, ciudad: $ciudad, urlFoto: $urlFoto, color: $color, totalBateadores: $totalBateadores, totalLanzadores: $totalLanzadores, registro: $registro)';
}


}

/// @nodoc
abstract mixin class _$EquipoCopyWith<$Res> implements $EquipoCopyWith<$Res> {
  factory _$EquipoCopyWith(_Equipo value, $Res Function(_Equipo) _then) = __$EquipoCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombre, String? ciudad, String? urlFoto, String? color, int totalBateadores, int totalLanzadores, Registro registro
});


@override $RegistroCopyWith<$Res> get registro;

}
/// @nodoc
class __$EquipoCopyWithImpl<$Res>
    implements _$EquipoCopyWith<$Res> {
  __$EquipoCopyWithImpl(this._self, this._then);

  final _Equipo _self;
  final $Res Function(_Equipo) _then;

/// Create a copy of Equipo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? ciudad = freezed,Object? urlFoto = freezed,Object? color = freezed,Object? totalBateadores = null,Object? totalLanzadores = null,Object? registro = null,}) {
  return _then(_Equipo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,totalBateadores: null == totalBateadores ? _self.totalBateadores : totalBateadores // ignore: cast_nullable_to_non_nullable
as int,totalLanzadores: null == totalLanzadores ? _self.totalLanzadores : totalLanzadores // ignore: cast_nullable_to_non_nullable
as int,registro: null == registro ? _self.registro : registro // ignore: cast_nullable_to_non_nullable
as Registro,
  ));
}

/// Create a copy of Equipo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistroCopyWith<$Res> get registro {
  
  return $RegistroCopyWith<$Res>(_self.registro, (value) {
    return _then(_self.copyWith(registro: value));
  });
}
}


/// @nodoc
mixin _$EquipoDetalle {

 String get id; String get nombre; String? get ciudad; String? get urlFoto; String? get color; Registro get registro; List<Bateador> get bateadores; List<Lanzador> get lanzadores;
/// Create a copy of EquipoDetalle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoDetalleCopyWith<EquipoDetalle> get copyWith => _$EquipoDetalleCopyWithImpl<EquipoDetalle>(this as EquipoDetalle, _$identity);

  /// Serializes this EquipoDetalle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoDetalle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoDetalle&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ciudad, _this.ciudad) || other.ciudad == _this.ciudad)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.registro, _this.registro) || other.registro == _this.registro)&&const DeepCollectionEquality().equals(other.bateadores, _this.bateadores)&&const DeepCollectionEquality().equals(other.lanzadores, _this.lanzadores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoDetalle;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.ciudad,_this.urlFoto,_this.color,_this.registro,const DeepCollectionEquality().hash(_this.bateadores),const DeepCollectionEquality().hash(_this.lanzadores));
}

@override
String toString() {
  final _this = this as EquipoDetalle;
  return 'EquipoDetalle(id: ${_this.id}, nombre: ${_this.nombre}, ciudad: ${_this.ciudad}, urlFoto: ${_this.urlFoto}, color: ${_this.color}, registro: ${_this.registro}, bateadores: ${_this.bateadores}, lanzadores: ${_this.lanzadores})';
}


}

/// @nodoc
abstract mixin class $EquipoDetalleCopyWith<$Res>  {
  factory $EquipoDetalleCopyWith(EquipoDetalle value, $Res Function(EquipoDetalle) _then) = _$EquipoDetalleCopyWithImpl;
@useResult
$Res call({
 String id, String nombre, String? ciudad, String? urlFoto, String? color, Registro registro, List<Bateador> bateadores, List<Lanzador> lanzadores
});


$RegistroCopyWith<$Res> get registro;

}
/// @nodoc
class _$EquipoDetalleCopyWithImpl<$Res>
    implements $EquipoDetalleCopyWith<$Res> {
  _$EquipoDetalleCopyWithImpl(this._self, this._then);

  final EquipoDetalle _self;
  final $Res Function(EquipoDetalle) _then;

/// Create a copy of EquipoDetalle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? ciudad = freezed,Object? urlFoto = freezed,Object? color = freezed,Object? registro = null,Object? bateadores = null,Object? lanzadores = null,}) {
  return _then(EquipoDetalle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,registro: null == registro ? _self.registro : registro // ignore: cast_nullable_to_non_nullable
as Registro,bateadores: null == bateadores ? _self.bateadores : bateadores // ignore: cast_nullable_to_non_nullable
as List<Bateador>,lanzadores: null == lanzadores ? _self.lanzadores : lanzadores // ignore: cast_nullable_to_non_nullable
as List<Lanzador>,
  ));
}
/// Create a copy of EquipoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistroCopyWith<$Res> get registro {
  
  return $RegistroCopyWith<$Res>(_self.registro, (value) {
    return _then(_self.copyWith(registro: value));
  });
}
}


/// Adds pattern-matching-related methods to [EquipoDetalle].
extension EquipoDetallePatterns on EquipoDetalle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoDetalle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoDetalle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoDetalle value)  $default,){
final _that = this;
switch (_that) {
case _EquipoDetalle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoDetalle value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoDetalle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  Registro registro,  List<Bateador> bateadores,  List<Lanzador> lanzadores)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoDetalle() when $default != null:
return $default(_that.id,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.registro,_that.bateadores,_that.lanzadores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  Registro registro,  List<Bateador> bateadores,  List<Lanzador> lanzadores)  $default,) {final _that = this;
switch (_that) {
case _EquipoDetalle():
return $default(_that.id,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.registro,_that.bateadores,_that.lanzadores);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  Registro registro,  List<Bateador> bateadores,  List<Lanzador> lanzadores)?  $default,) {final _that = this;
switch (_that) {
case _EquipoDetalle() when $default != null:
return $default(_that.id,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.registro,_that.bateadores,_that.lanzadores);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoDetalle implements EquipoDetalle {
  const _EquipoDetalle({required this.id, required this.nombre, this.ciudad, this.urlFoto, this.color, this.registro = const Registro(),  List<Bateador> bateadores = const <Bateador>[],  List<Lanzador> lanzadores = const <Lanzador>[]}): _bateadores = bateadores,_lanzadores = lanzadores;
  factory _EquipoDetalle.fromJson(Map<String, dynamic> json) => _$EquipoDetalleFromJson(json);

@override final  String id;
@override final  String nombre;
@override final  String? ciudad;
@override final  String? urlFoto;
@override final  String? color;
@override@JsonKey() final  Registro registro;
 final  List<Bateador> _bateadores;
@override@JsonKey() List<Bateador> get bateadores {
  if (_bateadores is EqualUnmodifiableListView) return _bateadores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bateadores);
}

 final  List<Lanzador> _lanzadores;
@override@JsonKey() List<Lanzador> get lanzadores {
  if (_lanzadores is EqualUnmodifiableListView) return _lanzadores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lanzadores);
}


/// Create a copy of EquipoDetalle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoDetalleCopyWith<_EquipoDetalle> get copyWith => __$EquipoDetalleCopyWithImpl<_EquipoDetalle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoDetalleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoDetalle&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ciudad, ciudad) || other.ciudad == ciudad)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.color, color) || other.color == color)&&(identical(other.registro, registro) || other.registro == registro)&&const DeepCollectionEquality().equals(other.bateadores, _bateadores)&&const DeepCollectionEquality().equals(other.lanzadores, _lanzadores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,ciudad,urlFoto,color,registro,const DeepCollectionEquality().hash(_bateadores),const DeepCollectionEquality().hash(_lanzadores));
}

@override
String toString() {
    return 'EquipoDetalle(id: $id, nombre: $nombre, ciudad: $ciudad, urlFoto: $urlFoto, color: $color, registro: $registro, bateadores: $bateadores, lanzadores: $lanzadores)';
}


}

/// @nodoc
abstract mixin class _$EquipoDetalleCopyWith<$Res> implements $EquipoDetalleCopyWith<$Res> {
  factory _$EquipoDetalleCopyWith(_EquipoDetalle value, $Res Function(_EquipoDetalle) _then) = __$EquipoDetalleCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombre, String? ciudad, String? urlFoto, String? color, Registro registro, List<Bateador> bateadores, List<Lanzador> lanzadores
});


@override $RegistroCopyWith<$Res> get registro;

}
/// @nodoc
class __$EquipoDetalleCopyWithImpl<$Res>
    implements _$EquipoDetalleCopyWith<$Res> {
  __$EquipoDetalleCopyWithImpl(this._self, this._then);

  final _EquipoDetalle _self;
  final $Res Function(_EquipoDetalle) _then;

/// Create a copy of EquipoDetalle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? ciudad = freezed,Object? urlFoto = freezed,Object? color = freezed,Object? registro = null,Object? bateadores = null,Object? lanzadores = null,}) {
  return _then(_EquipoDetalle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,registro: null == registro ? _self.registro : registro // ignore: cast_nullable_to_non_nullable
as Registro,bateadores: null == bateadores ? _self._bateadores : bateadores // ignore: cast_nullable_to_non_nullable
as List<Bateador>,lanzadores: null == lanzadores ? _self._lanzadores : lanzadores // ignore: cast_nullable_to_non_nullable
as List<Lanzador>,
  ));
}

/// Create a copy of EquipoDetalle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistroCopyWith<$Res> get registro {
  
  return $RegistroCopyWith<$Res>(_self.registro, (value) {
    return _then(_self.copyWith(registro: value));
  });
}
}


/// @nodoc
mixin _$Posicion {

 int get posicion; String get idEquipo; String get nombre; String? get ciudad; String? get urlFoto; String? get color; int get partidosJugados; int get ganados; int get perdidos; int get empates; double? get porcentajeVictorias; double get juegosDetras; int get carrerasFavor; int get carrerasContra; int get diferencial; List<String> get ultimosResultados; String? get racha;
/// Create a copy of Posicion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosicionCopyWith<Posicion> get copyWith => _$PosicionCopyWithImpl<Posicion>(this as Posicion, _$identity);

  /// Serializes this Posicion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Posicion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Posicion&&(identical(other.posicion, _this.posicion) || other.posicion == _this.posicion)&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ciudad, _this.ciudad) || other.ciudad == _this.ciudad)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.partidosJugados, _this.partidosJugados) || other.partidosJugados == _this.partidosJugados)&&(identical(other.ganados, _this.ganados) || other.ganados == _this.ganados)&&(identical(other.perdidos, _this.perdidos) || other.perdidos == _this.perdidos)&&(identical(other.empates, _this.empates) || other.empates == _this.empates)&&(identical(other.porcentajeVictorias, _this.porcentajeVictorias) || other.porcentajeVictorias == _this.porcentajeVictorias)&&(identical(other.juegosDetras, _this.juegosDetras) || other.juegosDetras == _this.juegosDetras)&&(identical(other.carrerasFavor, _this.carrerasFavor) || other.carrerasFavor == _this.carrerasFavor)&&(identical(other.carrerasContra, _this.carrerasContra) || other.carrerasContra == _this.carrerasContra)&&(identical(other.diferencial, _this.diferencial) || other.diferencial == _this.diferencial)&&const DeepCollectionEquality().equals(other.ultimosResultados, _this.ultimosResultados)&&(identical(other.racha, _this.racha) || other.racha == _this.racha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Posicion;
  return Object.hash(runtimeType,_this.posicion,_this.idEquipo,_this.nombre,_this.ciudad,_this.urlFoto,_this.color,_this.partidosJugados,_this.ganados,_this.perdidos,_this.empates,_this.porcentajeVictorias,_this.juegosDetras,_this.carrerasFavor,_this.carrerasContra,_this.diferencial,const DeepCollectionEquality().hash(_this.ultimosResultados),_this.racha);
}

@override
String toString() {
  final _this = this as Posicion;
  return 'Posicion(posicion: ${_this.posicion}, idEquipo: ${_this.idEquipo}, nombre: ${_this.nombre}, ciudad: ${_this.ciudad}, urlFoto: ${_this.urlFoto}, color: ${_this.color}, partidosJugados: ${_this.partidosJugados}, ganados: ${_this.ganados}, perdidos: ${_this.perdidos}, empates: ${_this.empates}, porcentajeVictorias: ${_this.porcentajeVictorias}, juegosDetras: ${_this.juegosDetras}, carrerasFavor: ${_this.carrerasFavor}, carrerasContra: ${_this.carrerasContra}, diferencial: ${_this.diferencial}, ultimosResultados: ${_this.ultimosResultados}, racha: ${_this.racha})';
}


}

/// @nodoc
abstract mixin class $PosicionCopyWith<$Res>  {
  factory $PosicionCopyWith(Posicion value, $Res Function(Posicion) _then) = _$PosicionCopyWithImpl;
@useResult
$Res call({
 int posicion, String idEquipo, String nombre, String? ciudad, String? urlFoto, String? color, int partidosJugados, int ganados, int perdidos, int empates, double? porcentajeVictorias, double juegosDetras, int carrerasFavor, int carrerasContra, int diferencial, List<String> ultimosResultados, String? racha
});




}
/// @nodoc
class _$PosicionCopyWithImpl<$Res>
    implements $PosicionCopyWith<$Res> {
  _$PosicionCopyWithImpl(this._self, this._then);

  final Posicion _self;
  final $Res Function(Posicion) _then;

/// Create a copy of Posicion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posicion = null,Object? idEquipo = null,Object? nombre = null,Object? ciudad = freezed,Object? urlFoto = freezed,Object? color = freezed,Object? partidosJugados = null,Object? ganados = null,Object? perdidos = null,Object? empates = null,Object? porcentajeVictorias = freezed,Object? juegosDetras = null,Object? carrerasFavor = null,Object? carrerasContra = null,Object? diferencial = null,Object? ultimosResultados = null,Object? racha = freezed,}) {
  return _then(Posicion(
posicion: null == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as int,idEquipo: null == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,empates: null == empates ? _self.empates : empates // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,juegosDetras: null == juegosDetras ? _self.juegosDetras : juegosDetras // ignore: cast_nullable_to_non_nullable
as double,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,diferencial: null == diferencial ? _self.diferencial : diferencial // ignore: cast_nullable_to_non_nullable
as int,ultimosResultados: null == ultimosResultados ? _self.ultimosResultados : ultimosResultados // ignore: cast_nullable_to_non_nullable
as List<String>,racha: freezed == racha ? _self.racha : racha // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Posicion].
extension PosicionPatterns on Posicion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Posicion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Posicion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Posicion value)  $default,){
final _that = this;
switch (_that) {
case _Posicion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Posicion value)?  $default,){
final _that = this;
switch (_that) {
case _Posicion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int posicion,  String idEquipo,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  int partidosJugados,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias,  double juegosDetras,  int carrerasFavor,  int carrerasContra,  int diferencial,  List<String> ultimosResultados,  String? racha)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Posicion() when $default != null:
return $default(_that.posicion,_that.idEquipo,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.partidosJugados,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias,_that.juegosDetras,_that.carrerasFavor,_that.carrerasContra,_that.diferencial,_that.ultimosResultados,_that.racha);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int posicion,  String idEquipo,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  int partidosJugados,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias,  double juegosDetras,  int carrerasFavor,  int carrerasContra,  int diferencial,  List<String> ultimosResultados,  String? racha)  $default,) {final _that = this;
switch (_that) {
case _Posicion():
return $default(_that.posicion,_that.idEquipo,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.partidosJugados,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias,_that.juegosDetras,_that.carrerasFavor,_that.carrerasContra,_that.diferencial,_that.ultimosResultados,_that.racha);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int posicion,  String idEquipo,  String nombre,  String? ciudad,  String? urlFoto,  String? color,  int partidosJugados,  int ganados,  int perdidos,  int empates,  double? porcentajeVictorias,  double juegosDetras,  int carrerasFavor,  int carrerasContra,  int diferencial,  List<String> ultimosResultados,  String? racha)?  $default,) {final _that = this;
switch (_that) {
case _Posicion() when $default != null:
return $default(_that.posicion,_that.idEquipo,_that.nombre,_that.ciudad,_that.urlFoto,_that.color,_that.partidosJugados,_that.ganados,_that.perdidos,_that.empates,_that.porcentajeVictorias,_that.juegosDetras,_that.carrerasFavor,_that.carrerasContra,_that.diferencial,_that.ultimosResultados,_that.racha);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Posicion implements Posicion {
  const _Posicion({required this.posicion, required this.idEquipo, required this.nombre, this.ciudad, this.urlFoto, this.color, this.partidosJugados = 0, this.ganados = 0, this.perdidos = 0, this.empates = 0, this.porcentajeVictorias, this.juegosDetras = 0, this.carrerasFavor = 0, this.carrerasContra = 0, this.diferencial = 0,  List<String> ultimosResultados = const <String>[], this.racha}): _ultimosResultados = ultimosResultados;
  factory _Posicion.fromJson(Map<String, dynamic> json) => _$PosicionFromJson(json);

@override final  int posicion;
@override final  String idEquipo;
@override final  String nombre;
@override final  String? ciudad;
@override final  String? urlFoto;
@override final  String? color;
@override@JsonKey() final  int partidosJugados;
@override@JsonKey() final  int ganados;
@override@JsonKey() final  int perdidos;
@override@JsonKey() final  int empates;
@override final  double? porcentajeVictorias;
@override@JsonKey() final  double juegosDetras;
@override@JsonKey() final  int carrerasFavor;
@override@JsonKey() final  int carrerasContra;
@override@JsonKey() final  int diferencial;
 final  List<String> _ultimosResultados;
@override@JsonKey() List<String> get ultimosResultados {
  if (_ultimosResultados is EqualUnmodifiableListView) return _ultimosResultados;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ultimosResultados);
}

@override final  String? racha;

/// Create a copy of Posicion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosicionCopyWith<_Posicion> get copyWith => __$PosicionCopyWithImpl<_Posicion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosicionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Posicion&&(identical(other.posicion, posicion) || other.posicion == posicion)&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ciudad, ciudad) || other.ciudad == ciudad)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.color, color) || other.color == color)&&(identical(other.partidosJugados, partidosJugados) || other.partidosJugados == partidosJugados)&&(identical(other.ganados, ganados) || other.ganados == ganados)&&(identical(other.perdidos, perdidos) || other.perdidos == perdidos)&&(identical(other.empates, empates) || other.empates == empates)&&(identical(other.porcentajeVictorias, porcentajeVictorias) || other.porcentajeVictorias == porcentajeVictorias)&&(identical(other.juegosDetras, juegosDetras) || other.juegosDetras == juegosDetras)&&(identical(other.carrerasFavor, carrerasFavor) || other.carrerasFavor == carrerasFavor)&&(identical(other.carrerasContra, carrerasContra) || other.carrerasContra == carrerasContra)&&(identical(other.diferencial, diferencial) || other.diferencial == diferencial)&&const DeepCollectionEquality().equals(other.ultimosResultados, _ultimosResultados)&&(identical(other.racha, racha) || other.racha == racha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,posicion,idEquipo,nombre,ciudad,urlFoto,color,partidosJugados,ganados,perdidos,empates,porcentajeVictorias,juegosDetras,carrerasFavor,carrerasContra,diferencial,const DeepCollectionEquality().hash(_ultimosResultados),racha);
}

@override
String toString() {
    return 'Posicion(posicion: $posicion, idEquipo: $idEquipo, nombre: $nombre, ciudad: $ciudad, urlFoto: $urlFoto, color: $color, partidosJugados: $partidosJugados, ganados: $ganados, perdidos: $perdidos, empates: $empates, porcentajeVictorias: $porcentajeVictorias, juegosDetras: $juegosDetras, carrerasFavor: $carrerasFavor, carrerasContra: $carrerasContra, diferencial: $diferencial, ultimosResultados: $ultimosResultados, racha: $racha)';
}


}

/// @nodoc
abstract mixin class _$PosicionCopyWith<$Res> implements $PosicionCopyWith<$Res> {
  factory _$PosicionCopyWith(_Posicion value, $Res Function(_Posicion) _then) = __$PosicionCopyWithImpl;
@override @useResult
$Res call({
 int posicion, String idEquipo, String nombre, String? ciudad, String? urlFoto, String? color, int partidosJugados, int ganados, int perdidos, int empates, double? porcentajeVictorias, double juegosDetras, int carrerasFavor, int carrerasContra, int diferencial, List<String> ultimosResultados, String? racha
});




}
/// @nodoc
class __$PosicionCopyWithImpl<$Res>
    implements _$PosicionCopyWith<$Res> {
  __$PosicionCopyWithImpl(this._self, this._then);

  final _Posicion _self;
  final $Res Function(_Posicion) _then;

/// Create a copy of Posicion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posicion = null,Object? idEquipo = null,Object? nombre = null,Object? ciudad = freezed,Object? urlFoto = freezed,Object? color = freezed,Object? partidosJugados = null,Object? ganados = null,Object? perdidos = null,Object? empates = null,Object? porcentajeVictorias = freezed,Object? juegosDetras = null,Object? carrerasFavor = null,Object? carrerasContra = null,Object? diferencial = null,Object? ultimosResultados = null,Object? racha = freezed,}) {
  return _then(_Posicion(
posicion: null == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as int,idEquipo: null == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ciudad: freezed == ciudad ? _self.ciudad : ciudad // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,ganados: null == ganados ? _self.ganados : ganados // ignore: cast_nullable_to_non_nullable
as int,perdidos: null == perdidos ? _self.perdidos : perdidos // ignore: cast_nullable_to_non_nullable
as int,empates: null == empates ? _self.empates : empates // ignore: cast_nullable_to_non_nullable
as int,porcentajeVictorias: freezed == porcentajeVictorias ? _self.porcentajeVictorias : porcentajeVictorias // ignore: cast_nullable_to_non_nullable
as double?,juegosDetras: null == juegosDetras ? _self.juegosDetras : juegosDetras // ignore: cast_nullable_to_non_nullable
as double,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,diferencial: null == diferencial ? _self.diferencial : diferencial // ignore: cast_nullable_to_non_nullable
as int,ultimosResultados: null == ultimosResultados ? _self._ultimosResultados : ultimosResultados // ignore: cast_nullable_to_non_nullable
as List<String>,racha: freezed == racha ? _self.racha : racha // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PartidoEquipo {

 String get idPartido; DateTime? get fecha; String? get hora; bool get local; EquipoRef? get rival; int get carrerasFavor; int get carrerasContra; int get diferencial; String get resultado;
/// Create a copy of PartidoEquipo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartidoEquipoCopyWith<PartidoEquipo> get copyWith => _$PartidoEquipoCopyWithImpl<PartidoEquipo>(this as PartidoEquipo, _$identity);

  /// Serializes this PartidoEquipo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PartidoEquipo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartidoEquipo&&(identical(other.idPartido, _this.idPartido) || other.idPartido == _this.idPartido)&&(identical(other.fecha, _this.fecha) || other.fecha == _this.fecha)&&(identical(other.hora, _this.hora) || other.hora == _this.hora)&&(identical(other.local, _this.local) || other.local == _this.local)&&(identical(other.rival, _this.rival) || other.rival == _this.rival)&&(identical(other.carrerasFavor, _this.carrerasFavor) || other.carrerasFavor == _this.carrerasFavor)&&(identical(other.carrerasContra, _this.carrerasContra) || other.carrerasContra == _this.carrerasContra)&&(identical(other.diferencial, _this.diferencial) || other.diferencial == _this.diferencial)&&(identical(other.resultado, _this.resultado) || other.resultado == _this.resultado));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PartidoEquipo;
  return Object.hash(runtimeType,_this.idPartido,_this.fecha,_this.hora,_this.local,_this.rival,_this.carrerasFavor,_this.carrerasContra,_this.diferencial,_this.resultado);
}

@override
String toString() {
  final _this = this as PartidoEquipo;
  return 'PartidoEquipo(idPartido: ${_this.idPartido}, fecha: ${_this.fecha}, hora: ${_this.hora}, local: ${_this.local}, rival: ${_this.rival}, carrerasFavor: ${_this.carrerasFavor}, carrerasContra: ${_this.carrerasContra}, diferencial: ${_this.diferencial}, resultado: ${_this.resultado})';
}


}

/// @nodoc
abstract mixin class $PartidoEquipoCopyWith<$Res>  {
  factory $PartidoEquipoCopyWith(PartidoEquipo value, $Res Function(PartidoEquipo) _then) = _$PartidoEquipoCopyWithImpl;
@useResult
$Res call({
 String idPartido, DateTime? fecha, String? hora, bool local, EquipoRef? rival, int carrerasFavor, int carrerasContra, int diferencial, String resultado
});


$EquipoRefCopyWith<$Res>? get rival;

}
/// @nodoc
class _$PartidoEquipoCopyWithImpl<$Res>
    implements $PartidoEquipoCopyWith<$Res> {
  _$PartidoEquipoCopyWithImpl(this._self, this._then);

  final PartidoEquipo _self;
  final $Res Function(PartidoEquipo) _then;

/// Create a copy of PartidoEquipo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idPartido = null,Object? fecha = freezed,Object? hora = freezed,Object? local = null,Object? rival = freezed,Object? carrerasFavor = null,Object? carrerasContra = null,Object? diferencial = null,Object? resultado = null,}) {
  return _then(PartidoEquipo(
idPartido: null == idPartido ? _self.idPartido : idPartido // ignore: cast_nullable_to_non_nullable
as String,fecha: freezed == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime?,hora: freezed == hora ? _self.hora : hora // ignore: cast_nullable_to_non_nullable
as String?,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as bool,rival: freezed == rival ? _self.rival : rival // ignore: cast_nullable_to_non_nullable
as EquipoRef?,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,diferencial: null == diferencial ? _self.diferencial : diferencial // ignore: cast_nullable_to_non_nullable
as int,resultado: null == resultado ? _self.resultado : resultado // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PartidoEquipo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get rival {
    if (_self.rival == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.rival!, (value) {
    return _then(_self.copyWith(rival: value));
  });
}
}


/// Adds pattern-matching-related methods to [PartidoEquipo].
extension PartidoEquipoPatterns on PartidoEquipo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartidoEquipo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartidoEquipo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartidoEquipo value)  $default,){
final _that = this;
switch (_that) {
case _PartidoEquipo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartidoEquipo value)?  $default,){
final _that = this;
switch (_that) {
case _PartidoEquipo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idPartido,  DateTime? fecha,  String? hora,  bool local,  EquipoRef? rival,  int carrerasFavor,  int carrerasContra,  int diferencial,  String resultado)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartidoEquipo() when $default != null:
return $default(_that.idPartido,_that.fecha,_that.hora,_that.local,_that.rival,_that.carrerasFavor,_that.carrerasContra,_that.diferencial,_that.resultado);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idPartido,  DateTime? fecha,  String? hora,  bool local,  EquipoRef? rival,  int carrerasFavor,  int carrerasContra,  int diferencial,  String resultado)  $default,) {final _that = this;
switch (_that) {
case _PartidoEquipo():
return $default(_that.idPartido,_that.fecha,_that.hora,_that.local,_that.rival,_that.carrerasFavor,_that.carrerasContra,_that.diferencial,_that.resultado);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idPartido,  DateTime? fecha,  String? hora,  bool local,  EquipoRef? rival,  int carrerasFavor,  int carrerasContra,  int diferencial,  String resultado)?  $default,) {final _that = this;
switch (_that) {
case _PartidoEquipo() when $default != null:
return $default(_that.idPartido,_that.fecha,_that.hora,_that.local,_that.rival,_that.carrerasFavor,_that.carrerasContra,_that.diferencial,_that.resultado);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartidoEquipo implements PartidoEquipo {
  const _PartidoEquipo({required this.idPartido, this.fecha, this.hora, this.local = false, this.rival, this.carrerasFavor = 0, this.carrerasContra = 0, this.diferencial = 0, required this.resultado});
  factory _PartidoEquipo.fromJson(Map<String, dynamic> json) => _$PartidoEquipoFromJson(json);

@override final  String idPartido;
@override final  DateTime? fecha;
@override final  String? hora;
@override@JsonKey() final  bool local;
@override final  EquipoRef? rival;
@override@JsonKey() final  int carrerasFavor;
@override@JsonKey() final  int carrerasContra;
@override@JsonKey() final  int diferencial;
@override final  String resultado;

/// Create a copy of PartidoEquipo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartidoEquipoCopyWith<_PartidoEquipo> get copyWith => __$PartidoEquipoCopyWithImpl<_PartidoEquipo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartidoEquipoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartidoEquipo&&(identical(other.idPartido, idPartido) || other.idPartido == idPartido)&&(identical(other.fecha, fecha) || other.fecha == fecha)&&(identical(other.hora, hora) || other.hora == hora)&&(identical(other.local, local) || other.local == local)&&(identical(other.rival, rival) || other.rival == rival)&&(identical(other.carrerasFavor, carrerasFavor) || other.carrerasFavor == carrerasFavor)&&(identical(other.carrerasContra, carrerasContra) || other.carrerasContra == carrerasContra)&&(identical(other.diferencial, diferencial) || other.diferencial == diferencial)&&(identical(other.resultado, resultado) || other.resultado == resultado));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idPartido,fecha,hora,local,rival,carrerasFavor,carrerasContra,diferencial,resultado);
}

@override
String toString() {
    return 'PartidoEquipo(idPartido: $idPartido, fecha: $fecha, hora: $hora, local: $local, rival: $rival, carrerasFavor: $carrerasFavor, carrerasContra: $carrerasContra, diferencial: $diferencial, resultado: $resultado)';
}


}

/// @nodoc
abstract mixin class _$PartidoEquipoCopyWith<$Res> implements $PartidoEquipoCopyWith<$Res> {
  factory _$PartidoEquipoCopyWith(_PartidoEquipo value, $Res Function(_PartidoEquipo) _then) = __$PartidoEquipoCopyWithImpl;
@override @useResult
$Res call({
 String idPartido, DateTime? fecha, String? hora, bool local, EquipoRef? rival, int carrerasFavor, int carrerasContra, int diferencial, String resultado
});


@override $EquipoRefCopyWith<$Res>? get rival;

}
/// @nodoc
class __$PartidoEquipoCopyWithImpl<$Res>
    implements _$PartidoEquipoCopyWith<$Res> {
  __$PartidoEquipoCopyWithImpl(this._self, this._then);

  final _PartidoEquipo _self;
  final $Res Function(_PartidoEquipo) _then;

/// Create a copy of PartidoEquipo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idPartido = null,Object? fecha = freezed,Object? hora = freezed,Object? local = null,Object? rival = freezed,Object? carrerasFavor = null,Object? carrerasContra = null,Object? diferencial = null,Object? resultado = null,}) {
  return _then(_PartidoEquipo(
idPartido: null == idPartido ? _self.idPartido : idPartido // ignore: cast_nullable_to_non_nullable
as String,fecha: freezed == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime?,hora: freezed == hora ? _self.hora : hora // ignore: cast_nullable_to_non_nullable
as String?,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as bool,rival: freezed == rival ? _self.rival : rival // ignore: cast_nullable_to_non_nullable
as EquipoRef?,carrerasFavor: null == carrerasFavor ? _self.carrerasFavor : carrerasFavor // ignore: cast_nullable_to_non_nullable
as int,carrerasContra: null == carrerasContra ? _self.carrerasContra : carrerasContra // ignore: cast_nullable_to_non_nullable
as int,diferencial: null == diferencial ? _self.diferencial : diferencial // ignore: cast_nullable_to_non_nullable
as int,resultado: null == resultado ? _self.resultado : resultado // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PartidoEquipo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res>? get rival {
    if (_self.rival == null) {
    return null;
  }

  return $EquipoRefCopyWith<$Res>(_self.rival!, (value) {
    return _then(_self.copyWith(rival: value));
  });
}
}


/// @nodoc
mixin _$Comparativa {

 String get metrica; String get etiqueta; double? get valorEquipo; double? get promedioLiga; bool get mayorEsMejor;
/// Create a copy of Comparativa
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComparativaCopyWith<Comparativa> get copyWith => _$ComparativaCopyWithImpl<Comparativa>(this as Comparativa, _$identity);

  /// Serializes this Comparativa to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Comparativa;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comparativa&&(identical(other.metrica, _this.metrica) || other.metrica == _this.metrica)&&(identical(other.etiqueta, _this.etiqueta) || other.etiqueta == _this.etiqueta)&&(identical(other.valorEquipo, _this.valorEquipo) || other.valorEquipo == _this.valorEquipo)&&(identical(other.promedioLiga, _this.promedioLiga) || other.promedioLiga == _this.promedioLiga)&&(identical(other.mayorEsMejor, _this.mayorEsMejor) || other.mayorEsMejor == _this.mayorEsMejor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Comparativa;
  return Object.hash(runtimeType,_this.metrica,_this.etiqueta,_this.valorEquipo,_this.promedioLiga,_this.mayorEsMejor);
}

@override
String toString() {
  final _this = this as Comparativa;
  return 'Comparativa(metrica: ${_this.metrica}, etiqueta: ${_this.etiqueta}, valorEquipo: ${_this.valorEquipo}, promedioLiga: ${_this.promedioLiga}, mayorEsMejor: ${_this.mayorEsMejor})';
}


}

/// @nodoc
abstract mixin class $ComparativaCopyWith<$Res>  {
  factory $ComparativaCopyWith(Comparativa value, $Res Function(Comparativa) _then) = _$ComparativaCopyWithImpl;
@useResult
$Res call({
 String metrica, String etiqueta, double? valorEquipo, double? promedioLiga, bool mayorEsMejor
});




}
/// @nodoc
class _$ComparativaCopyWithImpl<$Res>
    implements $ComparativaCopyWith<$Res> {
  _$ComparativaCopyWithImpl(this._self, this._then);

  final Comparativa _self;
  final $Res Function(Comparativa) _then;

/// Create a copy of Comparativa
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metrica = null,Object? etiqueta = null,Object? valorEquipo = freezed,Object? promedioLiga = freezed,Object? mayorEsMejor = null,}) {
  return _then(Comparativa(
metrica: null == metrica ? _self.metrica : metrica // ignore: cast_nullable_to_non_nullable
as String,etiqueta: null == etiqueta ? _self.etiqueta : etiqueta // ignore: cast_nullable_to_non_nullable
as String,valorEquipo: freezed == valorEquipo ? _self.valorEquipo : valorEquipo // ignore: cast_nullable_to_non_nullable
as double?,promedioLiga: freezed == promedioLiga ? _self.promedioLiga : promedioLiga // ignore: cast_nullable_to_non_nullable
as double?,mayorEsMejor: null == mayorEsMejor ? _self.mayorEsMejor : mayorEsMejor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Comparativa].
extension ComparativaPatterns on Comparativa {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comparativa value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comparativa() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comparativa value)  $default,){
final _that = this;
switch (_that) {
case _Comparativa():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comparativa value)?  $default,){
final _that = this;
switch (_that) {
case _Comparativa() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String metrica,  String etiqueta,  double? valorEquipo,  double? promedioLiga,  bool mayorEsMejor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comparativa() when $default != null:
return $default(_that.metrica,_that.etiqueta,_that.valorEquipo,_that.promedioLiga,_that.mayorEsMejor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String metrica,  String etiqueta,  double? valorEquipo,  double? promedioLiga,  bool mayorEsMejor)  $default,) {final _that = this;
switch (_that) {
case _Comparativa():
return $default(_that.metrica,_that.etiqueta,_that.valorEquipo,_that.promedioLiga,_that.mayorEsMejor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String metrica,  String etiqueta,  double? valorEquipo,  double? promedioLiga,  bool mayorEsMejor)?  $default,) {final _that = this;
switch (_that) {
case _Comparativa() when $default != null:
return $default(_that.metrica,_that.etiqueta,_that.valorEquipo,_that.promedioLiga,_that.mayorEsMejor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Comparativa implements Comparativa {
  const _Comparativa({required this.metrica, required this.etiqueta, this.valorEquipo, this.promedioLiga, this.mayorEsMejor = true});
  factory _Comparativa.fromJson(Map<String, dynamic> json) => _$ComparativaFromJson(json);

@override final  String metrica;
@override final  String etiqueta;
@override final  double? valorEquipo;
@override final  double? promedioLiga;
@override@JsonKey() final  bool mayorEsMejor;

/// Create a copy of Comparativa
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComparativaCopyWith<_Comparativa> get copyWith => __$ComparativaCopyWithImpl<_Comparativa>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComparativaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comparativa&&(identical(other.metrica, metrica) || other.metrica == metrica)&&(identical(other.etiqueta, etiqueta) || other.etiqueta == etiqueta)&&(identical(other.valorEquipo, valorEquipo) || other.valorEquipo == valorEquipo)&&(identical(other.promedioLiga, promedioLiga) || other.promedioLiga == promedioLiga)&&(identical(other.mayorEsMejor, mayorEsMejor) || other.mayorEsMejor == mayorEsMejor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,metrica,etiqueta,valorEquipo,promedioLiga,mayorEsMejor);
}

@override
String toString() {
    return 'Comparativa(metrica: $metrica, etiqueta: $etiqueta, valorEquipo: $valorEquipo, promedioLiga: $promedioLiga, mayorEsMejor: $mayorEsMejor)';
}


}

/// @nodoc
abstract mixin class _$ComparativaCopyWith<$Res> implements $ComparativaCopyWith<$Res> {
  factory _$ComparativaCopyWith(_Comparativa value, $Res Function(_Comparativa) _then) = __$ComparativaCopyWithImpl;
@override @useResult
$Res call({
 String metrica, String etiqueta, double? valorEquipo, double? promedioLiga, bool mayorEsMejor
});




}
/// @nodoc
class __$ComparativaCopyWithImpl<$Res>
    implements _$ComparativaCopyWith<$Res> {
  __$ComparativaCopyWithImpl(this._self, this._then);

  final _Comparativa _self;
  final $Res Function(_Comparativa) _then;

/// Create a copy of Comparativa
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metrica = null,Object? etiqueta = null,Object? valorEquipo = freezed,Object? promedioLiga = freezed,Object? mayorEsMejor = null,}) {
  return _then(_Comparativa(
metrica: null == metrica ? _self.metrica : metrica // ignore: cast_nullable_to_non_nullable
as String,etiqueta: null == etiqueta ? _self.etiqueta : etiqueta // ignore: cast_nullable_to_non_nullable
as String,valorEquipo: freezed == valorEquipo ? _self.valorEquipo : valorEquipo // ignore: cast_nullable_to_non_nullable
as double?,promedioLiga: freezed == promedioLiga ? _self.promedioLiga : promedioLiga // ignore: cast_nullable_to_non_nullable
as double?,mayorEsMejor: null == mayorEsMejor ? _self.mayorEsMejor : mayorEsMejor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BateoEquipo {

 int get hits; int get homeRuns; int get triples; int get dobles; int get sencillos; int get carrerasImpulsadas; int get roboDeBase; int get basePorBola; int get ponches;
/// Create a copy of BateoEquipo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BateoEquipoCopyWith<BateoEquipo> get copyWith => _$BateoEquipoCopyWithImpl<BateoEquipo>(this as BateoEquipo, _$identity);

  /// Serializes this BateoEquipo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BateoEquipo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BateoEquipo&&(identical(other.hits, _this.hits) || other.hits == _this.hits)&&(identical(other.homeRuns, _this.homeRuns) || other.homeRuns == _this.homeRuns)&&(identical(other.triples, _this.triples) || other.triples == _this.triples)&&(identical(other.dobles, _this.dobles) || other.dobles == _this.dobles)&&(identical(other.sencillos, _this.sencillos) || other.sencillos == _this.sencillos)&&(identical(other.carrerasImpulsadas, _this.carrerasImpulsadas) || other.carrerasImpulsadas == _this.carrerasImpulsadas)&&(identical(other.roboDeBase, _this.roboDeBase) || other.roboDeBase == _this.roboDeBase)&&(identical(other.basePorBola, _this.basePorBola) || other.basePorBola == _this.basePorBola)&&(identical(other.ponches, _this.ponches) || other.ponches == _this.ponches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BateoEquipo;
  return Object.hash(runtimeType,_this.hits,_this.homeRuns,_this.triples,_this.dobles,_this.sencillos,_this.carrerasImpulsadas,_this.roboDeBase,_this.basePorBola,_this.ponches);
}

@override
String toString() {
  final _this = this as BateoEquipo;
  return 'BateoEquipo(hits: ${_this.hits}, homeRuns: ${_this.homeRuns}, triples: ${_this.triples}, dobles: ${_this.dobles}, sencillos: ${_this.sencillos}, carrerasImpulsadas: ${_this.carrerasImpulsadas}, roboDeBase: ${_this.roboDeBase}, basePorBola: ${_this.basePorBola}, ponches: ${_this.ponches})';
}


}

/// @nodoc
abstract mixin class $BateoEquipoCopyWith<$Res>  {
  factory $BateoEquipoCopyWith(BateoEquipo value, $Res Function(BateoEquipo) _then) = _$BateoEquipoCopyWithImpl;
@useResult
$Res call({
 int hits, int homeRuns, int triples, int dobles, int sencillos, int carrerasImpulsadas, int roboDeBase, int basePorBola, int ponches
});




}
/// @nodoc
class _$BateoEquipoCopyWithImpl<$Res>
    implements $BateoEquipoCopyWith<$Res> {
  _$BateoEquipoCopyWithImpl(this._self, this._then);

  final BateoEquipo _self;
  final $Res Function(BateoEquipo) _then;

/// Create a copy of BateoEquipo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hits = null,Object? homeRuns = null,Object? triples = null,Object? dobles = null,Object? sencillos = null,Object? carrerasImpulsadas = null,Object? roboDeBase = null,Object? basePorBola = null,Object? ponches = null,}) {
  return _then(BateoEquipo(
hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as int,homeRuns: null == homeRuns ? _self.homeRuns : homeRuns // ignore: cast_nullable_to_non_nullable
as int,triples: null == triples ? _self.triples : triples // ignore: cast_nullable_to_non_nullable
as int,dobles: null == dobles ? _self.dobles : dobles // ignore: cast_nullable_to_non_nullable
as int,sencillos: null == sencillos ? _self.sencillos : sencillos // ignore: cast_nullable_to_non_nullable
as int,carrerasImpulsadas: null == carrerasImpulsadas ? _self.carrerasImpulsadas : carrerasImpulsadas // ignore: cast_nullable_to_non_nullable
as int,roboDeBase: null == roboDeBase ? _self.roboDeBase : roboDeBase // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,ponches: null == ponches ? _self.ponches : ponches // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BateoEquipo].
extension BateoEquipoPatterns on BateoEquipo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BateoEquipo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BateoEquipo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BateoEquipo value)  $default,){
final _that = this;
switch (_that) {
case _BateoEquipo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BateoEquipo value)?  $default,){
final _that = this;
switch (_that) {
case _BateoEquipo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int hits,  int homeRuns,  int triples,  int dobles,  int sencillos,  int carrerasImpulsadas,  int roboDeBase,  int basePorBola,  int ponches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BateoEquipo() when $default != null:
return $default(_that.hits,_that.homeRuns,_that.triples,_that.dobles,_that.sencillos,_that.carrerasImpulsadas,_that.roboDeBase,_that.basePorBola,_that.ponches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int hits,  int homeRuns,  int triples,  int dobles,  int sencillos,  int carrerasImpulsadas,  int roboDeBase,  int basePorBola,  int ponches)  $default,) {final _that = this;
switch (_that) {
case _BateoEquipo():
return $default(_that.hits,_that.homeRuns,_that.triples,_that.dobles,_that.sencillos,_that.carrerasImpulsadas,_that.roboDeBase,_that.basePorBola,_that.ponches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int hits,  int homeRuns,  int triples,  int dobles,  int sencillos,  int carrerasImpulsadas,  int roboDeBase,  int basePorBola,  int ponches)?  $default,) {final _that = this;
switch (_that) {
case _BateoEquipo() when $default != null:
return $default(_that.hits,_that.homeRuns,_that.triples,_that.dobles,_that.sencillos,_that.carrerasImpulsadas,_that.roboDeBase,_that.basePorBola,_that.ponches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BateoEquipo implements BateoEquipo {
  const _BateoEquipo({this.hits = 0, this.homeRuns = 0, this.triples = 0, this.dobles = 0, this.sencillos = 0, this.carrerasImpulsadas = 0, this.roboDeBase = 0, this.basePorBola = 0, this.ponches = 0});
  factory _BateoEquipo.fromJson(Map<String, dynamic> json) => _$BateoEquipoFromJson(json);

@override@JsonKey() final  int hits;
@override@JsonKey() final  int homeRuns;
@override@JsonKey() final  int triples;
@override@JsonKey() final  int dobles;
@override@JsonKey() final  int sencillos;
@override@JsonKey() final  int carrerasImpulsadas;
@override@JsonKey() final  int roboDeBase;
@override@JsonKey() final  int basePorBola;
@override@JsonKey() final  int ponches;

/// Create a copy of BateoEquipo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BateoEquipoCopyWith<_BateoEquipo> get copyWith => __$BateoEquipoCopyWithImpl<_BateoEquipo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BateoEquipoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BateoEquipo&&(identical(other.hits, hits) || other.hits == hits)&&(identical(other.homeRuns, homeRuns) || other.homeRuns == homeRuns)&&(identical(other.triples, triples) || other.triples == triples)&&(identical(other.dobles, dobles) || other.dobles == dobles)&&(identical(other.sencillos, sencillos) || other.sencillos == sencillos)&&(identical(other.carrerasImpulsadas, carrerasImpulsadas) || other.carrerasImpulsadas == carrerasImpulsadas)&&(identical(other.roboDeBase, roboDeBase) || other.roboDeBase == roboDeBase)&&(identical(other.basePorBola, basePorBola) || other.basePorBola == basePorBola)&&(identical(other.ponches, ponches) || other.ponches == ponches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,hits,homeRuns,triples,dobles,sencillos,carrerasImpulsadas,roboDeBase,basePorBola,ponches);
}

@override
String toString() {
    return 'BateoEquipo(hits: $hits, homeRuns: $homeRuns, triples: $triples, dobles: $dobles, sencillos: $sencillos, carrerasImpulsadas: $carrerasImpulsadas, roboDeBase: $roboDeBase, basePorBola: $basePorBola, ponches: $ponches)';
}


}

/// @nodoc
abstract mixin class _$BateoEquipoCopyWith<$Res> implements $BateoEquipoCopyWith<$Res> {
  factory _$BateoEquipoCopyWith(_BateoEquipo value, $Res Function(_BateoEquipo) _then) = __$BateoEquipoCopyWithImpl;
@override @useResult
$Res call({
 int hits, int homeRuns, int triples, int dobles, int sencillos, int carrerasImpulsadas, int roboDeBase, int basePorBola, int ponches
});




}
/// @nodoc
class __$BateoEquipoCopyWithImpl<$Res>
    implements _$BateoEquipoCopyWith<$Res> {
  __$BateoEquipoCopyWithImpl(this._self, this._then);

  final _BateoEquipo _self;
  final $Res Function(_BateoEquipo) _then;

/// Create a copy of BateoEquipo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hits = null,Object? homeRuns = null,Object? triples = null,Object? dobles = null,Object? sencillos = null,Object? carrerasImpulsadas = null,Object? roboDeBase = null,Object? basePorBola = null,Object? ponches = null,}) {
  return _then(_BateoEquipo(
hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as int,homeRuns: null == homeRuns ? _self.homeRuns : homeRuns // ignore: cast_nullable_to_non_nullable
as int,triples: null == triples ? _self.triples : triples // ignore: cast_nullable_to_non_nullable
as int,dobles: null == dobles ? _self.dobles : dobles // ignore: cast_nullable_to_non_nullable
as int,sencillos: null == sencillos ? _self.sencillos : sencillos // ignore: cast_nullable_to_non_nullable
as int,carrerasImpulsadas: null == carrerasImpulsadas ? _self.carrerasImpulsadas : carrerasImpulsadas // ignore: cast_nullable_to_non_nullable
as int,roboDeBase: null == roboDeBase ? _self.roboDeBase : roboDeBase // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,ponches: null == ponches ? _self.ponches : ponches // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PitcheoEquipo {

 int get inningsLanzados; int get ponchados; int get basePorBola; int get carrerasPermitidas; int get hitsPermitidos; double? get era; double? get whip; double? get k9;
/// Create a copy of PitcheoEquipo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PitcheoEquipoCopyWith<PitcheoEquipo> get copyWith => _$PitcheoEquipoCopyWithImpl<PitcheoEquipo>(this as PitcheoEquipo, _$identity);

  /// Serializes this PitcheoEquipo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PitcheoEquipo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PitcheoEquipo&&(identical(other.inningsLanzados, _this.inningsLanzados) || other.inningsLanzados == _this.inningsLanzados)&&(identical(other.ponchados, _this.ponchados) || other.ponchados == _this.ponchados)&&(identical(other.basePorBola, _this.basePorBola) || other.basePorBola == _this.basePorBola)&&(identical(other.carrerasPermitidas, _this.carrerasPermitidas) || other.carrerasPermitidas == _this.carrerasPermitidas)&&(identical(other.hitsPermitidos, _this.hitsPermitidos) || other.hitsPermitidos == _this.hitsPermitidos)&&(identical(other.era, _this.era) || other.era == _this.era)&&(identical(other.whip, _this.whip) || other.whip == _this.whip)&&(identical(other.k9, _this.k9) || other.k9 == _this.k9));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PitcheoEquipo;
  return Object.hash(runtimeType,_this.inningsLanzados,_this.ponchados,_this.basePorBola,_this.carrerasPermitidas,_this.hitsPermitidos,_this.era,_this.whip,_this.k9);
}

@override
String toString() {
  final _this = this as PitcheoEquipo;
  return 'PitcheoEquipo(inningsLanzados: ${_this.inningsLanzados}, ponchados: ${_this.ponchados}, basePorBola: ${_this.basePorBola}, carrerasPermitidas: ${_this.carrerasPermitidas}, hitsPermitidos: ${_this.hitsPermitidos}, era: ${_this.era}, whip: ${_this.whip}, k9: ${_this.k9})';
}


}

/// @nodoc
abstract mixin class $PitcheoEquipoCopyWith<$Res>  {
  factory $PitcheoEquipoCopyWith(PitcheoEquipo value, $Res Function(PitcheoEquipo) _then) = _$PitcheoEquipoCopyWithImpl;
@useResult
$Res call({
 int inningsLanzados, int ponchados, int basePorBola, int carrerasPermitidas, int hitsPermitidos, double? era, double? whip, double? k9
});




}
/// @nodoc
class _$PitcheoEquipoCopyWithImpl<$Res>
    implements $PitcheoEquipoCopyWith<$Res> {
  _$PitcheoEquipoCopyWithImpl(this._self, this._then);

  final PitcheoEquipo _self;
  final $Res Function(PitcheoEquipo) _then;

/// Create a copy of PitcheoEquipo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inningsLanzados = null,Object? ponchados = null,Object? basePorBola = null,Object? carrerasPermitidas = null,Object? hitsPermitidos = null,Object? era = freezed,Object? whip = freezed,Object? k9 = freezed,}) {
  return _then(PitcheoEquipo(
inningsLanzados: null == inningsLanzados ? _self.inningsLanzados : inningsLanzados // ignore: cast_nullable_to_non_nullable
as int,ponchados: null == ponchados ? _self.ponchados : ponchados // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,carrerasPermitidas: null == carrerasPermitidas ? _self.carrerasPermitidas : carrerasPermitidas // ignore: cast_nullable_to_non_nullable
as int,hitsPermitidos: null == hitsPermitidos ? _self.hitsPermitidos : hitsPermitidos // ignore: cast_nullable_to_non_nullable
as int,era: freezed == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as double?,whip: freezed == whip ? _self.whip : whip // ignore: cast_nullable_to_non_nullable
as double?,k9: freezed == k9 ? _self.k9 : k9 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PitcheoEquipo].
extension PitcheoEquipoPatterns on PitcheoEquipo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PitcheoEquipo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PitcheoEquipo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PitcheoEquipo value)  $default,){
final _that = this;
switch (_that) {
case _PitcheoEquipo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PitcheoEquipo value)?  $default,){
final _that = this;
switch (_that) {
case _PitcheoEquipo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int inningsLanzados,  int ponchados,  int basePorBola,  int carrerasPermitidas,  int hitsPermitidos,  double? era,  double? whip,  double? k9)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PitcheoEquipo() when $default != null:
return $default(_that.inningsLanzados,_that.ponchados,_that.basePorBola,_that.carrerasPermitidas,_that.hitsPermitidos,_that.era,_that.whip,_that.k9);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int inningsLanzados,  int ponchados,  int basePorBola,  int carrerasPermitidas,  int hitsPermitidos,  double? era,  double? whip,  double? k9)  $default,) {final _that = this;
switch (_that) {
case _PitcheoEquipo():
return $default(_that.inningsLanzados,_that.ponchados,_that.basePorBola,_that.carrerasPermitidas,_that.hitsPermitidos,_that.era,_that.whip,_that.k9);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int inningsLanzados,  int ponchados,  int basePorBola,  int carrerasPermitidas,  int hitsPermitidos,  double? era,  double? whip,  double? k9)?  $default,) {final _that = this;
switch (_that) {
case _PitcheoEquipo() when $default != null:
return $default(_that.inningsLanzados,_that.ponchados,_that.basePorBola,_that.carrerasPermitidas,_that.hitsPermitidos,_that.era,_that.whip,_that.k9);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PitcheoEquipo implements PitcheoEquipo {
  const _PitcheoEquipo({this.inningsLanzados = 0, this.ponchados = 0, this.basePorBola = 0, this.carrerasPermitidas = 0, this.hitsPermitidos = 0, this.era, this.whip, this.k9});
  factory _PitcheoEquipo.fromJson(Map<String, dynamic> json) => _$PitcheoEquipoFromJson(json);

@override@JsonKey() final  int inningsLanzados;
@override@JsonKey() final  int ponchados;
@override@JsonKey() final  int basePorBola;
@override@JsonKey() final  int carrerasPermitidas;
@override@JsonKey() final  int hitsPermitidos;
@override final  double? era;
@override final  double? whip;
@override final  double? k9;

/// Create a copy of PitcheoEquipo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PitcheoEquipoCopyWith<_PitcheoEquipo> get copyWith => __$PitcheoEquipoCopyWithImpl<_PitcheoEquipo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PitcheoEquipoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PitcheoEquipo&&(identical(other.inningsLanzados, inningsLanzados) || other.inningsLanzados == inningsLanzados)&&(identical(other.ponchados, ponchados) || other.ponchados == ponchados)&&(identical(other.basePorBola, basePorBola) || other.basePorBola == basePorBola)&&(identical(other.carrerasPermitidas, carrerasPermitidas) || other.carrerasPermitidas == carrerasPermitidas)&&(identical(other.hitsPermitidos, hitsPermitidos) || other.hitsPermitidos == hitsPermitidos)&&(identical(other.era, era) || other.era == era)&&(identical(other.whip, whip) || other.whip == whip)&&(identical(other.k9, k9) || other.k9 == k9));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,inningsLanzados,ponchados,basePorBola,carrerasPermitidas,hitsPermitidos,era,whip,k9);
}

@override
String toString() {
    return 'PitcheoEquipo(inningsLanzados: $inningsLanzados, ponchados: $ponchados, basePorBola: $basePorBola, carrerasPermitidas: $carrerasPermitidas, hitsPermitidos: $hitsPermitidos, era: $era, whip: $whip, k9: $k9)';
}


}

/// @nodoc
abstract mixin class _$PitcheoEquipoCopyWith<$Res> implements $PitcheoEquipoCopyWith<$Res> {
  factory _$PitcheoEquipoCopyWith(_PitcheoEquipo value, $Res Function(_PitcheoEquipo) _then) = __$PitcheoEquipoCopyWithImpl;
@override @useResult
$Res call({
 int inningsLanzados, int ponchados, int basePorBola, int carrerasPermitidas, int hitsPermitidos, double? era, double? whip, double? k9
});




}
/// @nodoc
class __$PitcheoEquipoCopyWithImpl<$Res>
    implements _$PitcheoEquipoCopyWith<$Res> {
  __$PitcheoEquipoCopyWithImpl(this._self, this._then);

  final _PitcheoEquipo _self;
  final $Res Function(_PitcheoEquipo) _then;

/// Create a copy of PitcheoEquipo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inningsLanzados = null,Object? ponchados = null,Object? basePorBola = null,Object? carrerasPermitidas = null,Object? hitsPermitidos = null,Object? era = freezed,Object? whip = freezed,Object? k9 = freezed,}) {
  return _then(_PitcheoEquipo(
inningsLanzados: null == inningsLanzados ? _self.inningsLanzados : inningsLanzados // ignore: cast_nullable_to_non_nullable
as int,ponchados: null == ponchados ? _self.ponchados : ponchados // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,carrerasPermitidas: null == carrerasPermitidas ? _self.carrerasPermitidas : carrerasPermitidas // ignore: cast_nullable_to_non_nullable
as int,hitsPermitidos: null == hitsPermitidos ? _self.hitsPermitidos : hitsPermitidos // ignore: cast_nullable_to_non_nullable
as int,era: freezed == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as double?,whip: freezed == whip ? _self.whip : whip // ignore: cast_nullable_to_non_nullable
as double?,k9: freezed == k9 ? _self.k9 : k9 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$EquipoEstadisticas {

 Equipo get equipo; List<PartidoEquipo> get partidos; List<Comparativa> get comparativaLiga; BateoEquipo get bateo; PitcheoEquipo get pitcheo;
/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipoEstadisticasCopyWith<EquipoEstadisticas> get copyWith => _$EquipoEstadisticasCopyWithImpl<EquipoEstadisticas>(this as EquipoEstadisticas, _$identity);

  /// Serializes this EquipoEstadisticas to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipoEstadisticas;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipoEstadisticas&&(identical(other.equipo, _this.equipo) || other.equipo == _this.equipo)&&const DeepCollectionEquality().equals(other.partidos, _this.partidos)&&const DeepCollectionEquality().equals(other.comparativaLiga, _this.comparativaLiga)&&(identical(other.bateo, _this.bateo) || other.bateo == _this.bateo)&&(identical(other.pitcheo, _this.pitcheo) || other.pitcheo == _this.pitcheo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipoEstadisticas;
  return Object.hash(runtimeType,_this.equipo,const DeepCollectionEquality().hash(_this.partidos),const DeepCollectionEquality().hash(_this.comparativaLiga),_this.bateo,_this.pitcheo);
}

@override
String toString() {
  final _this = this as EquipoEstadisticas;
  return 'EquipoEstadisticas(equipo: ${_this.equipo}, partidos: ${_this.partidos}, comparativaLiga: ${_this.comparativaLiga}, bateo: ${_this.bateo}, pitcheo: ${_this.pitcheo})';
}


}

/// @nodoc
abstract mixin class $EquipoEstadisticasCopyWith<$Res>  {
  factory $EquipoEstadisticasCopyWith(EquipoEstadisticas value, $Res Function(EquipoEstadisticas) _then) = _$EquipoEstadisticasCopyWithImpl;
@useResult
$Res call({
 Equipo equipo, List<PartidoEquipo> partidos, List<Comparativa> comparativaLiga, BateoEquipo bateo, PitcheoEquipo pitcheo
});


$EquipoCopyWith<$Res> get equipo;$BateoEquipoCopyWith<$Res> get bateo;$PitcheoEquipoCopyWith<$Res> get pitcheo;

}
/// @nodoc
class _$EquipoEstadisticasCopyWithImpl<$Res>
    implements $EquipoEstadisticasCopyWith<$Res> {
  _$EquipoEstadisticasCopyWithImpl(this._self, this._then);

  final EquipoEstadisticas _self;
  final $Res Function(EquipoEstadisticas) _then;

/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? equipo = null,Object? partidos = null,Object? comparativaLiga = null,Object? bateo = null,Object? pitcheo = null,}) {
  return _then(EquipoEstadisticas(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as Equipo,partidos: null == partidos ? _self.partidos : partidos // ignore: cast_nullable_to_non_nullable
as List<PartidoEquipo>,comparativaLiga: null == comparativaLiga ? _self.comparativaLiga : comparativaLiga // ignore: cast_nullable_to_non_nullable
as List<Comparativa>,bateo: null == bateo ? _self.bateo : bateo // ignore: cast_nullable_to_non_nullable
as BateoEquipo,pitcheo: null == pitcheo ? _self.pitcheo : pitcheo // ignore: cast_nullable_to_non_nullable
as PitcheoEquipo,
  ));
}
/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoCopyWith<$Res> get equipo {
  
  return $EquipoCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BateoEquipoCopyWith<$Res> get bateo {
  
  return $BateoEquipoCopyWith<$Res>(_self.bateo, (value) {
    return _then(_self.copyWith(bateo: value));
  });
}/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PitcheoEquipoCopyWith<$Res> get pitcheo {
  
  return $PitcheoEquipoCopyWith<$Res>(_self.pitcheo, (value) {
    return _then(_self.copyWith(pitcheo: value));
  });
}
}


/// Adds pattern-matching-related methods to [EquipoEstadisticas].
extension EquipoEstadisticasPatterns on EquipoEstadisticas {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipoEstadisticas value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipoEstadisticas() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipoEstadisticas value)  $default,){
final _that = this;
switch (_that) {
case _EquipoEstadisticas():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipoEstadisticas value)?  $default,){
final _that = this;
switch (_that) {
case _EquipoEstadisticas() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Equipo equipo,  List<PartidoEquipo> partidos,  List<Comparativa> comparativaLiga,  BateoEquipo bateo,  PitcheoEquipo pitcheo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipoEstadisticas() when $default != null:
return $default(_that.equipo,_that.partidos,_that.comparativaLiga,_that.bateo,_that.pitcheo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Equipo equipo,  List<PartidoEquipo> partidos,  List<Comparativa> comparativaLiga,  BateoEquipo bateo,  PitcheoEquipo pitcheo)  $default,) {final _that = this;
switch (_that) {
case _EquipoEstadisticas():
return $default(_that.equipo,_that.partidos,_that.comparativaLiga,_that.bateo,_that.pitcheo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Equipo equipo,  List<PartidoEquipo> partidos,  List<Comparativa> comparativaLiga,  BateoEquipo bateo,  PitcheoEquipo pitcheo)?  $default,) {final _that = this;
switch (_that) {
case _EquipoEstadisticas() when $default != null:
return $default(_that.equipo,_that.partidos,_that.comparativaLiga,_that.bateo,_that.pitcheo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipoEstadisticas implements EquipoEstadisticas {
  const _EquipoEstadisticas({required this.equipo,  List<PartidoEquipo> partidos = const <PartidoEquipo>[],  List<Comparativa> comparativaLiga = const <Comparativa>[], this.bateo = const BateoEquipo(), this.pitcheo = const PitcheoEquipo()}): _partidos = partidos,_comparativaLiga = comparativaLiga;
  factory _EquipoEstadisticas.fromJson(Map<String, dynamic> json) => _$EquipoEstadisticasFromJson(json);

@override final  Equipo equipo;
 final  List<PartidoEquipo> _partidos;
@override@JsonKey() List<PartidoEquipo> get partidos {
  if (_partidos is EqualUnmodifiableListView) return _partidos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partidos);
}

 final  List<Comparativa> _comparativaLiga;
@override@JsonKey() List<Comparativa> get comparativaLiga {
  if (_comparativaLiga is EqualUnmodifiableListView) return _comparativaLiga;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comparativaLiga);
}

@override@JsonKey() final  BateoEquipo bateo;
@override@JsonKey() final  PitcheoEquipo pitcheo;

/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipoEstadisticasCopyWith<_EquipoEstadisticas> get copyWith => __$EquipoEstadisticasCopyWithImpl<_EquipoEstadisticas>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipoEstadisticasToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipoEstadisticas&&(identical(other.equipo, equipo) || other.equipo == equipo)&&const DeepCollectionEquality().equals(other.partidos, _partidos)&&const DeepCollectionEquality().equals(other.comparativaLiga, _comparativaLiga)&&(identical(other.bateo, bateo) || other.bateo == bateo)&&(identical(other.pitcheo, pitcheo) || other.pitcheo == pitcheo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,equipo,const DeepCollectionEquality().hash(_partidos),const DeepCollectionEquality().hash(_comparativaLiga),bateo,pitcheo);
}

@override
String toString() {
    return 'EquipoEstadisticas(equipo: $equipo, partidos: $partidos, comparativaLiga: $comparativaLiga, bateo: $bateo, pitcheo: $pitcheo)';
}


}

/// @nodoc
abstract mixin class _$EquipoEstadisticasCopyWith<$Res> implements $EquipoEstadisticasCopyWith<$Res> {
  factory _$EquipoEstadisticasCopyWith(_EquipoEstadisticas value, $Res Function(_EquipoEstadisticas) _then) = __$EquipoEstadisticasCopyWithImpl;
@override @useResult
$Res call({
 Equipo equipo, List<PartidoEquipo> partidos, List<Comparativa> comparativaLiga, BateoEquipo bateo, PitcheoEquipo pitcheo
});


@override $EquipoCopyWith<$Res> get equipo;@override $BateoEquipoCopyWith<$Res> get bateo;@override $PitcheoEquipoCopyWith<$Res> get pitcheo;

}
/// @nodoc
class __$EquipoEstadisticasCopyWithImpl<$Res>
    implements _$EquipoEstadisticasCopyWith<$Res> {
  __$EquipoEstadisticasCopyWithImpl(this._self, this._then);

  final _EquipoEstadisticas _self;
  final $Res Function(_EquipoEstadisticas) _then;

/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equipo = null,Object? partidos = null,Object? comparativaLiga = null,Object? bateo = null,Object? pitcheo = null,}) {
  return _then(_EquipoEstadisticas(
equipo: null == equipo ? _self.equipo : equipo // ignore: cast_nullable_to_non_nullable
as Equipo,partidos: null == partidos ? _self._partidos : partidos // ignore: cast_nullable_to_non_nullable
as List<PartidoEquipo>,comparativaLiga: null == comparativaLiga ? _self._comparativaLiga : comparativaLiga // ignore: cast_nullable_to_non_nullable
as List<Comparativa>,bateo: null == bateo ? _self.bateo : bateo // ignore: cast_nullable_to_non_nullable
as BateoEquipo,pitcheo: null == pitcheo ? _self.pitcheo : pitcheo // ignore: cast_nullable_to_non_nullable
as PitcheoEquipo,
  ));
}

/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoCopyWith<$Res> get equipo {
  
  return $EquipoCopyWith<$Res>(_self.equipo, (value) {
    return _then(_self.copyWith(equipo: value));
  });
}/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BateoEquipoCopyWith<$Res> get bateo {
  
  return $BateoEquipoCopyWith<$Res>(_self.bateo, (value) {
    return _then(_self.copyWith(bateo: value));
  });
}/// Create a copy of EquipoEstadisticas
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PitcheoEquipoCopyWith<$Res> get pitcheo {
  
  return $PitcheoEquipoCopyWith<$Res>(_self.pitcheo, (value) {
    return _then(_self.copyWith(pitcheo: value));
  });
}
}

// dart format on
