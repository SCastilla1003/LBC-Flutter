import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/charts/base_graficas.dart';
import '../../../core/charts/medidor.dart';
import '../../../core/red/fallo_api.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/vista_async.dart';
import '../datos/modelos_prediccion.dart';
import '../datos/prediccion_repositorio.dart';

class PrediccionPantalla extends ConsumerWidget {
  const PrediccionPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opciones = ref.watch(opcionesPrediccionProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('¿Ganará?')),
      body: VistaAsync(
        valor: opciones,
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(opcionesPrediccionProvider),
        datos: (o) => _Formulario(opciones: o),
      ),
    );
  }
}

class _Formulario extends ConsumerStatefulWidget {
  const _Formulario({required this.opciones});

  final OpcionesPrediccion opciones;

  @override
  ConsumerState<_Formulario> createState() => _FormularioState();
}

class _FormularioState extends ConsumerState<_Formulario> {
  late String _localVisitante =
      widget.opciones.localVisitante.firstOrNull ?? 'Local';
  String _rivalFuerza = 'Media';
  double _racha = 1;
  late double _favor = _r(
    widget.opciones.rangos['promCarrerasFavor']?.promedio ?? 4,
  );
  late double _contra = _r(
    widget.opciones.rangos['promCarrerasContra']?.promedio ?? 4,
  );

  bool _enviando = false;
  Prediccion? _resultado;
  Object? _error;

  static double _r(double v) => (v * 10).round() / 10;

  Future<void> _predecir() async {
    setState(() {
      _enviando = true;
      _error = null;
    });
    try {
      final r = await ref
          .read(prediccionRepositorioProvider)
          .predecir(
            EntradaPrediccion(
              localVisitante: _localVisitante,
              rachaUlt3: _racha,
              promCarrerasFavor: _favor,
              promCarrerasContra: _contra,
              rivalFuerza: _rivalFuerza,
            ),
          );
      setState(() => _resultado = r);
    } catch (e) {
      setState(() {
        _error = FalloApi.desde(e);
        _resultado = null;
      });
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.opciones;
    final fuerzas = [
      'Baja',
      'Media',
      'Alta',
    ].where(o.rivalFuerza.contains).toList();
    final campos = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Pregunta(
          icono: Icons.home_work_outlined,
          titulo: 'Juega como',
          child: SegmentedButton<String>(
            segments: [
              for (final v in o.localVisitante)
                ButtonSegment(
                  value: v,
                  label: Text(v),
                  icon: Icon(
                    v == 'Local'
                        ? Icons.home_rounded
                        : Icons.directions_bus_rounded,
                  ),
                ),
            ],
            selected: {_localVisitante},
            onSelectionChanged: (s) =>
                setState(() => _localVisitante = s.first),
          ),
        ),
        _Pregunta(
          icono: Icons.local_fire_department_outlined,
          titulo: 'Ganados',
          valor: '${_racha.round()}',
          child: Slider(
            value: _racha,
            max: 3,
            divisions: 3,
            label: '${_racha.round()}',
            onChanged: (v) => setState(() => _racha = v),
          ),
        ),
        _SliderPromedio(
          icono: Icons.add_circle_outline,
          titulo: 'Carreras anotadas / partido',
          valor: _favor,
          rango: o.rangos['promCarrerasFavor'],
          onChanged: (v) => setState(() => _favor = v),
        ),
        _SliderPromedio(
          icono: Icons.remove_circle_outline,
          titulo: 'Carreras recibidas / partido',
          valor: _contra,
          rango: o.rangos['promCarrerasContra'],
          onChanged: (v) => setState(() => _contra = v),
        ),
        _Pregunta(
          icono: Icons.shield_outlined,
          titulo: 'Rival',
          child: SegmentedButton<String>(
            segments: [
              for (final f in fuerzas) ButtonSegment(value: f, label: Text(f)),
            ],
            selected: {_rivalFuerza},
            onSelectionChanged: (s) => setState(() => _rivalFuerza = s.first),
          ),
        ),
        FilledButton.icon(
          onPressed: _enviando ? null : _predecir,
          icon: _enviando
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.auto_graph_rounded),
          label: const Text('Predecir'),
        ),
      ],
    );

    final formulario = Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: ColoresMarca.franjaInstitucional,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: campos,
          ),
        ],
      ),
    );

    final resultado = _error != null
        ? EstadoError(error: _error!, compacto: true, onReintentar: _predecir)
        : _resultado == null
        ? const _SinResultado()
        : _Resultado(resultado: _resultado!);

    return LayoutBuilder(
      builder: (context, c) {
        final ancha = c.maxWidth >= 900;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AnchoMaximo(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeroLbc(
                    compacto: true,
                    etiqueta: 'Modelo de la liga',
                    titulo: 'El oráculo del diamante',
                    subtitulo: 'Ajusta cómo llega tu equipo y la fuerza del rival: la liga calcula la probabilidad de victoria.',
                    icono: Icons.auto_graph_rounded,
                    contenido: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        PastillaHero(
                          icono: Icons.home_rounded,
                          texto: 'Local o visitante',
                        ),
                        PastillaHero(
                          icono: Icons.local_fire_department_rounded,
                          texto: 'Racha y carreras',
                        ),
                      ],
                    ),
                  ),
                  if (ancha)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: formulario),
                        const SizedBox(width: 24),
                        Expanded(child: resultado),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        formulario,
                        const SizedBox(height: 20),
                        resultado,
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Pregunta extends StatelessWidget {
  const _Pregunta({
    required this.icono,
    required this.titulo,
    required this.child,
    this.valor,
  });

  final IconData icono;
  final String titulo;
  final String? valor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: tema.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  icono,
                  size: 16,
                  color: tema.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  titulo,
                  style: tema.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (valor != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: tema.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    valor!,
                    style: estiloMarcador(tema.textTheme.titleMedium)?.copyWith(
                      fontSize: 18,
                      color: tema.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _SliderPromedio extends StatelessWidget {
  const _SliderPromedio({
    required this.icono,
    required this.titulo,
    required this.valor,
    required this.rango,
    required this.onChanged,
  });

  final IconData icono;
  final String titulo;
  final double valor;
  final Rango? rango;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return _Pregunta(
      icono: icono,
      titulo: titulo,
      valor: valor.toStringAsFixed(1).replaceAll('.', ','),
      child: Tooltip(
        message: rango == null
            ? ''
            : 'Entrenado entre ${Formato.decimal(rango!.minimo)} y ${Formato.decimal(rango!.maximo)}',
        child: Slider(
          value: valor.clamp(0, 12),
          max: 12,
          divisions: 120,
          label: valor.toStringAsFixed(1),
          onChanged: (v) => onChanged((v * 10).round() / 10),
        ),
      ),
    );
  }
}

class _SinResultado extends StatelessWidget {
  const _SinResultado();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: tema.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 30,
                color: tema.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Aún no hay pronóstico',
              style: tema.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Completa los datos del partido y toca Predecir para ver la probabilidad de victoria.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodySmall?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Resultado extends StatelessWidget {
  const _Resultado({required this.resultado});

  final Prediccion resultado;

  @override
  Widget build(BuildContext context) {
    final r = resultado;
    final e = EstiloGrafica(context);
    final color = r.gana ? ColoresEstado.victoria : ColoresEstado.derrota;
    final ent = r.entradas;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, ColoresMarca.dorado]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Medidor(
                  valor: r.confianza,
                  minimo: 0,
                  maximo: 100,
                  colorRelleno: color,
                  etiqueta: 'confianza',
                  formato: (v) => '${v.round()}%',
                  ancho: 220,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      r.gana
                          ? Icons.emoji_events_rounded
                          : Icons.trending_down_rounded,
                      color: color,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      r.gana ? 'Gana' : 'No gana',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: color),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final (icono, texto) in [
                      (
                        ent.localVisitante == 'Local'
                            ? Icons.home_rounded
                            : Icons.directions_bus_rounded,
                        ent.localVisitante,
                      ),
                      (
                        Icons.local_fire_department_outlined,
                        '${ent.rachaUlt3.round()}/3',
                      ),
                      (
                        Icons.add_circle_outline,
                        Formato.decimal(ent.promCarrerasFavor),
                      ),
                      (
                        Icons.remove_circle_outline,
                        Formato.decimal(ent.promCarrerasContra),
                      ),
                      (Icons.shield_outlined, ent.rivalFuerza),
                    ])
                      Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: Icon(icono, size: 16),
                        label: Text(texto, style: e.etiqueta),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
