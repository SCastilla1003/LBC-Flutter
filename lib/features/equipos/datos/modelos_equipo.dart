import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/modelos/modelos_comunes.dart';
import '../../jugadores/datos/modelos_jugador.dart';

part 'modelos_equipo.freezed.dart';
part 'modelos_equipo.g.dart';

/// Récord calculado por la API con los partidos finalizados (`RegistroDto`).
@freezed
abstract class Registro with _$Registro {
  const factory Registro({
    @Default(0) int partidosJugados,
    @Default(0) int ganados,
    @Default(0) int perdidos,
    @Default(0) int empates,
    double? porcentajeVictorias,
    @Default(0) int carrerasFavor,
    @Default(0) int carrerasContra,
    @Default(0) int diferencial,
  }) = _Registro;

  factory Registro.fromJson(Map<String, dynamic> json) => _$RegistroFromJson(json);
}

@freezed
abstract class Equipo with _$Equipo {
  const factory Equipo({
    required String id,
    required String nombre,
    String? ciudad,
    String? urlFoto,
    String? color,
    @Default(0) int totalBateadores,
    @Default(0) int totalLanzadores,
    @Default(Registro()) Registro registro,
  }) = _Equipo;

  factory Equipo.fromJson(Map<String, dynamic> json) => _$EquipoFromJson(json);
}

@freezed
abstract class EquipoDetalle with _$EquipoDetalle {
  const factory EquipoDetalle({
    required String id,
    required String nombre,
    String? ciudad,
    String? urlFoto,
    String? color,
    @Default(Registro()) Registro registro,
    @Default(<Bateador>[]) List<Bateador> bateadores,
    @Default(<Lanzador>[]) List<Lanzador> lanzadores,
  }) = _EquipoDetalle;

  factory EquipoDetalle.fromJson(Map<String, dynamic> json) => _$EquipoDetalleFromJson(json);
}

/// Fila de la tabla de posiciones (`PosicionDto`).
@freezed
abstract class Posicion with _$Posicion {
  const factory Posicion({
    required int posicion,
    required String idEquipo,
    required String nombre,
    String? ciudad,
    String? urlFoto,
    String? color,
    @Default(0) int partidosJugados,
    @Default(0) int ganados,
    @Default(0) int perdidos,
    @Default(0) int empates,
    double? porcentajeVictorias,
    @Default(0) double juegosDetras,
    @Default(0) int carrerasFavor,
    @Default(0) int carrerasContra,
    @Default(0) int diferencial,
    @Default(<String>[]) List<String> ultimosResultados,
    String? racha,
  }) = _Posicion;

  factory Posicion.fromJson(Map<String, dynamic> json) => _$PosicionFromJson(json);
}

/// Un partido finalizado visto desde el equipo. [resultado]: "G", "P" o "E".
@freezed
abstract class PartidoEquipo with _$PartidoEquipo {
  const factory PartidoEquipo({
    required String idPartido,
    DateTime? fecha,
    String? hora,
    @Default(false) bool local,
    EquipoRef? rival,
    @Default(0) int carrerasFavor,
    @Default(0) int carrerasContra,
    @Default(0) int diferencial,
    required String resultado,
  }) = _PartidoEquipo;

  factory PartidoEquipo.fromJson(Map<String, dynamic> json) => _$PartidoEquipoFromJson(json);
}

@freezed
abstract class Comparativa with _$Comparativa {
  const factory Comparativa({
    required String metrica,
    required String etiqueta,
    double? valorEquipo,
    double? promedioLiga,
    @Default(true) bool mayorEsMejor,
  }) = _Comparativa;

  factory Comparativa.fromJson(Map<String, dynamic> json) => _$ComparativaFromJson(json);
}

@freezed
abstract class BateoEquipo with _$BateoEquipo {
  const factory BateoEquipo({
    @Default(0) int hits,
    @Default(0) int homeRuns,
    @Default(0) int triples,
    @Default(0) int dobles,
    @Default(0) int sencillos,
    @Default(0) int carrerasImpulsadas,
    @Default(0) int roboDeBase,
    @Default(0) int basePorBola,
    @Default(0) int ponches,
  }) = _BateoEquipo;

  factory BateoEquipo.fromJson(Map<String, dynamic> json) => _$BateoEquipoFromJson(json);
}

@freezed
abstract class PitcheoEquipo with _$PitcheoEquipo {
  const factory PitcheoEquipo({
    @Default(0) int inningsLanzados,
    @Default(0) int ponchados,
    @Default(0) int basePorBola,
    @Default(0) int carrerasPermitidas,
    @Default(0) int hitsPermitidos,
    double? era,
    double? whip,
    double? k9,
  }) = _PitcheoEquipo;

  factory PitcheoEquipo.fromJson(Map<String, dynamic> json) => _$PitcheoEquipoFromJson(json);
}

@freezed
abstract class EquipoEstadisticas with _$EquipoEstadisticas {
  const factory EquipoEstadisticas({
    required Equipo equipo,
    @Default(<PartidoEquipo>[]) List<PartidoEquipo> partidos,
    @Default(<Comparativa>[]) List<Comparativa> comparativaLiga,
    @Default(BateoEquipo()) BateoEquipo bateo,
    @Default(PitcheoEquipo()) PitcheoEquipo pitcheo,
  }) = _EquipoEstadisticas;

  factory EquipoEstadisticas.fromJson(Map<String, dynamic> json) => _$EquipoEstadisticasFromJson(json);
}
