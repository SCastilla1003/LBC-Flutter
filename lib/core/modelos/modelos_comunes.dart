import 'package:freezed_annotation/freezed_annotation.dart';

part 'modelos_comunes.freezed.dart';
part 'modelos_comunes.g.dart';

/// Referencia corta a un equipo (`EquipoRefDto`). [color] = clave de la paleta.
@freezed
abstract class EquipoRef with _$EquipoRef {
  const factory EquipoRef({String? id, String? nombre, String? urlFoto, String? color}) = _EquipoRef;

  factory EquipoRef.fromJson(Map<String, dynamic> json) => _$EquipoRefFromJson(json);
}

/// Referencia corta a un estadio (`EstadioRefDto`).
@freezed
abstract class EstadioRef with _$EstadioRef {
  const factory EstadioRef({String? id, String? nombre, String? ubicacion}) = _EstadioRef;

  factory EstadioRef.fromJson(Map<String, dynamic> json) => _$EstadioRefFromJson(json);
}

/// Referencia de liga para una métrica (`ReferenciaDto`): todo null si no hay muestras.
@freezed
abstract class Referencia with _$Referencia {
  const factory Referencia({double? promedio, double? minimo, double? maximo, @Default(0) int muestras}) =
      _Referencia;

  factory Referencia.fromJson(Map<String, dynamic> json) => _$ReferenciaFromJson(json);
}

/// Resultado de subir una foto (`FotoDto`).
@freezed
abstract class Foto with _$Foto {
  const factory Foto({required String fotoId, required String urlFoto}) = _Foto;

  factory Foto.fromJson(Map<String, dynamic> json) => _$FotoFromJson(json);
}
