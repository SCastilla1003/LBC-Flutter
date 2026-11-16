import 'package:freezed_annotation/freezed_annotation.dart';

part 'modelos_prediccion.freezed.dart';
part 'modelos_prediccion.g.dart';

/// Entradas del árbol J48 (`PrediccionRequest`).
@freezed
abstract class EntradaPrediccion with _$EntradaPrediccion {
  const factory EntradaPrediccion({
    required String localVisitante,
    required double rachaUlt3,
    required double promCarrerasFavor,
    required double promCarrerasContra,
    required String rivalFuerza,
  }) = _EntradaPrediccion;

  factory EntradaPrediccion.fromJson(Map<String, dynamic> json) => _$EntradaPrediccionFromJson(json);
}

/// Resultado (`PrediccionDto`). [confianza] y [probabilidades] van de 0 a 100.
@freezed
abstract class Prediccion with _$Prediccion {
  const factory Prediccion({
    required String clase,
    required bool gana,
    required double confianza,
    @Default(<String, double>{}) Map<String, double> probabilidades,
    required EntradaPrediccion entradas,
    @Default('') String resumen,
  }) = _Prediccion;

  factory Prediccion.fromJson(Map<String, dynamic> json) => _$PrediccionFromJson(json);
}

@freezed
abstract class Rango with _$Rango {
  const factory Rango({required double minimo, required double maximo, required double promedio}) = _Rango;

  factory Rango.fromJson(Map<String, dynamic> json) => _$RangoFromJson(json);
}

/// Valores admitidos y rangos del dataset de entrenamiento (`OpcionesPrediccionDto`).
@freezed
abstract class OpcionesPrediccion with _$OpcionesPrediccion {
  const factory OpcionesPrediccion({
    @Default(<String>[]) List<String> localVisitante,
    @Default(<String>[]) List<String> rivalFuerza,
    @Default(<String, Rango>{}) Map<String, Rango> rangos,
    @Default(0) int instanciasEntrenamiento,
  }) = _OpcionesPrediccion;

  factory OpcionesPrediccion.fromJson(Map<String, dynamic> json) => _$OpcionesPrediccionFromJson(json);
}
