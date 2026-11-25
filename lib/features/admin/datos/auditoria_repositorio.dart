import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/cliente_api.dart';

/// Un cambio del registro de auditoría: quién, qué y cuándo, con los datos de antes y después.
class RegistroAuditoria {
  const RegistroAuditoria({
    required this.id,
    required this.fecha,
    required this.accion,
    required this.entidad,
    required this.descripcion,
    this.usuario,
    this.entidadId,
    this.antes,
    this.despues,
  });

  factory RegistroAuditoria.fromJson(Map<String, dynamic> j) => RegistroAuditoria(
        id: (j['id'] as num).toInt(),
        fecha: DateTime.tryParse(j['fecha'] as String? ?? '') ?? DateTime.now(),
        usuario: j['usuario'] as String?,
        accion: j['accion'] as String? ?? '',
        entidad: j['entidad'] as String? ?? '',
        entidadId: (j['entidadId'] as num?)?.toInt(),
        descripcion: j['descripcion'] as String? ?? '${j['accion']} ${j['entidad']}',
        antes: j['antes'] as String?,
        despues: j['despues'] as String?,
      );

  final int id;
  final DateTime fecha;
  final String? usuario;
  final String accion;
  final String entidad;
  final int? entidadId;
  final String descripcion;

  /// Datos en JSON (texto) antes y después del cambio.
  final String? antes;
  final String? despues;
}

class PaginaAuditoria {
  const PaginaAuditoria({required this.registros, required this.hayMas});

  factory PaginaAuditoria.fromJson(Map<String, dynamic> j) => PaginaAuditoria(
        registros: [
          for (final r in (j['registros'] as List? ?? const [])) RegistroAuditoria.fromJson(r as Map<String, dynamic>),
        ],
        hayMas: j['hayMas'] as bool? ?? false,
      );

  final List<RegistroAuditoria> registros;
  final bool hayMas;
}

/// Lo que se borra al eliminar por completo un jugador o un partido.
class Impacto {
  const Impacto({
    required this.nombre,
    this.inscripciones = 0,
    this.alineaciones = 0,
    this.partidos = 0,
    this.jugadas = 0,
    this.lanzamientos = 0,
    this.cambios = 0,
    this.enJuego = false,
  });

  factory Impacto.fromJson(Map<String, dynamic> j) {
    int n(String k) => (j[k] as num?)?.toInt() ?? 0;
    return Impacto(
      nombre: j['nombre'] as String? ?? '',
      inscripciones: n('inscripciones'),
      alineaciones: n('alineaciones'),
      partidos: n('partidos'),
      jugadas: n('jugadas'),
      lanzamientos: n('lanzamientos'),
      cambios: n('cambios'),
      enJuego: j['enJuego'] as bool? ?? false,
    );
  }

  final String nombre;
  final int inscripciones;
  final int alineaciones;
  final int partidos;
  final int jugadas;
  final int lanzamientos;
  final int cambios;

  /// Jugador en un partido en juego o suspendido, o partido en vivo.
  final bool enJuego;
}

class AuditoriaRepositorio {
  AuditoriaRepositorio(this._api);

  final ClienteApi _api;

  Future<PaginaAuditoria> listar({String? entidad, String? texto, int pagina = 0, int tamano = 40}) async =>
      PaginaAuditoria.fromJson(await _api.get('/auditoria', query: {
        'entidad': ?entidad,
        if (texto != null && texto.trim().isNotEmpty) 'texto': texto.trim(),
        'pagina': pagina,
        'tamano': tamano,
      }) as Map<String, dynamic>);

  Future<Impacto> impactoJugador(int id) async =>
      Impacto.fromJson(await _api.get('/jugadores/$id/impacto') as Map<String, dynamic>);

  Future<Impacto> impactoPartido(int id) async =>
      Impacto.fromJson(await _api.get('/partidos/$id/impacto') as Map<String, dynamic>);

  /// Borra el jugador con sus inscripciones, alineaciones, jugadas... No se puede deshacer.
  Future<void> eliminarJugadorPorCompleto(int id) => _api.delete('/jugadores/$id?completo=true');

  /// Borra el partido en cualquier estado, con su alineación y sus jugadas. No se puede deshacer.
  Future<void> eliminarPartidoPorCompleto(int id) => _api.delete('/partidos/$id?completo=true');
}

final auditoriaRepositorioProvider =
    Provider<AuditoriaRepositorio>((ref) => AuditoriaRepositorio(ref.watch(clienteApiProvider)));
