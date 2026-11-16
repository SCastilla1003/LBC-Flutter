// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modelos_partido.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Partido {

 String get id; DateTime? get fecha; String? get hora; EstadoPartido get estado; EstadioRef? get estadio; EquipoRef get equipoLocal; EquipoRef get equipoVisitante; int get carrerasEquipoLocal; int get carrerasEquipoVisitante; int get innings; int get inningActual; int get hitTotalesPartido; int get erroresTotalesPartido; String? get idEquipoGanador;
/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartidoCopyWith<Partido> get copyWith => _$PartidoCopyWithImpl<Partido>(this as Partido, _$identity);

  /// Serializes this Partido to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Partido;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Partido&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fecha, _this.fecha) || other.fecha == _this.fecha)&&(identical(other.hora, _this.hora) || other.hora == _this.hora)&&(identical(other.estado, _this.estado) || other.estado == _this.estado)&&(identical(other.estadio, _this.estadio) || other.estadio == _this.estadio)&&(identical(other.equipoLocal, _this.equipoLocal) || other.equipoLocal == _this.equipoLocal)&&(identical(other.equipoVisitante, _this.equipoVisitante) || other.equipoVisitante == _this.equipoVisitante)&&(identical(other.carrerasEquipoLocal, _this.carrerasEquipoLocal) || other.carrerasEquipoLocal == _this.carrerasEquipoLocal)&&(identical(other.carrerasEquipoVisitante, _this.carrerasEquipoVisitante) || other.carrerasEquipoVisitante == _this.carrerasEquipoVisitante)&&(identical(other.innings, _this.innings) || other.innings == _this.innings)&&(identical(other.inningActual, _this.inningActual) || other.inningActual == _this.inningActual)&&(identical(other.hitTotalesPartido, _this.hitTotalesPartido) || other.hitTotalesPartido == _this.hitTotalesPartido)&&(identical(other.erroresTotalesPartido, _this.erroresTotalesPartido) || other.erroresTotalesPartido == _this.erroresTotalesPartido)&&(identical(other.idEquipoGanador, _this.idEquipoGanador) || other.idEquipoGanador == _this.idEquipoGanador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Partido;
  return Object.hash(runtimeType,_this.id,_this.fecha,_this.hora,_this.estado,_this.estadio,_this.equipoLocal,_this.equipoVisitante,_this.carrerasEquipoLocal,_this.carrerasEquipoVisitante,_this.innings,_this.inningActual,_this.hitTotalesPartido,_this.erroresTotalesPartido,_this.idEquipoGanador);
}

@override
String toString() {
  final _this = this as Partido;
  return 'Partido(id: ${_this.id}, fecha: ${_this.fecha}, hora: ${_this.hora}, estado: ${_this.estado}, estadio: ${_this.estadio}, equipoLocal: ${_this.equipoLocal}, equipoVisitante: ${_this.equipoVisitante}, carrerasEquipoLocal: ${_this.carrerasEquipoLocal}, carrerasEquipoVisitante: ${_this.carrerasEquipoVisitante}, innings: ${_this.innings}, inningActual: ${_this.inningActual}, hitTotalesPartido: ${_this.hitTotalesPartido}, erroresTotalesPartido: ${_this.erroresTotalesPartido}, idEquipoGanador: ${_this.idEquipoGanador})';
}


}

/// @nodoc
abstract mixin class $PartidoCopyWith<$Res>  {
  factory $PartidoCopyWith(Partido value, $Res Function(Partido) _then) = _$PartidoCopyWithImpl;
@useResult
$Res call({
 String id, DateTime? fecha, String? hora, EstadoPartido estado, EstadioRef? estadio, EquipoRef equipoLocal, EquipoRef equipoVisitante, int carrerasEquipoLocal, int carrerasEquipoVisitante, int innings, int inningActual, int hitTotalesPartido, int erroresTotalesPartido, String? idEquipoGanador
});


$EstadioRefCopyWith<$Res>? get estadio;$EquipoRefCopyWith<$Res> get equipoLocal;$EquipoRefCopyWith<$Res> get equipoVisitante;

}
/// @nodoc
class _$PartidoCopyWithImpl<$Res>
    implements $PartidoCopyWith<$Res> {
  _$PartidoCopyWithImpl(this._self, this._then);

  final Partido _self;
  final $Res Function(Partido) _then;

/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fecha = freezed,Object? hora = freezed,Object? estado = null,Object? estadio = freezed,Object? equipoLocal = null,Object? equipoVisitante = null,Object? carrerasEquipoLocal = null,Object? carrerasEquipoVisitante = null,Object? innings = null,Object? inningActual = null,Object? hitTotalesPartido = null,Object? erroresTotalesPartido = null,Object? idEquipoGanador = freezed,}) {
  return _then(Partido(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fecha: freezed == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime?,hora: freezed == hora ? _self.hora : hora // ignore: cast_nullable_to_non_nullable
as String?,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoPartido,estadio: freezed == estadio ? _self.estadio : estadio // ignore: cast_nullable_to_non_nullable
as EstadioRef?,equipoLocal: null == equipoLocal ? _self.equipoLocal : equipoLocal // ignore: cast_nullable_to_non_nullable
as EquipoRef,equipoVisitante: null == equipoVisitante ? _self.equipoVisitante : equipoVisitante // ignore: cast_nullable_to_non_nullable
as EquipoRef,carrerasEquipoLocal: null == carrerasEquipoLocal ? _self.carrerasEquipoLocal : carrerasEquipoLocal // ignore: cast_nullable_to_non_nullable
as int,carrerasEquipoVisitante: null == carrerasEquipoVisitante ? _self.carrerasEquipoVisitante : carrerasEquipoVisitante // ignore: cast_nullable_to_non_nullable
as int,innings: null == innings ? _self.innings : innings // ignore: cast_nullable_to_non_nullable
as int,inningActual: null == inningActual ? _self.inningActual : inningActual // ignore: cast_nullable_to_non_nullable
as int,hitTotalesPartido: null == hitTotalesPartido ? _self.hitTotalesPartido : hitTotalesPartido // ignore: cast_nullable_to_non_nullable
as int,erroresTotalesPartido: null == erroresTotalesPartido ? _self.erroresTotalesPartido : erroresTotalesPartido // ignore: cast_nullable_to_non_nullable
as int,idEquipoGanador: freezed == idEquipoGanador ? _self.idEquipoGanador : idEquipoGanador // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstadioRefCopyWith<$Res>? get estadio {
    if (_self.estadio == null) {
    return null;
  }

  return $EstadioRefCopyWith<$Res>(_self.estadio!, (value) {
    return _then(_self.copyWith(estadio: value));
  });
}/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res> get equipoLocal {
  
  return $EquipoRefCopyWith<$Res>(_self.equipoLocal, (value) {
    return _then(_self.copyWith(equipoLocal: value));
  });
}/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res> get equipoVisitante {
  
  return $EquipoRefCopyWith<$Res>(_self.equipoVisitante, (value) {
    return _then(_self.copyWith(equipoVisitante: value));
  });
}
}


/// Adds pattern-matching-related methods to [Partido].
extension PartidoPatterns on Partido {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Partido value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Partido() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Partido value)  $default,){
final _that = this;
switch (_that) {
case _Partido():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Partido value)?  $default,){
final _that = this;
switch (_that) {
case _Partido() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime? fecha,  String? hora,  EstadoPartido estado,  EstadioRef? estadio,  EquipoRef equipoLocal,  EquipoRef equipoVisitante,  int carrerasEquipoLocal,  int carrerasEquipoVisitante,  int innings,  int inningActual,  int hitTotalesPartido,  int erroresTotalesPartido,  String? idEquipoGanador)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Partido() when $default != null:
return $default(_that.id,_that.fecha,_that.hora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisitante,_that.carrerasEquipoLocal,_that.carrerasEquipoVisitante,_that.innings,_that.inningActual,_that.hitTotalesPartido,_that.erroresTotalesPartido,_that.idEquipoGanador);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime? fecha,  String? hora,  EstadoPartido estado,  EstadioRef? estadio,  EquipoRef equipoLocal,  EquipoRef equipoVisitante,  int carrerasEquipoLocal,  int carrerasEquipoVisitante,  int innings,  int inningActual,  int hitTotalesPartido,  int erroresTotalesPartido,  String? idEquipoGanador)  $default,) {final _that = this;
switch (_that) {
case _Partido():
return $default(_that.id,_that.fecha,_that.hora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisitante,_that.carrerasEquipoLocal,_that.carrerasEquipoVisitante,_that.innings,_that.inningActual,_that.hitTotalesPartido,_that.erroresTotalesPartido,_that.idEquipoGanador);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime? fecha,  String? hora,  EstadoPartido estado,  EstadioRef? estadio,  EquipoRef equipoLocal,  EquipoRef equipoVisitante,  int carrerasEquipoLocal,  int carrerasEquipoVisitante,  int innings,  int inningActual,  int hitTotalesPartido,  int erroresTotalesPartido,  String? idEquipoGanador)?  $default,) {final _that = this;
switch (_that) {
case _Partido() when $default != null:
return $default(_that.id,_that.fecha,_that.hora,_that.estado,_that.estadio,_that.equipoLocal,_that.equipoVisitante,_that.carrerasEquipoLocal,_that.carrerasEquipoVisitante,_that.innings,_that.inningActual,_that.hitTotalesPartido,_that.erroresTotalesPartido,_that.idEquipoGanador);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Partido extends Partido {
  const _Partido({required this.id, this.fecha, this.hora, this.estado = EstadoPartido.programado, this.estadio, required this.equipoLocal, required this.equipoVisitante, this.carrerasEquipoLocal = 0, this.carrerasEquipoVisitante = 0, this.innings = 9, this.inningActual = 0, this.hitTotalesPartido = 0, this.erroresTotalesPartido = 0, this.idEquipoGanador}): super._();
  factory _Partido.fromJson(Map<String, dynamic> json) => _$PartidoFromJson(json);

@override final  String id;
@override final  DateTime? fecha;
@override final  String? hora;
@override@JsonKey() final  EstadoPartido estado;
@override final  EstadioRef? estadio;
@override final  EquipoRef equipoLocal;
@override final  EquipoRef equipoVisitante;
@override@JsonKey() final  int carrerasEquipoLocal;
@override@JsonKey() final  int carrerasEquipoVisitante;
@override@JsonKey() final  int innings;
@override@JsonKey() final  int inningActual;
@override@JsonKey() final  int hitTotalesPartido;
@override@JsonKey() final  int erroresTotalesPartido;
@override final  String? idEquipoGanador;

/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartidoCopyWith<_Partido> get copyWith => __$PartidoCopyWithImpl<_Partido>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartidoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Partido&&(identical(other.id, id) || other.id == id)&&(identical(other.fecha, fecha) || other.fecha == fecha)&&(identical(other.hora, hora) || other.hora == hora)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.estadio, estadio) || other.estadio == estadio)&&(identical(other.equipoLocal, equipoLocal) || other.equipoLocal == equipoLocal)&&(identical(other.equipoVisitante, equipoVisitante) || other.equipoVisitante == equipoVisitante)&&(identical(other.carrerasEquipoLocal, carrerasEquipoLocal) || other.carrerasEquipoLocal == carrerasEquipoLocal)&&(identical(other.carrerasEquipoVisitante, carrerasEquipoVisitante) || other.carrerasEquipoVisitante == carrerasEquipoVisitante)&&(identical(other.innings, innings) || other.innings == innings)&&(identical(other.inningActual, inningActual) || other.inningActual == inningActual)&&(identical(other.hitTotalesPartido, hitTotalesPartido) || other.hitTotalesPartido == hitTotalesPartido)&&(identical(other.erroresTotalesPartido, erroresTotalesPartido) || other.erroresTotalesPartido == erroresTotalesPartido)&&(identical(other.idEquipoGanador, idEquipoGanador) || other.idEquipoGanador == idEquipoGanador));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,fecha,hora,estado,estadio,equipoLocal,equipoVisitante,carrerasEquipoLocal,carrerasEquipoVisitante,innings,inningActual,hitTotalesPartido,erroresTotalesPartido,idEquipoGanador);
}

@override
String toString() {
    return 'Partido(id: $id, fecha: $fecha, hora: $hora, estado: $estado, estadio: $estadio, equipoLocal: $equipoLocal, equipoVisitante: $equipoVisitante, carrerasEquipoLocal: $carrerasEquipoLocal, carrerasEquipoVisitante: $carrerasEquipoVisitante, innings: $innings, inningActual: $inningActual, hitTotalesPartido: $hitTotalesPartido, erroresTotalesPartido: $erroresTotalesPartido, idEquipoGanador: $idEquipoGanador)';
}


}

/// @nodoc
abstract mixin class _$PartidoCopyWith<$Res> implements $PartidoCopyWith<$Res> {
  factory _$PartidoCopyWith(_Partido value, $Res Function(_Partido) _then) = __$PartidoCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime? fecha, String? hora, EstadoPartido estado, EstadioRef? estadio, EquipoRef equipoLocal, EquipoRef equipoVisitante, int carrerasEquipoLocal, int carrerasEquipoVisitante, int innings, int inningActual, int hitTotalesPartido, int erroresTotalesPartido, String? idEquipoGanador
});


@override $EstadioRefCopyWith<$Res>? get estadio;@override $EquipoRefCopyWith<$Res> get equipoLocal;@override $EquipoRefCopyWith<$Res> get equipoVisitante;

}
/// @nodoc
class __$PartidoCopyWithImpl<$Res>
    implements _$PartidoCopyWith<$Res> {
  __$PartidoCopyWithImpl(this._self, this._then);

  final _Partido _self;
  final $Res Function(_Partido) _then;

/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fecha = freezed,Object? hora = freezed,Object? estado = null,Object? estadio = freezed,Object? equipoLocal = null,Object? equipoVisitante = null,Object? carrerasEquipoLocal = null,Object? carrerasEquipoVisitante = null,Object? innings = null,Object? inningActual = null,Object? hitTotalesPartido = null,Object? erroresTotalesPartido = null,Object? idEquipoGanador = freezed,}) {
  return _then(_Partido(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fecha: freezed == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime?,hora: freezed == hora ? _self.hora : hora // ignore: cast_nullable_to_non_nullable
as String?,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoPartido,estadio: freezed == estadio ? _self.estadio : estadio // ignore: cast_nullable_to_non_nullable
as EstadioRef?,equipoLocal: null == equipoLocal ? _self.equipoLocal : equipoLocal // ignore: cast_nullable_to_non_nullable
as EquipoRef,equipoVisitante: null == equipoVisitante ? _self.equipoVisitante : equipoVisitante // ignore: cast_nullable_to_non_nullable
as EquipoRef,carrerasEquipoLocal: null == carrerasEquipoLocal ? _self.carrerasEquipoLocal : carrerasEquipoLocal // ignore: cast_nullable_to_non_nullable
as int,carrerasEquipoVisitante: null == carrerasEquipoVisitante ? _self.carrerasEquipoVisitante : carrerasEquipoVisitante // ignore: cast_nullable_to_non_nullable
as int,innings: null == innings ? _self.innings : innings // ignore: cast_nullable_to_non_nullable
as int,inningActual: null == inningActual ? _self.inningActual : inningActual // ignore: cast_nullable_to_non_nullable
as int,hitTotalesPartido: null == hitTotalesPartido ? _self.hitTotalesPartido : hitTotalesPartido // ignore: cast_nullable_to_non_nullable
as int,erroresTotalesPartido: null == erroresTotalesPartido ? _self.erroresTotalesPartido : erroresTotalesPartido // ignore: cast_nullable_to_non_nullable
as int,idEquipoGanador: freezed == idEquipoGanador ? _self.idEquipoGanador : idEquipoGanador // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstadioRefCopyWith<$Res>? get estadio {
    if (_self.estadio == null) {
    return null;
  }

  return $EstadioRefCopyWith<$Res>(_self.estadio!, (value) {
    return _then(_self.copyWith(estadio: value));
  });
}/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res> get equipoLocal {
  
  return $EquipoRefCopyWith<$Res>(_self.equipoLocal, (value) {
    return _then(_self.copyWith(equipoLocal: value));
  });
}/// Create a copy of Partido
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EquipoRefCopyWith<$Res> get equipoVisitante {
  
  return $EquipoRefCopyWith<$Res>(_self.equipoVisitante, (value) {
    return _then(_self.copyWith(equipoVisitante: value));
  });
}
}


/// @nodoc
mixin _$Estadio {

 String get id; String get nombre; String? get ubicacion; int get partidosJugados; int get partidosProgramados;
/// Create a copy of Estadio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstadioCopyWith<Estadio> get copyWith => _$EstadioCopyWithImpl<Estadio>(this as Estadio, _$identity);

  /// Serializes this Estadio to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Estadio;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Estadio&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nombre, _this.nombre) || other.nombre == _this.nombre)&&(identical(other.ubicacion, _this.ubicacion) || other.ubicacion == _this.ubicacion)&&(identical(other.partidosJugados, _this.partidosJugados) || other.partidosJugados == _this.partidosJugados)&&(identical(other.partidosProgramados, _this.partidosProgramados) || other.partidosProgramados == _this.partidosProgramados));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Estadio;
  return Object.hash(runtimeType,_this.id,_this.nombre,_this.ubicacion,_this.partidosJugados,_this.partidosProgramados);
}

@override
String toString() {
  final _this = this as Estadio;
  return 'Estadio(id: ${_this.id}, nombre: ${_this.nombre}, ubicacion: ${_this.ubicacion}, partidosJugados: ${_this.partidosJugados}, partidosProgramados: ${_this.partidosProgramados})';
}


}

/// @nodoc
abstract mixin class $EstadioCopyWith<$Res>  {
  factory $EstadioCopyWith(Estadio value, $Res Function(Estadio) _then) = _$EstadioCopyWithImpl;
@useResult
$Res call({
 String id, String nombre, String? ubicacion, int partidosJugados, int partidosProgramados
});




}
/// @nodoc
class _$EstadioCopyWithImpl<$Res>
    implements $EstadioCopyWith<$Res> {
  _$EstadioCopyWithImpl(this._self, this._then);

  final Estadio _self;
  final $Res Function(Estadio) _then;

/// Create a copy of Estadio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? ubicacion = freezed,Object? partidosJugados = null,Object? partidosProgramados = null,}) {
  return _then(Estadio(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,partidosProgramados: null == partidosProgramados ? _self.partidosProgramados : partidosProgramados // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Estadio].
extension EstadioPatterns on Estadio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Estadio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Estadio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Estadio value)  $default,){
final _that = this;
switch (_that) {
case _Estadio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Estadio value)?  $default,){
final _that = this;
switch (_that) {
case _Estadio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombre,  String? ubicacion,  int partidosJugados,  int partidosProgramados)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Estadio() when $default != null:
return $default(_that.id,_that.nombre,_that.ubicacion,_that.partidosJugados,_that.partidosProgramados);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombre,  String? ubicacion,  int partidosJugados,  int partidosProgramados)  $default,) {final _that = this;
switch (_that) {
case _Estadio():
return $default(_that.id,_that.nombre,_that.ubicacion,_that.partidosJugados,_that.partidosProgramados);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombre,  String? ubicacion,  int partidosJugados,  int partidosProgramados)?  $default,) {final _that = this;
switch (_that) {
case _Estadio() when $default != null:
return $default(_that.id,_that.nombre,_that.ubicacion,_that.partidosJugados,_that.partidosProgramados);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Estadio implements Estadio {
  const _Estadio({required this.id, required this.nombre, this.ubicacion, this.partidosJugados = 0, this.partidosProgramados = 0});
  factory _Estadio.fromJson(Map<String, dynamic> json) => _$EstadioFromJson(json);

@override final  String id;
@override final  String nombre;
@override final  String? ubicacion;
@override@JsonKey() final  int partidosJugados;
@override@JsonKey() final  int partidosProgramados;

/// Create a copy of Estadio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstadioCopyWith<_Estadio> get copyWith => __$EstadioCopyWithImpl<_Estadio>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstadioToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Estadio&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.ubicacion, ubicacion) || other.ubicacion == ubicacion)&&(identical(other.partidosJugados, partidosJugados) || other.partidosJugados == partidosJugados)&&(identical(other.partidosProgramados, partidosProgramados) || other.partidosProgramados == partidosProgramados));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nombre,ubicacion,partidosJugados,partidosProgramados);
}

@override
String toString() {
    return 'Estadio(id: $id, nombre: $nombre, ubicacion: $ubicacion, partidosJugados: $partidosJugados, partidosProgramados: $partidosProgramados)';
}


}

/// @nodoc
abstract mixin class _$EstadioCopyWith<$Res> implements $EstadioCopyWith<$Res> {
  factory _$EstadioCopyWith(_Estadio value, $Res Function(_Estadio) _then) = __$EstadioCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombre, String? ubicacion, int partidosJugados, int partidosProgramados
});




}
/// @nodoc
class __$EstadioCopyWithImpl<$Res>
    implements _$EstadioCopyWith<$Res> {
  __$EstadioCopyWithImpl(this._self, this._then);

  final _Estadio _self;
  final $Res Function(_Estadio) _then;

/// Create a copy of Estadio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? ubicacion = freezed,Object? partidosJugados = null,Object? partidosProgramados = null,}) {
  return _then(_Estadio(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,ubicacion: freezed == ubicacion ? _self.ubicacion : ubicacion // ignore: cast_nullable_to_non_nullable
as String?,partidosJugados: null == partidosJugados ? _self.partidosJugados : partidosJugados // ignore: cast_nullable_to_non_nullable
as int,partidosProgramados: null == partidosProgramados ? _self.partidosProgramados : partidosProgramados // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
