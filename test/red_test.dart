import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:lbc_app/core/red/cliente_api.dart';
import 'package:lbc_app/core/red/fallo_api.dart';
import 'package:lbc_app/core/sesion/sesion.dart';
import 'package:lbc_app/features/equipos/datos/equipos_repositorio.dart';
import 'package:lbc_app/features/partidos/datos/modelos_partido.dart';
import 'package:lbc_app/features/partidos/datos/partidos_repositorio.dart';
import 'package:lbc_app/features/prediccion/datos/modelos_prediccion.dart';
import 'package:lbc_app/features/prediccion/datos/prediccion_repositorio.dart';
import 'package:lbc_app/features/temporadas/datos/temporadas_repositorio.dart';

import 'fixtures.dart';

DioException _error(int status, [Object? cuerpo]) {
  final req = RequestOptions(path: '/x');
  return DioException(
    requestOptions: req,
    type: DioExceptionType.badResponse,
    response: Response(requestOptions: req, statusCode: status, data: cuerpo),
  );
}

/// Servidor simulado: rechaza (401) cualquier petición con token y atiende las que no lo llevan.
class _ServidorConToken implements HttpClientAdapter {
  final autorizaciones = <String?>[];

  @override
  Future<ResponseBody> fetch(RequestOptions opciones, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    final auth = opciones.headers['Authorization'] as String?;
    autorizaciones.add(auth);
    final (status, datos) = auth != null ? (401, {'codigo': 'NO_AUTENTICADO'}) : (200, fixture('temporadas'));
    return ResponseBody.fromString(jsonEncode(datos), status, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

class _AlmacenFalso extends AlmacenSesion {
  bool borrado = false;

  @override
  Future<void> borrar() async => borrado = true;

  @override
  Future<void> guardar(RespuestaAuth r) async {}
}

void main() {
  group('FalloApi.desde', () {
    test('errores de red', () {
      final req = RequestOptions(path: '/x');
      expect(FalloApi.desde(DioException(requestOptions: req, type: DioExceptionType.connectionTimeout)),
          isA<FalloTiempoAgotado>());
      expect(FalloApi.desde(DioException(requestOptions: req, type: DioExceptionType.connectionError)),
          isA<FalloSinConexion>());
    });

    test('400 con detalles de validación de la API', () {
      final f = FalloApi.desde(_error(400, fixtureMapa('error_400')));
      expect(f, isA<FalloValidacion>());
      final v = f as FalloValidacion;
      expect(v.mensaje, 'Hay datos no válidos en la solicitud');
      expect(v.campos.keys, containsAll(['rachaUlt3', 'rivalFuerza']));
      expect(v.reintentable, isFalse);
    });

    test('401, 403, 404, 409 y 500', () {
      final f401 = FalloApi.desde(_error(401, {'codigo': 'CREDENCIALES_INVALIDAS', 'mensaje': 'Usuario o contraseña incorrectos'}));
      expect(f401, isA<FalloNoAutenticado>());
      expect((f401 as FalloNoAutenticado).credencialesInvalidas, isTrue);
      expect(FalloApi.desde(_error(403)), isA<FalloAccesoDenegado>());
      final f404 = FalloApi.desde(_error(404, fixtureMapa('error_404')));
      expect(f404, isA<FalloNoEncontrado>());
      expect(f404.mensaje, 'Temporada no encontrado');
      expect(FalloApi.desde(_error(409, {'mensaje': 'Ya existe'})), isA<FalloConflicto>());
      expect(FalloApi.desde(_error(500, '<html>')), isA<FalloServidor>());
    });
  });

  group('repositorios con el cliente HTTP simulado', () {
    late Dio dio;
    late DioAdapter adaptador;
    late ClienteApi api;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test/api/v1'));
      adaptador = DioAdapter(dio: dio);
      api = ClienteApi(dio);
    });

    test('temporadas: listar y 404', () async {
      adaptador.onGet('/temporadas', (s) => s.reply(200, fixture('temporadas')));
      adaptador.onGet('/temporadas/nada', (s) => s.reply(404, fixtureMapa('error_404')));
      final repo = TemporadasRepositorio(api);
      expect(await repo.listar(), isNotEmpty);
      expect(() => repo.detalle('nada'), throwsA(isA<FalloNoEncontrado>()));
    });

    test('posiciones', () async {
      adaptador.onGet('/temporadas/t1/posiciones', (s) => s.reply(200, fixture('posiciones')));
      final p = await EquiposRepositorio(api).posiciones('t1');
      expect(p.first.posicion, 1);
    });

    test('partidos con filtro de estado en la query', () async {
      adaptador.onGet('/temporadas/t1/partidos', (s) => s.reply(200, fixture('partidos')),
          queryParameters: {'estado': 'FINALIZADO'});
      final p = await PartidosRepositorio(api).listar('t1', estado: EstadoPartido.finalizado);
      expect(p, isNotEmpty);
    });

    test('predicción envía las 5 entradas', () async {
      const entrada = EntradaPrediccion(
          localVisitante: 'Local', rachaUlt3: 2, promCarrerasFavor: 5.1, promCarrerasContra: 3.2, rivalFuerza: 'Media');
      adaptador.onPost('/prediccion', (s) => s.reply(200, fixture('prediccion')), data: entrada.toJson());
      final r = await PrediccionRepositorio(api).predecir(entrada);
      expect(r.clase, isIn(['Si', 'No']));
    });

    test('sin conexión se convierte en FalloSinConexion', () async {
      adaptador.onGet(
          '/temporadas',
          (s) => s.throws(
              0, DioException(requestOptions: RequestOptions(path: '/temporadas'), type: DioExceptionType.connectionError)));
      expect(() => TemporadasRepositorio(api).listar(), throwsA(isA<FalloSinConexion>()));
    });
  });

  test('un 401 con token cierra la sesión y repite la lectura sin token', () async {
    final almacen = _AlmacenFalso();
    final contenedor = ProviderContainer(overrides: [
      urlApiProvider.overrideWithValue('https://api.test/api/v1'),
      almacenSesionProvider.overrideWithValue(almacen),
      sesionInicialProvider.overrideWithValue(EstadoSesion(
        token: 'caducado',
        usuario: const Usuario(username: 'adminlbc', roles: ['ADMIN']),
        expiraEn: DateTime.now().add(const Duration(hours: 1)),
      )),
    ]);
    addTearDown(contenedor.dispose);

    final adaptador = _ServidorConToken();
    contenedor.read(dioProvider).httpClientAdapter = adaptador;

    final lista = await TemporadasRepositorio(contenedor.read(clienteApiProvider)).listar();

    expect(lista, isNotEmpty);
    // Primero con el token caducado (401) y luego sin token (200)
    expect(adaptador.autorizaciones, ['Bearer caducado', null]);
    expect(almacen.borrado, isTrue);
    expect(contenedor.read(sesionProvider).autenticado, isFalse);
    expect(contenedor.read(sesionProvider).motivoCierre, contains('expiró'));
  });
}
