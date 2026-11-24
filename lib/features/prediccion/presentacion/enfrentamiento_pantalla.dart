import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/charts/medidor.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/estadisticas_repositorio.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/datos/temporada_en_foco.dart';

/// Bateador contra lanzador: historial entre los dos y probabilidad de hit, de
/// embasarse y de ponche en su próximo turno.
class PrediccionEnfrentamiento extends ConsumerStatefulWidget {
  const PrediccionEnfrentamiento({super.key, this.bateador, this.lanzador});

  /// Jugadores ya elegidos (p. ej. al venir del partido en vivo).
  final int? bateador;
  final int? lanzador;

  @override
  ConsumerState<PrediccionEnfrentamiento> createState() => _PrediccionEnfrentamientoState();
}

class _PrediccionEnfrentamientoState extends ConsumerState<PrediccionEnfrentamiento> {
  late int? _bateador = widget.bateador;
  late int? _lanzador = widget.lanzador;

  Future<void> _elegir(List<JugadorLiga> jugadores, {required bool lanzador}) async {
    final elegido = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _Selector(
        titulo: lanzador ? 'Elige el lanzador' : 'Elige el bateador',
        // Lanzadores: los pitchers primero, pero cualquiera puede haber lanzado.
        jugadores: lanzador
            ? [...jugadores.where((j) => j.esLanzador), ...jugadores.where((j) => !j.esLanzador)]
            : jugadores,
        excluir: lanzador ? _bateador : _lanzador,
      ),
    );
    if (elegido == null) return;
    setState(() => lanzador ? _lanzador = elegido : _bateador = elegido);
  }

  @override
  Widget build(BuildContext context) {
    final temporada = ref.watch(temporadaEnFocoLigaProvider).value;
    return VistaAsync<List<JugadorLiga>>(
      valor: ref.watch(jugadoresLigaProvider),
      cargando: const EsqueletoDetalle(),
      onReintentar: () => ref.invalidate(jugadoresLigaProvider),
      datos: (jugadores) {
        final ordenados = [...jugadores]..sort((a, b) => a.apellidos.compareTo(b.apellidos));
        JugadorLiga? buscar(int? id) => ordenados.where((j) => j.id == id).firstOrNull;
        final b = buscar(_bateador);
        final l = buscar(_lanzador);
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AnchoMaximo(
              ancho: 760,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const HeroLbc(
                  compacto: true,
                  etiqueta: 'Duelo en el plato',
                  titulo: 'Bateador vs lanzador',
                  subtitulo: 'Su historial cara a cara y la probabilidad de hit, de embasarse o de ponche '
                      'en el próximo turno.',
                  icono: Icons.compare_arrows_rounded,
                ),
                const SizedBox(height: 14),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: _Eleccion(
                      titulo: 'BATEADOR',
                      jugador: b,
                      onTap: () => _elegir(ordenados, lanzador: false),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 52),
                    child: _Vs(),
                  ),
                  Expanded(
                    child: _Eleccion(
                      titulo: 'LANZADOR',
                      jugador: l,
                      onTap: () => _elegir(ordenados, lanzador: true),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                if (b == null || l == null)
                  const EstadoVacio(
                    icono: Icons.touch_app_outlined,
                    mensaje: 'Toca cada lado para elegir al bateador y al lanzador.',
                  )
                else
                  VistaAsync<Enfrentamiento>(
                    valor: ref.watch(enfrentamientoProvider((b.id, l.id, temporada?.id))),
                    cargando: const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    onReintentar: () => ref.invalidate(enfrentamientoProvider((b.id, l.id, temporada?.id))),
                    datos: (e) => _Resultado(enfrentamiento: e),
                  ),
              ]),
            ),
          ],
        );
      },
    );
  }
}

class _Vs extends StatelessWidget {
  const _Vs();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: ColoresMarca.amarillo, shape: BoxShape.circle),
      child: Text(
        'VS',
        style: estiloMarcador(Theme.of(context).textTheme.titleMedium)
            ?.copyWith(color: ColoresMarca.tintaSobreAmarillo, fontSize: 16),
      ),
    );
  }
}

class _Eleccion extends StatelessWidget {
  const _Eleccion({required this.titulo, required this.jugador, required this.onTap});

  final String titulo;
  final JugadorLiga? jugador;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final j = jugador;
    final nombre = j == null ? 'Elegir' : '${j.nombres} ${j.apellidos}';
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(children: [
          Text(titulo, style: estiloEtiqueta(tema.textTheme.labelSmall)?.copyWith(color: tema.colorScheme.primary)),
          const SizedBox(height: 8),
          if (j == null)
            CircleAvatar(
              radius: 42,
              backgroundColor: tema.colorScheme.surfaceContainerHighest,
              child: Icon(Icons.person_add_alt_1_rounded, size: 32, color: tema.colorScheme.primary),
            )
          else
            ImagenApi(urlFoto: j.fotoUrl, nombre: nombre, tamano: 84),
          const SizedBox(height: 8),
          Text(
            nombre,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: tema.textTheme.titleMedium?.copyWith(
              fontFamily: FuentesLbc.titular,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Text(j == null ? 'Toca para elegir' : 'Toca para cambiar', style: tema.textTheme.bodySmall),
        ]),
      ),
    );
  }
}

class _Resultado extends StatelessWidget {
  const _Resultado({required this.enfrentamiento});

  final Enfrentamiento enfrentamiento;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final e = enfrentamiento;
    final p = e.pronostico;
    final h = e.historial;
    final fecha = DateFormat('d MMM y', 'es');

    Widget medidor(String etiqueta, double valor, Color color) => Expanded(
          child: Column(children: [
            Medidor(
              valor: valor * 100,
              minimo: 0,
              maximo: 100,
              colorRelleno: color,
              etiqueta: etiqueta,
              formato: (v) => '${v.round()}%',
              ancho: 104,
            ),
          ]),
        );

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Próximo turno', style: tema.textTheme.titleLarge?.copyWith(fontSize: 20)),
            const SizedBox(height: 12),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              medidor('Hit', p.hit, ColoresMarca.verdeVivo),
              medidor('Se embasa', p.embasarse, ColoresMarca.amarillo),
              medidor('Ponche', p.ponche, ColoresMarca.rojo),
            ]),
            const SizedBox(height: 12),
            Text(p.resumen, style: tema.textTheme.bodySmall),
          ]),
        ),
      ),
      const SizedBox(height: 8),
      Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Historial cara a cara', style: tema.textTheme.titleLarge?.copyWith(fontSize: 20)),
            const SizedBox(height: 4),
            Text(e.lineaHistorial, style: tema.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            if (h == null || h.pa == 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Todavía no se han enfrentado en un partido anotado.',
                  style: tema.textTheme.bodySmall,
                ),
              )
            else ...[
              Row(children: [
                for (final (etiqueta, valor) in [
                  ('PA', '${h.pa}'),
                  ('AB', '${h.ab}'),
                  ('H', '${h.h}'),
                  ('HR', '${h.hr}'),
                  ('BB', '${h.bb}'),
                  ('K', '${h.so}'),
                  ('AVG', promedio(h.avg)),
                ])
                  Expanded(
                    child: Column(children: [
                      Text(etiqueta, style: estiloEtiqueta(tema.textTheme.labelSmall)),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(valor, style: estiloMarcador(tema.textTheme.titleLarge)),
                      ),
                    ]),
                  ),
              ]),
              const Divider(height: 24),
              for (final t in e.turnos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      width: 92,
                      child: Text(
                        '${fecha.format(t.fecha)}\n${t.mitad == MitadEntrada.alta ? 'Alta' : 'Baja'} ${t.entrada}',
                        style: tema.textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        t.descripcion + (t.carreras > 0 ? ' (${t.carreras} C)' : ''),
                        style: tema.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ]),
                ),
            ],
          ]),
        ),
      ),
    ]);
  }
}

class _Selector extends StatefulWidget {
  const _Selector({required this.titulo, required this.jugadores, this.excluir});

  final String titulo;
  final List<JugadorLiga> jugadores;
  final int? excluir;

  @override
  State<_Selector> createState() => _SelectorState();
}

class _SelectorState extends State<_Selector> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    final f = _filtro.toLowerCase();
    final lista = [
      for (final j in widget.jugadores)
        if (j.id != widget.excluir && (f.isEmpty || '${j.nombres} ${j.apellidos}'.toLowerCase().contains(f))) j,
    ];
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(widget.titulo, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextField(
                autofocus: false,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Buscar jugador'),
                onChanged: (v) => setState(() => _filtro = v.trim()),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (_, i) {
                final j = lista[i];
                final nombre = '${j.nombres} ${j.apellidos}';
                return ListTile(
                  leading: ImagenApi(urlFoto: j.fotoUrl, nombre: nombre, tamano: 40),
                  title: Text(nombre),
                  subtitle: j.esLanzador ? const Text('Pitcher') : null,
                  onTap: () => Navigator.pop(context, j.id),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
