import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/modelos/modelos_comunes.dart';
import '../../equipos/datos/modelos_equipo.dart';
import '../../partidos/datos/modelos_partido.dart';

part 'modelos_temporada.freezed.dart';
part 'modelos_temporada.g.dart';

@freezed
abstract class TemporadaResumen with _$TemporadaResumen {
  const factory TemporadaResumen({
    required String id,
    required String nombreTemporada,
    required int anio,
    @Default(0) int totalEquipos,
    @Default(0) int totalPartidos,
    @Default(0) int partidosFinalizados,
    EquipoRef? campeon,
  }) = _TemporadaResumen;

  factory TemporadaResumen.fromJson(Map<String, dynamic> json) => _$TemporadaResumenFromJson(json);
}

@freezed
abstract class TemporadaDetalle with _$TemporadaDetalle {
  const factory TemporadaDetalle({
    required String id,
    required String nombreTemporada,
    required int anio,
    EquipoRef? campeon,
    @Default(0) int totalPartidos,
    @Default(0) int partidosFinalizados,
    @Default(0) int totalAgentesLibres,
    @Default(<Equipo>[]) List<Equipo> equipos,
    @Default(<Estadio>[]) List<Estadio> estadios,
  }) = _TemporadaDetalle;

  factory TemporadaDetalle.fromJson(Map<String, dynamic> json) => _$TemporadaDetalleFromJson(json);
}

// ---------------------------------------------------------------- estadísticas de temporada

@freezed
abstract class EstadisticasTemporada with _$EstadisticasTemporada {
  const factory EstadisticasTemporada({
    required String idTemporada,
    required Kpis kpis,
    @Default(<CarrerasPartido>[]) List<CarrerasPartido> carrerasPorPartido,
    @Default(<VictoriasEquipo>[]) List<VictoriasEquipo> victoriasPorEquipo,
    @Default(DistribucionHits()) DistribucionHits distribucionHits,
    @Default(<PartidosEstadio>[]) List<PartidosEstadio> partidosPorEstadio,
    @Default(<String, Referencia>{}) Map<String, Referencia> referenciaBateo,
    @Default(<String, Referencia>{}) Map<String, Referencia> referenciaPitcheo,
  }) = _EstadisticasTemporada;

  factory EstadisticasTemporada.fromJson(Map<String, dynamic> json) => _$EstadisticasTemporadaFromJson(json);
}

@freezed
abstract class Kpis with _$Kpis {
  const factory Kpis({
    @Default(0) int partidosJugados,
    @Default(0) int partidosPendientes,
    @Default(0) int carrerasTotales,
    double? promedioCarrerasPorPartido,
    @Default(0) int totalEquipos,
    @Default(0) int totalJugadores,
    JugadorDestacado? liderJonrones,
    EquipoDestacado? mejorRecord,
  }) = _Kpis;

  factory Kpis.fromJson(Map<String, dynamic> json) => _$KpisFromJson(json);
}

@freezed
abstract class JugadorDestacado with _$JugadorDestacado {
  const factory JugadorDestacado({
    required String idJugador,
    required String nombre,
    String? idEquipo,
    String? nombreEquipo,
    String? urlFoto,
    required double valor,
  }) = _JugadorDestacado;

  factory JugadorDestacado.fromJson(Map<String, dynamic> json) => _$JugadorDestacadoFromJson(json);
}

@freezed
abstract class EquipoDestacado with _$EquipoDestacado {
  const factory EquipoDestacado({
    required String idEquipo,
    required String nombre,
    String? urlFoto,
    @Default(0) int ganados,
    @Default(0) int perdidos,
    double? porcentajeVictorias,
  }) = _EquipoDestacado;

  factory EquipoDestacado.fromJson(Map<String, dynamic> json) => _$EquipoDestacadoFromJson(json);
}

@freezed
abstract class CarrerasPartido with _$CarrerasPartido {
  const factory CarrerasPartido({
    required String idPartido,
    DateTime? fecha,
    EquipoRef? local,
    EquipoRef? visitante,
    @Default(0) int carrerasLocal,
    @Default(0) int carrerasVisitante,
    @Default(0) int carrerasTotales,
    @Default(0) int hits,
    @Default(0) int errores,
  }) = _CarrerasPartido;

  factory CarrerasPartido.fromJson(Map<String, dynamic> json) => _$CarrerasPartidoFromJson(json);
}

@freezed
abstract class VictoriasEquipo with _$VictoriasEquipo {
  const factory VictoriasEquipo({
    required String idEquipo,
    required String nombre,
    @Default(0) int ganados,
    @Default(0) int perdidos,
    @Default(0) int empates,
    double? porcentajeVictorias,
  }) = _VictoriasEquipo;

  factory VictoriasEquipo.fromJson(Map<String, dynamic> json) => _$VictoriasEquipoFromJson(json);
}

@freezed
abstract class DistribucionHits with _$DistribucionHits {
  const factory DistribucionHits({
    @Default(0) int sencillos,
    @Default(0) int dobles,
    @Default(0) int triples,
    @Default(0) int homeRuns,
    @Default(0) int total,
  }) = _DistribucionHits;

  factory DistribucionHits.fromJson(Map<String, dynamic> json) => _$DistribucionHitsFromJson(json);
}

@freezed
abstract class PartidosEstadio with _$PartidosEstadio {
  const factory PartidosEstadio({
    required String idEstadio,
    required String nombre,
    String? ubicacion,
    @Default(0) int partidosJugados,
    @Default(0) int partidosProgramados,
  }) = _PartidosEstadio;

  factory PartidosEstadio.fromJson(Map<String, dynamic> json) => _$PartidosEstadioFromJson(json);
}
