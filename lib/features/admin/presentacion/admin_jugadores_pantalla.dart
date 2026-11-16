import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../equipos/datos/equipos_repositorio.dart';
import '../../jugadores/datos/jugadores_repositorio.dart';
import '../../jugadores/datos/modelos_jugador.dart';
import 'admin_comun.dart';

/// Bateadores y lanzadores de un equipo, o de los agentes libres si [idEquipo] es null.
class AdminJugadoresPantalla extends ConsumerWidget {
  const AdminJugadoresPantalla({super.key, required this.idTemporada, required this.idEquipo});

  final String idTemporada;
  final String? idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<(String, List<Bateador>, List<Lanzador>)> datos = idEquipo == null
        ? ref.watch(agentesLibresProvider(idTemporada)).whenData((a) => ('Agentes libres', a.bateadores, a.lanzadores))
        : ref
            .watch(equipoDetalleProvider((idTemporada, idEquipo!)))
            .whenData((e) => (e.nombre, e.bateadores, e.lanzadores));

    void recargar() => idEquipo == null
        ? ref.invalidate(agentesLibresProvider(idTemporada))
        : ref.invalidate(equipoDetalleProvider((idTemporada, idEquipo!)));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(datos.value?.$1 ?? 'Jugadores'),
          bottom: const TabBar(tabs: [Tab(text: 'Bateadores'), Tab(text: 'Lanzadores')]),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton.extended(
            onPressed: () {
              final esLanzador = DefaultTabController.of(context).index == 1;
              _abrirFormulario(context, esLanzador: esLanzador);
            },
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: const Text('Nuevo jugador'),
          ),
        ),
        body: VistaAsync(
          valor: datos,
          onReintentar: recargar,
          datos: (d) => TabBarView(children: [
            _Lista(
              vacio: 'Sin bateadores',
              filas: [
                for (final b in d.$2)
                  _FilaJugador(
                    nombre: b.nombre,
                    urlFoto: b.urlFoto,
                    detalle: '${b.posicion ?? 'Sin posición'} · ${b.hits} H · ${b.homeRuns} HR · ${b.carrerasImpulsadas} CI',
                    onEditar: () => _abrirFormulario(context, bateador: b),
                    onAccion: (a) => _accion(context, ref, a, b.id, b.nombre, 'bateadores'),
                    tieneFoto: b.urlFoto != null,
                  ),
              ],
            ),
            _Lista(
              vacio: 'Sin lanzadores',
              filas: [
                for (final l in d.$3)
                  _FilaJugador(
                    nombre: l.nombre,
                    urlFoto: l.urlFoto,
                    detalle: '${l.posicion ?? 'Sin posición'} · ${l.inningsLanzados} IP · ${l.ponchados} K · ERA ${Formato.decimal(l.era)}',
                    onEditar: () => _abrirFormulario(context, lanzador: l, esLanzador: true),
                    onAccion: (a) => _accion(context, ref, a, l.id, l.nombre, 'lanzadores'),
                    tieneFoto: l.urlFoto != null,
                  ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _abrirFormulario(BuildContext context, {Bateador? bateador, Lanzador? lanzador, bool esLanzador = false}) =>
      showDialog<void>(
        context: context,
        builder: (_) => Dialog.fullscreen(
          child: _FormularioJugador(
            idTemporada: idTemporada,
            idEquipo: idEquipo,
            esLanzador: esLanzador || lanzador != null,
            bateador: bateador,
            lanzador: lanzador,
          ),
        ),
      );

  Future<void> _accion(
      BuildContext context, WidgetRef ref, String accion, String idJugador, String nombre, String tipo) async {
    final repo = ref.read(jugadoresRepositorioProvider);
    switch (accion) {
      case 'foto':
        await elegirYSubirFoto(
            context, ref, (bytes, archivo) => repo.subirFoto(idTemporada, tipo, idJugador, bytes, archivo));
      case 'quitarFoto':
        await ejecutarAccion(context, ref, () => repo.eliminarFoto(idTemporada, tipo, idJugador),
            exito: 'Foto eliminada');
      case 'traspasar':
        await _traspasar(context, ref, idJugador, nombre);
      case 'eliminar':
        final ok = await confirmar(context,
            titulo: 'Eliminar jugador', mensaje: 'Se eliminará a $nombre y su foto. No se puede deshacer.');
        if (ok && context.mounted) {
          await ejecutarAccion(
            context,
            ref,
            () => tipo == 'bateadores'
                ? repo.eliminarBateador(idTemporada, idJugador)
                : repo.eliminarLanzador(idTemporada, idJugador),
            exito: 'Jugador eliminado',
          );
        }
    }
  }

  Future<void> _traspasar(BuildContext context, WidgetRef ref, String idJugador, String nombre) async {
    final equipos = await ref.read(equiposProvider(idTemporada).future).catchError((_) => <Never>[]);
    final libres = await ref.read(agentesLibresProvider(idTemporada).future).catchError((_) => const AgentesLibres());
    if (!context.mounted) return;
    final destinos = [
      for (final e in equipos)
        if (e.id != idEquipo) (e.id, e.nombre),
      if (idEquipo != null && libres.idEquipo != null) (libres.idEquipo!, 'Agentes libres'),
    ];
    if (destinos.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No hay otro equipo al que traspasar al jugador.')));
      return;
    }
    final destino = await showDialog<String>(
      context: context,
      builder: (c) => SimpleDialog(
        title: Text('Traspasar a $nombre'),
        children: [
          for (final d in destinos) SimpleDialogOption(onPressed: () => Navigator.pop(c, d.$1), child: Text(d.$2)),
        ],
      ),
    );
    if (destino == null || !context.mounted) return;
    await ejecutarAccion(context, ref, () => ref.read(jugadoresRepositorioProvider).traspasar(idTemporada, idJugador, destino),
        exito: 'Jugador traspasado');
  }
}

class _Lista extends StatelessWidget {
  const _Lista({required this.filas, required this.vacio});

  final List<Widget> filas;
  final String vacio;

  @override
  Widget build(BuildContext context) {
    if (filas.isEmpty) return EstadoVacio(mensaje: vacio, icono: Icons.person_outline_rounded);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [for (final f in filas) AnchoMaximo(ancho: 760, child: Padding(padding: const EdgeInsets.only(bottom: 8), child: f))],
    );
  }
}

class _FilaJugador extends StatelessWidget {
  const _FilaJugador({
    required this.nombre,
    required this.urlFoto,
    required this.detalle,
    required this.onEditar,
    required this.onAccion,
    required this.tieneFoto,
  });

  final String nombre;
  final String? urlFoto;
  final String detalle;
  final VoidCallback onEditar;
  final ValueChanged<String> onAccion;
  final bool tieneFoto;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ImagenApi(urlFoto: urlFoto, nombre: nombre, tamano: 40),
        title: Text(nombre),
        subtitle: Text(detalle),
        onTap: onEditar,
        trailing: PopupMenuButton<String>(
          tooltip: 'Acciones',
          onSelected: onAccion,
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'foto', child: Text('Cambiar foto')),
            if (tieneFoto) const PopupMenuItem(value: 'quitarFoto', child: Text('Quitar foto')),
            const PopupMenuItem(value: 'traspasar', child: Text('Traspasar')),
            const PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
          ],
        ),
      ),
    );
  }
}

class _FormularioJugador extends ConsumerStatefulWidget {
  const _FormularioJugador({
    required this.idTemporada,
    required this.idEquipo,
    required this.esLanzador,
    this.bateador,
    this.lanzador,
  });

  final String idTemporada;
  final String? idEquipo;
  final bool esLanzador;
  final Bateador? bateador;
  final Lanzador? lanzador;

  @override
  ConsumerState<_FormularioJugador> createState() => _FormularioJugadorState();
}

class _FormularioJugadorState extends ConsumerState<_FormularioJugador> {
  final _form = GlobalKey<FormState>();
  late final _nombre = TextEditingController(text: widget.bateador?.nombre ?? widget.lanzador?.nombre);
  late final _edad = TextEditingController(text: '${widget.bateador?.edad ?? widget.lanzador?.edad ?? ''}');
  late final _posicion = TextEditingController(text: widget.bateador?.posicion ?? widget.lanzador?.posicion);
  late String? _mano = widget.bateador?.derechoZurdo ?? widget.lanzador?.derechoZurdo;
  late final Map<String, TextEditingController> _stats;
  bool _guardando = false;

  static const _camposBateo = {
    'homeRuns': 'Jonrones',
    'triples': 'Triples',
    'dobles': 'Dobles',
    'sencillos': 'Sencillos',
    'basePorBola': 'Bases por bola',
    'basePorGolpe': 'Golpeados',
    'ponches': 'Ponches',
    'roboDeBase': 'Bases robadas',
    'carrerasImpulsadas': 'Carreras impulsadas',
    'errores': 'Errores',
  };

  static const _camposPitcheo = {
    'inningsLanzados': 'Innings lanzados',
    'numeroLanzamientos': 'Lanzamientos',
    'ponchados': 'Ponchados',
    'basePorBola': 'Bases por bola',
    'carrerasPermitidas': 'Carreras permitidas',
    'hitsPermitidos': 'Hits permitidos',
    'aparicionesPlato': 'Bateadores enfrentados',
  };

  Map<String, String> get _campos => widget.esLanzador ? _camposPitcheo : _camposBateo;

  @override
  void initState() {
    super.initState();
    final actual = widget.esLanzador ? widget.lanzador?.toJson() : widget.bateador?.toJson();
    _stats = {for (final c in _campos.keys) c: TextEditingController(text: '${actual?[c] ?? 0}')};
  }

  @override
  void dispose() {
    for (final c in [_nombre, _edad, _posicion, ..._stats.values]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _guardando = true);
    final cuerpo = <String, dynamic>{
      'nombre': _nombre.text.trim(),
      'edad': entero(_edad),
      'posicion': _posicion.text.trim().isEmpty ? null : _posicion.text.trim(),
      'derechoZurdo': _mano,
      for (final e in _stats.entries) e.key: entero(e.value),
    };
    final repo = ref.read(jugadoresRepositorioProvider);
    final t = widget.idTemporada;
    final ok = await ejecutarAccion(context, ref, () async {
      if (widget.esLanzador) {
        widget.lanzador == null
            ? await repo.crearLanzador(t, widget.idEquipo, cuerpo)
            : await repo.actualizarLanzador(t, widget.lanzador!.id, cuerpo);
      } else {
        widget.bateador == null
            ? await repo.crearBateador(t, widget.idEquipo, cuerpo)
            : await repo.actualizarBateador(t, widget.bateador!.id, cuerpo);
      }
    }, exito: 'Jugador guardado');
    if (!mounted) return;
    setState(() => _guardando = false);
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final nuevo = widget.bateador == null && widget.lanzador == null;
    final rol = widget.esLanzador ? 'lanzador' : 'bateador';
    return Scaffold(
      appBar: AppBar(
        title: Text(nuevo ? 'Nuevo $rol' : 'Editar $rol'),
        leading: IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(onPressed: _guardando ? null : _guardar, child: const Text('Guardar')),
          const SizedBox(width: 8),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AnchoMaximo(
              ancho: 760,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                TextFormField(
                  controller: _nombre,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Obligatorio' : null,
                ),
                const SizedBox(height: 12),
                RejillaCampos(hijos: [
                  CampoNumero(controller: _edad, etiqueta: 'Edad', minimo: 1, maximo: 99),
                  TextFormField(
                    controller: _posicion,
                    decoration: InputDecoration(
                        labelText: 'Posición', hintText: widget.esLanzador ? 'RHP, LHP…' : 'SS, CF…', isDense: true),
                  ),
                  DropdownButtonFormField<String?>(
                    initialValue: _mano,
                    decoration: const InputDecoration(labelText: 'Mano', isDense: true),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Sin dato')),
                      for (final m in {'Derecho', 'Zurdo', 'Ambidiestro', ?_mano})
                        DropdownMenuItem(value: m, child: Text(m)),
                    ],
                    onChanged: (v) => setState(() => _mano = v),
                  ),
                ]),
                const SizedBox(height: 24),
                Text('Estadísticas', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 12),
                RejillaCampos(hijos: [
                  for (final c in _campos.entries) CampoNumero(controller: _stats[c.key]!, etiqueta: c.value),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
