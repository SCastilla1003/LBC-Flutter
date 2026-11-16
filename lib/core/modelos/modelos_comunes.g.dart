// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_comunes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EquipoRef _$EquipoRefFromJson(Map<String, dynamic> json) => _EquipoRef(
  id: json['id'] as String?,
  nombre: json['nombre'] as String?,
  urlFoto: json['urlFoto'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$EquipoRefToJson(_EquipoRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'urlFoto': instance.urlFoto,
      'color': instance.color,
    };

_EstadioRef _$EstadioRefFromJson(Map<String, dynamic> json) => _EstadioRef(
  id: json['id'] as String?,
  nombre: json['nombre'] as String?,
  ubicacion: json['ubicacion'] as String?,
);

Map<String, dynamic> _$EstadioRefToJson(_EstadioRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'ubicacion': instance.ubicacion,
    };

_Referencia _$ReferenciaFromJson(Map<String, dynamic> json) => _Referencia(
  promedio: (json['promedio'] as num?)?.toDouble(),
  minimo: (json['minimo'] as num?)?.toDouble(),
  maximo: (json['maximo'] as num?)?.toDouble(),
  muestras: (json['muestras'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ReferenciaToJson(_Referencia instance) =>
    <String, dynamic>{
      'promedio': instance.promedio,
      'minimo': instance.minimo,
      'maximo': instance.maximo,
      'muestras': instance.muestras,
    };

_Foto _$FotoFromJson(Map<String, dynamic> json) =>
    _Foto(fotoId: json['fotoId'] as String, urlFoto: json['urlFoto'] as String);

Map<String, dynamic> _$FotoToJson(_Foto instance) => <String, dynamic>{
  'fotoId': instance.fotoId,
  'urlFoto': instance.urlFoto,
};
