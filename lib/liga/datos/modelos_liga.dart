import 'package:freezed_annotation/freezed_annotation.dart';

part 'modelos_liga.freezed.dart';
part 'modelos_liga.g.dart';

// Contrato v1 de la API (docs/CONTRATO_API.md del backend). IDs numéricos.

enum EstadoTemporadaLiga {
  @JsonValue('DRAFT')
  borrador,
  @JsonValue('ACTIVE')
  activa,
  @JsonValue('FINISHED')
  finalizada,
}

enum EstadoPartidoLiga {
  @JsonValue('SCHEDULED')
  programado,
  @JsonValue('LINEUP_PUBLISHED')
  alineacionPublicada,
  @JsonValue('LIVE')
  enJuego,
  @JsonValue('FINISHED')
  finalizado,
  @JsonValue('SUSPENDED')
  suspendido,
}

enum MitadEntrada {
  @JsonValue('TOP')
  alta,
  @JsonValue('BOTTOM')
  baja,
}

enum LadoBateo {
  @JsonValue('D')
  derecho,
  @JsonValue('Z')
  zurdo,
  @JsonValue('A')
  ambidiestro,
}

enum LadoLanzamiento {
  @JsonValue('D')
  derecho,
  @JsonValue('Z')
  zurdo,
}

@freezed
abstract class TemporadaLiga with _$TemporadaLiga {
  const factory TemporadaLiga({
    required int id,
    required String nombre,
    required int anio,
    @Default(EstadoTemporadaLiga.borrador) EstadoTemporadaLiga estado,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) = _TemporadaLiga;

  factory TemporadaLiga.fromJson(Map<String, dynamic> json) => _$TemporadaLigaFromJson(json);
}

@freezed
abstract class EquipoRefLiga with _$EquipoRefLiga {
  const factory EquipoRefLiga({
    required int id,
    required String nombre,
    required String abreviatura,
    String? color,
    String? escudoUrl,
  }) = _EquipoRefLiga;

  factory EquipoRefLiga.fromJson(Map<String, dynamic> json) => _$EquipoRefLigaFromJson(json);
}

@freezed
abstract class EquipoLiga with _$EquipoLiga {
  const factory EquipoLiga({
    required int id,
    required String nombre,
    required String abreviatura,
    String? ciudad,
    String? color,
    String? escudoUrl,
  }) = _EquipoLiga;

  factory EquipoLiga.fromJson(Map<String, dynamic> json) => _$EquipoLigaFromJson(json);
}

@freezed
abstract class EstadioLiga with _$EstadioLiga {
  const factory EstadioLiga({
    required int id,
    required String nombre,
    String? ubicacion,
  }) = _EstadioLiga;

  factory EstadioLiga.fromJson(Map<String, dynamic> json) => _$EstadioLigaFromJson(json);
}

@freezed
abstract class JugadorResumenLiga with _$JugadorResumenLiga {
  const factory JugadorResumenLiga({
    required int id,
    required String nombres,
    required String apellidos,
    LadoBateo? batea,
    LadoLanzamiento? lanza,
    String? fotoUrl,
    @Default(false) bool esLanzador,
  }) = _JugadorResumenLiga;

  factory JugadorResumenLiga.fromJson(Map<String, dynamic> json) => _$JugadorResumenLigaFromJson(json);
}

@freezed
abstract class JugadorLiga with _$JugadorLiga {
  const factory JugadorLiga({
    required int id,
    required String nombres,
    required String apellidos,
    DateTime? fechaNacimiento,
    int? edad,
    LadoBateo? batea,
    /// Mano con la que lanza (la tienen todos los jugadores).
    LadoLanzamiento? lanza,
    String? fotoUrl,

    /// Es pitcher.
    @Default(false) bool esLanzador,
  }) = _JugadorLiga;

  factory JugadorLiga.fromJson(Map<String, dynamic> json) => _$JugadorLigaFromJson(json);
}

/// Entrada de la plantilla de una temporada. equipo nulo = agente libre.
@freezed
abstract class PlantillaLiga with _$PlantillaLiga {
  const factory PlantillaLiga({
    required int id,
    required JugadorResumenLiga jugador,
    EquipoRefLiga? equipo,
    int? numero,
    String? posicion,
  }) = _PlantillaLiga;

  factory PlantillaLiga.fromJson(Map<String, dynamic> json) => _$PlantillaLigaFromJson(json);
}

@freezed
abstract class JugadorRefLiga with _$JugadorRefLiga {
  const factory JugadorRefLiga({required int id, required String nombre}) = _JugadorRefLiga;

  factory JugadorRefLiga.fromJson(Map<String, dynamic> json) => _$JugadorRefLigaFromJson(json);
}

/// Marcador o pareja local/visita (carreras, hits o errores).
@freezed
abstract class ParLocalVisita with _$ParLocalVisita {
  const factory ParLocalVisita({@Default(0) int local, @Default(0) int visita}) = _ParLocalVisita;

  factory ParLocalVisita.fromJson(Map<String, dynamic> json) => _$ParLocalVisitaFromJson(json);
}

@freezed
abstract class EntradaLineScore with _$EntradaLineScore {
  const factory EntradaLineScore({required int numero, int? local, int? visita}) = _EntradaLineScore;

  factory EntradaLineScore.fromJson(Map<String, dynamic> json) => _$EntradaLineScoreFromJson(json);
}

/// Marcador por entrada, estilo MLB. Las entradas sin jugar llevan null.
@freezed
abstract class LineScore with _$LineScore {
  const factory LineScore({
    required int entradasProgramadas,
    @Default(false) bool entradasExtra,
    @Default(<EntradaLineScore>[]) List<EntradaLineScore> entradas,
  }) = _LineScore;

  factory LineScore.fromJson(Map<String, dynamic> json) => _$LineScoreFromJson(json);
}

@freezed
abstract class EstadioRefLiga with _$EstadioRefLiga {
  const factory EstadioRefLiga({required int id, required String nombre, String? ubicacion}) = _EstadioRefLiga;

  factory EstadioRefLiga.fromJson(Map<String, dynamic> json) => _$EstadioRefLigaFromJson(json);
}

/// Partido en listas (resumen).
@freezed
abstract class PartidoResumen with _$PartidoResumen {
  const factory PartidoResumen({
    required int id,
    required int temporadaId,
    required DateTime fechaHora,
    required EstadoPartidoLiga estado,
    EstadioRefLiga? estadio,
    required EquipoRefLiga equipoLocal,
    required EquipoRefLiga equipoVisita,
    required ParLocalVisita marcador,
    int? ganadorId,
  }) = _PartidoResumen;

  factory PartidoResumen.fromJson(Map<String, dynamic> json) => _$PartidoResumenFromJson(json);
}

@freezed
abstract class CorredoresLiga with _$CorredoresLiga {
  const factory CorredoresLiga({JugadorRefLiga? primera, JugadorRefLiga? segunda, JugadorRefLiga? tercera}) =
      _CorredoresLiga;

  factory CorredoresLiga.fromJson(Map<String, dynamic> json) => _$CorredoresLigaFromJson(json);
}

@freezed
abstract class SituacionLiga with _$SituacionLiga {
  const factory SituacionLiga({
    @Default(0) int outs,
    @Default(0) int bolas,
    @Default(0) int strikes,
    JugadorRefLiga? bateador,
    JugadorRefLiga? lanzador,
    CorredoresLiga? corredores,
  }) = _SituacionLiga;

  factory SituacionLiga.fromJson(Map<String, dynamic> json) => _$SituacionLigaFromJson(json);
}

/// Partido con marcador por entrada, situación en vivo y estadísticas del momento.
@freezed
abstract class PartidoDetalle with _$PartidoDetalle {
  const factory PartidoDetalle({
    required int id,
    required int temporadaId,
    required DateTime fechaHora,
    required EstadoPartidoLiga estado,
    EstadioRefLiga? estadio,
    required EquipoRefLiga equipoLocal,
    required EquipoRefLiga equipoVisita,
    required ParLocalVisita marcador,
    int? ganadorId,
    required int entradasProgramadas,
    required int entradaActual,
    @Default(MitadEntrada.alta) MitadEntrada mitad,
    SituacionLiga? situacion,
    @Default(ParLocalVisita()) ParLocalVisita hits,
    @Default(ParLocalVisita()) ParLocalVisita errores,
    required LineScore lineScore,
    int? version,
  }) = _PartidoDetalle;

  factory PartidoDetalle.fromJson(Map<String, dynamic> json) => _$PartidoDetalleFromJson(json);
}

@freezed
abstract class PosicionLiga with _$PosicionLiga {
  const factory PosicionLiga({
    required EquipoRefLiga equipo,
    @Default(0) int juegos,
    @Default(0) int ganados,
    @Default(0) int perdidos,
    @Default(0) double pct,
    @Default(0) int carrerasFavor,
    @Default(0) int carrerasContra,
  }) = _PosicionLiga;

  factory PosicionLiga.fromJson(Map<String, dynamic> json) => _$PosicionLigaFromJson(json);
}

@freezed
abstract class BateadorAlineacion with _$BateadorAlineacion {
  const factory BateadorAlineacion({
    required int orden,
    required String posicion,
    required JugadorResumenLiga jugador,
  }) = _BateadorAlineacion;

  factory BateadorAlineacion.fromJson(Map<String, dynamic> json) => _$BateadorAlineacionFromJson(json);
}

@freezed
abstract class EquipoAlineacion with _$EquipoAlineacion {
  const factory EquipoAlineacion({
    required EquipoRefLiga equipo,
    JugadorResumenLiga? lanzadorInicial,
    @Default(<BateadorAlineacion>[]) List<BateadorAlineacion> bateo,
    @Default(<JugadorResumenLiga>[]) List<JugadorResumenLiga> banca,
  }) = _EquipoAlineacion;

  factory EquipoAlineacion.fromJson(Map<String, dynamic> json) => _$EquipoAlineacionFromJson(json);
}

/// Alineación completa. Si publicada es false y no tienes permiso, local y visita llegan nulos.
@freezed
abstract class Alineacion with _$Alineacion {
  const factory Alineacion({
    @Default(false) bool publicada,
    EquipoAlineacion? local,
    EquipoAlineacion? visita,
  }) = _Alineacion;

  factory Alineacion.fromJson(Map<String, dynamic> json) => _$AlineacionFromJson(json);
}

@freezed
abstract class EquipoPitcheo with _$EquipoPitcheo {
  const factory EquipoPitcheo({
    required EquipoRefLiga equipo,
    JugadorResumenLiga? lanzadorInicial,
    @Default(<JugadorResumenLiga>[]) List<JugadorResumenLiga> relevistas,
  }) = _EquipoPitcheo;

  factory EquipoPitcheo.fromJson(Map<String, dynamic> json) => _$EquipoPitcheoFromJson(json);
}

/// Alineación de pitcheo (botón de pitcheo): lanzador inicial y relevistas.
@freezed
abstract class Pitcheo with _$Pitcheo {
  const factory Pitcheo({
    @Default(false) bool publicada,
    EquipoPitcheo? local,
    EquipoPitcheo? visita,
  }) = _Pitcheo;

  factory Pitcheo.fromJson(Map<String, dynamic> json) => _$PitcheoFromJson(json);
}
