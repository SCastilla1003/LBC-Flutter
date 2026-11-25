import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/tema/colores_equipo.dart';
import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/animaciones.dart';
import '../../core/widgets/imagen_api.dart';
import '../datos/juego_repositorio.dart';
import '../datos/modelos_liga.dart';
import 'anuncios_juego.dart';

/// Lado del plato donde se para el bateador, visto desde detrás del home: el derecho
/// sale a la izquierda (lado de tercera) y el zurdo a la derecha. El ambidiestro batea
/// del lado contrario a la mano del lanzador.
bool bateadorALaIzquierda(LadoBateo? batea, LadoLanzamiento? lanza) => switch (batea) {
      LadoBateo.zurdo => false,
      LadoBateo.ambidiestro => lanza == LadoLanzamiento.zurdo,
      _ => true,
    };

/// El terreno en vivo visto desde detrás del home: el lanzador en el montículo, el
/// bateador en su caja (derecho o zurdo), las caras de los corredores en sus bases y el
/// próximo bateador en su círculo (a la derecha si batea el visitante, a la izquierda si
/// batea el local).
///
/// Cuando llega una jugada nueva las caras corren a su base nueva, las que anotan van hasta
/// home, la pelota vuela y sale un cartel ("¡STRIKE!", "OUT", "¡JONRÓN!"...).
class CampoEnVivo extends StatefulWidget {
  const CampoEnVivo({super.key, required this.juego, this.alTocar});

  final EstadoJuego juego;

  /// Si se da, tocar a un jugador lo abre.
  final void Function(JugadorResumenLiga jugador, EquipoRefLiga equipo)? alTocar;

  @override
  State<CampoEnVivo> createState() => _CampoEnVivoState();
}

/// Un jugador que ya no está en el campo y se va: a home si anotó, o se desvanece si fue out.
class _Fantasma {
  _Fantasma({
    required this.clave,
    required this.desde,
    required this.anota,
    required this.nombre,
    required this.jugador,
    required this.color,
  });

  final String clave;

  /// 0 = bateador, 1..3 = base.
  final int desde;

  /// Si anotó corre por las bases que le faltan hasta home; si fue out se desvanece.
  final bool anota;
  final String nombre;
  final JugadorResumenLiga? jugador;
  final Color color;
}

const _corre = Duration(milliseconds: 750);

class _CampoEnVivoState extends State<CampoEnVivo> {
  int? _ultimaAccion;
  AccionJuego? _nueva;
  int _serie = 0;
  final _fantasmas = <_Fantasma>[];

  /// Bases por las que pasa cada corredor que avanzó más de una (de primera a tercera pasa por
  /// segunda), para que corra por las líneas y no cruce el cuadro.
  final _via = <int, List<int>>{};

  @override
  void initState() {
    super.initState();
    // Lo que ya pasó no se anuncia: solo lo que llegue mientras se mira.
    _ultimaAccion = widget.juego.jugadas.firstOrNull?.id;
  }

  /// Dónde está cada jugador de la ofensiva: 0 = al bate, 1..3 = base.
  static Map<int, int> _lugares(EstadoJuego j) {
    final s = j.partido.situacion;
    final c = s?.corredores;
    return {
      if (s?.bateador != null) s!.bateador!.id: 0,
      if (c?.primera != null) c!.primera!.id: 1,
      if (c?.segunda != null) c!.segunda!.id: 2,
      if (c?.tercera != null) c!.tercera!.id: 3,
    };
  }

  static int _carrerasDe(EstadoJuego j, int idEquipo) =>
      j.partido.equipoLocal.id == idEquipo ? j.partido.marcador.local : j.partido.marcador.visita;

  @override
  void didUpdateWidget(CampoEnVivo old) {
    super.didUpdateWidget(old);
    final nueva = widget.juego.jugadas.firstOrNull;
    if (nueva == null || nueva.id == _ultimaAccion) return;
    _ultimaAccion = nueva.id;
    _nueva = nueva;
    _serie++;
    _via.clear();

    // Quien estaba en base (o al bate) y ya no está: los primeros en anotar son los más adelantados.
    final antes = _lugares(old.juego);
    final ahora = _lugares(widget.juego);
    final equipo = old.juego.ofensiva.equipo;
    var anotaron = _carrerasDe(widget.juego, equipo.id) - _carrerasDe(old.juego, equipo.id);
    final mismaOfensiva = widget.juego.ofensiva.equipo.id == equipo.id;
    final idos = [
      for (final MapEntry(key: id, value: lugar) in antes.entries)
        if (!(mismaOfensiva && ahora.containsKey(id))) (id, lugar),
    ]..sort((a, b) => b.$2.compareTo(a.$2));
    if (mismaOfensiva) {
      for (final MapEntry(key: id, value: base) in ahora.entries) {
        final previa = antes[id];
        if (previa != null && base > previa + 1) _via[id] = [for (var b = previa + 1; b < base; b++) b];
      }
    }
    final orden = old.juego.ofensiva.orden.map((t) => t.jugador).whereType<JugadorResumenLiga>();
    for (final (id, lugar) in idos) {
      // Al cambiar de mitad el bateador de la mitad anterior simplemente se va.
      if (lugar == 0 && anotaron <= 0) continue;
      final anota = anotaron > 0;
      if (anota) anotaron--;
      _fantasmas.add(_Fantasma(
        clave: '$_serie-$id',
        desde: lugar,
        anota: anota,
        nombre: old.juego.nombre(id),
        jugador: orden.where((j) => j.id == id).firstOrNull,
        color: ColoresEquipo.de(context, equipo.color),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final juego = widget.juego;
    final p = juego.partido;
    final s = p.situacion;
    final of = juego.ofensiva;
    final def = juego.defensa;
    final turno = of.orden.where((t) => t.jugador != null && t.jugador!.id == s?.bateador?.id).firstOrNull;
    final bateador = turno?.jugador;
    final lanzador = def.lanzador;
    final despues = (turno?.orden ?? of.proximo) % 9 + 1;
    final siguiente = of.orden.where((t) => t.orden == despues).firstOrNull?.jugador;
    JugadorResumenLiga? deOfensiva(int id) =>
        of.orden.map((t) => t.jugador).whereType<JugadorResumenLiga>().where((j) => j.id == id).firstOrNull;
    final c = s?.corredores;
    final corredores = [c?.primera, c?.segunda, c?.tercera];
    final colorOf = ColoresEquipo.de(context, of.equipo.color);
    final colorDef = ColoresEquipo.de(context, def.equipo.color);
    final izquierda = bateadorALaIzquierda(bateador?.batea, lanzador?.lanza);
    final proximoDerecha = !juego.bateaLocal;
    final alTocar = widget.alTocar;
    VoidCallback? abrir(JugadorResumenLiga? j, EquipoRefLiga e) =>
        j == null || alTocar == null ? null : () => alTocar(j, e);
    final corre = duracionLbc(context, _corre);

    return LayoutBuilder(builder: (context, cons) {
      final w = math.min(cons.maxWidth, 460.0);
      final h = w * 1.28;
      Offset en(double x, double y) => Offset(w * x, h * y);
      final home = en(0.5, 0.72);
      final primera = en(0.83, 0.47);
      final segunda = en(0.5, 0.23);
      final tercera = en(0.17, 0.47);
      final monticulo = en(0.5, 0.47);
      final bases = [primera, segunda, tercera];
      final caraGrande = (w * 0.17).clamp(52.0, 74.0);
      final caraCorredor = (w * 0.13).clamp(40.0, 58.0);
      final caraProximo = (w * 0.12).clamp(38.0, 52.0);
      final cajaBateo = home + Offset(w * (izquierda ? -0.13 : 0.13), 0);
      final circuloIzq = Offset(w * 0.115, h - w * 0.17);
      final circuloDer = Offset(w * 0.885, h - w * 0.17);
      final circuloProximo = proximoDerecha ? circuloDer : circuloIzq;
      const alturaEtiqueta = 16.0;
      // Cara + separación + nombre en una línea.
      final altoCorredor = caraCorredor + 4 + 19;
      double arribaDeBase(int i) => bases[i].dy - w * 0.035 - altoCorredor;
      final anchoCorredor = w * 0.3;

      Offset sobreBase(int base) => base == 4
          ? Offset(home.dx, home.dy - altoCorredor + w * 0.02)
          : Offset(bases[base - 1].dx, arribaDeBase(base - 1));

      // Cada jugador conserva su clave: si cambia de lugar (del bate a primera, de primera a
      // tercera pasando por segunda, del círculo de espera al bate) corre hasta allí.
      Widget colocar(int id, double cx, double ancho, double top, Widget hijo) => _FichaEnRuta(
            key: ValueKey('j$id'),
            destino: Offset(cx, top),
            via: [for (final b in _via[id] ?? const <int>[]) sobreBase(b)],
            ancho: ancho,
            limite: w,
            tramo: corre,
            child: _Aparece(child: hijo),
          );

      final anuncio = _nueva == null ? null : anuncioDe(_nueva!);
      final enJuego = p.estado == EstadoPartidoLiga.enJuego;

      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: w,
            height: h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0F7340), Color(0xFF0A522D)],
              ),
            ),
            child: Stack(children: [
              Positioned.fill(
                child: ExcludeSemantics(
                  child: CustomPaint(
                    painter: _Terreno(
                      home: home,
                      bases: bases,
                      monticulo: monticulo,
                      ocupadas: [for (final r in corredores) r != null],
                      cajas: [home + Offset(-w * 0.13, 0), home + Offset(w * 0.13, 0)],
                      circulos: [circuloIzq, circuloDer],
                      escala: w,
                    ),
                  ),
                ),
              ),
              Positioned(top: 10, left: 10, child: _EnVivo(suspendido: p.estado == EstadoPartidoLiga.suspendido)),
              Positioned(
                top: 12,
                right: 12,
                child: AnimatedSwitcher(
                  duration: duracionLbc(context, const Duration(milliseconds: 400)),
                  child: Text(
                    'Batea ${of.equipo.abreviatura}',
                    key: ValueKey(of.equipo.id),
                    style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // Los que se van: a home si anotaron; si fueron out, se desvanecen.
              for (final f in _fantasmas)
                _FichaQueSeVa(
                  key: ValueKey('fantasma-${f.clave}'),
                  ruta: [
                    if (f.desde == 0)
                      Offset(cajaBateo.dx, cajaBateo.dy - caraGrande / 2 - alturaEtiqueta)
                    else
                      sobreBase(f.desde),
                    if (f.anota)
                      for (var b = f.desde + 1; b <= 4; b++) sobreBase(b),
                  ],
                  ancho: anchoCorredor,
                  limite: w,
                  duracion: duracionLbc(
                    context,
                    f.anota ? corre * (4 - f.desde) + const Duration(milliseconds: 350) : _corre,
                  ),
                  alTerminar: () => setState(() => _fantasmas.remove(f)),
                  child: _Ficha(
                    jugador: f.jugador,
                    nombre: f.nombre,
                    cara: caraCorredor,
                    color: f.color,
                    lineas: 1,
                  ),
                ),
              // El lanzador, en el montículo.
              if (lanzador != null || s?.lanzador != null)
                colocar(
                  lanzador?.id ?? s!.lanzador!.id,
                  monticulo.dx,
                  w * 0.38,
                  monticulo.dy - h * 0.03 - caraGrande / 2 - alturaEtiqueta,
                  _Ficha(
                    etiqueta: 'LANZA',
                    jugador: lanzador,
                    nombre: lanzador == null ? s!.lanzador!.nombre : '${lanzador.nombres} ${lanzador.apellidos}',
                    detalle: '${def.equipo.abreviatura} · ${def.lanzamientos} lanz.',
                    cara: caraGrande,
                    color: colorDef,
                    onTap: abrir(lanzador, def.equipo),
                  ),
                ),
              // Los corredores, justo encima de su base.
              for (final (i, r) in corredores.indexed)
                if (r != null)
                  colocar(
                    r.id,
                    bases[i].dx,
                    anchoCorredor,
                    arribaDeBase(i),
                    _Ficha(
                      jugador: deOfensiva(r.id),
                      nombre: r.nombre,
                      descripcion: 'En ${['primera', 'segunda', 'tercera'][i]}: ${r.nombre}',
                      cara: caraCorredor,
                      color: colorOf,
                      lineas: 1,
                      onTap: abrir(deOfensiva(r.id), of.equipo),
                    ),
                  ),
              // El bateador, en la caja de su lado.
              if (bateador != null || s?.bateador != null)
                colocar(
                  bateador?.id ?? s!.bateador!.id,
                  cajaBateo.dx,
                  w * 0.28,
                  cajaBateo.dy - caraGrande / 2 - alturaEtiqueta,
                  _Ficha(
                    etiqueta: 'AL BATE',
                    jugador: bateador,
                    nombre: bateador == null ? s!.bateador!.nombre : '${bateador.nombres} ${bateador.apellidos}',
                    detalle: [
                      of.equipo.abreviatura,
                      if (turno != null) '${turno.orden}º${turno.posicion == null ? '' : ' ${turno.posicion}'}',
                    ].join(' · '),
                    descripcion: 'Batea ${izquierda ? 'a la derecha' : 'a la zurda'}',
                    cara: caraGrande,
                    color: colorOf,
                    onTap: abrir(bateador, of.equipo),
                  ),
                ),
              // El próximo, en su círculo de espera.
              if (siguiente != null)
                colocar(
                  siguiente.id,
                  circuloProximo.dx,
                  w * 0.23,
                  circuloProximo.dy - caraProximo / 2 - alturaEtiqueta,
                  _Ficha(
                    etiqueta: 'PRÓXIMO',
                    jugador: siguiente,
                    nombre: '${siguiente.nombres} ${siguiente.apellidos}',
                    cara: caraProximo,
                    color: colorOf,
                    tamanoNombre: 12,
                    onTap: abrir(siguiente, of.equipo),
                  ),
                ),
              // La pelota y el cartel de lo que acaba de pasar.
              if (anuncio != null && (enJuego || p.estado == EstadoPartidoLiga.finalizado) &&
                  !MediaQuery.disableAnimationsOf(context)) ...[
                if (anuncio.vuelo != null)
                  Positioned.fill(
                    child: _pelota(anuncio.vuelo!, w: w, h: h, home: home, monticulo: monticulo, bases: bases),
                  ),
                Positioned(
                  left: 8,
                  right: 8,
                  top: h * 0.31,
                  child: Center(
                    child: CartelAnuncio(
                      key: ValueKey('anuncio$_serie'),
                      anuncio: anuncio,
                      retraso: Duration(milliseconds: anuncio.vuelo == null ? 0 : 450),
                    ),
                  ),
                ),
              ],
            ]),
          ),
        ),
      );
    });
  }

  /// Recorrido de la pelota: lanzamiento al home o batazo hacia una de tres zonas, que cambia
  /// de jugada en jugada.
  Widget _pelota(
    Vuelo vuelo, {
    required double w,
    required double h,
    required Offset home,
    required Offset monticulo,
    required List<Offset> bases,
  }) {
    final k = _serie % 3;
    final (desde, hasta, altura, ms) = switch (vuelo) {
      Vuelo.lanzamiento => (monticulo, home, 8.0, 420),
      Vuelo.rodado => (home, Offset.lerp(home, [bases[2], bases[1], bases[0]][k], 0.92)!, 0.0, 650),
      Vuelo.linea => (home, [Offset(w * 0.2, h * 0.2), Offset(w * 0.5, h * 0.09), Offset(w * 0.8, h * 0.2)][k], 22.0, 650),
      Vuelo.elevado => (home, [Offset(w * 0.24, h * 0.16), Offset(w * 0.5, h * 0.1), Offset(w * 0.76, h * 0.16)][k], 150.0, 1100),
      Vuelo.largo => (home, [Offset(w * 0.08, h * 0.12), Offset(w * 0.32, h * 0.04), Offset(w * 0.92, h * 0.12)][k], 70.0, 900),
      Vuelo.jonron => (home, [Offset(w * 0.1, -h * 0.12), Offset(w * 0.5, -h * 0.18), Offset(w * 0.9, -h * 0.12)][k], 170.0, 1300),
    };
    return PelotaEnVuelo(
      key: ValueKey('pelota$_serie'),
      desde: desde,
      hasta: hasta,
      altura: altura,
      duracion: Duration(milliseconds: ms),
    );
  }
}

/// Una cara nueva aparece creciendo un poco y con un fundido.
class _Aparece extends StatelessWidget {
  const _Aparece({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duracionLbc(context, const Duration(milliseconds: 450)),
      curve: Curves.easeOutBack,
      builder: (_, v, hijo) => Opacity(
        opacity: v.clamp(0, 1),
        child: Transform.scale(scale: 0.75 + 0.25 * v, child: hijo),
      ),
      child: child,
    );
  }
}

/// Punto a una fracción [t] (0..1) del recorrido por [ruta], repartido según la longitud.
Offset _enRuta(List<Offset> ruta, double t) {
  if (ruta.length == 1) return ruta.first;
  final tramos = [for (var i = 1; i < ruta.length; i++) (ruta[i] - ruta[i - 1]).distance];
  final total = tramos.fold<double>(0, (a, b) => a + b);
  if (total == 0) return ruta.last;
  var falta = t.clamp(0.0, 1.0) * total;
  for (var i = 0; i < tramos.length; i++) {
    if (falta <= tramos[i] || i == tramos.length - 1) {
      return Offset.lerp(ruta[i], ruta[i + 1], tramos[i] == 0 ? 1 : (falta / tramos[i]).clamp(0.0, 1.0))!;
    }
    falta -= tramos[i];
  }
  return ruta.last;
}

/// Ficha que se queda en el campo. Cuando cambia su [destino] corre hasta allí pasando por
/// [via] (las bases intermedias).
class _FichaEnRuta extends StatefulWidget {
  const _FichaEnRuta({
    super.key,
    required this.destino,
    required this.via,
    required this.ancho,
    required this.limite,
    required this.tramo,
    required this.child,
  });

  /// Centro horizontal y borde de arriba.
  final Offset destino;
  final List<Offset> via;
  final double ancho;
  final double limite;

  /// Lo que tarda cada tramo (de una base a la siguiente).
  final Duration tramo;
  final Widget child;

  @override
  State<_FichaEnRuta> createState() => _FichaEnRutaState();
}

class _FichaEnRutaState extends State<_FichaEnRuta> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, value: 1);
  late List<Offset> _ruta = [widget.destino];

  Offset get _actual => _enRuta(_ruta, Curves.easeInOut.transform(_c.value));

  @override
  void didUpdateWidget(_FichaEnRuta old) {
    super.didUpdateWidget(old);
    if (old.destino == widget.destino) return;
    _ruta = [_actual, ...widget.via, widget.destino];
    if (widget.tramo == Duration.zero) {
      _c.value = 1;
      return;
    }
    _c.duration = widget.tramo * (_ruta.length - 1);
    _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, hijo) {
        final p = _actual;
        return Positioned(
          left: (p.dx - widget.ancho / 2).clamp(4.0, widget.limite - widget.ancho - 4),
          top: p.dy,
          width: widget.ancho,
          child: hijo!,
        );
      },
      child: widget.child,
    );
  }
}

/// Cara que deja el campo: si anotó corre por [ruta] hasta home y se apaga al llegar; si fue
/// out ([ruta] de un solo punto) se apaga encogiéndose en su sitio.
class _FichaQueSeVa extends StatelessWidget {
  const _FichaQueSeVa({
    super.key,
    required this.ruta,
    required this.ancho,
    required this.limite,
    required this.duracion,
    required this.alTerminar,
    required this.child,
  });

  final List<Offset> ruta;
  final double ancho;
  final double limite;
  final Duration duracion;
  final VoidCallback alTerminar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final out = ruta.length == 1;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duracion,
      onEnd: alTerminar,
      builder: (_, t, hijo) {
        final p = _enRuta(ruta, Curves.easeInOut.transform((t / 0.85).clamp(0, 1)));
        final opacidad = out ? 1 - t : (t < 0.85 ? 1.0 : 1 - (t - 0.85) / 0.15);
        return Positioned(
          left: (p.dx - ancho / 2).clamp(4.0, limite - ancho - 4),
          top: p.dy,
          width: ancho,
          child: IgnorePointer(
            child: Opacity(
              opacity: opacidad.clamp(0, 1),
              child: Transform.scale(scale: out ? 1 - 0.3 * t : 1, child: hijo),
            ),
          ),
        );
      },
      child: ExcludeSemantics(child: child),
    );
  }
}

class _EnVivo extends StatelessWidget {
  const _EnVivo({required this.suspendido});

  final bool suspendido;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: suspendido ? Colors.black54 : ColoresMarca.rojo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        suspendido
            ? Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              )
            : const PuntoEnVivo(),
        const SizedBox(width: 5),
        Text(
          suspendido ? 'SUSPENDIDO' : 'EN VIVO',
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1),
        ),
      ]),
    );
  }
}

/// Cara de un jugador con su nombre debajo (y, si se da, una etiqueta encima).
class _Ficha extends StatelessWidget {
  const _Ficha({
    required this.nombre,
    required this.cara,
    required this.color,
    this.jugador,
    this.etiqueta,
    this.detalle,
    this.descripcion,
    this.tamanoNombre = 14,
    this.lineas = 2,
    this.onTap,
  });

  final JugadorResumenLiga? jugador;
  final String nombre;
  final String? etiqueta;
  final String? detalle;
  final String? descripcion;
  final double cara;
  final Color color;
  final double tamanoNombre;

  /// Líneas del nombre (los corredores van en una para que su alto sea fijo).
  final int lineas;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final contenido = Column(mainAxisSize: MainAxisSize.min, children: [
      if (etiqueta != null)
        SizedBox(
          height: 16,
          child: Text(
            etiqueta!,
            style: const TextStyle(
              color: ColoresMarca.amarillo,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
      // La cara cambia de tamaño con suavidad (por ejemplo, del bate a primera).
      AnimatedContainer(
        duration: duracionLbc(context, _corre),
        curve: Curves.easeInOutCubic,
        width: cara,
        height: cara,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: color, width: 3),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: ClipOval(
          child: FittedBox(
            fit: BoxFit.cover,
            child: ImagenApi(urlFoto: jugador?.fotoUrl, nombre: nombre, tamano: cara - 6, color: color),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.55), borderRadius: BorderRadius.circular(6)),
        child: Text(
          nombre,
          textAlign: TextAlign.center,
          maxLines: lineas,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontFamily: FuentesLbc.titular,
            fontWeight: FontWeight.w700,
            fontSize: tamanoNombre,
            height: 1.05,
          ),
        ),
      ),
      if (detalle != null)
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            detalle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ),
    ]);
    return Semantics(
      label: descripcion,
      button: onTap != null,
      child: MouseRegion(
        cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
        child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: contenido),
      ),
    );
  }
}

/// Dibujo del terreno: césped, tierra del cuadro, líneas, montículo, cajas de bateo,
/// círculos de espera y las bases (las ocupadas en amarillo).
class _Terreno extends CustomPainter {
  _Terreno({
    required this.home,
    required this.bases,
    required this.monticulo,
    required this.ocupadas,
    required this.cajas,
    required this.circulos,
    required this.escala,
  });

  final Offset home;
  final List<Offset> bases; // primera, segunda, tercera
  final Offset monticulo;
  final List<bool> ocupadas;
  final List<Offset> cajas;
  final List<Offset> circulos;
  final double escala;

  static const _tierra = Color(0xFFC4935F);
  static const _cesped = Color(0xFF11793F);

  @override
  void paint(Canvas canvas, Size size) {
    final w = escala;
    final (primera, segunda, tercera) = (bases[0], bases[1], bases[2]);

    // Franjas de corte del césped.
    final franja = Paint()..color = Colors.white.withValues(alpha: 0.035);
    final alto = size.height / 12;
    for (var i = 0; i < 12; i += 2) {
      canvas.drawRect(Rect.fromLTWH(0, i * alto, size.width, alto), franja);
    }

    // Tierra del cuadro: un abanico desde el home que pasa por detrás de segunda.
    final abierto = w * 0.075;
    final f = primera + Offset(abierto, 0);
    final t = tercera - Offset(abierto, 0);
    final tierra = Paint()..color = _tierra;
    canvas.drawPath(
      Path()
        ..moveTo(home.dx, home.dy + abierto)
        ..lineTo(f.dx, f.dy)
        ..arcToPoint(t, radius: Radius.circular((f.dx - t.dx) / 2), clockwise: false)
        ..close(),
      tierra,
    );

    // Césped interior.
    Offset hacia(Offset p, double k) => Offset.lerp(monticulo, p, k)!;
    canvas.drawPath(
      Path()
        ..addPolygon([hacia(home, 0.72), hacia(primera, 0.72), hacia(segunda, 0.72), hacia(tercera, 0.72)], true),
      Paint()..color = _cesped,
    );

    // Tierra del home y del montículo.
    canvas.drawCircle(home, w * 0.11, tierra);
    canvas.drawCircle(monticulo, w * 0.07, tierra);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: monticulo, width: w * 0.045, height: w * 0.01), const Radius.circular(1)),
      Paint()..color = Colors.white,
    );

    // Líneas de foul y caminos entre bases.
    final cal = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(home, home + (primera - home) * 4, cal);
    canvas.drawLine(home, home + (tercera - home) * 4, cal);
    canvas.drawPath(
      Path()..addPolygon([primera, segunda, tercera], false),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.45)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // Cajas de bateo.
    final caja = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (final c in cajas) {
      canvas.drawRect(Rect.fromCenter(center: c, width: w * 0.08, height: w * 0.15), caja);
    }

    // Círculos de espera.
    for (final c in circulos) {
      canvas.drawCircle(c, w * 0.075, Paint()..color = Colors.white.withValues(alpha: 0.1));
      canvas.drawCircle(
        c,
        w * 0.075,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    // Bases: las ocupadas brillan en amarillo.
    final lado = w * 0.032;
    for (final (i, b) in bases.indexed) {
      final rombo = Path()
        ..addPolygon([b + Offset(0, -lado), b + Offset(lado, 0), b + Offset(0, lado), b + Offset(-lado, 0)], true);
      canvas.drawPath(rombo.shift(const Offset(0, 2)), Paint()..color = Colors.black26);
      if (ocupadas[i]) {
        canvas.drawCircle(
          b,
          lado * 1.8,
          Paint()
            ..color = ColoresMarca.amarillo.withValues(alpha: 0.55)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
      }
      canvas.drawPath(rombo, Paint()..color = ocupadas[i] ? ColoresMarca.amarillo : Colors.white);
    }

    // Home: el pentágono.
    final s = w * 0.028;
    canvas.drawPath(
      Path()
        ..addPolygon([
          home + Offset(-s, -s * 0.7),
          home + Offset(s, -s * 0.7),
          home + Offset(s, s * 0.2),
          home + Offset(0, s),
          home + Offset(-s, s * 0.2),
        ], true),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_Terreno old) =>
      old.escala != escala || !listEquals(old.ocupadas, ocupadas) || old.home != home;
}
