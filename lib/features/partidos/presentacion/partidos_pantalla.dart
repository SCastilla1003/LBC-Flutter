import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../datos/modelos_partido.dart';
import '../datos/partidos_repositorio.dart';
import 'tarjeta_partido.dart';

class PartidosPantalla extends StatelessWidget {
  const PartidosPantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partidos')),
      body: ListaPartidos(idTemporada: idTemporada),
    );
  }
}

/// Lista de partidos con filtro por estado, agrupada por fecha. Se reutiliza en el detalle de temporada.
class ListaPartidos extends ConsumerStatefulWidget {
  const ListaPartidos({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  ConsumerState<ListaPartidos> createState() => _ListaPartidosState();
}

class _ListaPartidosState extends ConsumerState<ListaPartidos> {
  EstadoPartido? _filtro;

  @override
  Widget build(BuildContext context) {
    final partidos = ref.watch(partidosProvider(widget.idTemporada));
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(children: [
          _chip(null, 'Todos'),
          for (final e in EstadoPartido.values) _chip(e, e == EstadoPartido.finalizado ? 'Jugados' : e.etiqueta),
        ]),
      ),
      Expanded(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(partidosProvider(widget.idTemporada).future),
          child: VistaAsync(
            valor: partidos,
            onReintentar: () => ref.invalidate(partidosProvider(widget.idTemporada)),
            esVacio: (l) => l.isEmpty,
            mensajeVacio: 'Sin partidos',
            iconoVacio: Icons.sports_baseball_outlined,
            datos: (lista) {
              final filtrados = _filtro == null ? lista : lista.where((p) => p.estado == _filtro).toList();
              if (filtrados.isEmpty) {
                return RecargableSimple(
                  onRefresh: () => ref.refresh(partidosProvider(widget.idTemporada).future),
                  child: const EstadoVacio(mensaje: 'Sin partidos'),
                );
              }
              final grupos = <String, List<Partido>>{};
              for (final p in filtrados) {
                grupos.putIfAbsent(Formato.fechaLarga(p.fecha), () => []).add(p);
              }
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  for (final g in grupos.entries)
                    AnchoMaximo(
                      ancho: 800,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 8),
                          child: Text(g.key,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                        ),
                        for (final p in g.value)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TarjetaPartido(partido: p, idTemporada: widget.idTemporada),
                          ),
                      ]),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    ]);
  }

  Widget _chip(EstadoPartido? estado, String texto) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(texto),
          selected: _filtro == estado,
          onSelected: (_) => setState(() => _filtro = estado),
        ),
      );
}
