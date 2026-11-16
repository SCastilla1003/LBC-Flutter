// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_jugador.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bateador {

 String get id; String get nombre; int get edad; String? get posicion; String? get derechoZurdo; String? get idEquipo; String? get nombreEquipo; bool get agenteLibre; String? get urlFoto; int get homeRuns; int get triples; int get dobles; int get sencillos; int get basePorBola; int get basePorGolpe; int get ponches; int get roboDeBase; int get carrerasImpulsadas; int get errores; int get hits; int get extrabases; int get totalBases; int get vecesEmbasado; double? get relacionBbK;
/// Create a copy of Bateador
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BateadorCopyWith<Bateador> get copyWith => _$BateadorCopyWithImpl<Bateador>(this as Bateador, _$identity);

  /// Serializes this Bateador to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Bateador;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bateador&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.edad, _this.edad) || other.edad == _this.edad)&&(identical(other.posicion, _this.posicion) || other.posicion == _this.posicion)&&(identical(other.derechoZurdo, _this.derechoZurdo) || other.derechoZurdo == _this.derechoZurdo)&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombreEquipo, _this.nombreEquipo) || other.nombreEquipo == _this.nombreEquipo)&&(identical(other.agenteLibre, _this.agenteLibre) || other.agenteLibre == _this.agenteLibre)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.homeRuns, _this.homeRuns) || other.homeRuns == _this.homeRuns)&&(identical(other.triples, _this.triples) || other.triples == _this.triples)&&(identical(other.dobles, _this.dobles) || other.dobles == _this.dobles)&&(identical(other.sencillos, _this.sencillos) || other.sencillos == _this.sencillos)&&(identical(other.basePorBola, _this.basePorBola) || other.basePorBola == _this.basePorBola)&&(identical(other.basePorGolpe, _this.basePorGolpe) || other.basePorGolpe == _this.basePorGolpe)&&(identical(other.ponches, _this.ponches) || other.ponches == _this.ponches)&&(identical(other.roboDeBase, _this.roboDeBase) || other.roboDeBase == _this.roboDeBase)&&(identical(other.carrerasImpulsadas, _this.carrerasImpulsadas) || other.carrerasImpulsadas == _this.carrerasImpulsadas)&&(identical(other.errores, _this.errores) || other.errores == _this.errores)&&(identical(other.hits, _this.hits) || other.hits == _this.hits)&&(identical(other.extrabases, _this.extrabases) || other.extrabases == _this.extrabases)&&(identical(other.totalBases, _this.totalBases) || other.totalBases == _this.totalBases)&&(identical(other.vecesEmbasado, _this.vecesEmbasado) || other.vecesEmbasado == _this.vecesEmbasado)&&(identical(other.relacionBbK, _this.relacionBbK) || other.relacionBbK == _this.relacionBbK));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Bateador;
  return Object.hashAll([runtimeType,_this.id,_this.nombre,_this.edad,_this.posicion,_this.derechoZurdo,_this.idEquipo,_this.nombreEquipo,_this.agenteLibre,_this.urlFoto,_this.homeRuns,_this.triples,_this.dobles,_this.sencillos,_this.basePorBola,_this.basePorGolpe,_this.ponches,_this.roboDeBase,_this.carrerasImpulsadas,_this.errores,_this.hits,_this.extrabases,_this.totalBases,_this.vecesEmbasado,_this.relacionBbK]);
}

@override
String toString() {
  final _this = this as Bateador;
  return 'Bateador(id: ${_this.id}, nombre: ${_this.nombre}, edad: ${_this.edad}, posicion: ${_this.posicion}, derechoZurdo: ${_this.derechoZurdo}, idEquipo: ${_this.idEquipo}, nombreEquipo: ${_this.nombreEquipo}, agenteLibre: ${_this.agenteLibre}, urlFoto: ${_this.urlFoto}, homeRuns: ${_this.homeRuns}, triples: ${_this.triples}, dobles: ${_this.dobles}, sencillos: ${_this.sencillos}, basePorBola: ${_this.basePorBola}, basePorGolpe: ${_this.basePorGolpe}, ponches: ${_this.ponches}, roboDeBase: ${_this.roboDeBase}, carrerasImpulsadas: ${_this.carrerasImpulsadas}, errores: ${_this.errores}, hits: ${_this.hits}, extrabases: ${_this.extrabases}, totalBases: ${_this.totalBases}, vecesEmbasado: ${_this.vecesEmbasado}, relacionBbK: ${_this.relacionBbK})';
}


}

/// @nodoc
abstract mixin class $BateadorCopyWith<$Res>  {
  factory $BateadorCopyWith(Bateador value, $Res Function(Bateador) _then) = _$BateadorCopyWithImpl;
@useResult
$Res call({
 String id, String nombre, int edad, String? posicion, String? derechoZurdo, String? idEquipo, String? nombreEquipo, bool agenteLibre, String? urlFoto, int homeRuns, int triples, int dobles, int sencillos, int basePorBola, int basePorGolpe, int ponches, int roboDeBase, int carrerasImpulsadas, int errores, int hits, int extrabases, int totalBases, int vecesEmbasado, double? relacionBbK
});




}
/// @nodoc
class _$BateadorCopyWithImpl<$Res>
    implements $BateadorCopyWith<$Res> {
  _$BateadorCopyWithImpl(this._self, this._then);

  final Bateador _self;
  final $Res Function(Bateador) _then;

/// Create a copy of Bateador
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? edad = null,Object? posicion = freezed,Object? derechoZurdo = freezed,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? agenteLibre = null,Object? urlFoto = freezed,Object? homeRuns = null,Object? triples = null,Object? dobles = null,Object? sencillos = null,Object? basePorBola = null,Object? basePorGolpe = null,Object? ponches = null,Object? roboDeBase = null,Object? carrerasImpulsadas = null,Object? errores = null,Object? hits = null,Object? extrabases = null,Object? totalBases = null,Object? vecesEmbasado = null,Object? relacionBbK = freezed,}) {
  return _then(Bateador(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,edad: null == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int,posicion: freezed == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String?,derechoZurdo: freezed == derechoZurdo ? _self.derechoZurdo : derechoZurdo // ignore: cast_nullable_to_non_nullable
as String?,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,agenteLibre: null == agenteLibre ? _self.agenteLibre : agenteLibre // ignore: cast_nullable_to_non_nullable
as bool,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,homeRuns: null == homeRuns ? _self.homeRuns : homeRuns // ignore: cast_nullable_to_non_nullable
as int,triples: null == triples ? _self.triples : triples // ignore: cast_nullable_to_non_nullable
as int,dobles: null == dobles ? _self.dobles : dobles // ignore: cast_nullable_to_non_nullable
as int,sencillos: null == sencillos ? _self.sencillos : sencillos // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,basePorGolpe: null == basePorGolpe ? _self.basePorGolpe : basePorGolpe // ignore: cast_nullable_to_non_nullable
as int,ponches: null == ponches ? _self.ponches : ponches // ignore: cast_nullable_to_non_nullable
as int,roboDeBase: null == roboDeBase ? _self.roboDeBase : roboDeBase // ignore: cast_nullable_to_non_nullable
as int,carrerasImpulsadas: null == carrerasImpulsadas ? _self.carrerasImpulsadas : carrerasImpulsadas // ignore: cast_nullable_to_non_nullable
as int,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as int,hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as int,extrabases: null == extrabases ? _self.extrabases : extrabases // ignore: cast_nullable_to_non_nullable
as int,totalBases: null == totalBases ? _self.totalBases : totalBases // ignore: cast_nullable_to_non_nullable
as int,vecesEmbasado: null == vecesEmbasado ? _self.vecesEmbasado : vecesEmbasado // ignore: cast_nullable_to_non_nullable
as int,relacionBbK: freezed == relacionBbK ? _self.relacionBbK : relacionBbK // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Bateador].
extension BateadorPatterns on Bateador {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bateador value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bateador() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bateador value)  $default,){
final _that = this;
switch (_that) {
case _Bateador():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bateador value)?  $default,){
final _that = this;
switch (_that) {
case _Bateador() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombre,  int edad,  String? posicion,  String? derechoZurdo,  String? idEquipo,  String? nombreEquipo,  bool agenteLibre,  String? urlFoto,  int homeRuns,  int triples,  int dobles,  int sencillos,  int basePorBola,  int basePorGolpe,  int ponches,  int roboDeBase,  int carrerasImpulsadas,  int errores,  int hits,  int extrabases,  int totalBases,  int vecesEmbasado,  double? relacionBbK)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bateador() when $default != null:
return $default(_that.id,_that.nombre,_that.edad,_that.posicion,_that.derechoZurdo,_that.idEquipo,_that.nombreEquipo,_that.agenteLibre,_that.urlFoto,_that.homeRuns,_that.triples,_that.dobles,_that.sencillos,_that.basePorBola,_that.basePorGolpe,_that.ponches,_that.roboDeBase,_that.carrerasImpulsadas,_that.errores,_that.hits,_that.extrabases,_that.totalBases,_that.vecesEmbasado,_that.relacionBbK);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombre,  int edad,  String? posicion,  String? derechoZurdo,  String? idEquipo,  String? nombreEquipo,  bool agenteLibre,  String? urlFoto,  int homeRuns,  int triples,  int dobles,  int sencillos,  int basePorBola,  int basePorGolpe,  int ponches,  int roboDeBase,  int carrerasImpulsadas,  int errores,  int hits,  int extrabases,  int totalBases,  int vecesEmbasado,  double? relacionBbK)  $default,) {final _that = this;
switch (_that) {
case _Bateador():
return $default(_that.id,_that.nombre,_that.edad,_that.posicion,_that.derechoZurdo,_that.idEquipo,_that.nombreEquipo,_that.agenteLibre,_that.urlFoto,_that.homeRuns,_that.triples,_that.dobles,_that.sencillos,_that.basePorBola,_that.basePorGolpe,_that.ponches,_that.roboDeBase,_that.carrerasImpulsadas,_that.errores,_that.hits,_that.extrabases,_that.totalBases,_that.vecesEmbasado,_that.relacionBbK);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombre,  int edad,  String? posicion,  String? derechoZurdo,  String? idEquipo,  String? nombreEquipo,  bool agenteLibre,  String? urlFoto,  int homeRuns,  int triples,  int dobles,  int sencillos,  int basePorBola,  int basePorGolpe,  int ponches,  int roboDeBase,  int carrerasImpulsadas,  int errores,  int hits,  int extrabases,  int totalBases,  int vecesEmbasado,  double? relacionBbK)?  $default,) {final _that = this;
switch (_that) {
case _Bateador() when $default != null:
return $default(_that.id,_that.nombre,_that.edad,_that.posicion,_that.derechoZurdo,_that.idEquipo,_that.nombreEquipo,_that.agenteLibre,_that.urlFoto,_that.homeRuns,_that.triples,_that.dobles,_that.sencillos,_that.basePorBola,_that.basePorGolpe,_that.ponches,_that.roboDeBase,_that.carrerasImpulsadas,_that.errores,_that.hits,_that.extrabases,_that.totalBases,_that.vecesEmbasado,_that.relacionBbK);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bateador implements Bateador {
  const _Bateador({required this.id, required this.nombre, this.edad = 0, this.posicion, this.derechoZurdo, this.idEquipo, this.nombreEquipo, this.agenteLibre = false, this.urlFoto, this.homeRuns = 0, this.triples = 0, this.dobles = 0, this.sencillos = 0, this.basePorBola = 0, this.basePorGolpe = 0, this.ponches = 0, this.roboDeBase = 0, this.carrerasImpulsadas = 0, this.errores = 0, this.hits = 0, this.extrabases = 0, this.totalBases = 0, this.vecesEmbasado = 0, this.relacionBbK});
  factory _Bateador.fromJson(Map<String, dynamic> json) => _$BateadorFromJson(json);

@override final  String id;
@override final  String nombre;
@override@JsonKey() final  int edad;
@override final  String? posicion;
@override final  String? derechoZurdo;
@override final  String? idEquipo;
@override final  String? nombreEquipo;
@override@JsonKey() final  bool agenteLibre;
@override final  String? urlFoto;
@override@JsonKey() final  int homeRuns;
@override@JsonKey() final  int triples;
@override@JsonKey() final  int dobles;
@override@JsonKey() final  int sencillos;
@override@JsonKey() final  int basePorBola;
@override@JsonKey() final  int basePorGolpe;
@override@JsonKey() final  int ponches;
@override@JsonKey() final  int roboDeBase;
@override@JsonKey() final  int carrerasImpulsadas;
@override@JsonKey() final  int errores;
@override@JsonKey() final  int hits;
@override@JsonKey() final  int extrabases;
@override@JsonKey() final  int totalBases;
@override@JsonKey() final  int vecesEmbasado;
@override final  double? relacionBbK;

/// Create a copy of Bateador
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BateadorCopyWith<_Bateador> get copyWith => __$BateadorCopyWithImpl<_Bateador>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BateadorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bateador&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.edad, edad) || other.edad == edad)&&(identical(other.posicion, posicion) || other.posicion == posicion)&&(identical(other.derechoZurdo, derechoZurdo) || other.derechoZurdo == derechoZurdo)&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombreEquipo, nombreEquipo) || other.nombreEquipo == nombreEquipo)&&(identical(other.agenteLibre, agenteLibre) || other.agenteLibre == agenteLibre)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.homeRuns, homeRuns) || other.homeRuns == homeRuns)&&(identical(other.triples, triples) || other.triples == triples)&&(identical(other.dobles, dobles) || other.dobles == dobles)&&(identical(other.sencillos, sencillos) || other.sencillos == sencillos)&&(identical(other.basePorBola, basePorBola) || other.basePorBola == basePorBola)&&(identical(other.basePorGolpe, basePorGolpe) || other.basePorGolpe == basePorGolpe)&&(identical(other.ponches, ponches) || other.ponches == ponches)&&(identical(other.roboDeBase, roboDeBase) || other.roboDeBase == roboDeBase)&&(identical(other.carrerasImpulsadas, carrerasImpulsadas) || other.carrerasImpulsadas == carrerasImpulsadas)&&(identical(other.errores, errores) || other.errores == errores)&&(identical(other.hits, hits) || other.hits == hits)&&(identical(other.extrabases, extrabases) || other.extrabases == extrabases)&&(identical(other.totalBases, totalBases) || other.totalBases == totalBases)&&(identical(other.vecesEmbasado, vecesEmbasado) || other.vecesEmbasado == vecesEmbasado)&&(identical(other.relacionBbK, relacionBbK) || other.relacionBbK == relacionBbK));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,nombre,edad,posicion,derechoZurdo,idEquipo,nombreEquipo,agenteLibre,urlFoto,homeRuns,triples,dobles,sencillos,basePorBola,basePorGolpe,ponches,roboDeBase,carrerasImpulsadas,errores,hits,extrabases,totalBases,vecesEmbasado,relacionBbK]);
}

@override
String toString() {
    return 'Bateador(id: $id, nombre: $nombre, edad: $edad, posicion: $posicion, derechoZurdo: $derechoZurdo, idEquipo: $idEquipo, nombreEquipo: $nombreEquipo, agenteLibre: $agenteLibre, urlFoto: $urlFoto, homeRuns: $homeRuns, triples: $triples, dobles: $dobles, sencillos: $sencillos, basePorBola: $basePorBola, basePorGolpe: $basePorGolpe, ponches: $ponches, roboDeBase: $roboDeBase, carrerasImpulsadas: $carrerasImpulsadas, errores: $errores, hits: $hits, extrabases: $extrabases, totalBases: $totalBases, vecesEmbasado: $vecesEmbasado, relacionBbK: $relacionBbK)';
}


}

/// @nodoc
abstract mixin class _$BateadorCopyWith<$Res> implements $BateadorCopyWith<$Res> {
  factory _$BateadorCopyWith(_Bateador value, $Res Function(_Bateador) _then) = __$BateadorCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombre, int edad, String? posicion, String? derechoZurdo, String? idEquipo, String? nombreEquipo, bool agenteLibre, String? urlFoto, int homeRuns, int triples, int dobles, int sencillos, int basePorBola, int basePorGolpe, int ponches, int roboDeBase, int carrerasImpulsadas, int errores, int hits, int extrabases, int totalBases, int vecesEmbasado, double? relacionBbK
});




}
/// @nodoc
class __$BateadorCopyWithImpl<$Res>
    implements _$BateadorCopyWith<$Res> {
  __$BateadorCopyWithImpl(this._self, this._then);

  final _Bateador _self;
  final $Res Function(_Bateador) _then;

/// Create a copy of Bateador
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? edad = null,Object? posicion = freezed,Object? derechoZurdo = freezed,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? agenteLibre = null,Object? urlFoto = freezed,Object? homeRuns = null,Object? triples = null,Object? dobles = null,Object? sencillos = null,Object? basePorBola = null,Object? basePorGolpe = null,Object? ponches = null,Object? roboDeBase = null,Object? carrerasImpulsadas = null,Object? errores = null,Object? hits = null,Object? extrabases = null,Object? totalBases = null,Object? vecesEmbasado = null,Object? relacionBbK = freezed,}) {
  return _then(_Bateador(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,edad: null == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int,posicion: freezed == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String?,derechoZurdo: freezed == derechoZurdo ? _self.derechoZurdo : derechoZurdo // ignore: cast_nullable_to_non_nullable
as String?,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,agenteLibre: null == agenteLibre ? _self.agenteLibre : agenteLibre // ignore: cast_nullable_to_non_nullable
as bool,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,homeRuns: null == homeRuns ? _self.homeRuns : homeRuns // ignore: cast_nullable_to_non_nullable
as int,triples: null == triples ? _self.triples : triples // ignore: cast_nullable_to_non_nullable
as int,dobles: null == dobles ? _self.dobles : dobles // ignore: cast_nullable_to_non_nullable
as int,sencillos: null == sencillos ? _self.sencillos : sencillos // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,basePorGolpe: null == basePorGolpe ? _self.basePorGolpe : basePorGolpe // ignore: cast_nullable_to_non_nullable
as int,ponches: null == ponches ? _self.ponches : ponches // ignore: cast_nullable_to_non_nullable
as int,roboDeBase: null == roboDeBase ? _self.roboDeBase : roboDeBase // ignore: cast_nullable_to_non_nullable
as int,carrerasImpulsadas: null == carrerasImpulsadas ? _self.carrerasImpulsadas : carrerasImpulsadas // ignore: cast_nullable_to_non_nullable
as int,errores: null == errores ? _self.errores : errores // ignore: cast_nullable_to_non_nullable
as int,hits: null == hits ? _self.hits : hits // ignore: cast_nullable_to_non_nullable
as int,extrabases: null == extrabases ? _self.extrabases : extrabases // ignore: cast_nullable_to_non_nullable
as int,totalBases: null == totalBases ? _self.totalBases : totalBases // ignore: cast_nullable_to_non_nullable
as int,vecesEmbasado: null == vecesEmbasado ? _self.vecesEmbasado : vecesEmbasado // ignore: cast_nullable_to_non_nullable
as int,relacionBbK: freezed == relacionBbK ? _self.relacionBbK : relacionBbK // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$Lanzador {

 String get id; String get nombre; int get edad; String? get posicion; String? get derechoZurdo; String? get idEquipo; String? get nombreEquipo; bool get agenteLibre; String? get urlFoto; int get numeroLanzamientos; int get inningsLanzados; int get ponchados; int get basePorBola; int get carrerasPermitidas; int get hitsPermitidos; int get aparicionesPlato; double? get era; double? get whip; double? get k9; double? get bb9; double? get kbb; double? get lanzamientosPorInning;
/// Create a copy of Lanzador
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanzadorCopyWith<Lanzador> get copyWith => _$LanzadorCopyWithImpl<Lanzador>(this as Lanzador, _$identity);

  /// Serializes this Lanzador to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Lanzador;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lanzador&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.edad, _this.edad) || other.edad == _this.edad)&&(identical(other.posicion, _this.posicion) || other.posicion == _this.posicion)&&(identical(other.derechoZurdo, _this.derechoZurdo) || other.derechoZurdo == _this.derechoZurdo)&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombreEquipo, _this.nombreEquipo) || other.nombreEquipo == _this.nombreEquipo)&&(identical(other.agenteLibre, _this.agenteLibre) || other.agenteLibre == _this.agenteLibre)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.numeroLanzamientos, _this.numeroLanzamientos) || other.numeroLanzamientos == _this.numeroLanzamientos)&&(identical(other.inningsLanzados, _this.inningsLanzados) || other.inningsLanzados == _this.inningsLanzados)&&(identical(other.ponchados, _this.ponchados) || other.ponchados == _this.ponchados)&&(identical(other.basePorBola, _this.basePorBola) || other.basePorBola == _this.basePorBola)&&(identical(other.carrerasPermitidas, _this.carrerasPermitidas) || other.carrerasPermitidas == _this.carrerasPermitidas)&&(identical(other.hitsPermitidos, _this.hitsPermitidos) || other.hitsPermitidos == _this.hitsPermitidos)&&(identical(other.aparicionesPlato, _this.aparicionesPlato) || other.aparicionesPlato == _this.aparicionesPlato)&&(identical(other.era, _this.era) || other.era == _this.era)&&(identical(other.whip, _this.whip) || other.whip == _this.whip)&&(identical(other.k9, _this.k9) || other.k9 == _this.k9)&&(identical(other.bb9, _this.bb9) || other.bb9 == _this.bb9)&&(identical(other.kbb, _this.kbb) || other.kbb == _this.kbb)&&(identical(other.lanzamientosPorInning, _this.lanzamientosPorInning) || other.lanzamientosPorInning == _this.lanzamientosPorInning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Lanzador;
  return Object.hashAll([runtimeType,_this.id,_this.nombre,_this.edad,_this.posicion,_this.derechoZurdo,_this.idEquipo,_this.nombreEquipo,_this.agenteLibre,_this.urlFoto,_this.numeroLanzamientos,_this.inningsLanzados,_this.ponchados,_this.basePorBola,_this.carrerasPermitidas,_this.hitsPermitidos,_this.aparicionesPlato,_this.era,_this.whip,_this.k9,_this.bb9,_this.kbb,_this.lanzamientosPorInning]);
}

@override
String toString() {
  final _this = this as Lanzador;
  return 'Lanzador(id: ${_this.id}, nombre: ${_this.nombre}, edad: ${_this.edad}, posicion: ${_this.posicion}, derechoZurdo: ${_this.derechoZurdo}, idEquipo: ${_this.idEquipo}, nombreEquipo: ${_this.nombreEquipo}, agenteLibre: ${_this.agenteLibre}, urlFoto: ${_this.urlFoto}, numeroLanzamientos: ${_this.numeroLanzamientos}, inningsLanzados: ${_this.inningsLanzados}, ponchados: ${_this.ponchados}, basePorBola: ${_this.basePorBola}, carrerasPermitidas: ${_this.carrerasPermitidas}, hitsPermitidos: ${_this.hitsPermitidos}, aparicionesPlato: ${_this.aparicionesPlato}, era: ${_this.era}, whip: ${_this.whip}, k9: ${_this.k9}, bb9: ${_this.bb9}, kbb: ${_this.kbb}, lanzamientosPorInning: ${_this.lanzamientosPorInning})';
}


}

/// @nodoc
abstract mixin class $LanzadorCopyWith<$Res>  {
  factory $LanzadorCopyWith(Lanzador value, $Res Function(Lanzador) _then) = _$LanzadorCopyWithImpl;
@useResult
$Res call({
 String id, String nombre, int edad, String? posicion, String? derechoZurdo, String? idEquipo, String? nombreEquipo, bool agenteLibre, String? urlFoto, int numeroLanzamientos, int inningsLanzados, int ponchados, int basePorBola, int carrerasPermitidas, int hitsPermitidos, int aparicionesPlato, double? era, double? whip, double? k9, double? bb9, double? kbb, double? lanzamientosPorInning
});




}
/// @nodoc
class _$LanzadorCopyWithImpl<$Res>
    implements $LanzadorCopyWith<$Res> {
  _$LanzadorCopyWithImpl(this._self, this._then);

  final Lanzador _self;
  final $Res Function(Lanzador) _then;

/// Create a copy of Lanzador
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? edad = null,Object? posicion = freezed,Object? derechoZurdo = freezed,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? agenteLibre = null,Object? urlFoto = freezed,Object? numeroLanzamientos = null,Object? inningsLanzados = null,Object? ponchados = null,Object? basePorBola = null,Object? carrerasPermitidas = null,Object? hitsPermitidos = null,Object? aparicionesPlato = null,Object? era = freezed,Object? whip = freezed,Object? k9 = freezed,Object? bb9 = freezed,Object? kbb = freezed,Object? lanzamientosPorInning = freezed,}) {
  return _then(Lanzador(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,edad: null == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int,posicion: freezed == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String?,derechoZurdo: freezed == derechoZurdo ? _self.derechoZurdo : derechoZurdo // ignore: cast_nullable_to_non_nullable
as String?,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,agenteLibre: null == agenteLibre ? _self.agenteLibre : agenteLibre // ignore: cast_nullable_to_non_nullable
as bool,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,numeroLanzamientos: null == numeroLanzamientos ? _self.numeroLanzamientos : numeroLanzamientos // ignore: cast_nullable_to_non_nullable
as int,inningsLanzados: null == inningsLanzados ? _self.inningsLanzados : inningsLanzados // ignore: cast_nullable_to_non_nullable
as int,ponchados: null == ponchados ? _self.ponchados : ponchados // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,carrerasPermitidas: null == carrerasPermitidas ? _self.carrerasPermitidas : carrerasPermitidas // ignore: cast_nullable_to_non_nullable
as int,hitsPermitidos: null == hitsPermitidos ? _self.hitsPermitidos : hitsPermitidos // ignore: cast_nullable_to_non_nullable
as int,aparicionesPlato: null == aparicionesPlato ? _self.aparicionesPlato : aparicionesPlato // ignore: cast_nullable_to_non_nullable
as int,era: freezed == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as double?,whip: freezed == whip ? _self.whip : whip // ignore: cast_nullable_to_non_nullable
as double?,k9: freezed == k9 ? _self.k9 : k9 // ignore: cast_nullable_to_non_nullable
as double?,bb9: freezed == bb9 ? _self.bb9 : bb9 // ignore: cast_nullable_to_non_nullable
as double?,kbb: freezed == kbb ? _self.kbb : kbb // ignore: cast_nullable_to_non_nullable
as double?,lanzamientosPorInning: freezed == lanzamientosPorInning ? _self.lanzamientosPorInning : lanzamientosPorInning // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Lanzador].
extension LanzadorPatterns on Lanzador {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lanzador value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lanzador() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lanzador value)  $default,){
final _that = this;
switch (_that) {
case _Lanzador():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lanzador value)?  $default,){
final _that = this;
switch (_that) {
case _Lanzador() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombre,  int edad,  String? posicion,  String? derechoZurdo,  String? idEquipo,  String? nombreEquipo,  bool agenteLibre,  String? urlFoto,  int numeroLanzamientos,  int inningsLanzados,  int ponchados,  int basePorBola,  int carrerasPermitidas,  int hitsPermitidos,  int aparicionesPlato,  double? era,  double? whip,  double? k9,  double? bb9,  double? kbb,  double? lanzamientosPorInning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lanzador() when $default != null:
return $default(_that.id,_that.nombre,_that.edad,_that.posicion,_that.derechoZurdo,_that.idEquipo,_that.nombreEquipo,_that.agenteLibre,_that.urlFoto,_that.numeroLanzamientos,_that.inningsLanzados,_that.ponchados,_that.basePorBola,_that.carrerasPermitidas,_that.hitsPermitidos,_that.aparicionesPlato,_that.era,_that.whip,_that.k9,_that.bb9,_that.kbb,_that.lanzamientosPorInning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombre,  int edad,  String? posicion,  String? derechoZurdo,  String? idEquipo,  String? nombreEquipo,  bool agenteLibre,  String? urlFoto,  int numeroLanzamientos,  int inningsLanzados,  int ponchados,  int basePorBola,  int carrerasPermitidas,  int hitsPermitidos,  int aparicionesPlato,  double? era,  double? whip,  double? k9,  double? bb9,  double? kbb,  double? lanzamientosPorInning)  $default,) {final _that = this;
switch (_that) {
case _Lanzador():
return $default(_that.id,_that.nombre,_that.edad,_that.posicion,_that.derechoZurdo,_that.idEquipo,_that.nombreEquipo,_that.agenteLibre,_that.urlFoto,_that.numeroLanzamientos,_that.inningsLanzados,_that.ponchados,_that.basePorBola,_that.carrerasPermitidas,_that.hitsPermitidos,_that.aparicionesPlato,_that.era,_that.whip,_that.k9,_that.bb9,_that.kbb,_that.lanzamientosPorInning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombre,  int edad,  String? posicion,  String? derechoZurdo,  String? idEquipo,  String? nombreEquipo,  bool agenteLibre,  String? urlFoto,  int numeroLanzamientos,  int inningsLanzados,  int ponchados,  int basePorBola,  int carrerasPermitidas,  int hitsPermitidos,  int aparicionesPlato,  double? era,  double? whip,  double? k9,  double? bb9,  double? kbb,  double? lanzamientosPorInning)?  $default,) {final _that = this;
switch (_that) {
case _Lanzador() when $default != null:
return $default(_that.id,_that.nombre,_that.edad,_that.posicion,_that.derechoZurdo,_that.idEquipo,_that.nombreEquipo,_that.agenteLibre,_that.urlFoto,_that.numeroLanzamientos,_that.inningsLanzados,_that.ponchados,_that.basePorBola,_that.carrerasPermitidas,_that.hitsPermitidos,_that.aparicionesPlato,_that.era,_that.whip,_that.k9,_that.bb9,_that.kbb,_that.lanzamientosPorInning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lanzador implements Lanzador {
  const _Lanzador({required this.id, required this.nombre, this.edad = 0, this.posicion, this.derechoZurdo, this.idEquipo, this.nombreEquipo, this.agenteLibre = false, this.urlFoto, this.numeroLanzamientos = 0, this.inningsLanzados = 0, this.ponchados = 0, this.basePorBola = 0, this.carrerasPermitidas = 0, this.hitsPermitidos = 0, this.aparicionesPlato = 0, this.era, this.whip, this.k9, this.bb9, this.kbb, this.lanzamientosPorInning});
  factory _Lanzador.fromJson(Map<String, dynamic> json) => _$LanzadorFromJson(json);

@override final  String id;
@override final  String nombre;
@override@JsonKey() final  int edad;
@override final  String? posicion;
@override final  String? derechoZurdo;
@override final  String? idEquipo;
@override final  String? nombreEquipo;
@override@JsonKey() final  bool agenteLibre;
@override final  String? urlFoto;
@override@JsonKey() final  int numeroLanzamientos;
@override@JsonKey() final  int inningsLanzados;
@override@JsonKey() final  int ponchados;
@override@JsonKey() final  int basePorBola;
@override@JsonKey() final  int carrerasPermitidas;
@override@JsonKey() final  int hitsPermitidos;
@override@JsonKey() final  int aparicionesPlato;
@override final  double? era;
@override final  double? whip;
@override final  double? k9;
@override final  double? bb9;
@override final  double? kbb;
@override final  double? lanzamientosPorInning;

/// Create a copy of Lanzador
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanzadorCopyWith<_Lanzador> get copyWith => __$LanzadorCopyWithImpl<_Lanzador>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanzadorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lanzador&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.edad, edad) || other.edad == edad)&&(identical(other.posicion, posicion) || other.posicion == posicion)&&(identical(other.derechoZurdo, derechoZurdo) || other.derechoZurdo == derechoZurdo)&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombreEquipo, nombreEquipo) || other.nombreEquipo == nombreEquipo)&&(identical(other.agenteLibre, agenteLibre) || other.agenteLibre == agenteLibre)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.numeroLanzamientos, numeroLanzamientos) || other.numeroLanzamientos == numeroLanzamientos)&&(identical(other.inningsLanzados, inningsLanzados) || other.inningsLanzados == inningsLanzados)&&(identical(other.ponchados, ponchados) || other.ponchados == ponchados)&&(identical(other.basePorBola, basePorBola) || other.basePorBola == basePorBola)&&(identical(other.carrerasPermitidas, carrerasPermitidas) || other.carrerasPermitidas == carrerasPermitidas)&&(identical(other.hitsPermitidos, hitsPermitidos) || other.hitsPermitidos == hitsPermitidos)&&(identical(other.aparicionesPlato, aparicionesPlato) || other.aparicionesPlato == aparicionesPlato)&&(identical(other.era, era) || other.era == era)&&(identical(other.whip, whip) || other.whip == whip)&&(identical(other.k9, k9) || other.k9 == k9)&&(identical(other.bb9, bb9) || other.bb9 == bb9)&&(identical(other.kbb, kbb) || other.kbb == kbb)&&(identical(other.lanzamientosPorInning, lanzamientosPorInning) || other.lanzamientosPorInning == lanzamientosPorInning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,nombre,edad,posicion,derechoZurdo,idEquipo,nombreEquipo,agenteLibre,urlFoto,numeroLanzamientos,inningsLanzados,ponchados,basePorBola,carrerasPermitidas,hitsPermitidos,aparicionesPlato,era,whip,k9,bb9,kbb,lanzamientosPorInning]);
}

@override
String toString() {
    return 'Lanzador(id: $id, nombre: $nombre, edad: $edad, posicion: $posicion, derechoZurdo: $derechoZurdo, idEquipo: $idEquipo, nombreEquipo: $nombreEquipo, agenteLibre: $agenteLibre, urlFoto: $urlFoto, numeroLanzamientos: $numeroLanzamientos, inningsLanzados: $inningsLanzados, ponchados: $ponchados, basePorBola: $basePorBola, carrerasPermitidas: $carrerasPermitidas, hitsPermitidos: $hitsPermitidos, aparicionesPlato: $aparicionesPlato, era: $era, whip: $whip, k9: $k9, bb9: $bb9, kbb: $kbb, lanzamientosPorInning: $lanzamientosPorInning)';
}


}

/// @nodoc
abstract mixin class _$LanzadorCopyWith<$Res> implements $LanzadorCopyWith<$Res> {
  factory _$LanzadorCopyWith(_Lanzador value, $Res Function(_Lanzador) _then) = __$LanzadorCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombre, int edad, String? posicion, String? derechoZurdo, String? idEquipo, String? nombreEquipo, bool agenteLibre, String? urlFoto, int numeroLanzamientos, int inningsLanzados, int ponchados, int basePorBola, int carrerasPermitidas, int hitsPermitidos, int aparicionesPlato, double? era, double? whip, double? k9, double? bb9, double? kbb, double? lanzamientosPorInning
});




}
/// @nodoc
class __$LanzadorCopyWithImpl<$Res>
    implements _$LanzadorCopyWith<$Res> {
  __$LanzadorCopyWithImpl(this._self, this._then);

  final _Lanzador _self;
  final $Res Function(_Lanzador) _then;

/// Create a copy of Lanzador
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? edad = null,Object? posicion = freezed,Object? derechoZurdo = freezed,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? agenteLibre = null,Object? urlFoto = freezed,Object? numeroLanzamientos = null,Object? inningsLanzados = null,Object? ponchados = null,Object? basePorBola = null,Object? carrerasPermitidas = null,Object? hitsPermitidos = null,Object? aparicionesPlato = null,Object? era = freezed,Object? whip = freezed,Object? k9 = freezed,Object? bb9 = freezed,Object? kbb = freezed,Object? lanzamientosPorInning = freezed,}) {
  return _then(_Lanzador(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,edad: null == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int,posicion: freezed == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as String?,derechoZurdo: freezed == derechoZurdo ? _self.derechoZurdo : derechoZurdo // ignore: cast_nullable_to_non_nullable
as String?,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,agenteLibre: null == agenteLibre ? _self.agenteLibre : agenteLibre // ignore: cast_nullable_to_non_nullable
as bool,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,numeroLanzamientos: null == numeroLanzamientos ? _self.numeroLanzamientos : numeroLanzamientos // ignore: cast_nullable_to_non_nullable
as int,inningsLanzados: null == inningsLanzados ? _self.inningsLanzados : inningsLanzados // ignore: cast_nullable_to_non_nullable
as int,ponchados: null == ponchados ? _self.ponchados : ponchados // ignore: cast_nullable_to_non_nullable
as int,basePorBola: null == basePorBola ? _self.basePorBola : basePorBola // ignore: cast_nullable_to_non_nullable
as int,carrerasPermitidas: null == carrerasPermitidas ? _self.carrerasPermitidas : carrerasPermitidas // ignore: cast_nullable_to_non_nullable
as int,hitsPermitidos: null == hitsPermitidos ? _self.hitsPermitidos : hitsPermitidos // ignore: cast_nullable_to_non_nullable
as int,aparicionesPlato: null == aparicionesPlato ? _self.aparicionesPlato : aparicionesPlato // ignore: cast_nullable_to_non_nullable
as int,era: freezed == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as double?,whip: freezed == whip ? _self.whip : whip // ignore: cast_nullable_to_non_nullable
as double?,k9: freezed == k9 ? _self.k9 : k9 // ignore: cast_nullable_to_non_nullable
as double?,bb9: freezed == bb9 ? _self.bb9 : bb9 // ignore: cast_nullable_to_non_nullable
as double?,kbb: freezed == kbb ? _self.kbb : kbb // ignore: cast_nullable_to_non_nullable
as double?,lanzamientosPorInning: freezed == lanzamientosPorInning ? _self.lanzamientosPorInning : lanzamientosPorInning // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$BateadorPerfil {

 Bateador get jugador; Map<String, Referencia> get referenciaLiga;
/// Create a copy of BateadorPerfil
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BateadorPerfilCopyWith<BateadorPerfil> get copyWith => _$BateadorPerfilCopyWithImpl<BateadorPerfil>(this as BateadorPerfil, _$identity);

  /// Serializes this BateadorPerfil to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BateadorPerfil;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BateadorPerfil&&(identical(other.jugador, _this.jugador) || other.jugador == _this.jugador)&&const DeepCollectionEquality().equals(other.referenciaLiga, _this.referenciaLiga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BateadorPerfil;
  return Object.hash(runtimeType,_this.jugador,const DeepCollectionEquality().hash(_this.referenciaLiga));
}

@override
String toString() {
  final _this = this as BateadorPerfil;
  return 'BateadorPerfil(jugador: ${_this.jugador}, referenciaLiga: ${_this.referenciaLiga})';
}


}

/// @nodoc
abstract mixin class $BateadorPerfilCopyWith<$Res>  {
  factory $BateadorPerfilCopyWith(BateadorPerfil value, $Res Function(BateadorPerfil) _then) = _$BateadorPerfilCopyWithImpl;
@useResult
$Res call({
 Bateador jugador, Map<String, Referencia> referenciaLiga
});


$BateadorCopyWith<$Res> get jugador;

}
/// @nodoc
class _$BateadorPerfilCopyWithImpl<$Res>
    implements $BateadorPerfilCopyWith<$Res> {
  _$BateadorPerfilCopyWithImpl(this._self, this._then);

  final BateadorPerfil _self;
  final $Res Function(BateadorPerfil) _then;

/// Create a copy of BateadorPerfil
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jugador = null,Object? referenciaLiga = null,}) {
  return _then(BateadorPerfil(
jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as Bateador,referenciaLiga: null == referenciaLiga ? _self.referenciaLiga : referenciaLiga // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,
  ));
}
/// Create a copy of BateadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BateadorCopyWith<$Res> get jugador {
  
  return $BateadorCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}
}


/// Adds pattern-matching-related methods to [BateadorPerfil].
extension BateadorPerfilPatterns on BateadorPerfil {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BateadorPerfil value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BateadorPerfil() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BateadorPerfil value)  $default,){
final _that = this;
switch (_that) {
case _BateadorPerfil():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BateadorPerfil value)?  $default,){
final _that = this;
switch (_that) {
case _BateadorPerfil() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Bateador jugador,  Map<String, Referencia> referenciaLiga)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BateadorPerfil() when $default != null:
return $default(_that.jugador,_that.referenciaLiga);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Bateador jugador,  Map<String, Referencia> referenciaLiga)  $default,) {final _that = this;
switch (_that) {
case _BateadorPerfil():
return $default(_that.jugador,_that.referenciaLiga);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Bateador jugador,  Map<String, Referencia> referenciaLiga)?  $default,) {final _that = this;
switch (_that) {
case _BateadorPerfil() when $default != null:
return $default(_that.jugador,_that.referenciaLiga);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BateadorPerfil implements BateadorPerfil {
  const _BateadorPerfil({required this.jugador,  Map<String, Referencia> referenciaLiga = const <String, Referencia>{}}): _referenciaLiga = referenciaLiga;
  factory _BateadorPerfil.fromJson(Map<String, dynamic> json) => _$BateadorPerfilFromJson(json);

@override final  Bateador jugador;
 final  Map<String, Referencia> _referenciaLiga;
@override@JsonKey() Map<String, Referencia> get referenciaLiga {
  if (_referenciaLiga is EqualUnmodifiableMapView) return _referenciaLiga;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_referenciaLiga);
}


/// Create a copy of BateadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BateadorPerfilCopyWith<_BateadorPerfil> get copyWith => __$BateadorPerfilCopyWithImpl<_BateadorPerfil>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BateadorPerfilToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BateadorPerfil&&(identical(other.jugador, jugador) || other.jugador == jugador)&&const DeepCollectionEquality().equals(other.referenciaLiga, _referenciaLiga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,jugador,const DeepCollectionEquality().hash(_referenciaLiga));
}

@override
String toString() {
    return 'BateadorPerfil(jugador: $jugador, referenciaLiga: $referenciaLiga)';
}


}

/// @nodoc
abstract mixin class _$BateadorPerfilCopyWith<$Res> implements $BateadorPerfilCopyWith<$Res> {
  factory _$BateadorPerfilCopyWith(_BateadorPerfil value, $Res Function(_BateadorPerfil) _then) = __$BateadorPerfilCopyWithImpl;
@override @useResult
$Res call({
 Bateador jugador, Map<String, Referencia> referenciaLiga
});


@override $BateadorCopyWith<$Res> get jugador;

}
/// @nodoc
class __$BateadorPerfilCopyWithImpl<$Res>
    implements _$BateadorPerfilCopyWith<$Res> {
  __$BateadorPerfilCopyWithImpl(this._self, this._then);

  final _BateadorPerfil _self;
  final $Res Function(_BateadorPerfil) _then;

/// Create a copy of BateadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jugador = null,Object? referenciaLiga = null,}) {
  return _then(_BateadorPerfil(
jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as Bateador,referenciaLiga: null == referenciaLiga ? _self._referenciaLiga : referenciaLiga // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,
  ));
}

/// Create a copy of BateadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BateadorCopyWith<$Res> get jugador {
  
  return $BateadorCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}
}


/// @nodoc
mixin _$LanzadorPerfil {

 Lanzador get jugador; Map<String, Referencia> get referenciaLiga;
/// Create a copy of LanzadorPerfil
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanzadorPerfilCopyWith<LanzadorPerfil> get copyWith => _$LanzadorPerfilCopyWithImpl<LanzadorPerfil>(this as LanzadorPerfil, _$identity);

  /// Serializes this LanzadorPerfil to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LanzadorPerfil;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanzadorPerfil&&(identical(other.jugador, _this.jugador) || other.jugador == _this.jugador)&&const DeepCollectionEquality().equals(other.referenciaLiga, _this.referenciaLiga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LanzadorPerfil;
  return Object.hash(runtimeType,_this.jugador,const DeepCollectionEquality().hash(_this.referenciaLiga));
}

@override
String toString() {
  final _this = this as LanzadorPerfil;
  return 'LanzadorPerfil(jugador: ${_this.jugador}, referenciaLiga: ${_this.referenciaLiga})';
}


}

/// @nodoc
abstract mixin class $LanzadorPerfilCopyWith<$Res>  {
  factory $LanzadorPerfilCopyWith(LanzadorPerfil value, $Res Function(LanzadorPerfil) _then) = _$LanzadorPerfilCopyWithImpl;
@useResult
$Res call({
 Lanzador jugador, Map<String, Referencia> referenciaLiga
});


$LanzadorCopyWith<$Res> get jugador;

}
/// @nodoc
class _$LanzadorPerfilCopyWithImpl<$Res>
    implements $LanzadorPerfilCopyWith<$Res> {
  _$LanzadorPerfilCopyWithImpl(this._self, this._then);

  final LanzadorPerfil _self;
  final $Res Function(LanzadorPerfil) _then;

/// Create a copy of LanzadorPerfil
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jugador = null,Object? referenciaLiga = null,}) {
  return _then(LanzadorPerfil(
jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as Lanzador,referenciaLiga: null == referenciaLiga ? _self.referenciaLiga : referenciaLiga // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,
  ));
}
/// Create a copy of LanzadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LanzadorCopyWith<$Res> get jugador {
  
  return $LanzadorCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}
}


/// Adds pattern-matching-related methods to [LanzadorPerfil].
extension LanzadorPerfilPatterns on LanzadorPerfil {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanzadorPerfil value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanzadorPerfil() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanzadorPerfil value)  $default,){
final _that = this;
switch (_that) {
case _LanzadorPerfil():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanzadorPerfil value)?  $default,){
final _that = this;
switch (_that) {
case _LanzadorPerfil() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Lanzador jugador,  Map<String, Referencia> referenciaLiga)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanzadorPerfil() when $default != null:
return $default(_that.jugador,_that.referenciaLiga);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Lanzador jugador,  Map<String, Referencia> referenciaLiga)  $default,) {final _that = this;
switch (_that) {
case _LanzadorPerfil():
return $default(_that.jugador,_that.referenciaLiga);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Lanzador jugador,  Map<String, Referencia> referenciaLiga)?  $default,) {final _that = this;
switch (_that) {
case _LanzadorPerfil() when $default != null:
return $default(_that.jugador,_that.referenciaLiga);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LanzadorPerfil implements LanzadorPerfil {
  const _LanzadorPerfil({required this.jugador,  Map<String, Referencia> referenciaLiga = const <String, Referencia>{}}): _referenciaLiga = referenciaLiga;
  factory _LanzadorPerfil.fromJson(Map<String, dynamic> json) => _$LanzadorPerfilFromJson(json);

@override final  Lanzador jugador;
 final  Map<String, Referencia> _referenciaLiga;
@override@JsonKey() Map<String, Referencia> get referenciaLiga {
  if (_referenciaLiga is EqualUnmodifiableMapView) return _referenciaLiga;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_referenciaLiga);
}


/// Create a copy of LanzadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanzadorPerfilCopyWith<_LanzadorPerfil> get copyWith => __$LanzadorPerfilCopyWithImpl<_LanzadorPerfil>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanzadorPerfilToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanzadorPerfil&&(identical(other.jugador, jugador) || other.jugador == jugador)&&const DeepCollectionEquality().equals(other.referenciaLiga, _referenciaLiga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,jugador,const DeepCollectionEquality().hash(_referenciaLiga));
}

@override
String toString() {
    return 'LanzadorPerfil(jugador: $jugador, referenciaLiga: $referenciaLiga)';
}


}

/// @nodoc
abstract mixin class _$LanzadorPerfilCopyWith<$Res> implements $LanzadorPerfilCopyWith<$Res> {
  factory _$LanzadorPerfilCopyWith(_LanzadorPerfil value, $Res Function(_LanzadorPerfil) _then) = __$LanzadorPerfilCopyWithImpl;
@override @useResult
$Res call({
 Lanzador jugador, Map<String, Referencia> referenciaLiga
});


@override $LanzadorCopyWith<$Res> get jugador;

}
/// @nodoc
class __$LanzadorPerfilCopyWithImpl<$Res>
    implements _$LanzadorPerfilCopyWith<$Res> {
  __$LanzadorPerfilCopyWithImpl(this._self, this._then);

  final _LanzadorPerfil _self;
  final $Res Function(_LanzadorPerfil) _then;

/// Create a copy of LanzadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jugador = null,Object? referenciaLiga = null,}) {
  return _then(_LanzadorPerfil(
jugador: null == jugador ? _self.jugador : jugador // ignore: cast_nullable_to_non_nullable
as Lanzador,referenciaLiga: null == referenciaLiga ? _self._referenciaLiga : referenciaLiga // ignore: cast_nullable_to_non_nullable
as Map<String, Referencia>,
  ));
}

/// Create a copy of LanzadorPerfil
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LanzadorCopyWith<$Res> get jugador {
  
  return $LanzadorCopyWith<$Res>(_self.jugador, (value) {
    return _then(_self.copyWith(jugador: value));
  });
}
}


/// @nodoc
mixin _$AgentesLibres {

 String? get idEquipo; List<Bateador> get bateadores; List<Lanzador> get lanzadores;
/// Create a copy of AgentesLibres
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentesLibresCopyWith<AgentesLibres> get copyWith => _$AgentesLibresCopyWithImpl<AgentesLibres>(this as AgentesLibres, _$identity);

  /// Serializes this AgentesLibres to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AgentesLibres;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentesLibres&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&const DeepCollectionEquality().equals(other.bateadores, _this.bateadores)&&const DeepCollectionEquality().equals(other.lanzadores, _this.lanzadores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AgentesLibres;
  return Object.hash(runtimeType,_this.idEquipo,const DeepCollectionEquality().hash(_this.bateadores),const DeepCollectionEquality().hash(_this.lanzadores));
}

@override
String toString() {
  final _this = this as AgentesLibres;
  return 'AgentesLibres(idEquipo: ${_this.idEquipo}, bateadores: ${_this.bateadores}, lanzadores: ${_this.lanzadores})';
}


}

/// @nodoc
abstract mixin class $AgentesLibresCopyWith<$Res>  {
  factory $AgentesLibresCopyWith(AgentesLibres value, $Res Function(AgentesLibres) _then) = _$AgentesLibresCopyWithImpl;
@useResult
$Res call({
 String? idEquipo, List<Bateador> bateadores, List<Lanzador> lanzadores
});




}
/// @nodoc
class _$AgentesLibresCopyWithImpl<$Res>
    implements $AgentesLibresCopyWith<$Res> {
  _$AgentesLibresCopyWithImpl(this._self, this._then);

  final AgentesLibres _self;
  final $Res Function(AgentesLibres) _then;

/// Create a copy of AgentesLibres
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idEquipo = freezed,Object? bateadores = null,Object? lanzadores = null,}) {
  return _then(AgentesLibres(
idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,bateadores: null == bateadores ? _self.bateadores : bateadores // ignore: cast_nullable_to_non_nullable
as List<Bateador>,lanzadores: null == lanzadores ? _self.lanzadores : lanzadores // ignore: cast_nullable_to_non_nullable
as List<Lanzador>,
  ));
}

}


/// Adds pattern-matching-related methods to [AgentesLibres].
extension AgentesLibresPatterns on AgentesLibres {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgentesLibres value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgentesLibres() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgentesLibres value)  $default,){
final _that = this;
switch (_that) {
case _AgentesLibres():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgentesLibres value)?  $default,){
final _that = this;
switch (_that) {
case _AgentesLibres() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? idEquipo,  List<Bateador> bateadores,  List<Lanzador> lanzadores)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgentesLibres() when $default != null:
return $default(_that.idEquipo,_that.bateadores,_that.lanzadores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? idEquipo,  List<Bateador> bateadores,  List<Lanzador> lanzadores)  $default,) {final _that = this;
switch (_that) {
case _AgentesLibres():
return $default(_that.idEquipo,_that.bateadores,_that.lanzadores);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? idEquipo,  List<Bateador> bateadores,  List<Lanzador> lanzadores)?  $default,) {final _that = this;
switch (_that) {
case _AgentesLibres() when $default != null:
return $default(_that.idEquipo,_that.bateadores,_that.lanzadores);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgentesLibres implements AgentesLibres {
  const _AgentesLibres({this.idEquipo,  List<Bateador> bateadores = const <Bateador>[],  List<Lanzador> lanzadores = const <Lanzador>[]}): _bateadores = bateadores,_lanzadores = lanzadores;
  factory _AgentesLibres.fromJson(Map<String, dynamic> json) => _$AgentesLibresFromJson(json);

@override final  String? idEquipo;
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


/// Create a copy of AgentesLibres
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgentesLibresCopyWith<_AgentesLibres> get copyWith => __$AgentesLibresCopyWithImpl<_AgentesLibres>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgentesLibresToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgentesLibres&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&const DeepCollectionEquality().equals(other.bateadores, _bateadores)&&const DeepCollectionEquality().equals(other.lanzadores, _lanzadores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idEquipo,const DeepCollectionEquality().hash(_bateadores),const DeepCollectionEquality().hash(_lanzadores));
}

@override
String toString() {
    return 'AgentesLibres(idEquipo: $idEquipo, bateadores: $bateadores, lanzadores: $lanzadores)';
}


}

/// @nodoc
abstract mixin class _$AgentesLibresCopyWith<$Res> implements $AgentesLibresCopyWith<$Res> {
  factory _$AgentesLibresCopyWith(_AgentesLibres value, $Res Function(_AgentesLibres) _then) = __$AgentesLibresCopyWithImpl;
@override @useResult
$Res call({
 String? idEquipo, List<Bateador> bateadores, List<Lanzador> lanzadores
});




}
/// @nodoc
class __$AgentesLibresCopyWithImpl<$Res>
    implements _$AgentesLibresCopyWith<$Res> {
  __$AgentesLibresCopyWithImpl(this._self, this._then);

  final _AgentesLibres _self;
  final $Res Function(_AgentesLibres) _then;

/// Create a copy of AgentesLibres
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idEquipo = freezed,Object? bateadores = null,Object? lanzadores = null,}) {
  return _then(_AgentesLibres(
idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,bateadores: null == bateadores ? _self._bateadores : bateadores // ignore: cast_nullable_to_non_nullable
as List<Bateador>,lanzadores: null == lanzadores ? _self._lanzadores : lanzadores // ignore: cast_nullable_to_non_nullable
as List<Lanzador>,
  ));
}


}


/// @nodoc
mixin _$Lider {

 int get posicion; String get idJugador; String get nombre; String? get idEquipo; String? get nombreEquipo; String? get urlFoto; double get valor;
/// Create a copy of Lider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiderCopyWith<Lider> get copyWith => _$LiderCopyWithImpl<Lider>(this as Lider, _$identity);

  /// Serializes this Lider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Lider;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lider&&(identical(other.posicion, _this.posicion) || other.posicion == _this.posicion)&&(identical(other.idJugador, _this.idJugador) || other.idJugador == _this.idJugador)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.idEquipo, _this.idEquipo) || other.idEquipo == _this.idEquipo)&&(identical(other.nombreEquipo, _this.nombreEquipo) || other.nombreEquipo == _this.nombreEquipo)&&(identical(other.urlFoto, _this.urlFoto) || other.urlFoto == _this.urlFoto)&&(identical(other.valor, _this.valor) || other.valor == _this.valor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Lider;
  return Object.hash(runtimeType,_this.posicion,_this.idJugador,_this.nombre,_this.idEquipo,_this.nombreEquipo,_this.urlFoto,_this.valor);
}

@override
String toString() {
  final _this = this as Lider;
  return 'Lider(posicion: ${_this.posicion}, idJugador: ${_this.idJugador}, nombre: ${_this.nombre}, idEquipo: ${_this.idEquipo}, nombreEquipo: ${_this.nombreEquipo}, urlFoto: ${_this.urlFoto}, valor: ${_this.valor})';
}


}

/// @nodoc
abstract mixin class $LiderCopyWith<$Res>  {
  factory $LiderCopyWith(Lider value, $Res Function(Lider) _then) = _$LiderCopyWithImpl;
@useResult
$Res call({
 int posicion, String idJugador, String nombre, String? idEquipo, String? nombreEquipo, String? urlFoto, double valor
});




}
/// @nodoc
class _$LiderCopyWithImpl<$Res>
    implements $LiderCopyWith<$Res> {
  _$LiderCopyWithImpl(this._self, this._then);

  final Lider _self;
  final $Res Function(Lider) _then;

/// Create a copy of Lider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posicion = null,Object? idJugador = null,Object? nombre = null,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? urlFoto = freezed,Object? valor = null,}) {
  return _then(Lider(
posicion: null == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as int,idJugador: null == idJugador ? _self.idJugador : idJugador // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,idEquipo: freezed == idEquipo ? _self.idEquipo : idEquipo // ignore: cast_nullable_to_non_nullable
as String?,nombreEquipo: freezed == nombreEquipo ? _self.nombreEquipo : nombreEquipo // ignore: cast_nullable_to_non_nullable
as String?,urlFoto: freezed == urlFoto ? _self.urlFoto : urlFoto // ignore: cast_nullable_to_non_nullable
as String?,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Lider].
extension LiderPatterns on Lider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lider value)  $default,){
final _that = this;
switch (_that) {
case _Lider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lider value)?  $default,){
final _that = this;
switch (_that) {
case _Lider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int posicion,  String idJugador,  String nombre,  String? idEquipo,  String? nombreEquipo,  String? urlFoto,  double valor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lider() when $default != null:
return $default(_that.posicion,_that.idJugador,_that.nombre,_that.idEquipo,_that.nombreEquipo,_that.urlFoto,_that.valor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int posicion,  String idJugador,  String nombre,  String? idEquipo,  String? nombreEquipo,  String? urlFoto,  double valor)  $default,) {final _that = this;
switch (_that) {
case _Lider():
return $default(_that.posicion,_that.idJugador,_that.nombre,_that.idEquipo,_that.nombreEquipo,_that.urlFoto,_that.valor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int posicion,  String idJugador,  String nombre,  String? idEquipo,  String? nombreEquipo,  String? urlFoto,  double valor)?  $default,) {final _that = this;
switch (_that) {
case _Lider() when $default != null:
return $default(_that.posicion,_that.idJugador,_that.nombre,_that.idEquipo,_that.nombreEquipo,_that.urlFoto,_that.valor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lider implements Lider {
  const _Lider({required this.posicion, required this.idJugador, required this.nombre, this.idEquipo, this.nombreEquipo, this.urlFoto, required this.valor});
  factory _Lider.fromJson(Map<String, dynamic> json) => _$LiderFromJson(json);

@override final  int posicion;
@override final  String idJugador;
@override final  String nombre;
@override final  String? idEquipo;
@override final  String? nombreEquipo;
@override final  String? urlFoto;
@override final  double valor;

/// Create a copy of Lider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiderCopyWith<_Lider> get copyWith => __$LiderCopyWithImpl<_Lider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lider&&(identical(other.posicion, posicion) || other.posicion == posicion)&&(identical(other.idJugador, idJugador) || other.idJugador == idJugador)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.idEquipo, idEquipo) || other.idEquipo == idEquipo)&&(identical(other.nombreEquipo, nombreEquipo) || other.nombreEquipo == nombreEquipo)&&(identical(other.urlFoto, urlFoto) || other.urlFoto == urlFoto)&&(identical(other.valor, valor) || other.valor == valor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,posicion,idJugador,nombre,idEquipo,nombreEquipo,urlFoto,valor);
}

@override
String toString() {
    return 'Lider(posicion: $posicion, idJugador: $idJugador, nombre: $nombre, idEquipo: $idEquipo, nombreEquipo: $nombreEquipo, urlFoto: $urlFoto, valor: $valor)';
}


}

/// @nodoc
abstract mixin class _$LiderCopyWith<$Res> implements $LiderCopyWith<$Res> {
  factory _$LiderCopyWith(_Lider value, $Res Function(_Lider) _then) = __$LiderCopyWithImpl;
@override @useResult
$Res call({
 int posicion, String idJugador, String nombre, String? idEquipo, String? nombreEquipo, String? urlFoto, double valor
});




}
/// @nodoc
class __$LiderCopyWithImpl<$Res>
    implements _$LiderCopyWith<$Res> {
  __$LiderCopyWithImpl(this._self, this._then);

  final _Lider _self;
  final $Res Function(_Lider) _then;

/// Create a copy of Lider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posicion = null,Object? idJugador = null,Object? nombre = null,Object? idEquipo = freezed,Object? nombreEquipo = freezed,Object? urlFoto = freezed,Object? valor = null,}) {
  return _then(_Lider(
posicion: null == posicion ? _self.posicion : posicion // ignore: cast_nullable_to_non_nullable
as int,idJugador: null == idJugador ? _self.idJugador : idJugador // ignore: cast_nullable_to_non_nullable
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
mixin _$Lideres {

 String get tipo; String get estadistica; bool get menorEsMejor; List<Lider> get lideres; List<String> get estadisticasDisponibles;
/// Create a copy of Lideres
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LideresCopyWith<Lideres> get copyWith => _$LideresCopyWithImpl<Lideres>(this as Lideres, _$identity);

  /// Serializes this Lideres to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Lideres;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lideres&&(identical(other.tipo, _this.tipo) || other.tipo == _this.tipo)&&(identical(other.estadistica, _this.estadistica) || other.estadistica == _this.estadistica)&&(identical(other.menorEsMejor, _this.menorEsMejor) || other.menorEsMejor == _this.menorEsMejor)&&const DeepCollectionEquality().equals(other.lideres, _this.lideres)&&const DeepCollectionEquality().equals(other.estadisticasDisponibles, _this.estadisticasDisponibles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Lideres;
  return Object.hash(runtimeType,_this.tipo,_this.estadistica,_this.menorEsMejor,const DeepCollectionEquality().hash(_this.lideres),const DeepCollectionEquality().hash(_this.estadisticasDisponibles));
}

@override
String toString() {
  final _this = this as Lideres;
  return 'Lideres(tipo: ${_this.tipo}, estadistica: ${_this.estadistica}, menorEsMejor: ${_this.menorEsMejor}, lideres: ${_this.lideres}, estadisticasDisponibles: ${_this.estadisticasDisponibles})';
}


}

/// @nodoc
abstract mixin class $LideresCopyWith<$Res>  {
  factory $LideresCopyWith(Lideres value, $Res Function(Lideres) _then) = _$LideresCopyWithImpl;
@useResult
$Res call({
 String tipo, String estadistica, bool menorEsMejor, List<Lider> lideres, List<String> estadisticasDisponibles
});




}
/// @nodoc
class _$LideresCopyWithImpl<$Res>
    implements $LideresCopyWith<$Res> {
  _$LideresCopyWithImpl(this._self, this._then);

  final Lideres _self;
  final $Res Function(Lideres) _then;

/// Create a copy of Lideres
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tipo = null,Object? estadistica = null,Object? menorEsMejor = null,Object? lideres = null,Object? estadisticasDisponibles = null,}) {
  return _then(Lideres(
tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,estadistica: null == estadistica ? _self.estadistica : estadistica // ignore: cast_nullable_to_non_nullable
as String,menorEsMejor: null == menorEsMejor ? _self.menorEsMejor : menorEsMejor // ignore: cast_nullable_to_non_nullable
as bool,lideres: null == lideres ? _self.lideres : lideres // ignore: cast_nullable_to_non_nullable
as List<Lider>,estadisticasDisponibles: null == estadisticasDisponibles ? _self.estadisticasDisponibles : estadisticasDisponibles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Lideres].
extension LideresPatterns on Lideres {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lideres value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lideres() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lideres value)  $default,){
final _that = this;
switch (_that) {
case _Lideres():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lideres value)?  $default,){
final _that = this;
switch (_that) {
case _Lideres() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tipo,  String estadistica,  bool menorEsMejor,  List<Lider> lideres,  List<String> estadisticasDisponibles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lideres() when $default != null:
return $default(_that.tipo,_that.estadistica,_that.menorEsMejor,_that.lideres,_that.estadisticasDisponibles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tipo,  String estadistica,  bool menorEsMejor,  List<Lider> lideres,  List<String> estadisticasDisponibles)  $default,) {final _that = this;
switch (_that) {
case _Lideres():
return $default(_that.tipo,_that.estadistica,_that.menorEsMejor,_that.lideres,_that.estadisticasDisponibles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tipo,  String estadistica,  bool menorEsMejor,  List<Lider> lideres,  List<String> estadisticasDisponibles)?  $default,) {final _that = this;
switch (_that) {
case _Lideres() when $default != null:
return $default(_that.tipo,_that.estadistica,_that.menorEsMejor,_that.lideres,_that.estadisticasDisponibles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lideres implements Lideres {
  const _Lideres({required this.tipo, required this.estadistica, this.menorEsMejor = false,  List<Lider> lideres = const <Lider>[],  List<String> estadisticasDisponibles = const <String>[]}): _lideres = lideres,_estadisticasDisponibles = estadisticasDisponibles;
  factory _Lideres.fromJson(Map<String, dynamic> json) => _$LideresFromJson(json);

@override final  String tipo;
@override final  String estadistica;
@override@JsonKey() final  bool menorEsMejor;
 final  List<Lider> _lideres;
@override@JsonKey() List<Lider> get lideres {
  if (_lideres is EqualUnmodifiableListView) return _lideres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lideres);
}

 final  List<String> _estadisticasDisponibles;
@override@JsonKey() List<String> get estadisticasDisponibles {
  if (_estadisticasDisponibles is EqualUnmodifiableListView) return _estadisticasDisponibles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estadisticasDisponibles);
}


/// Create a copy of Lideres
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LideresCopyWith<_Lideres> get copyWith => __$LideresCopyWithImpl<_Lideres>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LideresToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lideres&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estadistica, estadistica) || other.estadistica == estadistica)&&(identical(other.menorEsMejor, menorEsMejor) || other.menorEsMejor == menorEsMejor)&&const DeepCollectionEquality().equals(other.lideres, _lideres)&&const DeepCollectionEquality().equals(other.estadisticasDisponibles, _estadisticasDisponibles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tipo,estadistica,menorEsMejor,const DeepCollectionEquality().hash(_lideres),const DeepCollectionEquality().hash(_estadisticasDisponibles));
}

@override
String toString() {
    return 'Lideres(tipo: $tipo, estadistica: $estadistica, menorEsMejor: $menorEsMejor, lideres: $lideres, estadisticasDisponibles: $estadisticasDisponibles)';
}


}

/// @nodoc
abstract mixin class _$LideresCopyWith<$Res> implements $LideresCopyWith<$Res> {
  factory _$LideresCopyWith(_Lideres value, $Res Function(_Lideres) _then) = __$LideresCopyWithImpl;
@override @useResult
$Res call({
 String tipo, String estadistica, bool menorEsMejor, List<Lider> lideres, List<String> estadisticasDisponibles
});




}
/// @nodoc
class __$LideresCopyWithImpl<$Res>
    implements _$LideresCopyWith<$Res> {
  __$LideresCopyWithImpl(this._self, this._then);

  final _Lideres _self;
  final $Res Function(_Lideres) _then;

/// Create a copy of Lideres
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tipo = null,Object? estadistica = null,Object? menorEsMejor = null,Object? lideres = null,Object? estadisticasDisponibles = null,}) {
  return _then(_Lideres(
tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,estadistica: null == estadistica ? _self.estadistica : estadistica // ignore: cast_nullable_to_non_nullable
as String,menorEsMejor: null == menorEsMejor ? _self.menorEsMejor : menorEsMejor // ignore: cast_nullable_to_non_nullable
as bool,lideres: null == lideres ? _self._lideres : lideres // ignore: cast_nullable_to_non_nullable
as List<Lider>,estadisticasDisponibles: null == estadisticasDisponibles ? _self._estadisticasDisponibles : estadisticasDisponibles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$TraspasoResultado {

 String get tipo; Bateador? get bateador; Lanzador? get lanzador;
/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraspasoResultadoCopyWith<TraspasoResultado> get copyWith => _$TraspasoResultadoCopyWithImpl<TraspasoResultado>(this as TraspasoResultado, _$identity);

  /// Serializes this TraspasoResultado to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TraspasoResultado;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraspasoResultado&&(identical(other.tipo, _this.tipo) || other.tipo == _this.tipo)&&(identical(other.bateador, _this.bateador) || other.bateador == _this.bateador)&&(identical(other.lanzador, _this.lanzador) || other.lanzador == _this.lanzador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TraspasoResultado;
  return Object.hash(runtimeType,_this.tipo,_this.bateador,_this.lanzador);
}

@override
String toString() {
  final _this = this as TraspasoResultado;
  return 'TraspasoResultado(tipo: ${_this.tipo}, bateador: ${_this.bateador}, lanzador: ${_this.lanzador})';
}


}

/// @nodoc
abstract mixin class $TraspasoResultadoCopyWith<$Res>  {
  factory $TraspasoResultadoCopyWith(TraspasoResultado value, $Res Function(TraspasoResultado) _then) = _$TraspasoResultadoCopyWithImpl;
@useResult
$Res call({
 String tipo, Bateador? bateador, Lanzador? lanzador
});


$BateadorCopyWith<$Res>? get bateador;$LanzadorCopyWith<$Res>? get lanzador;

}
/// @nodoc
class _$TraspasoResultadoCopyWithImpl<$Res>
    implements $TraspasoResultadoCopyWith<$Res> {
  _$TraspasoResultadoCopyWithImpl(this._self, this._then);

  final TraspasoResultado _self;
  final $Res Function(TraspasoResultado) _then;

/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tipo = null,Object? bateador = freezed,Object? lanzador = freezed,}) {
  return _then(TraspasoResultado(
tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,bateador: freezed == bateador ? _self.bateador : bateador // ignore: cast_nullable_to_non_nullable
as Bateador?,lanzador: freezed == lanzador ? _self.lanzador : lanzador // ignore: cast_nullable_to_non_nullable
as Lanzador?,
  ));
}
/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BateadorCopyWith<$Res>? get bateador {
    if (_self.bateador == null) {
    return null;
  }

  return $BateadorCopyWith<$Res>(_self.bateador!, (value) {
    return _then(_self.copyWith(bateador: value));
  });
}/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LanzadorCopyWith<$Res>? get lanzador {
    if (_self.lanzador == null) {
    return null;
  }

  return $LanzadorCopyWith<$Res>(_self.lanzador!, (value) {
    return _then(_self.copyWith(lanzador: value));
  });
}
}


/// Adds pattern-matching-related methods to [TraspasoResultado].
extension TraspasoResultadoPatterns on TraspasoResultado {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TraspasoResultado value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TraspasoResultado() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TraspasoResultado value)  $default,){
final _that = this;
switch (_that) {
case _TraspasoResultado():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TraspasoResultado value)?  $default,){
final _that = this;
switch (_that) {
case _TraspasoResultado() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tipo,  Bateador? bateador,  Lanzador? lanzador)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TraspasoResultado() when $default != null:
return $default(_that.tipo,_that.bateador,_that.lanzador);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tipo,  Bateador? bateador,  Lanzador? lanzador)  $default,) {final _that = this;
switch (_that) {
case _TraspasoResultado():
return $default(_that.tipo,_that.bateador,_that.lanzador);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tipo,  Bateador? bateador,  Lanzador? lanzador)?  $default,) {final _that = this;
switch (_that) {
case _TraspasoResultado() when $default != null:
return $default(_that.tipo,_that.bateador,_that.lanzador);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TraspasoResultado implements TraspasoResultado {
  const _TraspasoResultado({required this.tipo, this.bateador, this.lanzador});
  factory _TraspasoResultado.fromJson(Map<String, dynamic> json) => _$TraspasoResultadoFromJson(json);

@override final  String tipo;
@override final  Bateador? bateador;
@override final  Lanzador? lanzador;

/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TraspasoResultadoCopyWith<_TraspasoResultado> get copyWith => __$TraspasoResultadoCopyWithImpl<_TraspasoResultado>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TraspasoResultadoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TraspasoResultado&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.bateador, bateador) || other.bateador == bateador)&&(identical(other.lanzador, lanzador) || other.lanzador == lanzador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tipo,bateador,lanzador);
}

@override
String toString() {
    return 'TraspasoResultado(tipo: $tipo, bateador: $bateador, lanzador: $lanzador)';
}


}

/// @nodoc
abstract mixin class _$TraspasoResultadoCopyWith<$Res> implements $TraspasoResultadoCopyWith<$Res> {
  factory _$TraspasoResultadoCopyWith(_TraspasoResultado value, $Res Function(_TraspasoResultado) _then) = __$TraspasoResultadoCopyWithImpl;
@override @useResult
$Res call({
 String tipo, Bateador? bateador, Lanzador? lanzador
});


@override $BateadorCopyWith<$Res>? get bateador;@override $LanzadorCopyWith<$Res>? get lanzador;

}
/// @nodoc
class __$TraspasoResultadoCopyWithImpl<$Res>
    implements _$TraspasoResultadoCopyWith<$Res> {
  __$TraspasoResultadoCopyWithImpl(this._self, this._then);

  final _TraspasoResultado _self;
  final $Res Function(_TraspasoResultado) _then;

/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tipo = null,Object? bateador = freezed,Object? lanzador = freezed,}) {
  return _then(_TraspasoResultado(
tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,bateador: freezed == bateador ? _self.bateador : bateador // ignore: cast_nullable_to_non_nullable
as Bateador?,lanzador: freezed == lanzador ? _self.lanzador : lanzador // ignore: cast_nullable_to_non_nullable
as Lanzador?,
  ));
}

/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BateadorCopyWith<$Res>? get bateador {
    if (_self.bateador == null) {
    return null;
  }

  return $BateadorCopyWith<$Res>(_self.bateador!, (value) {
    return _then(_self.copyWith(bateador: value));
  });
}/// Create a copy of TraspasoResultado
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LanzadorCopyWith<$Res>? get lanzador {
    if (_self.lanzador == null) {
    return null;
  }

  return $LanzadorCopyWith<$Res>(_self.lanzador!, (value) {
    return _then(_self.copyWith(lanzador: value));
  });
}
}

// dart format on
