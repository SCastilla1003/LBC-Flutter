// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_partido.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Partido _$PartidoFromJson(Map<String, dynamic> json) => _Partido(
  id: json['id'] as String,
  fecha: json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String),
  hora: json['hora'] as String?,
  estado:
      $enumDecodeNullable(_$EstadoPartidoEnumMap, json['estado']) ??
      EstadoPartido.programado,
  estadio: json['estadio'] == null
      ? null
      : EstadioRef.fromJson(json['estadio'] as Map<String, dynamic>),
  equipoLocal: EquipoRef.fromJson(json['equipoLocal'] as Map<String, dynamic>),
  equipoVisitante: EquipoRef.fromJson(
    json['equipoVisitante'] as Map<String, dynamic>,
  ),
  carrerasEquipoLocal: (json['carrerasEquipoLocal'] as num?)?.toInt() ?? 0,
  carrerasEquipoVisitante:
      (json['carrerasEquipoVisitante'] as num?)?.toInt() ?? 0,
  innings: (json['innings'] as num?)?.toInt() ?? 9,
  inningActual: (json['inningActual'] as num?)?.toInt() ?? 0,
  hitTotalesPartido: (json['hitTotalesPartido'] as num?)?.toInt() ?? 0,
  erroresTotalesPartido: (json['erroresTotalesPartido'] as num?)?.toInt() ?? 0,
  idEquipoGanador: json['idEquipoGanador'] as String?,
);

Map<String, dynamic> _$PartidoToJson(_Partido instance) => <String, dynamic>{
  'id': instance.id,
  'fecha': instance.fecha?.toIso8601String(),
  'hora': instance.hora,
  'estado': _$EstadoPartidoEnumMap[instance.estado]!,
  'estadio': instance.estadio?.toJson(),
  'equipoLocal': instance.equipoLocal.toJson(),
  'equipoVisitante': instance.equipoVisitante.toJson(),
  'carrerasEquipoLocal': instance.carrerasEquipoLocal,
  'carrerasEquipoVisitante': instance.carrerasEquipoVisitante,
  'innings': instance.innings,
  'inningActual': instance.inningActual,
  'hitTotalesPartido': instance.hitTotalesPartido,
  'erroresTotalesPartido': instance.erroresTotalesPartido,
  'idEquipoGanador': instance.idEquipoGanador,
};

const _$EstadoPartidoEnumMap = {
  EstadoPartido.programado: 'PROGRAMADO',
  EstadoPartido.enJuego: 'EN_JUEGO',
  EstadoPartido.finalizado: 'FINALIZADO',
};

_Estadio _$EstadioFromJson(Map<String, dynamic> json) => _Estadio(
  id: json['id'] as String,
  nombre: json['nombre'] as String,
  ubicacion: json['ubicacion'] as String?,
  partidosJugados: (json['partidosJugados'] as num?)?.toInt() ?? 0,
  partidosProgramados: (json['partidosProgramados'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$EstadioToJson(_Estadio instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.nombre,
  'ubicacion': instance.ubicacion,
  'partidosJugados': instance.partidosJugados,
  'partidosProgramados': instance.partidosProgramados,
};
