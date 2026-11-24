import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'liga_repositorio.dart';
import 'modelos_liga.dart';

/// Temporada elegida a mano en el selector (null = la temporada en curso).
class TemporadaElegida extends Notifier<int?> {
  @override
  int? build() => null;

  void elegir(int? id) => state = id;
}

final temporadaElegidaLigaProvider = NotifierProvider<TemporadaElegida, int?>(TemporadaElegida.new);

/// Temporada que muestran Inicio y Líderes: la elegida; si no, la que está en
/// curso; si no hay ninguna en curso, la más reciente. null si no hay temporadas.
final temporadaEnFocoLigaProvider = FutureProvider<TemporadaLiga?>((ref) async {
  final elegida = ref.watch(temporadaElegidaLigaProvider);
  final lista = await ref.watch(temporadasLigaProvider.future);
  if (elegida != null) {
    final t = lista.where((t) => t.id == elegida).firstOrNull;
    if (t != null) return t;
  }
  final enCurso = lista.where((t) => t.estado == EstadoTemporadaLiga.activa).toList()
    ..sort((a, b) => b.anio.compareTo(a.anio));
  if (enCurso.isNotEmpty) return enCurso.first;
  final todas = [...lista]..sort((a, b) => b.anio.compareTo(a.anio));
  return todas.firstOrNull;
});
