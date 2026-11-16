import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../equipos/datos/modelos_equipo.dart';
import '../../partidos/datos/modelos_partido.dart';
import '../../partidos/datos/partidos_repositorio.dart';
import 'admin_comun.dart';

class AdminPartidosPantalla extends ConsumerWidget {
  const AdminPartidosPantalla({super.key, required this.idTemporada});

  final String idTemporada;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partidos = ref.watch(partidosProvider(idTemporada));
    return Scaffold(
      appBar: AppBar(title: const Text('Partidos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _formulario(context, null),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nuevo partido'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(partidosProvider(idTemporada).future),
        child: VistaAsync(
          valor: partidos,
          onReintentar: () => ref.invalidate(partidosProvider(idTemporada)),
          esVacio: (l) => l.isEmpty,
          mensajeVacio: 'Sin partidos',
          datos: (lista) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              for (final p in lista.reversed)
                AnchoMaximo(
                  ancho: 760,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: ListTile(
                        title: Text('${p.equipoLocal.nombre ?? '?'} vs ${p.equipoVisitante.nombre ?? '?'}'),
                        subtitle: Text([
                          Formato.fecha(p.fecha),
                          p.estado.etiqueta,
                          if (p.estado != EstadoPartido.programado) '${p.carrerasEquipoLocal}-${p.carrerasEquipoVisitante}',
                        ].join(' · ')),
                        onTap: () => _formulario(context, p),
                        trailing: IconButton(
                          tooltip: 'Eliminar',
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () async {
                            final ok = await confirmar(context,
                                titulo: 'Eliminar partido',
                                mensaje: 'Se eliminará el partido y dejará de contar en los récords.');
                            if (ok && context.mounted) {
                              await ejecutarAccion(context, ref,
                                  () => ref.read(partidosRepositorioProvider).eliminar(idTemporada, p.id),
                                  exito: 'Partido eliminado');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _formulario(BuildContext context, Partido? partido) => showDialog<void>(
        context: context,
        builder: (_) => Dialog.fullscreen(child: _FormularioPartido(idTemporada: idTemporada, partido: partido)),
      );
}

class _FormularioPartido extends ConsumerStatefulWidget {
  const _FormularioPartido({required this.idTemporada, required this.partido});

  final String idTemporada;
  final Partido? partido;

  @override
  ConsumerState<_FormularioPartido> createState() => _FormularioPartidoState();
}

class _FormularioPartidoState extends ConsumerState<_FormularioPartido> {
  final _form = GlobalKey<FormState>();
  late DateTime? _fecha = widget.partido?.fecha;
  late TimeOfDay? _hora = _leerHora(widget.partido?.hora);
  late EstadoPartido _estado = widget.partido?.estado ?? EstadoPartido.programado;
  late String? _estadio = widget.partido?.estadio?.id;
  late String? _local = widget.partido?.equipoLocal.id;
  late String? _visitante = widget.partido?.equipoVisitante.id;
  late final _cl = TextEditingController(text: '${widget.partido?.carrerasEquipoLocal ?? 0}');
  late final _cv = TextEditingController(text: '${widget.partido?.carrerasEquipoVisitante ?? 0}');
  late final _innings = TextEditingController(text: '${widget.partido?.innings ?? 9}');
  late final _actual = TextEditingController(text: '${widget.partido?.inningActual ?? 0}');
  late final _hits = TextEditingController(text: '${widget.partido?.hitTotalesPartido ?? 0}');
  late final _errores = TextEditingController(text: '${widget.partido?.erroresTotalesPartido ?? 0}');
  bool _guardando = false;
  String? _error;

  static TimeOfDay? _leerHora(String? h) {
    if (h == null || h.length < 5) return null;
    return TimeOfDay(hour: int.parse(h.substring(0, 2)), minute: int.parse(h.substring(3, 5)));
  }

  static String _dos(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    for (final c in [_cl, _cv, _innings, _actual, _hits, _errores]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _guardar() async {
    setState(() => _error = null);
    if (!_form.currentState!.validate()) return;
    if (_fecha == null) {
      setState(() => _error = 'Elige la fecha del partido.');
      return;
    }
    if (_local == _visitante) {
      setState(() => _error = 'El equipo local y el visitante deben ser distintos.');
      return;
    }
    setState(() => _guardando = true);
    final f = _fecha!;
    final cuerpo = {
      'fecha': '${f.year}-${_dos(f.month)}-${_dos(f.day)}',
      'hora': _hora == null ? null : '${_dos(_hora!.hour)}:${_dos(_hora!.minute)}',
      'estado': _estado.valorApi,
      'idEstadio': _estadio,
      'idEquipoLocal': _local,
      'idEquipoVisitante': _visitante,
      'carrerasEquipoLocal': entero(_cl),
      'carrerasEquipoVisitante': entero(_cv),
      'innings': entero(_innings),
      'inningActual': entero(_actual),
      'hitTotalesPartido': entero(_hits),
      'erroresTotalesPartido': entero(_errores),
    };
    final repo = ref.read(partidosRepositorioProvider);
    final p = widget.partido;
    final ok = await ejecutarAccion(
      context,
      ref,
      () => p == null ? repo.crear(widget.idTemporada, cuerpo) : repo.actualizar(widget.idTemporada, p.id, cuerpo),
      exito: p == null ? 'Partido creado' : 'Partido actualizado',
    );
    if (!mounted) return;
    setState(() => _guardando = false);
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final equipos = ref.watch(equiposProvider(widget.idTemporada));
    final estadios = ref.watch(estadiosProvider(widget.idTemporada));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.partido == null ? 'Nuevo partido' : 'Editar partido'),
        leading: IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(onPressed: _guardando ? null : _guardar, child: const Text('Guardar')),
          const SizedBox(width: 8),
        ],
      ),
      body: VistaAsync<List<Equipo>>(
        valor: equipos,
        onReintentar: () => ref.invalidate(equiposProvider(widget.idTemporada)),
        esVacio: (l) => l.length < 2,
        mensajeVacio: 'Faltan equipos (mínimo 2)',
        datos: (listaEquipos) => Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AnchoMaximo(
                ancho: 760,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  RejillaCampos(hijos: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.event_rounded),
                      label: Text(_fecha == null ? 'Elegir fecha' : Formato.fecha(_fecha)),
                      onPressed: () async {
                        final f = await showDatePicker(
                          context: context,
                          initialDate: _fecha ?? DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2100),
                        );
                        if (f != null) setState(() => _fecha = f);
                      },
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.schedule_rounded),
                      label: Text(_hora == null ? 'Hora (opcional)' : _hora!.format(context)),
                      onPressed: () async {
                        final h = await showTimePicker(context: context, initialTime: _hora ?? const TimeOfDay(hour: 19, minute: 0));
                        if (h != null) setState(() => _hora = h);
                      },
                    ),
                  ]),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<EstadoPartido>(
                    initialValue: _estado,
                    decoration: const InputDecoration(labelText: 'Estado'),
                    items: [for (final e in EstadoPartido.values) DropdownMenuItem(value: e, child: Text(e.etiqueta))],
                    onChanged: (v) => setState(() => _estado = v ?? _estado),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: listaEquipos.any((e) => e.id == _local) ? _local : null,
                    decoration: const InputDecoration(labelText: 'Equipo local'),
                    items: [for (final e in listaEquipos) DropdownMenuItem(value: e.id, child: Text(e.nombre))],
                    validator: (v) => v == null ? 'Obligatorio' : null,
                    onChanged: (v) => setState(() => _local = v),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: listaEquipos.any((e) => e.id == _visitante) ? _visitante : null,
                    decoration: const InputDecoration(labelText: 'Equipo visitante'),
                    items: [for (final e in listaEquipos) DropdownMenuItem(value: e.id, child: Text(e.nombre))],
                    validator: (v) => v == null ? 'Obligatorio' : null,
                    onChanged: (v) => setState(() => _visitante = v),
                  ),
                  const SizedBox(height: 12),
                  estadios.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => EstadoError(
                        error: e, compacto: true, onReintentar: () => ref.invalidate(estadiosProvider(widget.idTemporada))),
                    data: (lista) => DropdownButtonFormField<String?>(
                      initialValue: lista.any((s) => s.id == _estadio) ? _estadio : null,
                      decoration: const InputDecoration(labelText: 'Estadio'),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('Sin estadio')),
                        for (final s in lista) DropdownMenuItem(value: s.id, child: Text(s.nombre)),
                      ],
                      onChanged: (v) => setState(() => _estadio = v),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Marcador', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 12),
                  RejillaCampos(hijos: [
                    CampoNumero(controller: _cl, etiqueta: 'Carreras local'),
                    CampoNumero(controller: _cv, etiqueta: 'Carreras visitante'),
                    CampoNumero(controller: _innings, etiqueta: 'Innings', minimo: 1, maximo: 30),
                    CampoNumero(controller: _actual, etiqueta: 'Inning actual'),
                    CampoNumero(controller: _hits, etiqueta: 'Hits totales'),
                    CampoNumero(controller: _errores, etiqueta: 'Errores totales'),
                  ]),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
