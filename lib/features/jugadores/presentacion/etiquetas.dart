import '../../../core/widgets/comunes.dart';

/// Nombres en español de las estadísticas que devuelve la API.
abstract final class EtiquetasEstadistica {
  static const bateo = {
    'homeRuns': 'Jonrones',
    'carrerasImpulsadas': 'Carreras impulsadas',
    'hits': 'Hits',
    'extrabases': 'Extrabases',
    'totalBases': 'Total de bases',
    'sencillos': 'Sencillos',
    'dobles': 'Dobles',
    'triples': 'Triples',
    'roboDeBase': 'Bases robadas',
    'basePorBola': 'Bases por bola',
    'basePorGolpe': 'Golpeados',
    'vecesEmbasado': 'Veces en base',
    'ponches': 'Ponches',
    'errores': 'Errores',
    'relacionBbK': 'BB/K',
  };

  static const pitcheo = {
    'ponchados': 'Ponchados',
    'era': 'ERA',
    'whip': 'WHIP',
    'k9': 'K/9',
    'bb9': 'BB/9',
    'kbb': 'K/BB',
    'inningsLanzados': 'Innings lanzados',
    'numeroLanzamientos': 'Lanzamientos',
    'aparicionesPlato': 'Bateadores enfrentados',
    'basePorBola': 'Bases por bola',
    'carrerasPermitidas': 'Carreras permitidas',
    'hitsPermitidos': 'Hits permitidos',
    'lanzamientosPorInning': 'Lanzamientos por inning',
  };

  /// Estadísticas que son tasas (se muestran con 2 decimales).
  static const tasas = {'era', 'whip', 'k9', 'bb9', 'kbb', 'relacionBbK', 'lanzamientosPorInning'};

  static String de(String tipo, String clave) =>
      (tipo == 'pitcheo' ? pitcheo[clave] : bateo[clave]) ?? clave;

  static String valor(String clave, num? v) {
    if (v == null) return '—';
    return tasas.contains(clave) ? Formato.decimal(v) : v.round().toString();
  }
}
