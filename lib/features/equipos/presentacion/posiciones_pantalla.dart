import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/tema/colores_equipo.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../datos/equipos_repositorio.dart';
import '../datos/modelos_equipo.dart';

class PosicionesPantalla extends ConsumerWidget {
  const PosicionesPantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posiciones = ref.watch(posicionesProvider(idTemporada));
    return Scaffold(
      appBar: AppBar(title: const Text('Tabla de posiciones')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(posicionesProvider(idTemporada).future),
        child: VistaAsync(
          valor: posiciones,
          onReintentar: () => ref.invalidate(posicionesProvider(idTemporada)),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin equipos',
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              AnchoMaximo(
                child: Card(
                  child: LayoutBuilder(builder: (context, c) {
                    final ancha = c.maxWidth >= 600;
                    return Column(children: [
                      _Encabezado(ancha: ancha),
                      const Divider(),
                      for (final p in lista) _Fila(p: p, ancha: ancha, idTemporada: idTemporada),
                    ]);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _anchoNum = 44.0;

class _Encabezado extends StatelessWidget {
  const _Encabezado({required this.ancha});

  final bool ancha;

  @override
  Widget build(BuildContext context) {
    final estilo = Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700);
    Widget n(String t, [String? ayuda]) => SizedBox(
        width: _anchoNum,
        child: Tooltip(message: ayuda ?? t, child: Text(t, textAlign: TextAlign.end, style: estilo)));
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Row(children: [
        SizedBox(width: 28, child: Text('#', style: estilo)),
        Expanded(child: Text('Equipo', style: estilo)),
        n('G', 'Ganados'),
        n('P', 'Perdidos'),
        n('%', 'Porcentaje de victorias'),
        n('JD', 'Juegos detrás del líder'),
        if (ancha) ...[n('Dif', 'Diferencial de carreras'), SizedBox(width: 64, child: Text('Racha', textAlign: TextAlign.end, style: estilo))],
      ]),
    );
  }
}

class _Fila extends StatelessWidget {
  const _Fila({required this.p, required this.ancha, required this.idTemporada});

  final Posicion p;
  final bool ancha;
  final String idTemporada;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cifra = estiloCifra(tema.textTheme.bodyMedium);
    Widget n(String t, {bool fuerte = false}) => SizedBox(
        width: _anchoNum,
        child: Text(t, textAlign: TextAlign.end, style: fuerte ? cifra?.copyWith(fontWeight: FontWeight.w800) : cifra));
    final color = ColoresEquipo.de(context, p.color);
    return InkWell(
      onTap: () => context.push('/temporadas/$idTemporada/equipos/${p.idEquipo}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(children: [
          SizedBox(width: 28, child: Text('${p.posicion}', style: cifra?.copyWith(fontWeight: FontWeight.w700))),
          FranjaColor(color: color, alto: 32),
          const SizedBox(width: 8),
          ImagenApi(urlFoto: p.urlFoto, nombre: p.nombre, tamano: 32, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(p.nombre, overflow: TextOverflow.ellipsis)),
          n('${p.ganados}'),
          n('${p.perdidos}'),
          n(Formato.promedio(p.porcentajeVictorias), fuerte: true),
          n(p.juegosDetras == 0 ? '—' : p.juegosDetras.toStringAsFixed(1).replaceAll('.', ',')),
          if (ancha) ...[
            n(Formato.conSigno(p.diferencial)),
            SizedBox(width: 64, child: Text(p.racha ?? '—', textAlign: TextAlign.end, style: cifra)),
          ],
        ]),
      ),
    );
  }
}
