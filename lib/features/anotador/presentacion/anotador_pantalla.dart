import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/fallo_api.dart';
import '../../../core/sesion/sesion.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/animaciones.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/juego_repositorio.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/campo_en_vivo.dart';
import 'diamante_jugada.dart';
import '../../../liga/presentacion/widgets_juego.dart';
import '../../admin/presentacion/admin_comun.dart';

/// Etiqueta corta para los botones del anotador.
String etiquetaBoton(ResultadoJugada r) => switch (r) {
      ResultadoJugada.basePorBolas => 'Base por bolas',
      ResultadoJugada.toqueSacrificio => 'Sac. toque',
      ResultadoJugada.elevadoSacrificio => 'Sac. elevado',
      ResultadoJugada.descontrolado => 'Wild pitch',
      ResultadoJugada.atrapadoRobando => 'Atrapado robando',
      _ => r.etiqueta,
    };

const _hits = [ResultadoJugada.sencillo, ResultadoJugada.doble, ResultadoJugada.triple, ResultadoJugada.jonron];
const _embasado = [
  ResultadoJugada.basePorBolas,
  ResultadoJugada.golpeado,
  ResultadoJugada.error,
  ResultadoJugada.bolaOcupada,
];
const _outs = [
  ResultadoJugada.ponche,
  ResultadoJugada.rolata,
  ResultadoJugada.elevado,
  ResultadoJugada.linea,
  ResultadoJugada.globo,
  ResultadoJugada.doblePlay,
  ResultadoJugada.elevadoSacrificio,
  ResultadoJugada.toqueSacrificio,
];
const _corredores = [
  ResultadoJugada.baseRobada,
  ResultadoJugada.atrapadoRobando,
  ResultadoJugada.descontrolado,
  ResultadoJugada.passedBall,
  ResultadoJugada.balk,
];

/// Anotador en vivo para admin y anotador: lanzamientos, resultado de cada turno,
/// corredores, cambios, deshacer y fin del partido. Todo se guarda al instante en la API.
class AnotadorPantalla extends ConsumerStatefulWidget {
  const AnotadorPantalla({super.key, required this.idPartido});

  final int idPartido;

  @override
  ConsumerState<AnotadorPantalla> createState() => _AnotadorPantallaState();
}

class _AnotadorPantallaState extends ConsumerState<AnotadorPantalla> {
  /// Último estado devuelto por una acción (más nuevo que el de la carga inicial).
  EstadoJuego? _estado;
  bool _ocupado = false;

  JuegoRepositorio get _repo => ref.read(juegoRepositorioProvider);

  Future<void> _hacer(Future<EstadoJuego> Function() accion) async {
    if (_ocupado) return;
    setState(() => _ocupado = true);
    final mensajero = ScaffoldMessenger.of(context);
    try {
      final e = await accion();
      if (!mounted) return;
      setState(() => _estado = e);
      // Marcador y posiciones que ve el público (este estado ya viene en la respuesta).
      ref.invalidate(partidosLigaProvider);
      ref.invalidate(partidoDetalleLigaProvider);
      ref.invalidate(posicionesLigaProvider);
    } catch (e) {
      final fallo = FalloApi.desde(e);
      mensajero.showSnackBar(SnackBar(content: Text(fallo.mensaje), backgroundColor: ColoresMarca.rojo));
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  Future<void> _jugada(EstadoJuego e, ResultadoJugada r, {bool ajustar = false}) async {
    final hayCorredores = e.bases.any((b) => b != null);
    if (r.deCorredores && !hayCorredores) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay corredores en base')));
      return;
    }
    if (!ajustar && !hayCorredores && !r.deCorredores) {
      await _hacer(() => _repo.jugada(widget.idPartido, r, errores: r == ResultadoJugada.error ? 1 : 0));
      return;
    }
    final elegido = await showModalBottomSheet<({List<Movimiento> movimientos, int errores})>(
      context: context,
      isScrollControlled: true,
      builder: (_) => HojaCorredores(estado: e, resultado: r),
    );
    if (elegido == null || !mounted) return;
    await _hacer(() => _repo.jugada(widget.idPartido, r, movimientos: elegido.movimientos, errores: elegido.errores));
  }

  Future<void> _cambio(EstadoJuego e) async {
    final c = await showModalBottomSheet<_Cambio>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _HojaCambio(estado: e),
    );
    if (c == null || !mounted) return;
    await _hacer(() => _repo.cambio(
          widget.idPartido,
          tipo: c.tipo,
          local: c.local,
          saleId: c.sale,
          entraId: c.entra,
          posicion: c.posicion,
        ));
  }

  /// Detener el partido: retrasado, pospuesto o cancelado. Lo que pasa después lo decide el
  /// administrador.
  Future<void> _detener({bool porEmpate = false}) async {
    final motivo = await showModalBottomSheet<MotivoDetencion>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _HojaMotivo(porEmpate: porEmpate),
    );
    if (motivo == null || !mounted) return;
    await _hacer(() => _repo.suspender(widget.idPartido, motivo: motivo));
  }

  /// El administrador continúa el partido detenido o lo deja así.
  Future<void> _decidir(EstadoJuego e, {required bool continuar}) async {
    final p = e.partido;
    final empate = p.marcador.local == p.marcador.visita;
    final ok = await confirmar(
      context,
      titulo: continuar ? 'Continuar el partido' : 'Dejar el partido así',
      mensaje: continuar
          ? 'El partido vuelve a estar en vivo desde donde quedó.'
          : 'El partido se cierra como ${p.motivo?.etiqueta.toLowerCase() ?? 'cancelado'} con '
              '${p.equipoVisita.abreviatura} ${p.marcador.visita} – ${p.marcador.local} ${p.equipoLocal.abreviatura}.'
              '${empate ? ' Como va empatado, no cuenta en la tabla de posiciones.' : ''}',
      accion: continuar ? 'Continuar' : 'Dejar así',
    );
    if (ok) await _hacer(() => _repo.decidir(widget.idPartido, continuar: continuar));
  }

  Future<void> _finalizar(EstadoJuego e) async {
    final p = e.partido;
    // En el béisbol no hay empates: si va igualado, se detiene con su motivo.
    if (p.marcador.local == p.marcador.visita) {
      await _detener(porEmpate: true);
      return;
    }
    final ok = await confirmar(
      context,
      titulo: 'Finalizar partido',
      mensaje: 'Quedará ${p.equipoVisita.abreviatura} ${p.marcador.visita} – ${p.marcador.local} '
          '${p.equipoLocal.abreviatura}. El partido termina solo al completar las entradas; usa esto '
          'si se acortó (lluvia, regla de nocaut…). Se puede deshacer.',
      accion: 'Finalizar',
    );
    if (ok) await _hacer(() => _repo.finalizar(widget.idPartido));
  }

  @override
  Widget build(BuildContext context) {
    final cargado = ref.watch(estadoJuegoProvider(widget.idPartido));
    final valor = _estado == null ? cargado : AsyncValue.data(_estado!);
    final e = valor.value;
    final enVivo = e?.partido.estado == EstadoPartidoLiga.enJuego;
    final suspendido = e?.partido.estado == EstadoPartidoLiga.suspendido;
    final conMotivo = e?.partido.motivo != null;
    final esAdmin = ref.watch(sesionProvider).esAdmin;
    return Scaffold(
      appBar: AppBar(
        title: Text(e == null ? 'Anotador' : '${e.partido.equipoVisita.abreviatura} @ ${e.partido.equipoLocal.abreviatura}'),
        actions: [
          if (e != null)
            IconButton(
              tooltip: 'Deshacer la última acción',
              onPressed: e.puedeDeshacer && !_ocupado ? () => _hacer(() => _repo.deshacer(widget.idPartido)) : null,
              icon: const Icon(Icons.undo_rounded),
            ),
          if (e != null && (enVivo || suspendido))
            PopupMenuButton<String>(
              tooltip: 'Más acciones',
              onSelected: (v) => switch (v) {
                'cambio' => _cambio(e),
                'suspender' => _detener(),
                'reanudar' => _hacer(() => _repo.reanudar(widget.idPartido)),
                'continuar' => _decidir(e, continuar: true),
                'dejar' => _decidir(e, continuar: false),
                'finalizar' => _finalizar(e),
                _ => null,
              },
              itemBuilder: (_) => [
                if (enVivo) const PopupMenuItem(value: 'cambio', child: Text('Cambios de jugadores')),
                if (enVivo) const PopupMenuItem(value: 'suspender', child: Text('Detener partido')),
                if (suspendido && !conMotivo) const PopupMenuItem(value: 'reanudar', child: Text('Reanudar partido')),
                if (suspendido && conMotivo && esAdmin)
                  const PopupMenuItem(value: 'continuar', child: Text('Continuar el partido')),
                if (suspendido && conMotivo && esAdmin)
                  const PopupMenuItem(value: 'dejar', child: Text('Dejar el partido así')),
                if (!conMotivo) const PopupMenuItem(value: 'finalizar', child: Text('Finalizar partido')),
              ],
            ),
        ],
      ),
      body: VistaAsync<EstadoJuego>(
        valor: valor,
        cargando: const EsqueletoDetalle(),
        onReintentar: () => ref.invalidate(estadoJuegoProvider(widget.idPartido)),
        datos: (e) => Stack(children: [
          _Cuerpo(
            estado: e,
            ocupado: _ocupado,
            alLanzamiento: (t) => _hacer(() => _repo.lanzamiento(widget.idPartido, t)),
            alJugada: (r, {ajustar = false}) => _jugada(e, r, ajustar: ajustar),
            alCambio: () => _cambio(e),
            alReanudar: () => _hacer(() => _repo.reanudar(widget.idPartido)),
            esAdmin: esAdmin,
            alDecidir: (continuar) => _decidir(e, continuar: continuar),
          ),
          if (_ocupado) const Positioned(top: 0, left: 0, right: 0, child: LinearProgressIndicator(minHeight: 3)),
        ]),
      ),
    );
  }
}

class _Cuerpo extends StatelessWidget {
  const _Cuerpo({
    required this.estado,
    required this.ocupado,
    required this.alLanzamiento,
    required this.alJugada,
    required this.alCambio,
    required this.alReanudar,
    this.esAdmin = false,
    this.alDecidir,
  });

  final EstadoJuego estado;
  final bool ocupado;
  final ValueChanged<TipoLanzamiento> alLanzamiento;
  final void Function(ResultadoJugada r, {bool ajustar}) alJugada;
  final VoidCallback alCambio;
  final VoidCallback alReanudar;
  final bool esAdmin;
  final ValueChanged<bool>? alDecidir;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final e = estado;
    final p = e.partido;
    final enVivo = p.estado == EstadoPartidoLiga.enJuego;
    final hayCorredores = e.bases.any((b) => b != null);

    Widget grupo(String titulo, List<ResultadoJugada> rs, {required Color color}) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 8),
              child: Text(titulo.toUpperCase(), style: estiloEtiqueta(tema.textTheme.labelSmall)),
            ),
            _Rejilla(columnas: 2, hijos: [
              for (final r in rs)
                _BotonJugada(
                  texto: etiquetaBoton(r),
                  sigla: r.sigla,
                  color: color,
                  onTap: ocupado || (r.deCorredores && !hayCorredores) ? null : () => alJugada(r),
                  onLongPress: ocupado || r.deCorredores ? null : () => alJugada(r, ajustar: true),
                ),
            ]),
          ],
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      children: [
        AnchoMaximo(
          ancho: 760,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _Tablero(estado: e),
            const SizedBox(height: 12),
            if (p.estado == EstadoPartidoLiga.finalizado) ...[
              if (p.finalEspecial != null) ...[
                LetreroWalkOff(finalEspecial: p.finalEspecial!, equipo: p.equipoLocal.nombre),
                const SizedBox(height: 10),
              ],
              _Banda(
                icono: Icons.flag_rounded,
                texto: p.motivo != null
                    ? 'Partido ${p.motivo!.etiqueta.toLowerCase()}: el administrador lo dejó así.'
                    : 'Partido finalizado. Si hubo un error en la última jugada, usa deshacer (arriba).',
              ),
            ] else if (p.estado == EstadoPartidoLiga.suspendido && p.motivo != null)
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _Banda(
                  icono: Icons.pause_circle_rounded,
                  texto: 'Partido ${p.motivo!.etiqueta.toLowerCase()}. '
                      '${esAdmin ? '¿Continúa el partido o se deja así?' : 'El administrador decidirá si continúa o se deja así.'}',
                ),
                if (esAdmin) ...[
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: ocupado ? null : () => alDecidir?.call(true),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Continuar el partido'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: ocupado ? null : () => alDecidir?.call(false),
                    icon: const Icon(Icons.stop_circle_outlined),
                    label: const Text('Dejarlo así'),
                  ),
                ],
              ])
            else if (p.estado == EstadoPartidoLiga.suspendido)
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const _Banda(icono: Icons.pause_circle_rounded, texto: 'Partido suspendido.'),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: ocupado ? null : alReanudar,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Reanudar partido'),
                ),
              ]),
            if (enVivo) ...[
              CampoEnVivo(juego: e),
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 8),
                child: Text('LANZAMIENTO', style: estiloEtiqueta(tema.textTheme.labelSmall)),
              ),
              _Rejilla(columnas: 2, hijos: [
                for (final t in TipoLanzamiento.values)
                  _BotonLanzamiento(tipo: t, onTap: ocupado ? null : () => alLanzamiento(t)),
              ]),
              grupo('Hit', _hits, color: ColoresMarca.verdeVivo),
              grupo('Se embasa', _embasado, color: ColoresMarca.verdeCampo),
              grupo('Out', _outs, color: ColoresMarca.rojo),
              grupo('Corredores', _corredores, color: ColoresMarca.amarillo),
              const SizedBox(height: 8),
              Text(
                hayCorredores
                    ? 'Con corredores en base podrás indicar a dónde llega cada uno.'
                    : 'Mantén presionado un resultado para ajustar a dónde llega el bateador o anotar errores.',
                style: tema.textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: ocupado ? null : alCambio,
                icon: const Icon(Icons.swap_horiz_rounded),
                label: const Text('Cambios de jugadores'),
              ),
            ],
            if (e.jugadas.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 8),
                child: Text('JUGADA A JUGADA', style: estiloEtiqueta(tema.textTheme.labelSmall)),
              ),
              for (final a in e.jugadas)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      width: 40,
                      child: IndicadorMitad(
                        mitad: a.mitad,
                        texto: '${a.entrada}',
                        color: tema.colorScheme.primary,
                        estilo: estiloCifra(tema.textTheme.labelMedium),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        a.descripcion,
                        style: a.tipo == 'LANZAMIENTO'
                            ? tema.textTheme.bodySmall
                            : tema.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ]),
                ),
            ],
          ]),
        ),
      ],
    );
  }
}

/// Marcador, entrada, diamante con corredores, conteo y outs.
class _Tablero extends StatelessWidget {
  const _Tablero({required this.estado});

  final EstadoJuego estado;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final p = estado.partido;
    final s = p.situacion;
    final enCurso = p.estado == EstadoPartidoLiga.enJuego || p.estado == EstadoPartidoLiga.suspendido;
    const blanco = Colors.white;

    Widget fila(EquipoRefLiga eq, int carreras, bool alBate) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(children: [
            SizedBox(
              width: 12,
              child: alBate && enCurso
                  ? const Icon(Icons.play_arrow_rounded, size: 14, color: ColoresMarca.amarillo)
                  : null,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                eq.abreviatura,
                style: estiloMarcador(tema.textTheme.headlineSmall)?.copyWith(color: blanco),
              ),
            ),
            CifraAnimada(carreras, estilo: estiloMarcador(tema.textTheme.headlineMedium)?.copyWith(color: blanco)),
          ]),
        );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColoresMarca.verdeNoche,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: [
        Expanded(
          flex: 5,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            fila(p.equipoVisita, p.marcador.visita, !estado.bateaLocal),
            fila(p.equipoLocal, p.marcador.local, estado.bateaLocal),
            const SizedBox(height: 6),
            if (enCurso)
              IndicadorMitad(
                mitad: p.mitad,
                texto: '${p.mitad == MitadEntrada.alta ? 'Alta' : 'Baja'} del ${p.entradaActual}',
                color: ColoresMarca.amarillo,
                estilo: tema.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              )
            else
              Text(
                p.estado == EstadoPartidoLiga.finalizado
                    ? 'Final${p.entradaActual > p.entradasProgramadas ? ' · ${p.entradaActual} entradas' : ''}'
                    : 'Sin empezar',
                style: tema.textTheme.labelLarge?.copyWith(color: ColoresMarca.amarillo, fontWeight: FontWeight.w700),
              ),
            Text(
              'H ${p.hits.visita}-${p.hits.local} · E ${p.errores.visita}-${p.errores.local}',
              style: tema.textTheme.labelSmall?.copyWith(color: Colors.white70),
            ),
          ]),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: Column(children: [
            DiamanteBases(bases: estado.bases),
            const SizedBox(height: 8),
            ConteoJuego(bolas: s?.bolas ?? 0, strikes: s?.strikes ?? 0, outs: s?.outs ?? 0),
          ]),
        ),
      ]),
    );
  }
}

/// Rejilla de botones del mismo ancho.
class _Rejilla extends StatelessWidget {
  const _Rejilla({required this.columnas, required this.hijos});

  final int columnas;
  final List<Widget> hijos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      const espacio = 8.0;
      final ancho = (c.maxWidth - espacio * (columnas - 1)) / columnas;
      return Wrap(
        spacing: espacio,
        runSpacing: espacio,
        children: [for (final h in hijos) SizedBox(width: ancho, child: h)],
      );
    });
  }
}

class _BotonLanzamiento extends StatelessWidget {
  const _BotonLanzamiento({required this.tipo, required this.onTap});

  final TipoLanzamiento tipo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (fondo, tinta) = switch (tipo) {
      TipoLanzamiento.bola => (ColoresMarca.verdeVivo, Colors.white),
      TipoLanzamiento.foul => (ColoresMarca.amarillo, ColoresMarca.tintaSobreAmarillo),
      _ => (ColoresMarca.rojo, Colors.white),
    };
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: fondo,
        foregroundColor: tinta,
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(tipo.etiqueta, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}

class _BotonJugada extends StatelessWidget {
  const _BotonJugada({
    required this.texto,
    required this.sigla,
    required this.color,
    required this.onTap,
    required this.onLongPress,
  });

  final String texto;
  final String sigla;
  final Color color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return OutlinedButton(
      onPressed: onTap,
      onLongPress: onLongPress,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(46),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        side: BorderSide(color: onTap == null ? tema.disabledColor : color, width: 1.5),
      ),
      child: Row(children: [
        Container(
          width: 34,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: onTap == null ? tema.disabledColor : color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            sigla,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color == ColoresMarca.amarillo ? ColoresMarca.tintaSobreAmarillo : Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(texto, maxLines: 1, overflow: TextOverflow.ellipsis, style: tema.textTheme.labelLarge),
        ),
      ]),
    );
  }
}

/// Por qué se detiene el partido: retrasado, pospuesto o cancelado.
class _HojaMotivo extends StatelessWidget {
  const _HojaMotivo({required this.porEmpate});

  /// Se abrió al intentar finalizar con el marcador empatado.
  final bool porEmpate;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(porEmpate ? 'En el béisbol no hay empates' : 'Detener partido', style: tema.textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            porEmpate
                ? 'El partido va empatado, así que no se puede finalizar. ¿Por qué se detiene? '
                    'Luego el administrador decide si continúa o se deja así.'
                : '¿Por qué se detiene? Luego el administrador decide si continúa o se deja así.',
            style: tema.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          for (final (m, icono) in [
            (MotivoDetencion.retrasado, Icons.schedule_rounded),
            (MotivoDetencion.pospuesto, Icons.event_repeat_rounded),
            (MotivoDetencion.cancelado, Icons.cancel_outlined),
          ])
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(icono, color: tema.colorScheme.primary),
                title: Text(m.etiqueta, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(m.descripcion),
                onTap: () => Navigator.pop(context, m),
              ),
            ),
        ]),
      ),
    );
  }
}

class _Banda extends StatelessWidget {
  const _Banda({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: esquema.secondaryContainer, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icono, color: esquema.onSecondaryContainer),
        const SizedBox(width: 10),
        Expanded(child: Text(texto, style: TextStyle(color: esquema.onSecondaryContainer))),
      ]),
    );
  }
}

// ------------------------------------------------------------------ corredores

/// Hoja para indicar a dónde llega cada corredor (y el bateador) y los errores.
class HojaCorredores extends StatefulWidget {
  const HojaCorredores({super.key, required this.estado, required this.resultado});

  final EstadoJuego estado;
  final ResultadoJugada resultado;

  @override
  State<HojaCorredores> createState() => _HojaCorredoresState();
}

class _HojaCorredoresState extends State<HojaCorredores> {
  /// Vista elegida (lista o diamante); se recuerda mientras la app esté abierta.
  static bool _diamante = false;

  /// desde → hasta (null = out; igual a desde = se queda).
  late final Map<int, int?> _destino = _inicial();
  late int _errores = widget.resultado == ResultadoJugada.error ? 1 : 0;

  Map<int, int?> _inicial() {
    final bases = widget.estado.bases;
    final m = <int, int?>{
      if (!widget.resultado.deCorredores) 0: 1,
      for (var b = 1; b <= 3; b++)
        if (bases[b] != null) b: b,
    };
    for (final mov in movimientosPorDefecto(bases, widget.resultado)) {
      m[mov.desde] = mov.hasta;
    }
    return m;
  }

  String _nombre(int desde) {
    final e = widget.estado;
    final id = desde == 0 ? e.partido.situacion?.bateador?.id : e.bases[desde];
    final n = e.nombre(id);
    return n.isEmpty ? (desde == 0 ? 'Bateador' : 'Corredor') : n;
  }

  /// Las mismas reglas que los botones: nadie retrocede y el bateador llega por lo menos a la
  /// base que exige la jugada (y no puede ser out si llega a salvo).
  bool _permitido(int desde, int? hasta) {
    final r = widget.resultado;
    if (desde == 0) return hasta == null ? !r.bateadorASalvo : hasta >= r.baseMinima;
    return hasta == null || hasta >= desde;
  }

  /// Bases donde quedarían dos corredores.
  List<int> get _repetidas {
    final cuenta = <int, int>{};
    for (final h in _destino.values) {
      if (h != null && h >= 1 && h <= 3) cuenta[h] = (cuenta[h] ?? 0) + 1;
    }
    return [for (final MapEntry(key: b, value: n) in cuenta.entries) if (n > 1) b]..sort();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final r = widget.resultado;
    final filas = _destino.keys.toList()..sort((a, b) => b.compareTo(a));
    final repetidas = _repetidas;

    Widget fila(int desde) {
      final opciones = <(String, int?)>[
        ('Out', null),
        for (var b = max(1, desde); b <= 3; b++) (b == desde ? 'Se queda' : '$bª', b),
        ('Anota', 4),
      ];
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '${_nombre(desde)} · ${desde == 0 ? 'bateador' : 'en ${MitadNombre.base(desde)}'}',
            style: tema.textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Wrap(spacing: 6, runSpacing: 6, children: [
            for (final (texto, hasta) in opciones)
              ChoiceChip(
                label: Text(texto),
                selected: _destino[desde] == hasta,
                onSelected: _permitido(desde, hasta) ? (_) => setState(() => _destino[desde] = hasta) : null,
              ),
          ]),
        ]),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(r.etiqueta, style: tema.textTheme.titleLarge),
                Text(
                  _diamante
                      ? 'Arrastra cada cara a donde llegó, o tócala y luego toca la base.'
                      : '¿A dónde llega cada uno?',
                  style: tema.textTheme.bodySmall,
                ),
              ]),
            ),
            IconButton.filledTonal(
              tooltip: _diamante ? 'Ver como lista' : 'Ver en el diamante',
              onPressed: () => setState(() => _diamante = !_diamante),
              icon: Icon(_diamante ? Icons.view_list_rounded : Icons.sports_baseball_rounded),
            ),
          ]),
          const SizedBox(height: 14),
          if (_diamante)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DiamanteJugada(
                estado: widget.estado,
                destino: _destino,
                permitido: _permitido,
                alMover: (desde, hasta) => setState(() => _destino[desde] = hasta),
              ),
            )
          else
            for (final d in filas) fila(d),
          if (repetidas.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Dos corredores no pueden quedar en ${repetidas.map(MitadNombre.base).join(' ni en ')}.',
                style: tema.textTheme.bodyMedium?.copyWith(color: tema.colorScheme.error, fontWeight: FontWeight.w600),
              ),
            ),
          if (!r.deCorredores)
            Row(children: [
              Expanded(child: Text('Errores de la defensa', style: tema.textTheme.titleSmall)),
              IconButton(
                tooltip: 'Menos errores',
                onPressed: _errores > (r == ResultadoJugada.error ? 1 : 0) ? () => setState(() => _errores--) : null,
                icon: const Icon(Icons.remove_circle_outline_rounded),
              ),
              Text('$_errores', style: estiloMarcador(tema.textTheme.titleLarge)),
              IconButton(
                tooltip: 'Más errores',
                onPressed: _errores < 3 ? () => setState(() => _errores++) : null,
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
            ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: repetidas.isNotEmpty ? null : () => Navigator.pop(context, (
                  movimientos: [
                    for (final MapEntry(key: desde, value: hasta) in _destino.entries)
                      if (hasta != desde) (desde: desde, hasta: hasta),
                  ],
                  errores: _errores,
                )),
                child: const Text('Anotar'),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

/// Nombres de las bases para los textos.
abstract final class MitadNombre {
  static String base(int b) => switch (b) {
        1 => 'primera',
        2 => 'segunda',
        3 => 'tercera',
        _ => 'home',
      };
}

// ------------------------------------------------------------------ cambios

typedef _Cambio = ({TipoCambio tipo, bool local, int sale, int entra, String? posicion});

const _posiciones = ['P', 'C', '1B', '2B', '3B', 'SS', 'LF', 'CF', 'RF', 'DH'];

class _HojaCambio extends StatefulWidget {
  const _HojaCambio({required this.estado});

  final EstadoJuego estado;

  @override
  State<_HojaCambio> createState() => _HojaCambioState();
}

class _HojaCambioState extends State<_HojaCambio> {
  TipoCambio _tipo = TipoCambio.emergente;
  late bool _local = widget.estado.bateaLocal;
  int? _sale;
  int? _entra;
  String? _posicion;

  EstadoJuego get _e => widget.estado;
  EquipoJuego get _equipo => _local ? _e.local : _e.visita;

  @override
  void initState() {
    super.initState();
    _elegirTipo(TipoCambio.emergente);
  }

  /// Ajusta equipo y "sale" a lo típico de cada cambio.
  void _elegirTipo(TipoCambio t) {
    _tipo = t;
    _entra = null;
    _posicion = null;
    switch (t) {
      case TipoCambio.emergente:
        _local = _e.bateaLocal;
        _sale = _e.partido.situacion?.bateador?.id;
      case TipoCambio.corredorEmergente:
        _local = _e.bateaLocal;
        _sale = _e.bases.skip(1).whereType<int>().firstOrNull;
      case TipoCambio.lanzador:
        _local = !_e.bateaLocal;
        _sale = _equipo.lanzador?.id;
      case TipoCambio.defensivo:
        _local = !_e.bateaLocal;
        _sale = null;
    }
  }

  List<JugadorResumenLiga> get _quienesSalen => switch (_tipo) {
        TipoCambio.emergente => _equipo.enJuego.where((j) => j.id == _e.partido.situacion?.bateador?.id).toList(),
        TipoCambio.corredorEmergente => _equipo.enJuego.where((j) => _e.bases.contains(j.id)).toList(),
        TipoCambio.lanzador => [?_equipo.lanzador],
        TipoCambio.defensivo => _equipo.enJuego.where((j) => j.id != _equipo.lanzador?.id).toList(),
      };

  String _nombre(JugadorResumenLiga j) => '${j.nombres} ${j.apellidos}';

  bool get _listo =>
      _sale != null &&
      _entra != null &&
      (_tipo != TipoCambio.defensivo || _posicion != null) &&
      (_entra != _sale || _tipo == TipoCambio.defensivo);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final salen = _quienesSalen;
    final entran = [
      if (_tipo == TipoCambio.defensivo && _sale != null)
        ...salen.where((j) => j.id == _sale),
      ..._equipo.disponibles,
    ];
    final equipoFijo = _tipo == TipoCambio.emergente || _tipo == TipoCambio.corredorEmergente;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Cambio de jugadores', style: tema.textTheme.titleLarge),
          const SizedBox(height: 12),
          DropdownButtonFormField<TipoCambio>(
            initialValue: _tipo,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Tipo de cambio'),
            items: [for (final t in TipoCambio.values) DropdownMenuItem(value: t, child: Text(t.etiqueta))],
            onChanged: (t) => setState(() => _elegirTipo(t!)),
          ),
          const SizedBox(height: 12),
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: false, label: Text(_e.visita.equipo.abreviatura)),
              ButtonSegment(value: true, label: Text(_e.local.equipo.abreviatura)),
            ],
            selected: {_local},
            onSelectionChanged: equipoFijo
                ? null
                : (v) => setState(() {
                      _local = v.first;
                      _sale = _tipo == TipoCambio.lanzador ? _equipo.lanzador?.id : null;
                      _entra = null;
                    }),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            key: ValueKey('sale-$_tipo-$_local'),
            initialValue: salen.any((j) => j.id == _sale) ? _sale : null,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Sale'),
            items: [for (final j in salen) DropdownMenuItem(value: j.id, child: Text(_nombre(j)))],
            onChanged: (v) => setState(() {
              _sale = v;
              _entra = null;
            }),
          ),
          if (salen.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('No hay a quién cambiar con este tipo de cambio.', style: tema.textTheme.bodySmall),
            ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            key: ValueKey('entra-$_tipo-$_local-$_sale'),
            initialValue: _entra,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Entra'),
            items: [
              for (final j in entran)
                DropdownMenuItem(
                  value: j.id,
                  child: Text(j.id == _sale ? '${_nombre(j)} (solo cambia de posición)' : _nombre(j)),
                ),
            ],
            onChanged: (v) => setState(() => _entra = v),
          ),
          if (_equipo.disponibles.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('No quedan jugadores disponibles en el roster.', style: tema.textTheme.bodySmall),
            ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            initialValue: _posicion,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: _tipo == TipoCambio.defensivo ? 'Posición' : 'Posición (opcional)',
            ),
            items: [
              if (_tipo != TipoCambio.defensivo) const DropdownMenuItem(value: null, child: Text('Sin cambiar')),
              for (final p in _posiciones)
                if (_tipo != TipoCambio.defensivo || p != 'P') DropdownMenuItem(value: p, child: Text(p)),
            ],
            onChanged: (v) => setState(() => _posicion = v),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: _listo
                    ? () => Navigator.pop<_Cambio>(context, (
                          tipo: _tipo,
                          local: _local,
                          sale: _sale!,
                          entra: _entra!,
                          posicion: _posicion,
                        ))
                    : null,
                child: const Text('Hacer cambio'),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
