// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelos_jugador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bateador _$BateadorFromJson(Map<String, dynamic> json) => _Bateador(
  id: json['id'] as String,
  nombre: json['nombre'] as String,
  edad: (json['edad'] as num?)?.toInt() ?? 0,
  posicion: json['posicion'] as String?,
  derechoZurdo: json['derechoZurdo'] as String?,
  idEquipo: json['idEquipo'] as String?,
  nombreEquipo: json['nombreEquipo'] as String?,
  agenteLibre: json['agenteLibre'] as bool? ?? false,
  urlFoto: json['urlFoto'] as String?,
  homeRuns: (json['homeRuns'] as num?)?.toInt() ?? 0,
  triples: (json['triples'] as num?)?.toInt() ?? 0,
  dobles: (json['dobles'] as num?)?.toInt() ?? 0,
  sencillos: (json['sencillos'] as num?)?.toInt() ?? 0,
  basePorBola: (json['basePorBola'] as num?)?.toInt() ?? 0,
  basePorGolpe: (json['basePorGolpe'] as num?)?.toInt() ?? 0,
  ponches: (json['ponches'] as num?)?.toInt() ?? 0,
  roboDeBase: (json['roboDeBase'] as num?)?.toInt() ?? 0,
  carrerasImpulsadas: (json['carrerasImpulsadas'] as num?)?.toInt() ?? 0,
  errores: (json['errores'] as num?)?.toInt() ?? 0,
  hits: (json['hits'] as num?)?.toInt() ?? 0,
  extrabases: (json['extrabases'] as num?)?.toInt() ?? 0,
  totalBases: (json['totalBases'] as num?)?.toInt() ?? 0,
  vecesEmbasado: (json['vecesEmbasado'] as num?)?.toInt() ?? 0,
  relacionBbK: (json['relacionBbK'] as num?)?.toDouble(),
);

Map<String, dynamic> _$BateadorToJson(_Bateador instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.nombre,
  'edad': instance.edad,
  'posicion': instance.posicion,
  'derechoZurdo': instance.derechoZurdo,
  'idEquipo': instance.idEquipo,
  'nombreEquipo': instance.nombreEquipo,
  'agenteLibre': instance.agenteLibre,
  'urlFoto': instance.urlFoto,
  'homeRuns': instance.homeRuns,
  'triples': instance.triples,
  'dobles': instance.dobles,
  'sencillos': instance.sencillos,
  'basePorBola': instance.basePorBola,
  'basePorGolpe': instance.basePorGolpe,
  'ponches': instance.ponches,
  'roboDeBase': instance.roboDeBase,
  'carrerasImpulsadas': instance.carrerasImpulsadas,
  'errores': instance.errores,
  'hits': instance.hits,
  'extrabases': instance.extrabases,
  'totalBases': instance.totalBases,
  'vecesEmbasado': instance.vecesEmbasado,
  'relacionBbK': instance.relacionBbK,
};

_Lanzador _$LanzadorFromJson(Map<String, dynamic> json) => _Lanzador(
  id: json['id'] as String,
  nombre: json['nombre'] as String,
  edad: (json['edad'] as num?)?.toInt() ?? 0,
  posicion: json['posicion'] as String?,
  derechoZurdo: json['derechoZurdo'] as String?,
  idEquipo: json['idEquipo'] as String?,
  nombreEquipo: json['nombreEquipo'] as String?,
  agenteLibre: json['agenteLibre'] as bool? ?? false,
  urlFoto: json['urlFoto'] as String?,
  numeroLanzamientos: (json['numeroLanzamientos'] as num?)?.toInt() ?? 0,
  inningsLanzados: (json['inningsLanzados'] as num?)?.toInt() ?? 0,
  ponchados: (json['ponchados'] as num?)?.toInt() ?? 0,
  basePorBola: (json['basePorBola'] as num?)?.toInt() ?? 0,
  carrerasPermitidas: (json['carrerasPermitidas'] as num?)?.toInt() ?? 0,
  hitsPermitidos: (json['hitsPermitidos'] as num?)?.toInt() ?? 0,
  aparicionesPlato: (json['aparicionesPlato'] as num?)?.toInt() ?? 0,
  era: (json['era'] as num?)?.toDouble(),
  whip: (json['whip'] as num?)?.toDouble(),
  k9: (json['k9'] as num?)?.toDouble(),
  bb9: (json['bb9'] as num?)?.toDouble(),
  kbb: (json['kbb'] as num?)?.toDouble(),
  lanzamientosPorInning: (json['lanzamientosPorInning'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LanzadorToJson(_Lanzador instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.nombre,
  'edad': instance.edad,
  'posicion': instance.posicion,
  'derechoZurdo': instance.derechoZurdo,
  'idEquipo': instance.idEquipo,
  'nombreEquipo': instance.nombreEquipo,
  'agenteLibre': instance.agenteLibre,
  'urlFoto': instance.urlFoto,
  'numeroLanzamientos': instance.numeroLanzamientos,
  'inningsLanzados': instance.inningsLanzados,
  'ponchados': instance.ponchados,
  'basePorBola': instance.basePorBola,
  'carrerasPermitidas': instance.carrerasPermitidas,
  'hitsPermitidos': instance.hitsPermitidos,
  'aparicionesPlato': instance.aparicionesPlato,
  'era': instance.era,
  'whip': instance.whip,
  'k9': instance.k9,
  'bb9': instance.bb9,
  'kbb': instance.kbb,
  'lanzamientosPorInning': instance.lanzamientosPorInning,
};

_BateadorPerfil _$BateadorPerfilFromJson(Map<String, dynamic> json) =>
    _BateadorPerfil(
      jugador: Bateador.fromJson(json['jugador'] as Map<String, dynamic>),
      referenciaLiga:
          (json['referenciaLiga'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, Referencia.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, Referencia>{},
    );

Map<String, dynamic> _$BateadorPerfilToJson(_BateadorPerfil instance) =>
    <String, dynamic>{
      'jugador': instance.jugador.toJson(),
      'referenciaLiga': instance.referenciaLiga.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
    };

_LanzadorPerfil _$LanzadorPerfilFromJson(Map<String, dynamic> json) =>
    _LanzadorPerfil(
      jugador: Lanzador.fromJson(json['jugador'] as Map<String, dynamic>),
      referenciaLiga:
          (json['referenciaLiga'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, Referencia.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, Referencia>{},
    );

Map<String, dynamic> _$LanzadorPerfilToJson(_LanzadorPerfil instance) =>
    <String, dynamic>{
      'jugador': instance.jugador.toJson(),
      'referenciaLiga': instance.referenciaLiga.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
    };

_AgentesLibres _$AgentesLibresFromJson(Map<String, dynamic> json) =>
    _AgentesLibres(
      idEquipo: json['idEquipo'] as String?,
      bateadores:
          (json['bateadores'] as List<dynamic>?)
              ?.map((e) => Bateador.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Bateador>[],
      lanzadores:
          (json['lanzadores'] as List<dynamic>?)
              ?.map((e) => Lanzador.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Lanzador>[],
    );

Map<String, dynamic> _$AgentesLibresToJson(_AgentesLibres instance) =>
    <String, dynamic>{
      'idEquipo': instance.idEquipo,
      'bateadores': instance.bateadores.map((e) => e.toJson()).toList(),
      'lanzadores': instance.lanzadores.map((e) => e.toJson()).toList(),
    };

_Lider _$LiderFromJson(Map<String, dynamic> json) => _Lider(
  posicion: (json['posicion'] as num).toInt(),
  idJugador: json['idJugador'] as String,
  nombre: json['nombre'] as String,
  idEquipo: json['idEquipo'] as String?,
  nombreEquipo: json['nombreEquipo'] as String?,
  urlFoto: json['urlFoto'] as String?,
  valor: (json['valor'] as num).toDouble(),
);

Map<String, dynamic> _$LiderToJson(_Lider instance) => <String, dynamic>{
  'posicion': instance.posicion,
  'idJugador': instance.idJugador,
  'nombre': instance.nombre,
  'idEquipo': instance.idEquipo,
  'nombreEquipo': instance.nombreEquipo,
  'urlFoto': instance.urlFoto,
  'valor': instance.valor,
};

_Lideres _$LideresFromJson(Map<String, dynamic> json) => _Lideres(
  tipo: json['tipo'] as String,
  estadistica: json['estadistica'] as String,
  menorEsMejor: json['menorEsMejor'] as bool? ?? false,
  lideres:
      (json['lideres'] as List<dynamic>?)
          ?.map((e) => Lider.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Lider>[],
  estadisticasDisponibles:
      (json['estadisticasDisponibles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$LideresToJson(_Lideres instance) => <String, dynamic>{
  'tipo': instance.tipo,
  'estadistica': instance.estadistica,
  'menorEsMejor': instance.menorEsMejor,
  'lideres': instance.lideres.map((e) => e.toJson()).toList(),
  'estadisticasDisponibles': instance.estadisticasDisponibles,
};

_TraspasoResultado _$TraspasoResultadoFromJson(Map<String, dynamic> json) =>
    _TraspasoResultado(
      tipo: json['tipo'] as String,
      bateador: json['bateador'] == null
          ? null
          : Bateador.fromJson(json['bateador'] as Map<String, dynamic>),
      lanzador: json['lanzador'] == null
          ? null
          : Lanzador.fromJson(json['lanzador'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TraspasoResultadoToJson(_TraspasoResultado instance) =>
    <String, dynamic>{
      'tipo': instance.tipo,
      'bateador': instance.bateador?.toJson(),
      'lanzador': instance.lanzador?.toJson(),
    };
