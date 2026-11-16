import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/cliente_api.dart';
import 'modelos_temporada.dart';

class TemporadasRepositorio {
  TemporadasRepositorio(this._api);

  final ClienteApi _api;

  Future<List<TemporadaResumen>> listar() async {
    final datos = await _api.get('/temporadas') as List;
    return datos.map((e) => TemporadaResumen.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<TemporadaDetalle> actual() async =>
      TemporadaDetalle.fromJson(await _api.get('/temporadas/actual') as Map<String, dynamic>);

  Future<TemporadaDetalle> detalle(String id) async =>
      TemporadaDetalle.fromJson(await _api.get('/temporadas/$id') as Map<String, dynamic>);

  Future<EstadisticasTemporada> estadisticas(String id) async =>
      EstadisticasTemporada.fromJson(await _api.get('/temporadas/$id/estadisticas') as Map<String, dynamic>);

  Future<TemporadaDetalle> crear({required String nombre, required int anio}) async => TemporadaDetalle.fromJson(
      await _api.post('/temporadas', {'nombreTemporada': nombre, 'anio': anio}) as Map<String, dynamic>);

  Future<TemporadaDetalle> actualizar(String id,
          {required String nombre, required int anio, String? idEquipoCampeon}) async =>
      TemporadaDetalle.fromJson(await _api.put('/temporadas/$id', {
        'nombreTemporada': nombre,
        'anio': anio,
        'idEquipoCampeon': idEquipoCampeon,
      }) as Map<String, dynamic>);

  Future<void> eliminar(String id) => _api.delete('/temporadas/$id');
}

final temporadasRepositorioProvider =
    Provider<TemporadasRepositorio>((ref) => TemporadasRepositorio(ref.watch(clienteApiProvider)));

final temporadasProvider =
    FutureProvider<List<TemporadaResumen>>((ref) => ref.watch(temporadasRepositorioProvider).listar());

final temporadaActualProvider =
    FutureProvider<TemporadaDetalle>((ref) => ref.watch(temporadasRepositorioProvider).actual());

final temporadaDetalleProvider = FutureProvider.autoDispose
    .family<TemporadaDetalle, String>((ref, id) => ref.watch(temporadasRepositorioProvider).detalle(id));

final estadisticasTemporadaProvider = FutureProvider.autoDispose
    .family<EstadisticasTemporada, String>((ref, id) => ref.watch(temporadasRepositorioProvider).estadisticas(id));

/// Temporada que el usuario eligió en el selector global (null = la actual de la API).
class TemporadaSeleccionada extends Notifier<String?> {
  @override
  String? build() => null;

  void elegir(String? id) => state = id;
}

final temporadaSeleccionadaProvider =
    NotifierProvider<TemporadaSeleccionada, String?>(TemporadaSeleccionada.new);

/// Id de la temporada en foco: la elegida o, si no hay, la actual según la API.
final idTemporadaEnFocoProvider = FutureProvider<String>((ref) async {
  final elegida = ref.watch(temporadaSeleccionadaProvider);
  if (elegida != null) return elegida;
  final actual = await ref.watch(temporadaActualProvider.future);
  return actual.id;
});
