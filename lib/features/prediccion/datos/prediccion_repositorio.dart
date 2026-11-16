import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/cliente_api.dart';
import 'modelos_prediccion.dart';

class PrediccionRepositorio {
  PrediccionRepositorio(this._api);

  final ClienteApi _api;

  Future<OpcionesPrediccion> opciones() async =>
      OpcionesPrediccion.fromJson(await _api.get('/prediccion/opciones') as Map<String, dynamic>);

  Future<Prediccion> predecir(EntradaPrediccion entrada) async =>
      Prediccion.fromJson(await _api.post('/prediccion', entrada.toJson()) as Map<String, dynamic>);
}

final prediccionRepositorioProvider =
    Provider<PrediccionRepositorio>((ref) => PrediccionRepositorio(ref.watch(clienteApiProvider)));

final opcionesPrediccionProvider =
    FutureProvider<OpcionesPrediccion>((ref) => ref.watch(prediccionRepositorioProvider).opciones());
