import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/modelos/modelos_comunes.dart';
import '../../../core/red/cliente_api.dart';
import 'modelos_equipo.dart';

class EquiposRepositorio {
  EquiposRepositorio(this._api);

  final ClienteApi _api;

  Future<List<Equipo>> listar(String t) async {
    final datos = await _api.get('/temporadas/$t/equipos') as List;
    return datos.map((e) => Equipo.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<EquipoDetalle> detalle(String t, String e) async =>
      EquipoDetalle.fromJson(await _api.get('/temporadas/$t/equipos/$e') as Map<String, dynamic>);

  Future<EquipoEstadisticas> estadisticas(String t, String e) async =>
      EquipoEstadisticas.fromJson(await _api.get('/temporadas/$t/equipos/$e/estadisticas') as Map<String, dynamic>);

  Future<List<Posicion>> posiciones(String t) async {
    final datos = await _api.get('/temporadas/$t/posiciones') as List;
    return datos.map((e) => Posicion.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<EquipoDetalle> crear(String t, {required String nombre, String? ciudad, String? color}) async =>
      EquipoDetalle.fromJson(await _api.post('/temporadas/$t/equipos', {
        'nombre': nombre,
        'ciudad': ciudad,
        'color': color,
      }) as Map<String, dynamic>);

  Future<EquipoDetalle> actualizar(String t, String e, {required String nombre, String? ciudad, String? color}) async =>
      EquipoDetalle.fromJson(await _api.put('/temporadas/$t/equipos/$e', {
        'nombre': nombre,
        'ciudad': ciudad,
        'color': color,
      }) as Map<String, dynamic>);

  Future<void> eliminar(String t, String e) => _api.delete('/temporadas/$t/equipos/$e');

  Future<Foto> subirFoto(String t, String e, List<int> bytes, String nombreArchivo) async =>
      Foto.fromJson(await _api.subirArchivo('/temporadas/$t/equipos/$e/foto', bytes, nombreArchivo)
          as Map<String, dynamic>);

  Future<void> eliminarFoto(String t, String e) => _api.delete('/temporadas/$t/equipos/$e/foto');
}

final equiposRepositorioProvider =
    Provider<EquiposRepositorio>((ref) => EquiposRepositorio(ref.watch(clienteApiProvider)));

final equiposProvider = FutureProvider.autoDispose
    .family<List<Equipo>, String>((ref, t) => ref.watch(equiposRepositorioProvider).listar(t));

final posicionesProvider = FutureProvider.autoDispose
    .family<List<Posicion>, String>((ref, t) => ref.watch(equiposRepositorioProvider).posiciones(t));

/// Argumento (idTemporada, idEquipo).
typedef ClaveEquipo = (String temporada, String equipo);

final equipoDetalleProvider = FutureProvider.autoDispose
    .family<EquipoDetalle, ClaveEquipo>((ref, k) => ref.watch(equiposRepositorioProvider).detalle(k.$1, k.$2));

final equipoEstadisticasProvider = FutureProvider.autoDispose.family<EquipoEstadisticas, ClaveEquipo>(
    (ref, k) => ref.watch(equiposRepositorioProvider).estadisticas(k.$1, k.$2));

/// idEquipo → clave de color, para pintar a cada jugador con el color de su equipo.
final coloresEquiposProvider = FutureProvider.autoDispose.family<Map<String, String?>, String>((ref, t) async {
  final equipos = await ref.watch(equiposProvider(t).future);
  return {for (final e in equipos) e.id: e.color};
});
