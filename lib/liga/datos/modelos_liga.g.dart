// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_liga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemporadaLiga _$TemporadaLigaFromJson(Map<String, dynamic> json) =>
    _TemporadaLiga(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      anio: (json['anio'] as num).toInt(),
      estado:
          $enumDecodeNullable(_$EstadoTemporadaLigaEnumMap, json['estado']) ??
          EstadoTemporadaLiga.borrador,
      fechaInicio: json['fechaInicio'] == null
          ? null
          : DateTime.parse(json['fechaInicio'] as String),
      fechaFin: json['fechaFin'] == null
          ? null
          : DateTime.parse(json['fechaFin'] as String),
    );

Map<String, dynamic> _$TemporadaLigaToJson(_TemporadaLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'anio': instance.anio,
      'estado': _$EstadoTemporadaLigaEnumMap[instance.estado]!,
      'fechaInicio': instance.fechaInicio?.toIso8601String(),
      'fechaFin': instance.fechaFin?.toIso8601String(),
    };

const _$EstadoTemporadaLigaEnumMap = {
  EstadoTemporadaLiga.borrador: 'DRAFT',
  EstadoTemporadaLiga.activa: 'ACTIVE',
  EstadoTemporadaLiga.finalizada: 'FINISHED',
};

_EquipoRefLiga _$EquipoRefLigaFromJson(Map<String, dynamic> json) =>
    _EquipoRefLiga(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      abreviatura: json['abreviatura'] as String,
      color: json['color'] as String?,
      escudoUrl: json['escudoUrl'] as String?,
    );

Map<String, dynamic> _$EquipoRefLigaToJson(_EquipoRefLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'abreviatura': instance.abreviatura,
      'color': instance.color,
      'escudoUrl': instance.escudoUrl,
    };

_EquipoLiga _$EquipoLigaFromJson(Map<String, dynamic> json) => _EquipoLiga(
  id: (json['id'] as num).toInt(),
  nombre: json['nombre'] as String,
  abreviatura: json['abreviatura'] as String,
  ciudad: json['ciudad'] as String?,
  color: json['color'] as String?,
  escudoUrl: json['escudoUrl'] as String?,
);

Map<String, dynamic> _$EquipoLigaToJson(_EquipoLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'abreviatura': instance.abreviatura,
      'ciudad': instance.ciudad,
      'color': instance.color,
      'escudoUrl': instance.escudoUrl,
    };

_EstadioLiga _$EstadioLigaFromJson(Map<String, dynamic> json) => _EstadioLiga(
  id: (json['id'] as num).toInt(),
  nombre: json['nombre'] as String,
  ubicacion: json['ubicacion'] as String?,
);

Map<String, dynamic> _$EstadioLigaToJson(_EstadioLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'ubicacion': instance.ubicacion,
    };

_JugadorResumenLiga _$JugadorResumenLigaFromJson(Map<String, dynamic> json) =>
    _JugadorResumenLiga(
      id: (json['id'] as num).toInt(),
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      batea: $enumDecodeNullable(_$LadoBateoEnumMap, json['batea']),
      lanza: $enumDecodeNullable(_$LadoLanzamientoEnumMap, json['lanza']),
      fotoUrl: json['fotoUrl'] as String?,
      esLanzador: json['esLanzador'] as bool? ?? false,
    );

Map<String, dynamic> _$JugadorResumenLigaToJson(_JugadorResumenLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombres': instance.nombres,
      'apellidos': instance.apellidos,
      'batea': _$LadoBateoEnumMap[instance.batea],
      'lanza': _$LadoLanzamientoEnumMap[instance.lanza],
      'fotoUrl': instance.fotoUrl,
      'esLanzador': instance.esLanzador,
    };

const _$LadoBateoEnumMap = {
  LadoBateo.derecho: 'D',
  LadoBateo.zurdo: 'Z',
  LadoBateo.ambidiestro: 'A',
};

const _$LadoLanzamientoEnumMap = {
  LadoLanzamiento.derecho: 'D',
  LadoLanzamiento.zurdo: 'Z',
};

_JugadorLiga _$JugadorLigaFromJson(Map<String, dynamic> json) => _JugadorLiga(
  id: (json['id'] as num).toInt(),
  nombres: json['nombres'] as String,
  apellidos: json['apellidos'] as String,
  fechaNacimiento: json['fechaNacimiento'] == null
      ? null
      : DateTime.parse(json['fechaNacimiento'] as String),
  edad: (json['edad'] as num?)?.toInt(),
  batea: $enumDecodeNullable(_$LadoBateoEnumMap, json['batea']),
  lanza: $enumDecodeNullable(_$LadoLanzamientoEnumMap, json['lanza']),
  fotoUrl: json['fotoUrl'] as String?,
  esLanzador: json['esLanzador'] as bool? ?? false,
);

Map<String, dynamic> _$JugadorLigaToJson(_JugadorLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombres': instance.nombres,
      'apellidos': instance.apellidos,
      'fechaNacimiento': instance.fechaNacimiento?.toIso8601String(),
      'edad': instance.edad,
      'batea': _$LadoBateoEnumMap[instance.batea],
      'lanza': _$LadoLanzamientoEnumMap[instance.lanza],
      'fotoUrl': instance.fotoUrl,
      'esLanzador': instance.esLanzador,
    };

_PlantillaLiga _$PlantillaLigaFromJson(Map<String, dynamic> json) =>
    _PlantillaLiga(
      id: (json['id'] as num).toInt(),
      jugador: JugadorResumenLiga.fromJson(
        json['jugador'] as Map<String, dynamic>,
      ),
      equipo: json['equipo'] == null
          ? null
          : EquipoRefLiga.fromJson(json['equipo'] as Map<String, dynamic>),
      numero: (json['numero'] as num?)?.toInt(),
      posicion: json['posicion'] as String?,
    );

Map<String, dynamic> _$PlantillaLigaToJson(_PlantillaLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jugador': instance.jugador.toJson(),
      'equipo': instance.equipo?.toJson(),
      'numero': instance.numero,
      'posicion': instance.posicion,
    };

_JugadorRefLiga _$JugadorRefLigaFromJson(Map<String, dynamic> json) =>
    _JugadorRefLiga(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
    );

Map<String, dynamic> _$JugadorRefLigaToJson(_JugadorRefLiga instance) =>
    <String, dynamic>{'id': instance.id, 'nombre': instance.nombre};

_ParLocalVisita _$ParLocalVisitaFromJson(Map<String, dynamic> json) =>
    _ParLocalVisita(
      local: (json['local'] as num?)?.toInt() ?? 0,
      visita: (json['visita'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ParLocalVisitaToJson(_ParLocalVisita instance) =>
    <String, dynamic>{'local': instance.local, 'visita': instance.visita};

_EntradaLineScore _$EntradaLineScoreFromJson(Map<String, dynamic> json) =>
    _EntradaLineScore(
      numero: (json['numero'] as num).toInt(),
      local: (json['local'] as num?)?.toInt(),
      visita: (json['visita'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EntradaLineScoreToJson(_EntradaLineScore instance) =>
    <String, dynamic>{
      'numero': instance.numero,
      'local': instance.local,
      'visita': instance.visita,
    };

_LineScore _$LineScoreFromJson(Map<String, dynamic> json) => _LineScore(
  entradasProgramadas: (json['entradasProgramadas'] as num).toInt(),
  entradasExtra: json['entradasExtra'] as bool? ?? false,
  entradas:
      (json['entradas'] as List<dynamic>?)
          ?.map((e) => EntradaLineScore.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EntradaLineScore>[],
);

Map<String, dynamic> _$LineScoreToJson(_LineScore instance) =>
    <String, dynamic>{
      'entradasProgramadas': instance.entradasProgramadas,
      'entradasExtra': instance.entradasExtra,
      'entradas': instance.entradas.map((e) => e.toJson()).toList(),
    };

_EstadioRefLiga _$EstadioRefLigaFromJson(Map<String, dynamic> json) =>
    _EstadioRefLiga(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      ubicacion: json['ubicacion'] as String?,
    );

Map<String, dynamic> _$EstadioRefLigaToJson(_EstadioRefLiga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'ubicacion': instance.ubicacion,
    };

_PartidoResumen _$PartidoResumenFromJson(Map<String, dynamic> json) =>
    _PartidoResumen(
      id: (json['id'] as num).toInt(),
      temporadaId: (json['temporadaId'] as num).toInt(),
      fechaHora: DateTime.parse(json['fechaHora'] as String),
      estado: $enumDecode(_$EstadoPartidoLigaEnumMap, json['estado']),
      estadio: json['estadio'] == null
          ? null
          : EstadioRefLiga.fromJson(json['estadio'] as Map<String, dynamic>),
      equipoLocal: EquipoRefLiga.fromJson(
        json['equipoLocal'] as Map<String, dynamic>,
      ),
      equipoVisita: EquipoRefLiga.fromJson(
        json['equipoVisita'] as Map<String, dynamic>,
      ),
      marcador: ParLocalVisita.fromJson(
        json['marcador'] as Map<String, dynamic>,
      ),
      ganadorId: (json['ganadorId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PartidoResumenToJson(_PartidoResumen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temporadaId': instance.temporadaId,
      'fechaHora': instance.fechaHora.toIso8601String(),
      'estado': _$EstadoPartidoLigaEnumMap[instance.estado]!,
      'estadio': instance.estadio?.toJson(),
      'equipoLocal': instance.equipoLocal.toJson(),
      'equipoVisita': instance.equipoVisita.toJson(),
      'marcador': instance.marcador.toJson(),
      'ganadorId': instance.ganadorId,
    };

const _$EstadoPartidoLigaEnumMap = {
  EstadoPartidoLiga.programado: 'SCHEDULED',
  EstadoPartidoLiga.alineacionPublicada: 'LINEUP_PUBLISHED',
  EstadoPartidoLiga.enJuego: 'LIVE',
  EstadoPartidoLiga.finalizado: 'FINISHED',
  EstadoPartidoLiga.suspendido: 'SUSPENDED',
};

_CorredoresLiga _$CorredoresLigaFromJson(Map<String, dynamic> json) =>
    _CorredoresLiga(
      primera: json['primera'] == null
          ? null
          : JugadorRefLiga.fromJson(json['primera'] as Map<String, dynamic>),
      segunda: json['segunda'] == null
          ? null
          : JugadorRefLiga.fromJson(json['segunda'] as Map<String, dynamic>),
      tercera: json['tercera'] == null
          ? null
          : JugadorRefLiga.fromJson(json['tercera'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CorredoresLigaToJson(_CorredoresLiga instance) =>
    <String, dynamic>{
      'primera': instance.primera?.toJson(),
      'segunda': instance.segunda?.toJson(),
      'tercera': instance.tercera?.toJson(),
    };

_SituacionLiga _$SituacionLigaFromJson(Map<String, dynamic> json) =>
    _SituacionLiga(
      outs: (json['outs'] as num?)?.toInt() ?? 0,
      bolas: (json['bolas'] as num?)?.toInt() ?? 0,
      strikes: (json['strikes'] as num?)?.toInt() ?? 0,
      bateador: json['bateador'] == null
          ? null
          : JugadorRefLiga.fromJson(json['bateador'] as Map<String, dynamic>),
      lanzador: json['lanzador'] == null
          ? null
          : JugadorRefLiga.fromJson(json['lanzador'] as Map<String, dynamic>),
      corredores: json['corredores'] == null
          ? null
          : CorredoresLiga.fromJson(json['corredores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SituacionLigaToJson(_SituacionLiga instance) =>
    <String, dynamic>{
      'outs': instance.outs,
      'bolas': instance.bolas,
      'strikes': instance.strikes,
      'bateador': instance.bateador?.toJson(),
      'lanzador': instance.lanzador?.toJson(),
      'corredores': instance.corredores?.toJson(),
    };

_PartidoDetalle _$PartidoDetalleFromJson(Map<String, dynamic> json) =>
    _PartidoDetalle(
      id: (json['id'] as num).toInt(),
      temporadaId: (json['temporadaId'] as num).toInt(),
      fechaHora: DateTime.parse(json['fechaHora'] as String),
      estado: $enumDecode(_$EstadoPartidoLigaEnumMap, json['estado']),
      estadio: json['estadio'] == null
          ? null
          : EstadioRefLiga.fromJson(json['estadio'] as Map<String, dynamic>),
      equipoLocal: EquipoRefLiga.fromJson(
        json['equipoLocal'] as Map<String, dynamic>,
      ),
      equipoVisita: EquipoRefLiga.fromJson(
        json['equipoVisita'] as Map<String, dynamic>,
      ),
      marcador: ParLocalVisita.fromJson(
        json['marcador'] as Map<String, dynamic>,
      ),
      ganadorId: (json['ganadorId'] as num?)?.toInt(),
      entradasProgramadas: (json['entradasProgramadas'] as num).toInt(),
      entradaActual: (json['entradaActual'] as num).toInt(),
      mitad:
          $enumDecodeNullable(_$MitadEntradaEnumMap, json['mitad']) ??
          MitadEntrada.alta,
      situacion: json['situacion'] == null
          ? null
          : SituacionLiga.fromJson(json['situacion'] as Map<String, dynamic>),
      hits: json['hits'] == null
          ? const ParLocalVisita()
          : ParLocalVisita.fromJson(json['hits'] as Map<String, dynamic>),
      errores: json['errores'] == null
          ? const ParLocalVisita()
          : ParLocalVisita.fromJson(json['errores'] as Map<String, dynamic>),
      lineScore: LineScore.fromJson(json['lineScore'] as Map<String, dynamic>),
      version: (json['version'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PartidoDetalleToJson(_PartidoDetalle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temporadaId': instance.temporadaId,
      'fechaHora': instance.fechaHora.toIso8601String(),
      'estado': _$EstadoPartidoLigaEnumMap[instance.estado]!,
      'estadio': instance.estadio?.toJson(),
      'equipoLocal': instance.equipoLocal.toJson(),
      'equipoVisita': instance.equipoVisita.toJson(),
      'marcador': instance.marcador.toJson(),
      'ganadorId': instance.ganadorId,
      'entradasProgramadas': instance.entradasProgramadas,
      'entradaActual': instance.entradaActual,
      'mitad': _$MitadEntradaEnumMap[instance.mitad]!,
      'situacion': instance.situacion?.toJson(),
      'hits': instance.hits.toJson(),
      'errores': instance.errores.toJson(),
      'lineScore': instance.lineScore.toJson(),
      'version': instance.version,
    };

const _$MitadEntradaEnumMap = {
  MitadEntrada.alta: 'TOP',
  MitadEntrada.baja: 'BOTTOM',
};

_PosicionLiga _$PosicionLigaFromJson(Map<String, dynamic> json) =>
    _PosicionLiga(
      equipo: EquipoRefLiga.fromJson(json['equipo'] as Map<String, dynamic>),
      juegos: (json['juegos'] as num?)?.toInt() ?? 0,
      ganados: (json['ganados'] as num?)?.toInt() ?? 0,
      perdidos: (json['perdidos'] as num?)?.toInt() ?? 0,
      pct: (json['pct'] as num?)?.toDouble() ?? 0,
      carrerasFavor: (json['carrerasFavor'] as num?)?.toInt() ?? 0,
      carrerasContra: (json['carrerasContra'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PosicionLigaToJson(_PosicionLiga instance) =>
    <String, dynamic>{
      'equipo': instance.equipo.toJson(),
      'juegos': instance.juegos,
      'ganados': instance.ganados,
      'perdidos': instance.perdidos,
      'pct': instance.pct,
      'carrerasFavor': instance.carrerasFavor,
      'carrerasContra': instance.carrerasContra,
    };

_BateadorAlineacion _$BateadorAlineacionFromJson(Map<String, dynamic> json) =>
    _BateadorAlineacion(
      orden: (json['orden'] as num).toInt(),
      posicion: json['posicion'] as String,
      jugador: JugadorResumenLiga.fromJson(
        json['jugador'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$BateadorAlineacionToJson(_BateadorAlineacion instance) =>
    <String, dynamic>{
      'orden': instance.orden,
      'posicion': instance.posicion,
      'jugador': instance.jugador.toJson(),
    };

_EquipoAlineacion _$EquipoAlineacionFromJson(
  Map<String, dynamic> json,
) => _EquipoAlineacion(
  equipo: EquipoRefLiga.fromJson(json['equipo'] as Map<String, dynamic>),
  lanzadorInicial: json['lanzadorInicial'] == null
      ? null
      : JugadorResumenLiga.fromJson(
          json['lanzadorInicial'] as Map<String, dynamic>,
        ),
  bateo:
      (json['bateo'] as List<dynamic>?)
          ?.map((e) => BateadorAlineacion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <BateadorAlineacion>[],
  banca:
      (json['banca'] as List<dynamic>?)
          ?.map((e) => JugadorResumenLiga.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <JugadorResumenLiga>[],
);

Map<String, dynamic> _$EquipoAlineacionToJson(_EquipoAlineacion instance) =>
    <String, dynamic>{
      'equipo': instance.equipo.toJson(),
      'lanzadorInicial': instance.lanzadorInicial?.toJson(),
      'bateo': instance.bateo.map((e) => e.toJson()).toList(),
      'banca': instance.banca.map((e) => e.toJson()).toList(),
    };

_Alineacion _$AlineacionFromJson(Map<String, dynamic> json) => _Alineacion(
  publicada: json['publicada'] as bool? ?? false,
  local: json['local'] == null
      ? null
      : EquipoAlineacion.fromJson(json['local'] as Map<String, dynamic>),
  visita: json['visita'] == null
      ? null
      : EquipoAlineacion.fromJson(json['visita'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AlineacionToJson(_Alineacion instance) =>
    <String, dynamic>{
      'publicada': instance.publicada,
      'local': instance.local?.toJson(),
      'visita': instance.visita?.toJson(),
    };

_EquipoPitcheo _$EquipoPitcheoFromJson(Map<String, dynamic> json) =>
    _EquipoPitcheo(
      equipo: EquipoRefLiga.fromJson(json['equipo'] as Map<String, dynamic>),
      lanzadorInicial: json['lanzadorInicial'] == null
          ? null
          : JugadorResumenLiga.fromJson(
              json['lanzadorInicial'] as Map<String, dynamic>,
            ),
      relevistas:
          (json['relevistas'] as List<dynamic>?)
              ?.map(
                (e) => JugadorResumenLiga.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <JugadorResumenLiga>[],
    );

Map<String, dynamic> _$EquipoPitcheoToJson(_EquipoPitcheo instance) =>
    <String, dynamic>{
      'equipo': instance.equipo.toJson(),
      'lanzadorInicial': instance.lanzadorInicial?.toJson(),
      'relevistas': instance.relevistas.map((e) => e.toJson()).toList(),
    };

_Pitcheo _$PitcheoFromJson(Map<String, dynamic> json) => _Pitcheo(
  publicada: json['publicada'] as bool? ?? false,
  local: json['local'] == null
      ? null
      : EquipoPitcheo.fromJson(json['local'] as Map<String, dynamic>),
  visita: json['visita'] == null
      ? null
      : EquipoPitcheo.fromJson(json['visita'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PitcheoToJson(_Pitcheo instance) => <String, dynamic>{
  'publicada': instance.publicada,
  'local': instance.local?.toJson(),
  'visita': instance.visita?.toJson(),
};
