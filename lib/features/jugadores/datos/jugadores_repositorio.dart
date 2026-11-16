import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/modelos/modelos_comunes.dart';
import '../../../core/red/cliente_api.dart';
import 'modelos_jugador.dart';

class JugadoresRepositorio {
  JugadoresRepositorio(this._api);

  final ClienteApi _api;

  List<Bateador> _bateadores(dynamic d) =>
      (d as List).map((e) => Bateador.fromJson(e as Map<String, dynamic>)).toList();

  List<Lanzador> _lanzadores(dynamic d) =>
      (d as List).map((e) => Lanzador.fromJson(e as Map<String, dynamic>)).toList();

  Future<List<Bateador>> bateadoresDeTemporada(String t) async => _bateadores(await _api.get('/temporadas/$t/bateadores'));

  Future<List<Lanzador>> lanzadoresDeTemporada(String t) async => _lanzadores(await _api.get('/temporadas/$t/lanzadores'));

  Future<BateadorPerfil> perfilBateador(String t, String j) async =>
      BateadorPerfil.fromJson(await _api.get('/temporadas/$t/bateadores/$j') as Map<String, dynamic>);

  Future<LanzadorPerfil> perfilLanzador(String t, String j) async =>
      LanzadorPerfil.fromJson(await _api.get('/temporadas/$t/lanzadores/$j') as Map<String, dynamic>);

  Future<AgentesLibres> agentesLibres(String t) async =>
      AgentesLibres.fromJson(await _api.get('/temporadas/$t/agentes-libres') as Map<String, dynamic>);

  Future<Lideres> lideres(String t, {required String tipo, required String estadistica, int limite = 10}) async =>
      Lideres.fromJson(await _api.get('/temporadas/$t/lideres',
          query: {'tipo': tipo, 'estadistica': estadistica, 'limite': limite}) as Map<String, dynamic>);

  // ---- escritura (ADMIN). [cuerpo] tiene los campos de BateadorRequest / LanzadorRequest.

  Future<Bateador> crearBateador(String t, String? idEquipo, Map<String, dynamic> cuerpo) async =>
      Bateador.fromJson(await _api.post(
          idEquipo == null ? '/temporadas/$t/agentes-libres/bateadores' : '/temporadas/$t/equipos/$idEquipo/bateadores',
          cuerpo) as Map<String, dynamic>);

  Future<Lanzador> crearLanzador(String t, String? idEquipo, Map<String, dynamic> cuerpo) async =>
      Lanzador.fromJson(await _api.post(
          idEquipo == null ? '/temporadas/$t/agentes-libres/lanzadores' : '/temporadas/$t/equipos/$idEquipo/lanzadores',
          cuerpo) as Map<String, dynamic>);

  Future<Bateador> actualizarBateador(String t, String j, Map<String, dynamic> cuerpo) async =>
      Bateador.fromJson(await _api.put('/temporadas/$t/bateadores/$j', cuerpo) as Map<String, dynamic>);

  Future<Lanzador> actualizarLanzador(String t, String j, Map<String, dynamic> cuerpo) async =>
      Lanzador.fromJson(await _api.put('/temporadas/$t/lanzadores/$j', cuerpo) as Map<String, dynamic>);

  Future<void> eliminarBateador(String t, String j) => _api.delete('/temporadas/$t/bateadores/$j');

  Future<void> eliminarLanzador(String t, String j) => _api.delete('/temporadas/$t/lanzadores/$j');

  Future<TraspasoResultado> traspasar(String t, String j, String idEquipoDestino) async => TraspasoResultado.fromJson(
      await _api.post('/temporadas/$t/jugadores/$j/traspaso', {'idEquipoDestino': idEquipoDestino})
          as Map<String, dynamic>);

  /// [tipo]: "bateadores" o "lanzadores".
  Future<Foto> subirFoto(String t, String tipo, String j, List<int> bytes, String nombreArchivo) async =>
      Foto.fromJson(await _api.subirArchivo('/temporadas/$t/$tipo/$j/foto', bytes, nombreArchivo)
          as Map<String, dynamic>);

  Future<void> eliminarFoto(String t, String tipo, String j) => _api.delete('/temporadas/$t/$tipo/$j/foto');
}

final jugadoresRepositorioProvider =
    Provider<JugadoresRepositorio>((ref) => JugadoresRepositorio(ref.watch(clienteApiProvider)));

typedef ClaveJugador = (String temporada, String jugador);

final perfilBateadorProvider = FutureProvider.autoDispose.family<BateadorPerfil, ClaveJugador>(
    (ref, k) => ref.watch(jugadoresRepositorioProvider).perfilBateador(k.$1, k.$2));

final perfilLanzadorProvider = FutureProvider.autoDispose.family<LanzadorPerfil, ClaveJugador>(
    (ref, k) => ref.watch(jugadoresRepositorioProvider).perfilLanzador(k.$1, k.$2));

final bateadoresTemporadaProvider = FutureProvider.autoDispose
    .family<List<Bateador>, String>((ref, t) => ref.watch(jugadoresRepositorioProvider).bateadoresDeTemporada(t));

final lanzadoresTemporadaProvider = FutureProvider.autoDispose
    .family<List<Lanzador>, String>((ref, t) => ref.watch(jugadoresRepositorioProvider).lanzadoresDeTemporada(t));

final agentesLibresProvider = FutureProvider.autoDispose
    .family<AgentesLibres, String>((ref, t) => ref.watch(jugadoresRepositorioProvider).agentesLibres(t));

/// (idTemporada, tipo "bateo"|"pitcheo", estadística, límite)
typedef ConsultaLideres = (String temporada, String tipo, String estadistica, int limite);

final lideresProvider = FutureProvider.autoDispose.family<Lideres, ConsultaLideres>((ref, c) =>
    ref.watch(jugadoresRepositorioProvider).lideres(c.$1, tipo: c.$2, estadistica: c.$3, limite: c.$4));
