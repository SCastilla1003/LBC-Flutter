// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_equipo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Registro _$RegistroFromJson(Map<String, dynamic> json) => _Registro(
  partidosJugados: (json['partidosJugados'] as num?)?.toInt() ?? 0,
  ganados: (json['ganados'] as num?)?.toInt() ?? 0,
  perdidos: (json['perdidos'] as num?)?.toInt() ?? 0,
  empates: (json['empates'] as num?)?.toInt() ?? 0,
  porcentajeVictorias: (json['porcentajeVictorias'] as num?)?.toDouble(),
  carrerasFavor: (json['carrerasFavor'] as num?)?.toInt() ?? 0,
  carrerasContra: (json['carrerasContra'] as num?)?.toInt() ?? 0,
  diferencial: (json['diferencial'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RegistroToJson(_Registro instance) => <String, dynamic>{
  'partidosJugados': instance.partidosJugados,
  'ganados': instance.ganados,
  'perdidos': instance.perdidos,
  'empates': instance.empates,
  'porcentajeVictorias': instance.porcentajeVictorias,
  'carrerasFavor': instance.carrerasFavor,
  'carrerasContra': instance.carrerasContra,
  'diferencial': instance.diferencial,
};

_Equipo _$EquipoFromJson(Map<String, dynamic> json) => _Equipo(
  id: json['id'] as String,
  nombre: json['nombre'] as String,
  ciudad: json['ciudad'] as String?,
  urlFoto: json['urlFoto'] as String?,
  color: json['color'] as String?,
  totalBateadores: (json['totalBateadores'] as num?)?.toInt() ?? 0,
  totalLanzadores: (json['totalLanzadores'] as num?)?.toInt() ?? 0,
  registro: json['registro'] == null
      ? const Registro()
      : Registro.fromJson(json['registro'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EquipoToJson(_Equipo instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.nombre,
  'ciudad': instance.ciudad,
  'urlFoto': instance.urlFoto,
  'color': instance.color,
  'totalBateadores': instance.totalBateadores,
  'totalLanzadores': instance.totalLanzadores,
  'registro': instance.registro.toJson(),
};

_EquipoDetalle _$EquipoDetalleFromJson(Map<String, dynamic> json) =>
    _EquipoDetalle(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      ciudad: json['ciudad'] as String?,
      urlFoto: json['urlFoto'] as String?,
      color: json['color'] as String?,
      registro: json['registro'] == null
          ? const Registro()
          : Registro.fromJson(json['registro'] as Map<String, dynamic>),
      bateadores:
          (json['bateadores'] as List<dynamic>?)
              ?.map((e) => Bateador.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Bateador>[],
      lanzadores:
          (json['lanzadores'] as List<dynamic>?)
              ?.map((e) => Lanzador.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Lanzador>[],
    );

Map<String, dynamic> _$EquipoDetalleToJson(_EquipoDetalle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'ciudad': instance.ciudad,
      'urlFoto': instance.urlFoto,
      'color': instance.color,
      'registro': instance.registro.toJson(),
      'bateadores': instance.bateadores.map((e) => e.toJson()).toList(),
      'lanzadores': instance.lanzadores.map((e) => e.toJson()).toList(),
    };

_Posicion _$PosicionFromJson(Map<String, dynamic> json) => _Posicion(
  posicion: (json['posicion'] as num).toInt(),
  idEquipo: json['idEquipo'] as String,
  nombre: json['nombre'] as String,
  ciudad: json['ciudad'] as String?,
  urlFoto: json['urlFoto'] as String?,
  color: json['color'] as String?,
  partidosJugados: (json['partidosJugados'] as num?)?.toInt() ?? 0,
  ganados: (json['ganados'] as num?)?.toInt() ?? 0,
  perdidos: (json['perdidos'] as num?)?.toInt() ?? 0,
  empates: (json['empates'] as num?)?.toInt() ?? 0,
  porcentajeVictorias: (json['porcentajeVictorias'] as num?)?.toDouble(),
  juegosDetras: (json['juegosDetras'] as num?)?.toDouble() ?? 0,
  carrerasFavor: (json['carrerasFavor'] as num?)?.toInt() ?? 0,
  carrerasContra: (json['carrerasContra'] as num?)?.toInt() ?? 0,
  diferencial: (json['diferencial'] as num?)?.toInt() ?? 0,
  ultimosResultados:
      (json['ultimosResultados'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  racha: json['racha'] as String?,
);

Map<String, dynamic> _$PosicionToJson(_Posicion instance) => <String, dynamic>{
  'posicion': instance.posicion,
  'idEquipo': instance.idEquipo,
  'nombre': instance.nombre,
  'ciudad': instance.ciudad,
  'urlFoto': instance.urlFoto,
  'color': instance.color,
  'partidosJugados': instance.partidosJugados,
  'ganados': instance.ganados,
  'perdidos': instance.perdidos,
  'empates': instance.empates,
  'porcentajeVictorias': instance.porcentajeVictorias,
  'juegosDetras': instance.juegosDetras,
  'carrerasFavor': instance.carrerasFavor,
  'carrerasContra': instance.carrerasContra,
  'diferencial': instance.diferencial,
  'ultimosResultados': instance.ultimosResultados,
  'racha': instance.racha,
};

_PartidoEquipo _$PartidoEquipoFromJson(Map<String, dynamic> json) =>
    _PartidoEquipo(
      idPartido: json['idPartido'] as String,
      fecha: json['fecha'] == null
          ? null
          : DateTime.parse(json['fecha'] as String),
      hora: json['hora'] as String?,
      local: json['local'] as bool? ?? false,
      rival: json['rival'] == null
          ? null
          : EquipoRef.fromJson(json['rival'] as Map<String, dynamic>),
      carrerasFavor: (json['carrerasFavor'] as num?)?.toInt() ?? 0,
      carrerasContra: (json['carrerasContra'] as num?)?.toInt() ?? 0,
      diferencial: (json['diferencial'] as num?)?.toInt() ?? 0,
      resultado: json['resultado'] as String,
    );

Map<String, dynamic> _$PartidoEquipoToJson(_PartidoEquipo instance) =>
    <String, dynamic>{
      'idPartido': instance.idPartido,
      'fecha': instance.fecha?.toIso8601String(),
      'hora': instance.hora,
      'local': instance.local,
      'rival': instance.rival?.toJson(),
      'carrerasFavor': instance.carrerasFavor,
      'carrerasContra': instance.carrerasContra,
      'diferencial': instance.diferencial,
      'resultado': instance.resultado,
    };

_Comparativa _$ComparativaFromJson(Map<String, dynamic> json) => _Comparativa(
  metrica: json['metrica'] as String,
  etiqueta: json['etiqueta'] as String,
  valorEquipo: (json['valorEquipo'] as num?)?.toDouble(),
  promedioLiga: (json['promedioLiga'] as num?)?.toDouble(),
  mayorEsMejor: json['mayorEsMejor'] as bool? ?? true,
);

Map<String, dynamic> _$ComparativaToJson(_Comparativa instance) =>
    <String, dynamic>{
      'metrica': instance.metrica,
      'etiqueta': instance.etiqueta,
      'valorEquipo': instance.valorEquipo,
      'promedioLiga': instance.promedioLiga,
      'mayorEsMejor': instance.mayorEsMejor,
    };

_BateoEquipo _$BateoEquipoFromJson(Map<String, dynamic> json) => _BateoEquipo(
  hits: (json['hits'] as num?)?.toInt() ?? 0,
  homeRuns: (json['homeRuns'] as num?)?.toInt() ?? 0,
  triples: (json['triples'] as num?)?.toInt() ?? 0,
  dobles: (json['dobles'] as num?)?.toInt() ?? 0,
  sencillos: (json['sencillos'] as num?)?.toInt() ?? 0,
  carrerasImpulsadas: (json['carrerasImpulsadas'] as num?)?.toInt() ?? 0,
  roboDeBase: (json['roboDeBase'] as num?)?.toInt() ?? 0,
  basePorBola: (json['basePorBola'] as num?)?.toInt() ?? 0,
  ponches: (json['ponches'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BateoEquipoToJson(_BateoEquipo instance) =>
    <String, dynamic>{
      'hits': instance.hits,
      'homeRuns': instance.homeRuns,
      'triples': instance.triples,
      'dobles': instance.dobles,
      'sencillos': instance.sencillos,
      'carrerasImpulsadas': instance.carrerasImpulsadas,
      'roboDeBase': instance.roboDeBase,
      'basePorBola': instance.basePorBola,
      'ponches': instance.ponches,
    };

_PitcheoEquipo _$PitcheoEquipoFromJson(Map<String, dynamic> json) =>
    _PitcheoEquipo(
      inningsLanzados: (json['inningsLanzados'] as num?)?.toInt() ?? 0,
      ponchados: (json['ponchados'] as num?)?.toInt() ?? 0,
      basePorBola: (json['basePorBola'] as num?)?.toInt() ?? 0,
      carrerasPermitidas: (json['carrerasPermitidas'] as num?)?.toInt() ?? 0,
      hitsPermitidos: (json['hitsPermitidos'] as num?)?.toInt() ?? 0,
      era: (json['era'] as num?)?.toDouble(),
      whip: (json['whip'] as num?)?.toDouble(),
      k9: (json['k9'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PitcheoEquipoToJson(_PitcheoEquipo instance) =>
    <String, dynamic>{
      'inningsLanzados': instance.inningsLanzados,
      'ponchados': instance.ponchados,
      'basePorBola': instance.basePorBola,
      'carrerasPermitidas': instance.carrerasPermitidas,
      'hitsPermitidos': instance.hitsPermitidos,
      'era': instance.era,
      'whip': instance.whip,
      'k9': instance.k9,
    };

_EquipoEstadisticas _$EquipoEstadisticasFromJson(Map<String, dynamic> json) =>
    _EquipoEstadisticas(
      equipo: Equipo.fromJson(json['equipo'] as Map<String, dynamic>),
      partidos:
          (json['partidos'] as List<dynamic>?)
              ?.map((e) => PartidoEquipo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PartidoEquipo>[],
      comparativaLiga:
          (json['comparativaLiga'] as List<dynamic>?)
              ?.map((e) => Comparativa.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Comparativa>[],
      bateo: json['bateo'] == null
          ? const BateoEquipo()
          : BateoEquipo.fromJson(json['bateo'] as Map<String, dynamic>),
      pitcheo: json['pitcheo'] == null
          ? const PitcheoEquipo()
          : PitcheoEquipo.fromJson(json['pitcheo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipoEstadisticasToJson(
  _EquipoEstadisticas instance,
) => <String, dynamic>{
  'equipo': instance.equipo.toJson(),
  'partidos': instance.partidos.map((e) => e.toJson()).toList(),
  'comparativaLiga': instance.comparativaLiga.map((e) => e.toJson()).toList(),
  'bateo': instance.bateo.toJson(),
  'pitcheo': instance.pitcheo.toJson(),
};
