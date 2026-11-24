import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/vista_async.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'widgets_liga.dart';

class TemporadasLigaPantalla extends ConsumerWidget {
  const TemporadasLigaPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valor = ref.watch(temporadasLigaProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Temporadas')),
      body: RecargableSimple(
        onRefresh: () => ref.refresh(temporadasLigaProvider.future).then((_) {}, onError: (_) {}),
        child: VistaAsync<List<TemporadaLiga>>(
          valor: valor,
          onReintentar: () => ref.invalidate(temporadasLigaProvider),
          esVacio: (lista) => lista.isEmpty,
          mensajeVacio: 'Todavía no hay temporadas.',
          iconoVacio: Icons.calendar_month_outlined,
          datos: (lista) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [for (final t in lista) _TarjetaTemporada(temporada: t)],
            ),
          ),
        ),
      ),
    );
  }
}

class _TarjetaTemporada extends StatelessWidget {
  const _TarjetaTemporada({required this.temporada});

  final TemporadaLiga temporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    final activa = temporada.estado == EstadoTemporadaLiga.activa;
    return TarjetaLiga(
      onTap: () => context.go('/temporadas/${temporada.id}'),
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Placa del año: tablero verde noche con la cifra en amarillo.
            Container(
              width: 92,
              decoration: const BoxDecoration(gradient: ColoresMarca.tablero),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                '${temporada.anio}',
                style: estiloMarcador(tema.textTheme.headlineMedium)?.copyWith(
                  fontSize: 30,
                  color: ColoresMarca.amarillo,
                ),
              ),
            ),
            Container(width: 4, color: ColoresMarca.amarillo),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(temporada.nombre, style: tema.textTheme.titleLarge?.copyWith(fontSize: 21)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: activa ? esquema.primary : esquema.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        etiquetaEstadoTemporada(temporada.estado),
                        style: tema.textTheme.labelSmall?.copyWith(
                          color: activa ? esquema.onPrimary : esquema.onSurfaceVariant,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(Icons.chevron_right_rounded, color: esquema.primary),
            ),
          ],
        ),
      ),
    );
  }
}
