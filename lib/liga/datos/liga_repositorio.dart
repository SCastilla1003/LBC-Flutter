import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/red/cliente_api.dart';
import 'modelos_liga.dart';

/// Lecturas del contrato v1 de la API (IDs numéricos). Las escrituras se añaden por fases.
class LigaRepositorio {
  LigaRepositorio(this._api);

  final ClienteApi _api;

  Future<List<TemporadaLiga>> temporadas() => _lista('/temporadas', TemporadaLiga.fromJson);

  Future<TemporadaLiga> temporadaActual() async =>
      TemporadaLiga.fromJson(await _api.get('/temporadas/actual') as Map<String, dynamic>);

  Future<TemporadaLiga> temporada(int id) async =>
      TemporadaLiga.fromJson(await _api.get('/temporadas/$id') as Map<String, dynamic>);

  Future<List<EquipoRefLiga>> equiposDeTemporada(int temporadaId) =>
      _lista('/temporadas/$temporadaId/equipos', EquipoRefLiga.fromJson);

  Future<List<PartidoResumen>> partidos(
    int temporadaId, {
    EstadoPartidoLiga? estado,
    int? equipoId,
    DateTime? desde,
    DateTime? hasta,
  }) =>
      _lista(
        '/temporadas/$temporadaId/partidos',
        PartidoResumen.fromJson,
        query: {
          'estado': ?_valorEstadoOpcional(estado),
          'equipoId': ?equipoId,
          'desde': ?_fechaOpcional(desde),
          'hasta': ?_fechaOpcional(hasta),
        },
      );

  Future<PartidoDetalle> partido(int id) async =>
      PartidoDetalle.fromJson(await _api.get('/partidos/$id') as Map<String, dynamic>);

  Future<List<PosicionLiga>> posiciones(int temporadaId) =>
      _lista('/temporadas/$temporadaId/posiciones', PosicionLiga.fromJson);

  Future<Alineacion> alineacion(int partidoId) async =>
      Alineacion.fromJson(await _api.get('/partidos/$partidoId/alineacion') as Map<String, dynamic>);

  Future<Pitcheo> pitcheo(int partidoId) async =>
      Pitcheo.fromJson(await _api.get('/partidos/$partidoId/alineacion/pitcheo') as Map<String, dynamic>);

  Future<List<EstadioLiga>> estadios() => _lista('/estadios', EstadioLiga.fromJson);

  Future<List<EquipoLiga>> equipos() => _lista('/equipos', EquipoLiga.fromJson);

  Future<List<PlantillaLiga>> plantilla(int temporadaId, int equipoId) =>
      _lista('/temporadas/$temporadaId/equipos/$equipoId/plantilla', PlantillaLiga.fromJson);

  Future<List<PlantillaLiga>> agentesLibres(int temporadaId) =>
      _lista('/temporadas/$temporadaId/agentes-libres', PlantillaLiga.fromJson);

  Future<List<T>> _lista<T>(String ruta, T Function(Map<String, dynamic>) desde,
      {Map<String, dynamic>? query}) async {
    final datos = await _api.get(ruta, query: query) as List;
    return datos.map((e) => desde(e as Map<String, dynamic>)).toList();
  }

  static String _valorEstado(EstadoPartidoLiga e) => switch (e) {
        EstadoPartidoLiga.programado => 'SCHEDULED',
        EstadoPartidoLiga.alineacionPublicada => 'LINEUP_PUBLISHED',
        EstadoPartidoLiga.enJuego => 'LIVE',
        EstadoPartidoLiga.finalizado => 'FINISHED',
        EstadoPartidoLiga.suspendido => 'SUSPENDED',
      };

  static String? _valorEstadoOpcional(EstadoPartidoLiga? e) => e == null ? null : _valorEstado(e);

  static String? _fechaOpcional(DateTime? d) => d == null
      ? null
      : '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

final ligaRepositorioProvider = Provider<LigaRepositorio>((ref) => LigaRepositorio(ref.watch(clienteApiProvider)));

final temporadasLigaProvider =
    FutureProvider<List<TemporadaLiga>>((ref) => ref.watch(ligaRepositorioProvider).temporadas());

final temporadaActualLigaProvider =
    FutureProvider<TemporadaLiga>((ref) => ref.watch(ligaRepositorioProvider).temporadaActual());

final temporadaLigaProvider = FutureProvider.autoDispose
    .family<TemporadaLiga, int>((ref, id) => ref.watch(ligaRepositorioProvider).temporada(id));

final equiposTemporadaLigaProvider = FutureProvider.autoDispose
    .family<List<EquipoRefLiga>, int>((ref, id) => ref.watch(ligaRepositorioProvider).equiposDeTemporada(id));

final partidosLigaProvider = FutureProvider.autoDispose
    .family<List<PartidoResumen>, int>((ref, temporadaId) => ref.watch(ligaRepositorioProvider).partidos(temporadaId));

final partidoDetalleLigaProvider = FutureProvider.autoDispose
    .family<PartidoDetalle, int>((ref, id) => ref.watch(ligaRepositorioProvider).partido(id));

final posicionesLigaProvider = FutureProvider.autoDispose
    .family<List<PosicionLiga>, int>((ref, temporadaId) => ref.watch(ligaRepositorioProvider).posiciones(temporadaId));

final alineacionLigaProvider = FutureProvider.autoDispose
    .family<Alineacion, int>((ref, partidoId) => ref.watch(ligaRepositorioProvider).alineacion(partidoId));

final pitcheoLigaProvider = FutureProvider.autoDispose
    .family<Pitcheo, int>((ref, partidoId) => ref.watch(ligaRepositorioProvider).pitcheo(partidoId));
