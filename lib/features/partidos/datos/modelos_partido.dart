import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/modelos/modelos_comunes.dart';

part 'modelos_partido.freezed.dart';
part 'modelos_partido.g.dart';

enum EstadoPartido {
  @JsonValue('PROGRAMADO')
  programado('Programado'),
  @JsonValue('EN_JUEGO')
  enJuego('En juego'),
  @JsonValue('FINALIZADO')
  finalizado('Finalizado');

  const EstadoPartido(this.etiqueta);

  final String etiqueta;

  /// Valor que espera la API.
  String get valorApi => switch (this) {
        EstadoPartido.programado => 'PROGRAMADO',
        EstadoPartido.enJuego => 'EN_JUEGO',
        EstadoPartido.finalizado => 'FINALIZADO',
      };
}

/// Partido (`PartidoDto`). [hora] llega como "09:30:00".
@freezed
abstract class Partido with _$Partido {
  const Partido._();

  const factory Partido({
    required String id,
    DateTime? fecha,
    String? hora,
    @Default(EstadoPartido.programado) EstadoPartido estado,
    EstadioRef? estadio,
    required EquipoRef equipoLocal,
    required EquipoRef equipoVisitante,
    @Default(0) int carrerasEquipoLocal,
    @Default(0) int carrerasEquipoVisitante,
    @Default(9) int innings,
    @Default(0) int inningActual,
    @Default(0) int hitTotalesPartido,
    @Default(0) int erroresTotalesPartido,
    String? idEquipoGanador,
  }) = _Partido;

  factory Partido.fromJson(Map<String, dynamic> json) => _$PartidoFromJson(json);

  bool get finalizado => estado == EstadoPartido.finalizado;
}

/// Estadio de una temporada (`EstadioDto`).
@freezed
abstract class Estadio with _$Estadio {
  const factory Estadio({
    required String id,
    required String nombre,
    String? ubicacion,
    @Default(0) int partidosJugados,
    @Default(0) int partidosProgramados,
  }) = _Estadio;

  factory Estadio.fromJson(Map<String, dynamic> json) => _$EstadioFromJson(json);
}
