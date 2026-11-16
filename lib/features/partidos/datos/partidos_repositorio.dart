import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/cliente_api.dart';
import 'modelos_partido.dart';

class PartidosRepositorio {
  PartidosRepositorio(this._api);

  final ClienteApi _api;

  Future<List<Partido>> listar(String t, {EstadoPartido? estado, String? idEquipo}) async {
    final datos = await _api.get('/temporadas/$t/partidos', query: {
      if (estado != null) 'estado': estado.valorApi,
      'idEquipo': ?idEquipo,
    }) as List;
    return datos.map((e) => Partido.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Partido> detalle(String t, String p) async =>
      Partido.fromJson(await _api.get('/temporadas/$t/partidos/$p') as Map<String, dynamic>);

  /// [cuerpo] con los campos de PartidoRequest (fecha "2026-02-07", hora "19:00", ids...).
  Future<Partido> crear(String t, Map<String, dynamic> cuerpo) async =>
      Partido.fromJson(await _api.post('/temporadas/$t/partidos', cuerpo) as Map<String, dynamic>);

  Future<Partido> actualizar(String t, String p, Map<String, dynamic> cuerpo) async =>
      Partido.fromJson(await _api.put('/temporadas/$t/partidos/$p', cuerpo) as Map<String, dynamic>);

  Future<void> eliminar(String t, String p) => _api.delete('/temporadas/$t/partidos/$p');

  // ---- estadios

  Future<List<Estadio>> estadios(String t) async {
    final datos = await _api.get('/temporadas/$t/estadios') as List;
    return datos.map((e) => Estadio.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Estadio> crearEstadio(String t, {required String nombre, String? ubicacion}) async => Estadio.fromJson(
      await _api.post('/temporadas/$t/estadios', {'nombre': nombre, 'ubicacion': ubicacion}) as Map<String, dynamic>);

  Future<Estadio> actualizarEstadio(String t, String s, {required String nombre, String? ubicacion}) async =>
      Estadio.fromJson(await _api.put('/temporadas/$t/estadios/$s', {'nombre': nombre, 'ubicacion': ubicacion})
          as Map<String, dynamic>);

  Future<void> eliminarEstadio(String t, String s) => _api.delete('/temporadas/$t/estadios/$s');
}

final partidosRepositorioProvider =
    Provider<PartidosRepositorio>((ref) => PartidosRepositorio(ref.watch(clienteApiProvider)));

final partidosProvider = FutureProvider.autoDispose
    .family<List<Partido>, String>((ref, t) => ref.watch(partidosRepositorioProvider).listar(t));

typedef ClavePartido = (String temporada, String partido);

final partidoProvider = FutureProvider.autoDispose
    .family<Partido, ClavePartido>((ref, k) => ref.watch(partidosRepositorioProvider).detalle(k.$1, k.$2));

final estadiosProvider = FutureProvider.autoDispose
    .family<List<Estadio>, String>((ref, t) => ref.watch(partidosRepositorioProvider).estadios(t));
