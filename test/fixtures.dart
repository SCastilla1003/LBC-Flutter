import 'dart:convert';
import 'dart:io';

/// Respuestas JSON reales capturadas de la API (solo para tests; la app nunca las usa).
dynamic fixture(String nombre) => jsonDecode(File('test/fixtures/$nombre.json').readAsStringSync());

Map<String, dynamic> fixtureMapa(String nombre) => fixture(nombre) as Map<String, dynamic>;

List<Map<String, dynamic>> fixtureLista(String nombre) =>
    (fixture(nombre) as List).cast<Map<String, dynamic>>();
