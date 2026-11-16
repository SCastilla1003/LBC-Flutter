// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_temporada.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemporadaResumen _$TemporadaResumenFromJson(Map<String, dynamic> json) =>
    _TemporadaResumen(
      id: json['id'] as String,
      nombreTemporada: json['nombreTemporada'] as String,
      anio: (json['anio'] as num).toInt(),
      totalEquipos: (json['totalEquipos'] as num?)?.toInt() ?? 0,
      totalPartidos: (json['totalPartidos'] as num?)?.toInt() ?? 0,
      partidosFinalizados: (json['partidosFinalizados'] as num?)?.toInt() ?? 0,
      campeon: json['campeon'] == null
          ? null
          : EquipoRef.fromJson(json['campeon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TemporadaResumenToJson(_TemporadaResumen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombreTemporada': instance.nombreTemporada,
      'anio': instance.anio,
      'totalEquipos': instance.totalEquipos,
      'totalPartidos': instance.totalPartidos,
      'partidosFinalizados': instance.partidosFinalizados,
      'campeon': instance.campeon?.toJson(),
    };

_TemporadaDetalle _$TemporadaDetalleFromJson(Map<String, dynamic> json) =>
    _TemporadaDetalle(
      id: json['id'] as String,
      nombreTemporada: json['nombreTemporada'] as String,
      anio: (json['anio'] as num).toInt(),
      campeon: json['campeon'] == null
          ? null
          : EquipoRef.fromJson(json['campeon'] as Map<String, dynamic>),
      totalPartidos: (json['totalPartidos'] as num?)?.toInt() ?? 0,
      partidosFinalizados: (json['partidosFinalizados'] as num?)?.toInt() ?? 0,
      totalAgentesLibres: (json['totalAgentesLibres'] as num?)?.toInt() ?? 0,
      equipos:
          (json['equipos'] as List<dynamic>?)
              ?.map((e) => Equipo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Equipo>[],
      estadios:
          (json['estadios'] as List<dynamic>?)
              ?.map((e) => Estadio.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Estadio>[],
    );

Map<String, dynamic> _$TemporadaDetalleToJson(_TemporadaDetalle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombreTemporada': instance.nombreTemporada,
      'anio': instance.anio,
      'campeon': instance.campeon?.toJson(),
      'totalPartidos': instance.totalPartidos,
      'partidosFinalizados': instance.partidosFinalizados,
      'totalAgentesLibres': instance.totalAgentesLibres,
      'equipos': instance.equipos.map((e) => e.toJson()).toList(),
      'estadios': instance.estadios.map((e) => e.toJson()).toList(),
    };

_EstadisticasTemporada _$EstadisticasTemporadaFromJson(
  Map<String, dynamic> json,
) => _EstadisticasTemporada(
  idTemporada: json['idTemporada'] as String,
  kpis: Kpis.fromJson(json['kpis'] as Map<String, dynamic>),
  carrerasPorPartido:
      (json['carrerasPorPartido'] as List<dynamic>?)
          ?.map((e) => CarrerasPartido.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CarrerasPartido>[],
  victoriasPorEquipo:
      (json['victoriasPorEquipo'] as List<dynamic>?)
          ?.map((e) => VictoriasEquipo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <VictoriasEquipo>[],
  distribucionHits: json['distribucionHits'] == null
      ? const DistribucionHits()
      : DistribucionHits.fromJson(
          json['distribucionHits'] as Map<String, dynamic>,
        ),
  partidosPorEstadio:
      (json['partidosPorEstadio'] as List<dynamic>?)
          ?.map((e) => PartidosEstadio.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PartidosEstadio>[],
  referenciaBateo:
      (json['referenciaBateo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Referencia.fromJson(e as Map<String, dynamic>)),
      ) ??
      const <String, Referencia>{},
  referenciaPitcheo:
      (json['referenciaPitcheo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Referencia.fromJson(e as Map<String, dynamic>)),
      ) ??
      const <String, Referencia>{},
);

Map<String, dynamic> _$EstadisticasTemporadaToJson(
  _EstadisticasTemporada instance,
) => <String, dynamic>{
  'idTemporada': instance.idTemporada,
  'kpis': instance.kpis.toJson(),
  'carrerasPorPartido': instance.carrerasPorPartido
      .map((e) => e.toJson())
      .toList(),
  'victoriasPorEquipo': instance.victoriasPorEquipo
      .map((e) => e.toJson())
      .toList(),
  'distribucionHits': instance.distribucionHits.toJson(),
  'partidosPorEstadio': instance.partidosPorEstadio
      .map((e) => e.toJson())
      .toList(),
  'referenciaBateo': instance.referenciaBateo.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'referenciaPitcheo': instance.referenciaPitcheo.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
};

_Kpis _$KpisFromJson(Map<String, dynamic> json) => _Kpis(
  partidosJugados: (json['partidosJugados'] as num?)?.toInt() ?? 0,
  partidosPendientes: (json['partidosPendientes'] as num?)?.toInt() ?? 0,
  carrerasTotales: (json['carrerasTotales'] as num?)?.toInt() ?? 0,
  promedioCarrerasPorPartido: (json['promedioCarrerasPorPartido'] as num?)
      ?.toDouble(),
  totalEquipos: (json['totalEquipos'] as num?)?.toInt() ?? 0,
  totalJugadores: (json['totalJugadores'] as num?)?.toInt() ?? 0,
  liderJonrones: json['liderJonrones'] == null
      ? null
      : JugadorDestacado.fromJson(
          json['liderJonrones'] as Map<String, dynamic>,
        ),
  mejorRecord: json['mejorRecord'] == null
      ? null
      : EquipoDestacado.fromJson(json['mejorRecord'] as Map<String, dynamic>),
);

Map<String, dynamic> _$KpisToJson(_Kpis instance) => <String, dynamic>{
  'partidosJugados': instance.partidosJugados,
  'partidosPendientes': instance.partidosPendientes,
  'carrerasTotales': instance.carrerasTotales,
  'promedioCarrerasPorPartido': instance.promedioCarrerasPorPartido,
  'totalEquipos': instance.totalEquipos,
  'totalJugadores': instance.totalJugadores,
  'liderJonrones': instance.liderJonrones?.toJson(),
  'mejorRecord': instance.mejorRecord?.toJson(),
};

_JugadorDestacado _$JugadorDestacadoFromJson(Map<String, dynamic> json) =>
    _JugadorDestacado(
      idJugador: json['idJugador'] as String,
      nombre: json['nombre'] as String,
      idEquipo: json['idEquipo'] as String?,
      nombreEquipo: json['nombreEquipo'] as String?,
      urlFoto: json['urlFoto'] as String?,
      valor: (json['valor'] as num).toDouble(),
    );

Map<String, dynamic> _$JugadorDestacadoToJson(_JugadorDestacado instance) =>
    <String, dynamic>{
      'idJugador': instance.idJugador,
      'nombre': instance.nombre,
      'idEquipo': instance.idEquipo,
      'nombreEquipo': instance.nombreEquipo,
      'urlFoto': instance.urlFoto,
      'valor': instance.valor,
    };

_EquipoDestacado _$EquipoDestacadoFromJson(Map<String, dynamic> json) =>
    _EquipoDestacado(
      idEquipo: json['idEquipo'] as String,
      nombre: json['nombre'] as String,
      urlFoto: json['urlFoto'] as String?,
      ganados: (json['ganados'] as num?)?.toInt() ?? 0,
      perdidos: (json['perdidos'] as num?)?.toInt() ?? 0,
      porcentajeVictorias: (json['porcentajeVictorias'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EquipoDestacadoToJson(_EquipoDestacado instance) =>
    <String, dynamic>{
      'idEquipo': instance.idEquipo,
      'nombre': instance.nombre,
      'urlFoto': instance.urlFoto,
      'ganados': instance.ganados,
      'perdidos': instance.perdidos,
      'porcentajeVictorias': instance.porcentajeVictorias,
    };

_CarrerasPartido _$CarrerasPartidoFromJson(Map<String, dynamic> json) =>
    _CarrerasPartido(
      idPartido: json['idPartido'] as String,
      fecha: json['fecha'] == null
          ? null
          : DateTime.parse(json['fecha'] as String),
      local: json['local'] == null
          ? null
          : EquipoRef.fromJson(json['local'] as Map<String, dynamic>),
      visitante: json['visitante'] == null
          ? null
          : EquipoRef.fromJson(json['visitante'] as Map<String, dynamic>),
      carrerasLocal: (json['carrerasLocal'] as num?)?.toInt() ?? 0,
      carrerasVisitante: (json['carrerasVisitante'] as num?)?.toInt() ?? 0,
      carrerasTotales: (json['carrerasTotales'] as num?)?.toInt() ?? 0,
      hits: (json['hits'] as num?)?.toInt() ?? 0,
      errores: (json['errores'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CarrerasPartidoToJson(_CarrerasPartido instance) =>
    <String, dynamic>{
      'idPartido': instance.idPartido,
      'fecha': instance.fecha?.toIso8601String(),
      'local': instance.local?.toJson(),
      'visitante': instance.visitante?.toJson(),
      'carrerasLocal': instance.carrerasLocal,
      'carrerasVisitante': instance.carrerasVisitante,
      'carrerasTotales': instance.carrerasTotales,
      'hits': instance.hits,
      'errores': instance.errores,
    };

_VictoriasEquipo _$VictoriasEquipoFromJson(Map<String, dynamic> json) =>
    _VictoriasEquipo(
      idEquipo: json['idEquipo'] as String,
      nombre: json['nombre'] as String,
      ganados: (json['ganados'] as num?)?.toInt() ?? 0,
      perdidos: (json['perdidos'] as num?)?.toInt() ?? 0,
      empates: (json['empates'] as num?)?.toInt() ?? 0,
      porcentajeVictorias: (json['porcentajeVictorias'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VictoriasEquipoToJson(_VictoriasEquipo instance) =>
    <String, dynamic>{
      'idEquipo': instance.idEquipo,
      'nombre': instance.nombre,
      'ganados': instance.ganados,
      'perdidos': instance.perdidos,
      'empates': instance.empates,
      'porcentajeVictorias': instance.porcentajeVictorias,
    };

_DistribucionHits _$DistribucionHitsFromJson(Map<String, dynamic> json) =>
    _DistribucionHits(
      sencillos: (json['sencillos'] as num?)?.toInt() ?? 0,
      dobles: (json['dobles'] as num?)?.toInt() ?? 0,
      triples: (json['triples'] as num?)?.toInt() ?? 0,
      homeRuns: (json['homeRuns'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DistribucionHitsToJson(_DistribucionHits instance) =>
    <String, dynamic>{
      'sencillos': instance.sencillos,
      'dobles': instance.dobles,
      'triples': instance.triples,
      'homeRuns': instance.homeRuns,
      'total': instance.total,
    };

_PartidosEstadio _$PartidosEstadioFromJson(Map<String, dynamic> json) =>
    _PartidosEstadio(
      idEstadio: json['idEstadio'] as String,
      nombre: json['nombre'] as String,
      ubicacion: json['ubicacion'] as String?,
      partidosJugados: (json['partidosJugados'] as num?)?.toInt() ?? 0,
      partidosProgramados: (json['partidosProgramados'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PartidosEstadioToJson(_PartidosEstadio instance) =>
    <String, dynamic>{
      'idEstadio': instance.idEstadio,
      'nombre': instance.nombre,
      'ubicacion': instance.ubicacion,
      'partidosJugados': instance.partidosJugados,
      'partidosProgramados': instance.partidosProgramados,
    };
