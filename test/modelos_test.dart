import 'package:flutter_test/flutter_test.dart';
import 'package:lbc_app/core/sesion/sesion.dart';
import 'package:lbc_app/features/equipos/datos/modelos_equipo.dart';
import 'package:lbc_app/features/jugadores/datos/modelos_jugador.dart';
import 'package:lbc_app/features/partidos/datos/modelos_partido.dart';
import 'package:lbc_app/features/prediccion/datos/modelos_prediccion.dart';
import 'package:lbc_app/features/temporadas/datos/modelos_temporada.dart';

import 'fixtures.dart';

void main() {
  group('fromJson con respuestas reales de la API', () {
    test('lista de temporadas', () {
      final lista = fixtureLista('temporadas').map(TemporadaResumen.fromJson).toList();
      expect(lista, isNotEmpty);
      final demo = lista.firstWhere((t) => t.nombreTemporada.contains('Demo'));
      expect(demo.anio, 2026);
      expect(demo.totalEquipos, 6);
      expect(demo.partidosFinalizados, 24);
    });

    test('detalle de temporada con equipos, récord, color y estadios', () {
      final t = TemporadaDetalle.fromJson(fixtureMapa('temporada_detalle'));
      expect(t.equipos, hasLength(6));
      expect(t.estadios, hasLength(3));
      final e = t.equipos.first;
      expect(e.color, isNotNull);
      expect(e.registro.partidosJugados, e.registro.ganados + e.registro.perdidos + e.registro.empates);
    });

    test('estadísticas de temporada', () {
      final s = EstadisticasTemporada.fromJson(fixtureMapa('estadisticas_temporada'));
      expect(s.kpis.partidosJugados, 24);
      expect(s.kpis.liderJonrones, isNotNull);
      expect(s.carrerasPorPartido, hasLength(24));
      expect(s.distribucionHits.total,
          s.distribucionHits.sencillos + s.distribucionHits.dobles + s.distribucionHits.triples + s.distribucionHits.homeRuns);
      expect(s.referenciaPitcheo['era']?.promedio, isNotNull);
      expect(s.referenciaBateo.keys, contains('homeRuns'));
    });

    test('tabla de posiciones ordenada', () {
      final p = fixtureLista('posiciones').map(Posicion.fromJson).toList();
      expect(p.first.posicion, 1);
      expect(p.first.juegosDetras, 0);
      expect(p.first.ultimosResultados, everyElement(isIn(['G', 'P', 'E'])));
      for (var i = 1; i < p.length; i++) {
        expect((p[i - 1].porcentajeVictorias ?? -1) >= (p[i].porcentajeVictorias ?? -1), isTrue);
      }
    });

    test('detalle y estadísticas de equipo', () {
      final e = EquipoDetalle.fromJson(fixtureMapa('equipo_detalle'));
      expect(e.bateadores, isNotEmpty);
      expect(e.lanzadores, isNotEmpty);
      final s = EquipoEstadisticas.fromJson(fixtureMapa('equipo_estadisticas'));
      expect(s.partidos.every((p) => ['G', 'P', 'E'].contains(p.resultado)), isTrue);
      expect(s.comparativaLiga.map((c) => c.metrica), containsAll(['carrerasFavorPorPartido', 'era']));
      expect(s.comparativaLiga.firstWhere((c) => c.metrica == 'era').mayorEsMejor, isFalse);
    });

    test('perfiles de bateador y lanzador con métricas derivadas', () {
      final b = BateadorPerfil.fromJson(fixtureMapa('perfil_bateador'));
      final j = b.jugador;
      expect(j.hits, j.sencillos + j.dobles + j.triples + j.homeRuns);
      expect(b.referenciaLiga['homeRuns']?.muestras, greaterThan(0));

      final l = LanzadorPerfil.fromJson(fixtureMapa('perfil_lanzador'));
      expect(l.jugador.inningsLanzados, greaterThan(0));
      expect(l.jugador.era, isNotNull);
      expect(l.jugador.whip, isNotNull);
    });

    test('lanzadores con 0 innings tienen tasas null (no inventadas)', () {
      final lista = fixtureLista('lanzadores_sin_innings').map(Lanzador.fromJson).toList();
      final sinInnings = lista.where((l) => l.inningsLanzados == 0);
      expect(sinInnings, isNotEmpty);
      expect(sinInnings.every((l) => l.era == null && l.whip == null && l.k9 == null), isTrue);
    });

    test('partidos con estado, fecha, hora y referencias', () {
      final p = fixtureLista('partidos').map(Partido.fromJson).toList();
      expect(p.where((x) => x.estado == EstadoPartido.finalizado), hasLength(24));
      expect(p.where((x) => x.estado == EstadoPartido.programado), hasLength(6));
      final jugado = p.firstWhere((x) => x.finalizado);
      expect(jugado.fecha, isNotNull);
      expect(jugado.hora, matches(RegExp(r'^\d{2}:\d{2}')));
      expect(jugado.idEquipoGanador, anyOf(jugado.equipoLocal.id, jugado.equipoVisitante.id));
      expect(jugado.equipoLocal.color, isNotNull);
    });

    test('líderes y agentes libres', () {
      final l = Lideres.fromJson(fixtureMapa('lideres'));
      expect(l.menorEsMejor, isTrue);
      expect(l.lideres.first.posicion, 1);
      for (var i = 1; i < l.lideres.length; i++) {
        expect(l.lideres[i - 1].valor <= l.lideres[i].valor, isTrue);
      }
      final a = AgentesLibres.fromJson(fixtureMapa('agentes_libres'));
      expect(a.bateadores.every((b) => b.agenteLibre), isTrue);
    });

    test('predicción y opciones', () {
      final o = OpcionesPrediccion.fromJson(fixtureMapa('prediccion_opciones'));
      expect(o.localVisitante, ['Local', 'Visitante']);
      expect(o.rangos['rachaUlt3']?.maximo, 3);
      final p = Prediccion.fromJson(fixtureMapa('prediccion'));
      expect(p.gana, p.clase == 'Si');
      expect(p.confianza, inInclusiveRange(0, 100));
      expect(p.entradas.rivalFuerza, 'Media');
    });
  });

  test('EstadoPartido usa los valores de la API', () {
    expect(EstadoPartido.enJuego.valorApi, 'EN_JUEGO');
    expect(
      Partido.fromJson({
        'id': 'p',
        'estado': 'EN_JUEGO',
        'equipoLocal': {'id': 'a'},
        'equipoVisitante': {'id': 'b'},
      }).estado,
      EstadoPartido.enJuego,
    );
  });

  test('RespuestaAuth y rol de administrador', () {
    final r = RespuestaAuth.fromJson({
      'token': 'jwt',
      'tipo': 'Bearer',
      'expiraEn': '2030-01-01T00:00:00Z',
      'usuario': {'username': 'adminlbc', 'roles': ['ADMIN'], 'proveedor': 'local'},
    });
    expect(r.usuario.esAdmin, isTrue);
    expect(r.expiraEn.isUtc, isTrue);
    expect(RespuestaAuth.fromJson(r.toJson()), r);
  });
}
