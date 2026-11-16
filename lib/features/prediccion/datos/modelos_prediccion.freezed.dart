// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_prediccion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntradaPrediccion {

 String get localVisitante; double get rachaUlt3; double get promCarrerasFavor; double get promCarrerasContra; String get rivalFuerza;
/// Create a copy of EntradaPrediccion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntradaPrediccionCopyWith<EntradaPrediccion> get copyWith => _$EntradaPrediccionCopyWithImpl<EntradaPrediccion>(this as EntradaPrediccion, _$identity);

  /// Serializes this EntradaPrediccion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EntradaPrediccion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntradaPrediccion&&(identical(other.localVisitante, _this.localVisitante) || other.localVisitante == _this.localVisitante)&&(identical(other.rachaUlt3, _this.rachaUlt3) || other.rachaUlt3 == _this.rachaUlt3)&&(identical(other.promCarrerasFavor, _this.promCarrerasFavor) || other.promCarrerasFavor == _this.promCarrerasFavor)&&(identical(other.promCarrerasContra, _this.promCarrerasContra) || other.promCarrerasContra == _this.promCarrerasContra)&&(identical(other.rivalFuerza, _this.rivalFuerza) || other.rivalFuerza == _this.rivalFuerza));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EntradaPrediccion;
  return Object.hash(runtimeType,_this.localVisitante,_this.rachaUlt3,_this.promCarrerasFavor,_this.promCarrerasContra,_this.rivalFuerza);
}

@override
String toString() {
  final _this = this as EntradaPrediccion;
  return 'EntradaPrediccion(localVisitante: ${_this.localVisitante}, rachaUlt3: ${_this.rachaUlt3}, promCarrerasFavor: ${_this.promCarrerasFavor}, promCarrerasContra: ${_this.promCarrerasContra}, rivalFuerza: ${_this.rivalFuerza})';
}


}

/// @nodoc
abstract mixin class $EntradaPrediccionCopyWith<$Res>  {
  factory $EntradaPrediccionCopyWith(EntradaPrediccion value, $Res Function(EntradaPrediccion) _then) = _$EntradaPrediccionCopyWithImpl;
@useResult
$Res call({
 String localVisitante, double rachaUlt3, double promCarrerasFavor, double promCarrerasContra, String rivalFuerza
});




}
/// @nodoc
class _$EntradaPrediccionCopyWithImpl<$Res>
    implements $EntradaPrediccionCopyWith<$Res> {
  _$EntradaPrediccionCopyWithImpl(this._self, this._then);

  final EntradaPrediccion _self;
  final $Res Function(EntradaPrediccion) _then;

/// Create a copy of EntradaPrediccion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localVisitante = null,Object? rachaUlt3 = null,Object? promCarrerasFavor = null,Object? promCarrerasContra = null,Object? rivalFuerza = null,}) {
  return _then(EntradaPrediccion(
localVisitante: null == localVisitante ? _self.localVisitante : localVisitante // ignore: cast_nullable_to_non_nullable
as String,rachaUlt3: null == rachaUlt3 ? _self.rachaUlt3 : rachaUlt3 // ignore: cast_nullable_to_non_nullable
as double,promCarrerasFavor: null == promCarrerasFavor ? _self.promCarrerasFavor : promCarrerasFavor // ignore: cast_nullable_to_non_nullable
as double,promCarrerasContra: null == promCarrerasContra ? _self.promCarrerasContra : promCarrerasContra // ignore: cast_nullable_to_non_nullable
as double,rivalFuerza: null == rivalFuerza ? _self.rivalFuerza : rivalFuerza // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EntradaPrediccion].
extension EntradaPrediccionPatterns on EntradaPrediccion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntradaPrediccion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntradaPrediccion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntradaPrediccion value)  $default,){
final _that = this;
switch (_that) {
case _EntradaPrediccion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntradaPrediccion value)?  $default,){
final _that = this;
switch (_that) {
case _EntradaPrediccion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localVisitante,  double rachaUlt3,  double promCarrerasFavor,  double promCarrerasContra,  String rivalFuerza)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntradaPrediccion() when $default != null:
return $default(_that.localVisitante,_that.rachaUlt3,_that.promCarrerasFavor,_that.promCarrerasContra,_that.rivalFuerza);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localVisitante,  double rachaUlt3,  double promCarrerasFavor,  double promCarrerasContra,  String rivalFuerza)  $default,) {final _that = this;
switch (_that) {
case _EntradaPrediccion():
return $default(_that.localVisitante,_that.rachaUlt3,_that.promCarrerasFavor,_that.promCarrerasContra,_that.rivalFuerza);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localVisitante,  double rachaUlt3,  double promCarrerasFavor,  double promCarrerasContra,  String rivalFuerza)?  $default,) {final _that = this;
switch (_that) {
case _EntradaPrediccion() when $default != null:
return $default(_that.localVisitante,_that.rachaUlt3,_that.promCarrerasFavor,_that.promCarrerasContra,_that.rivalFuerza);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntradaPrediccion implements EntradaPrediccion {
  const _EntradaPrediccion({required this.localVisitante, required this.rachaUlt3, required this.promCarrerasFavor, required this.promCarrerasContra, required this.rivalFuerza});
  factory _EntradaPrediccion.fromJson(Map<String, dynamic> json) => _$EntradaPrediccionFromJson(json);

@override final  String localVisitante;
@override final  double rachaUlt3;
@override final  double promCarrerasFavor;
@override final  double promCarrerasContra;
@override final  String rivalFuerza;

/// Create a copy of EntradaPrediccion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntradaPrediccionCopyWith<_EntradaPrediccion> get copyWith => __$EntradaPrediccionCopyWithImpl<_EntradaPrediccion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntradaPrediccionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntradaPrediccion&&(identical(other.localVisitante, localVisitante) || other.localVisitante == localVisitante)&&(identical(other.rachaUlt3, rachaUlt3) || other.rachaUlt3 == rachaUlt3)&&(identical(other.promCarrerasFavor, promCarrerasFavor) || other.promCarrerasFavor == promCarrerasFavor)&&(identical(other.promCarrerasContra, promCarrerasContra) || other.promCarrerasContra == promCarrerasContra)&&(identical(other.rivalFuerza, rivalFuerza) || other.rivalFuerza == rivalFuerza));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,localVisitante,rachaUlt3,promCarrerasFavor,promCarrerasContra,rivalFuerza);
}

@override
String toString() {
    return 'EntradaPrediccion(localVisitante: $localVisitante, rachaUlt3: $rachaUlt3, promCarrerasFavor: $promCarrerasFavor, promCarrerasContra: $promCarrerasContra, rivalFuerza: $rivalFuerza)';
}


}

/// @nodoc
abstract mixin class _$EntradaPrediccionCopyWith<$Res> implements $EntradaPrediccionCopyWith<$Res> {
  factory _$EntradaPrediccionCopyWith(_EntradaPrediccion value, $Res Function(_EntradaPrediccion) _then) = __$EntradaPrediccionCopyWithImpl;
@override @useResult
$Res call({
 String localVisitante, double rachaUlt3, double promCarrerasFavor, double promCarrerasContra, String rivalFuerza
});




}
/// @nodoc
class __$EntradaPrediccionCopyWithImpl<$Res>
    implements _$EntradaPrediccionCopyWith<$Res> {
  __$EntradaPrediccionCopyWithImpl(this._self, this._then);

  final _EntradaPrediccion _self;
  final $Res Function(_EntradaPrediccion) _then;

/// Create a copy of EntradaPrediccion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localVisitante = null,Object? rachaUlt3 = null,Object? promCarrerasFavor = null,Object? promCarrerasContra = null,Object? rivalFuerza = null,}) {
  return _then(_EntradaPrediccion(
localVisitante: null == localVisitante ? _self.localVisitante : localVisitante // ignore: cast_nullable_to_non_nullable
as String,rachaUlt3: null == rachaUlt3 ? _self.rachaUlt3 : rachaUlt3 // ignore: cast_nullable_to_non_nullable
as double,promCarrerasFavor: null == promCarrerasFavor ? _self.promCarrerasFavor : promCarrerasFavor // ignore: cast_nullable_to_non_nullable
as double,promCarrerasContra: null == promCarrerasContra ? _self.promCarrerasContra : promCarrerasContra // ignore: cast_nullable_to_non_nullable
as double,rivalFuerza: null == rivalFuerza ? _self.rivalFuerza : rivalFuerza // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Prediccion {

 String get clase; bool get gana; double get confianza; Map<String, double> get probabilidades; EntradaPrediccion get entradas; String get resumen;
/// Create a copy of Prediccion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrediccionCopyWith<Prediccion> get copyWith => _$PrediccionCopyWithImpl<Prediccion>(this as Prediccion, _$identity);

  /// Serializes this Prediccion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Prediccion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Prediccion&&(identical(other.clase, _this.clase) || other.clase == _this.clase)&&(identical(other.gana, _this.gana) || other.gana == _this.gana)&&(identical(other.confianza, _this.confianza) || other.confianza == _this.confianza)&&const DeepCollectionEquality().equals(other.probabilidades, _this.probabilidades)&&(identical(other.entradas, _this.entradas) || other.entradas == _this.entradas)&&(identical(other.resumen, _this.resumen) || other.resumen == _this.resumen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Prediccion;
  return Object.hash(runtimeType,_this.clase,_this.gana,_this.confianza,const DeepCollectionEquality().hash(_this.probabilidades),_this.entradas,_this.resumen);
}

@override
String toString() {
  final _this = this as Prediccion;
  return 'Prediccion(clase: ${_this.clase}, gana: ${_this.gana}, confianza: ${_this.confianza}, probabilidades: ${_this.probabilidades}, entradas: ${_this.entradas}, resumen: ${_this.resumen})';
}


}

/// @nodoc
abstract mixin class $PrediccionCopyWith<$Res>  {
  factory $PrediccionCopyWith(Prediccion value, $Res Function(Prediccion) _then) = _$PrediccionCopyWithImpl;
@useResult
$Res call({
 String clase, bool gana, double confianza, Map<String, double> probabilidades, EntradaPrediccion entradas, String resumen
});


$EntradaPrediccionCopyWith<$Res> get entradas;

}
/// @nodoc
class _$PrediccionCopyWithImpl<$Res>
    implements $PrediccionCopyWith<$Res> {
  _$PrediccionCopyWithImpl(this._self, this._then);

  final Prediccion _self;
  final $Res Function(Prediccion) _then;

/// Create a copy of Prediccion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clase = null,Object? gana = null,Object? confianza = null,Object? probabilidades = null,Object? entradas = null,Object? resumen = null,}) {
  return _then(Prediccion(
clase: null == clase ? _self.clase : clase // ignore: cast_nullable_to_non_nullable
as String,gana: null == gana ? _self.gana : gana // ignore: cast_nullable_to_non_nullable
as bool,confianza: null == confianza ? _self.confianza : confianza // ignore: cast_nullable_to_non_nullable
as double,probabilidades: null == probabilidades ? _self.probabilidades : probabilidades // ignore: cast_nullable_to_non_nullable
as Map<String, double>,entradas: null == entradas ? _self.entradas : entradas // ignore: cast_nullable_to_non_nullable
as EntradaPrediccion,resumen: null == resumen ? _self.resumen : resumen // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Prediccion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntradaPrediccionCopyWith<$Res> get entradas {
  
  return $EntradaPrediccionCopyWith<$Res>(_self.entradas, (value) {
    return _then(_self.copyWith(entradas: value));
  });
}
}


/// Adds pattern-matching-related methods to [Prediccion].
extension PrediccionPatterns on Prediccion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Prediccion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Prediccion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Prediccion value)  $default,){
final _that = this;
switch (_that) {
case _Prediccion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Prediccion value)?  $default,){
final _that = this;
switch (_that) {
case _Prediccion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clase,  bool gana,  double confianza,  Map<String, double> probabilidades,  EntradaPrediccion entradas,  String resumen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Prediccion() when $default != null:
return $default(_that.clase,_that.gana,_that.confianza,_that.probabilidades,_that.entradas,_that.resumen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clase,  bool gana,  double confianza,  Map<String, double> probabilidades,  EntradaPrediccion entradas,  String resumen)  $default,) {final _that = this;
switch (_that) {
case _Prediccion():
return $default(_that.clase,_that.gana,_that.confianza,_that.probabilidades,_that.entradas,_that.resumen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clase,  bool gana,  double confianza,  Map<String, double> probabilidades,  EntradaPrediccion entradas,  String resumen)?  $default,) {final _that = this;
switch (_that) {
case _Prediccion() when $default != null:
return $default(_that.clase,_that.gana,_that.confianza,_that.probabilidades,_that.entradas,_that.resumen);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Prediccion implements Prediccion {
  const _Prediccion({required this.clase, required this.gana, required this.confianza,  Map<String, double> probabilidades = const <String, double>{}, required this.entradas, this.resumen = ''}): _probabilidades = probabilidades;
  factory _Prediccion.fromJson(Map<String, dynamic> json) => _$PrediccionFromJson(json);

@override final  String clase;
@override final  bool gana;
@override final  double confianza;
 final  Map<String, double> _probabilidades;
@override@JsonKey() Map<String, double> get probabilidades {
  if (_probabilidades is EqualUnmodifiableMapView) return _probabilidades;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_probabilidades);
}

@override final  EntradaPrediccion entradas;
@override@JsonKey() final  String resumen;

/// Create a copy of Prediccion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrediccionCopyWith<_Prediccion> get copyWith => __$PrediccionCopyWithImpl<_Prediccion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrediccionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Prediccion&&(identical(other.clase, clase) || other.clase == clase)&&(identical(other.gana, gana) || other.gana == gana)&&(identical(other.confianza, confianza) || other.confianza == confianza)&&const DeepCollectionEquality().equals(other.probabilidades, _probabilidades)&&(identical(other.entradas, entradas) || other.entradas == entradas)&&(identical(other.resumen, resumen) || other.resumen == resumen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,clase,gana,confianza,const DeepCollectionEquality().hash(_probabilidades),entradas,resumen);
}

@override
String toString() {
    return 'Prediccion(clase: $clase, gana: $gana, confianza: $confianza, probabilidades: $probabilidades, entradas: $entradas, resumen: $resumen)';
}


}

/// @nodoc
abstract mixin class _$PrediccionCopyWith<$Res> implements $PrediccionCopyWith<$Res> {
  factory _$PrediccionCopyWith(_Prediccion value, $Res Function(_Prediccion) _then) = __$PrediccionCopyWithImpl;
@override @useResult
$Res call({
 String clase, bool gana, double confianza, Map<String, double> probabilidades, EntradaPrediccion entradas, String resumen
});


@override $EntradaPrediccionCopyWith<$Res> get entradas;

}
/// @nodoc
class __$PrediccionCopyWithImpl<$Res>
    implements _$PrediccionCopyWith<$Res> {
  __$PrediccionCopyWithImpl(this._self, this._then);

  final _Prediccion _self;
  final $Res Function(_Prediccion) _then;

/// Create a copy of Prediccion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clase = null,Object? gana = null,Object? confianza = null,Object? probabilidades = null,Object? entradas = null,Object? resumen = null,}) {
  return _then(_Prediccion(
clase: null == clase ? _self.clase : clase // ignore: cast_nullable_to_non_nullable
as String,gana: null == gana ? _self.gana : gana // ignore: cast_nullable_to_non_nullable
as bool,confianza: null == confianza ? _self.confianza : confianza // ignore: cast_nullable_to_non_nullable
as double,probabilidades: null == probabilidades ? _self._probabilidades : probabilidades // ignore: cast_nullable_to_non_nullable
as Map<String, double>,entradas: null == entradas ? _self.entradas : entradas // ignore: cast_nullable_to_non_nullable
as EntradaPrediccion,resumen: null == resumen ? _self.resumen : resumen // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Prediccion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntradaPrediccionCopyWith<$Res> get entradas {
  
  return $EntradaPrediccionCopyWith<$Res>(_self.entradas, (value) {
    return _then(_self.copyWith(entradas: value));
  });
}
}


/// @nodoc
mixin _$Rango {

 double get minimo; double get maximo; double get promedio;
/// Create a copy of Rango
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RangoCopyWith<Rango> get copyWith => _$RangoCopyWithImpl<Rango>(this as Rango, _$identity);

  /// Serializes this Rango to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Rango;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rango&&(identical(other.minimo, _this.minimo) || other.minimo == _this.minimo)&&(identical(other.maximo, _this.maximo) || other.maximo == _this.maximo)&&(identical(other.promedio, _this.promedio) || other.promedio == _this.promedio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Rango;
  return Object.hash(runtimeType,_this.minimo,_this.maximo,_this.promedio);
}

@override
String toString() {
  final _this = this as Rango;
  return 'Rango(minimo: ${_this.minimo}, maximo: ${_this.maximo}, promedio: ${_this.promedio})';
}


}

/// @nodoc
abstract mixin class $RangoCopyWith<$Res>  {
  factory $RangoCopyWith(Rango value, $Res Function(Rango) _then) = _$RangoCopyWithImpl;
@useResult
$Res call({
 double minimo, double maximo, double promedio
});




}
/// @nodoc
class _$RangoCopyWithImpl<$Res>
    implements $RangoCopyWith<$Res> {
  _$RangoCopyWithImpl(this._self, this._then);

  final Rango _self;
  final $Res Function(Rango) _then;

/// Create a copy of Rango
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minimo = null,Object? maximo = null,Object? promedio = null,}) {
  return _then(Rango(
minimo: null == minimo ? _self.minimo : minimo // ignore: cast_nullable_to_non_nullable
as double,maximo: null == maximo ? _self.maximo : maximo // ignore: cast_nullable_to_non_nullable
as double,promedio: null == promedio ? _self.promedio : promedio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Rango].
extension RangoPatterns on Rango {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rango value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rango() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rango value)  $default,){
final _that = this;
switch (_that) {
case _Rango():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rango value)?  $default,){
final _that = this;
switch (_that) {
case _Rango() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double minimo,  double maximo,  double promedio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rango() when $default != null:
return $default(_that.minimo,_that.maximo,_that.promedio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double minimo,  double maximo,  double promedio)  $default,) {final _that = this;
switch (_that) {
case _Rango():
return $default(_that.minimo,_that.maximo,_that.promedio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double minimo,  double maximo,  double promedio)?  $default,) {final _that = this;
switch (_that) {
case _Rango() when $default != null:
return $default(_that.minimo,_that.maximo,_that.promedio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Rango implements Rango {
  const _Rango({required this.minimo, required this.maximo, required this.promedio});
  factory _Rango.fromJson(Map<String, dynamic> json) => _$RangoFromJson(json);

@override final  double minimo;
@override final  double maximo;
@override final  double promedio;

/// Create a copy of Rango
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RangoCopyWith<_Rango> get copyWith => __$RangoCopyWithImpl<_Rango>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RangoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rango&&(identical(other.minimo, minimo) || other.minimo == minimo)&&(identical(other.maximo, maximo) || other.maximo == maximo)&&(identical(other.promedio, promedio) || other.promedio == promedio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,minimo,maximo,promedio);
}

@override
String toString() {
    return 'Rango(minimo: $minimo, maximo: $maximo, promedio: $promedio)';
}


}

/// @nodoc
abstract mixin class _$RangoCopyWith<$Res> implements $RangoCopyWith<$Res> {
  factory _$RangoCopyWith(_Rango value, $Res Function(_Rango) _then) = __$RangoCopyWithImpl;
@override @useResult
$Res call({
 double minimo, double maximo, double promedio
});




}
/// @nodoc
class __$RangoCopyWithImpl<$Res>
    implements _$RangoCopyWith<$Res> {
  __$RangoCopyWithImpl(this._self, this._then);

  final _Rango _self;
  final $Res Function(_Rango) _then;

/// Create a copy of Rango
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minimo = null,Object? maximo = null,Object? promedio = null,}) {
  return _then(_Rango(
minimo: null == minimo ? _self.minimo : minimo // ignore: cast_nullable_to_non_nullable
as double,maximo: null == maximo ? _self.maximo : maximo // ignore: cast_nullable_to_non_nullable
as double,promedio: null == promedio ? _self.promedio : promedio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OpcionesPrediccion {

 List<String> get localVisitante; List<String> get rivalFuerza; Map<String, Rango> get rangos; int get instanciasEntrenamiento;
/// Create a copy of OpcionesPrediccion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpcionesPrediccionCopyWith<OpcionesPrediccion> get copyWith => _$OpcionesPrediccionCopyWithImpl<OpcionesPrediccion>(this as OpcionesPrediccion, _$identity);

  /// Serializes this OpcionesPrediccion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OpcionesPrediccion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpcionesPrediccion&&const DeepCollectionEquality().equals(other.localVisitante, _this.localVisitante)&&const DeepCollectionEquality().equals(other.rivalFuerza, _this.rivalFuerza)&&const DeepCollectionEquality().equals(other.rangos, _this.rangos)&&(identical(other.instanciasEntrenamiento, _this.instanciasEntrenamiento) || other.instanciasEntrenamiento == _this.instanciasEntrenamiento));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OpcionesPrediccion;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.localVisitante),const DeepCollectionEquality().hash(_this.rivalFuerza),const DeepCollectionEquality().hash(_this.rangos),_this.instanciasEntrenamiento);
}

@override
String toString() {
  final _this = this as OpcionesPrediccion;
  return 'OpcionesPrediccion(localVisitante: ${_this.localVisitante}, rivalFuerza: ${_this.rivalFuerza}, rangos: ${_this.rangos}, instanciasEntrenamiento: ${_this.instanciasEntrenamiento})';
}


}

/// @nodoc
abstract mixin class $OpcionesPrediccionCopyWith<$Res>  {
  factory $OpcionesPrediccionCopyWith(OpcionesPrediccion value, $Res Function(OpcionesPrediccion) _then) = _$OpcionesPrediccionCopyWithImpl;
@useResult
$Res call({
 List<String> localVisitante, List<String> rivalFuerza, Map<String, Rango> rangos, int instanciasEntrenamiento
});




}
/// @nodoc
class _$OpcionesPrediccionCopyWithImpl<$Res>
    implements $OpcionesPrediccionCopyWith<$Res> {
  _$OpcionesPrediccionCopyWithImpl(this._self, this._then);

  final OpcionesPrediccion _self;
  final $Res Function(OpcionesPrediccion) _then;

/// Create a copy of OpcionesPrediccion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localVisitante = null,Object? rivalFuerza = null,Object? rangos = null,Object? instanciasEntrenamiento = null,}) {
  return _then(OpcionesPrediccion(
localVisitante: null == localVisitante ? _self.localVisitante : localVisitante // ignore: cast_nullable_to_non_nullable
as List<String>,rivalFuerza: null == rivalFuerza ? _self.rivalFuerza : rivalFuerza // ignore: cast_nullable_to_non_nullable
as List<String>,rangos: null == rangos ? _self.rangos : rangos // ignore: cast_nullable_to_non_nullable
as Map<String, Rango>,instanciasEntrenamiento: null == instanciasEntrenamiento ? _self.instanciasEntrenamiento : instanciasEntrenamiento // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OpcionesPrediccion].
extension OpcionesPrediccionPatterns on OpcionesPrediccion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpcionesPrediccion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpcionesPrediccion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpcionesPrediccion value)  $default,){
final _that = this;
switch (_that) {
case _OpcionesPrediccion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpcionesPrediccion value)?  $default,){
final _that = this;
switch (_that) {
case _OpcionesPrediccion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> localVisitante,  List<String> rivalFuerza,  Map<String, Rango> rangos,  int instanciasEntrenamiento)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpcionesPrediccion() when $default != null:
return $default(_that.localVisitante,_that.rivalFuerza,_that.rangos,_that.instanciasEntrenamiento);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> localVisitante,  List<String> rivalFuerza,  Map<String, Rango> rangos,  int instanciasEntrenamiento)  $default,) {final _that = this;
switch (_that) {
case _OpcionesPrediccion():
return $default(_that.localVisitante,_that.rivalFuerza,_that.rangos,_that.instanciasEntrenamiento);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> localVisitante,  List<String> rivalFuerza,  Map<String, Rango> rangos,  int instanciasEntrenamiento)?  $default,) {final _that = this;
switch (_that) {
case _OpcionesPrediccion() when $default != null:
return $default(_that.localVisitante,_that.rivalFuerza,_that.rangos,_that.instanciasEntrenamiento);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpcionesPrediccion implements OpcionesPrediccion {
  const _OpcionesPrediccion({ List<String> localVisitante = const <String>[],  List<String> rivalFuerza = const <String>[],  Map<String, Rango> rangos = const <String, Rango>{}, this.instanciasEntrenamiento = 0}): _localVisitante = localVisitante,_rivalFuerza = rivalFuerza,_rangos = rangos;
  factory _OpcionesPrediccion.fromJson(Map<String, dynamic> json) => _$OpcionesPrediccionFromJson(json);

 final  List<String> _localVisitante;
@override@JsonKey() List<String> get localVisitante {
  if (_localVisitante is EqualUnmodifiableListView) return _localVisitante;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localVisitante);
}

 final  List<String> _rivalFuerza;
@override@JsonKey() List<String> get rivalFuerza {
  if (_rivalFuerza is EqualUnmodifiableListView) return _rivalFuerza;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rivalFuerza);
}

 final  Map<String, Rango> _rangos;
@override@JsonKey() Map<String, Rango> get rangos {
  if (_rangos is EqualUnmodifiableMapView) return _rangos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rangos);
}

@override@JsonKey() final  int instanciasEntrenamiento;

/// Create a copy of OpcionesPrediccion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpcionesPrediccionCopyWith<_OpcionesPrediccion> get copyWith => __$OpcionesPrediccionCopyWithImpl<_OpcionesPrediccion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpcionesPrediccionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpcionesPrediccion&&const DeepCollectionEquality().equals(other.localVisitante, _localVisitante)&&const DeepCollectionEquality().equals(other.rivalFuerza, _rivalFuerza)&&const DeepCollectionEquality().equals(other.rangos, _rangos)&&(identical(other.instanciasEntrenamiento, instanciasEntrenamiento) || other.instanciasEntrenamiento == instanciasEntrenamiento));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_localVisitante),const DeepCollectionEquality().hash(_rivalFuerza),const DeepCollectionEquality().hash(_rangos),instanciasEntrenamiento);
}

@override
String toString() {
    return 'OpcionesPrediccion(localVisitante: $localVisitante, rivalFuerza: $rivalFuerza, rangos: $rangos, instanciasEntrenamiento: $instanciasEntrenamiento)';
}


}

/// @nodoc
abstract mixin class _$OpcionesPrediccionCopyWith<$Res> implements $OpcionesPrediccionCopyWith<$Res> {
  factory _$OpcionesPrediccionCopyWith(_OpcionesPrediccion value, $Res Function(_OpcionesPrediccion) _then) = __$OpcionesPrediccionCopyWithImpl;
@override @useResult
$Res call({
 List<String> localVisitante, List<String> rivalFuerza, Map<String, Rango> rangos, int instanciasEntrenamiento
});




}
/// @nodoc
class __$OpcionesPrediccionCopyWithImpl<$Res>
    implements _$OpcionesPrediccionCopyWith<$Res> {
  __$OpcionesPrediccionCopyWithImpl(this._self, this._then);

  final _OpcionesPrediccion _self;
  final $Res Function(_OpcionesPrediccion) _then;

/// Create a copy of OpcionesPrediccion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localVisitante = null,Object? rivalFuerza = null,Object? rangos = null,Object? instanciasEntrenamiento = null,}) {
  return _then(_OpcionesPrediccion(
localVisitante: null == localVisitante ? _self._localVisitante : localVisitante // ignore: cast_nullable_to_non_nullable
as List<String>,rivalFuerza: null == rivalFuerza ? _self._rivalFuerza : rivalFuerza // ignore: cast_nullable_to_non_nullable
as List<String>,rangos: null == rangos ? _self._rangos : rangos // ignore: cast_nullable_to_non_nullable
as Map<String, Rango>,instanciasEntrenamiento: null == instanciasEntrenamiento ? _self.instanciasEntrenamiento : instanciasEntrenamiento // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
