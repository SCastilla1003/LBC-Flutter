import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/modelos/modelos_comunes.dart';

part 'modelos_jugador.freezed.dart';
part 'modelos_jugador.g.dart';

/// Bateador con estadísticas y métricas derivadas calculadas por la API (`BateadorDto`).
/// No hay turnos al bate: no existen AVG/OBP/SLG.
@freezed
abstract class Bateador with _$Bateador {
  const factory Bateador({
    required String id,
    required String nombre,
    @Default(0) int edad,
    String? posicion,
    String? derechoZurdo,
    String? idEquipo,
    String? nombreEquipo,
    @Default(false) bool agenteLibre,
    String? urlFoto,
    @Default(0) int homeRuns,
    @Default(0) int triples,
    @Default(0) int dobles,
    @Default(0) int sencillos,
    @Default(0) int basePorBola,
    @Default(0) int basePorGolpe,
    @Default(0) int ponches,
    @Default(0) int roboDeBase,
    @Default(0) int carrerasImpulsadas,
    @Default(0) int errores,
    @Default(0) int hits,
    @Default(0) int extrabases,
    @Default(0) int totalBases,
    @Default(0) int vecesEmbasado,
    double? relacionBbK,
  }) = _Bateador;

  factory Bateador.fromJson(Map<String, dynamic> json) => _$BateadorFromJson(json);
}

/// Lanzador (`LanzadorDto`). Las tasas son null con 0 innings lanzados.
@freezed
abstract class Lanzador with _$Lanzador {
  const factory Lanzador({
    required String id,
    required String nombre,
    @Default(0) int edad,
    String? posicion,
    String? derechoZurdo,
    String? idEquipo,
    String? nombreEquipo,
    @Default(false) bool agenteLibre,
    String? urlFoto,
    @Default(0) int numeroLanzamientos,
    @Default(0) int inningsLanzados,
    @Default(0) int ponchados,
    @Default(0) int basePorBola,
    @Default(0) int carrerasPermitidas,
    @Default(0) int hitsPermitidos,
    @Default(0) int aparicionesPlato,
    double? era,
    double? whip,
    double? k9,
    double? bb9,
    double? kbb,
    double? lanzamientosPorInning,
  }) = _Lanzador;

  factory Lanzador.fromJson(Map<String, dynamic> json) => _$LanzadorFromJson(json);
}

@freezed
abstract class BateadorPerfil with _$BateadorPerfil {
  const factory BateadorPerfil({
    required Bateador jugador,
    @Default(<String, Referencia>{}) Map<String, Referencia> referenciaLiga,
  }) = _BateadorPerfil;

  factory BateadorPerfil.fromJson(Map<String, dynamic> json) => _$BateadorPerfilFromJson(json);
}

@freezed
abstract class LanzadorPerfil with _$LanzadorPerfil {
  const factory LanzadorPerfil({
    required Lanzador jugador,
    @Default(<String, Referencia>{}) Map<String, Referencia> referenciaLiga,
  }) = _LanzadorPerfil;

  factory LanzadorPerfil.fromJson(Map<String, dynamic> json) => _$LanzadorPerfilFromJson(json);
}

@freezed
abstract class AgentesLibres with _$AgentesLibres {
  const factory AgentesLibres({
    String? idEquipo,
    @Default(<Bateador>[]) List<Bateador> bateadores,
    @Default(<Lanzador>[]) List<Lanzador> lanzadores,
  }) = _AgentesLibres;

  factory AgentesLibres.fromJson(Map<String, dynamic> json) => _$AgentesLibresFromJson(json);
}

@freezed
abstract class Lider with _$Lider {
  const factory Lider({
    required int posicion,
    required String idJugador,
    required String nombre,
    String? idEquipo,
    String? nombreEquipo,
    String? urlFoto,
    required double valor,
  }) = _Lider;

  factory Lider.fromJson(Map<String, dynamic> json) => _$LiderFromJson(json);
}

@freezed
abstract class Lideres with _$Lideres {
  const factory Lideres({
    required String tipo,
    required String estadistica,
    @Default(false) bool menorEsMejor,
    @Default(<Lider>[]) List<Lider> lideres,
    @Default(<String>[]) List<String> estadisticasDisponibles,
  }) = _Lideres;

  factory Lideres.fromJson(Map<String, dynamic> json) => _$LideresFromJson(json);
}

@freezed
abstract class TraspasoResultado with _$TraspasoResultado {
  const factory TraspasoResultado({required String tipo, Bateador? bateador, Lanzador? lanzador}) =
      _TraspasoResultado;

  factory TraspasoResultado.fromJson(Map<String, dynamic> json) => _$TraspasoResultadoFromJson(json);
}
