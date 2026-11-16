// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_prediccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EntradaPrediccion _$EntradaPrediccionFromJson(Map<String, dynamic> json) =>
    _EntradaPrediccion(
      localVisitante: json['localVisitante'] as String,
      rachaUlt3: (json['rachaUlt3'] as num).toDouble(),
      promCarrerasFavor: (json['promCarrerasFavor'] as num).toDouble(),
      promCarrerasContra: (json['promCarrerasContra'] as num).toDouble(),
      rivalFuerza: json['rivalFuerza'] as String,
    );

Map<String, dynamic> _$EntradaPrediccionToJson(_EntradaPrediccion instance) =>
    <String, dynamic>{
      'localVisitante': instance.localVisitante,
      'rachaUlt3': instance.rachaUlt3,
      'promCarrerasFavor': instance.promCarrerasFavor,
      'promCarrerasContra': instance.promCarrerasContra,
      'rivalFuerza': instance.rivalFuerza,
    };

_Prediccion _$PrediccionFromJson(Map<String, dynamic> json) => _Prediccion(
  clase: json['clase'] as String,
  gana: json['gana'] as bool,
  confianza: (json['confianza'] as num).toDouble(),
  probabilidades:
      (json['probabilidades'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  entradas: EntradaPrediccion.fromJson(
    json['entradas'] as Map<String, dynamic>,
  ),
  resumen: json['resumen'] as String? ?? '',
);

Map<String, dynamic> _$PrediccionToJson(_Prediccion instance) =>
    <String, dynamic>{
      'clase': instance.clase,
      'gana': instance.gana,
      'confianza': instance.confianza,
      'probabilidades': instance.probabilidades,
      'entradas': instance.entradas.toJson(),
      'resumen': instance.resumen,
    };

_Rango _$RangoFromJson(Map<String, dynamic> json) => _Rango(
  minimo: (json['minimo'] as num).toDouble(),
  maximo: (json['maximo'] as num).toDouble(),
  promedio: (json['promedio'] as num).toDouble(),
);

Map<String, dynamic> _$RangoToJson(_Rango instance) => <String, dynamic>{
  'minimo': instance.minimo,
  'maximo': instance.maximo,
  'promedio': instance.promedio,
};

_OpcionesPrediccion _$OpcionesPrediccionFromJson(Map<String, dynamic> json) =>
    _OpcionesPrediccion(
      localVisitante:
          (json['localVisitante'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      rivalFuerza:
          (json['rivalFuerza'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      rangos:
          (json['rangos'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Rango.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, Rango>{},
      instanciasEntrenamiento:
          (json['instanciasEntrenamiento'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OpcionesPrediccionToJson(_OpcionesPrediccion instance) =>
    <String, dynamic>{
      'localVisitante': instance.localVisitante,
      'rivalFuerza': instance.rivalFuerza,
      'rangos': instance.rangos.map((k, e) => MapEntry(k, e.toJson())),
      'instanciasEntrenamiento': instance.instanciasEntrenamiento,
    };
