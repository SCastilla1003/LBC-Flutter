import 'package:flutter/material.dart';

import '../tema/tema_lbc.dart';
import 'logo_lbc.dart';

/// Las animaciones que se repiten sin fin (el punto de EN VIVO) solo corren en la app de verdad
/// y si el sistema no pidió reducir el movimiento. En las pruebas quedan quietas.
bool animacionesContinuas(BuildContext context) =>
    WidgetsBinding.instance is WidgetsFlutterBinding && !MediaQuery.disableAnimationsOf(context);

/// Duración de las animaciones de un solo paso: cero si el sistema pidió reducir el movimiento.
Duration duracionLbc(BuildContext context, Duration d) =>
    MediaQuery.disableAnimationsOf(context) ? Duration.zero : d;

/// Punto que late, para lo que está EN VIVO.
class PuntoEnVivo extends StatefulWidget {
  const PuntoEnVivo({super.key, this.color = Colors.white, this.tamano = 7});

  final Color color;
  final double tamano;

  @override
  State<PuntoEnVivo> createState() => _PuntoEnVivoState();
}

class _PuntoEnVivoState extends State<PuntoEnVivo> with SingleTickerProviderStateMixin {
  late final _latido = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (animacionesContinuas(context)) {
      if (!_latido.isAnimating) _latido.repeat();
    } else {
      _latido.stop();
    }
  }

  @override
  void dispose() {
    _latido.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tamano;
    return SizedBox(
      width: t,
      height: t,
      child: AnimatedBuilder(
        animation: _latido,
        builder: (_, _) {
          final v = _latido.value;
          return Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
            // Onda que se abre y se apaga.
            if (_latido.isAnimating)
              Container(
                width: t * (1 + 1.6 * v),
                height: t * (1 + 1.6 * v),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.45 * (1 - v)),
                ),
              ),
            Container(
              width: t,
              height: t,
              decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
            ),
          ]);
        },
      ),
    );
  }
}

/// Al cambiar de pestaña (Inicio, Temporadas...) la nueva entra con un fundido y un leve ascenso.
class TransicionPestanas extends StatefulWidget {
  const TransicionPestanas({super.key, required this.indice, required this.child});

  final int indice;
  final Widget child;

  @override
  State<TransicionPestanas> createState() => _TransicionPestanasState();
}

class _TransicionPestanasState extends State<TransicionPestanas> with SingleTickerProviderStateMixin {
  late final _entrada = AnimationController(vsync: this, duration: const Duration(milliseconds: 320), value: 1);

  @override
  void didUpdateWidget(TransicionPestanas old) {
    super.didUpdateWidget(old);
    if (old.indice != widget.indice && !MediaQuery.disableAnimationsOf(context)) {
      _entrada.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _entrada.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curva = CurvedAnimation(parent: _entrada, curve: Curves.easeOutCubic);
    return FadeTransition(
      opacity: curva,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.025), end: Offset.zero).animate(curva),
        child: widget.child,
      ),
    );
  }
}

/// Presentación al abrir la app: el escudo de la liga entra rebotando sobre el verde del
/// estadio, la franja amarilla se dibuja y todo se desvanece hacia la app.
class PresentacionLbc extends StatefulWidget {
  const PresentacionLbc({super.key, required this.child});

  final Widget child;

  @override
  State<PresentacionLbc> createState() => _PresentacionLbcState();
}

class _PresentacionLbcState extends State<PresentacionLbc> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1700));
  bool _terminada = false;

  @override
  void initState() {
    super.initState();
    _c.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) setState(() => _terminada = true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _terminada = true;
    } else if (!_c.isAnimating && !_terminada) {
      _c.forward();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_terminada) return widget.child;
    Animation<double> tramo(double a, double b, [Curve curva = Curves.linear]) =>
        CurvedAnimation(parent: _c, curve: Interval(a, b, curve: curva));
    final escudo = tramo(0, 0.45, Curves.elasticOut);
    final franja = tramo(0.25, 0.6, Curves.easeOutCubic);
    final texto = tramo(0.35, 0.65, Curves.easeOut);
    final salida = tramo(0.78, 1, Curves.easeIn);
    return Stack(children: [
      widget.child,
      AnimatedBuilder(
        animation: _c,
        builder: (context, _) => IgnorePointer(
          ignoring: salida.value > 0.5,
          child: Opacity(
            opacity: 1 - salida.value,
            child: Container(
              decoration: const BoxDecoration(gradient: ColoresMarca.tablero),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 1 + 0.08 * salida.value,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Transform.scale(
                    scale: escudo.value,
                    child: Transform.rotate(angle: (1 - escudo.value) * -0.6, child: const LogoLbc(tamano: 112)),
                  ),
                  const SizedBox(height: 22),
                  Opacity(
                    opacity: texto.value,
                    child: Transform.translate(
                      offset: Offset(0, 12 * (1 - texto.value)),
                      child: Text(
                        'LIGA DE BÉISBOL DE CARTAGENA',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ColoresMarca.tintaBarra,
                          fontFamily: FuentesLbc.titular,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          letterSpacing: 2,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 180 * franja.value,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ColoresMarca.amarillo,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

/// Número de marcador que, al cambiar, sale hacia arriba y entra el nuevo desde abajo.
class CifraAnimada extends StatelessWidget {
  const CifraAnimada(this.valor, {super.key, this.estilo});

  final int valor;
  final TextStyle? estilo;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duracionLbc(context, const Duration(milliseconds: 450)),
      transitionBuilder: (hijo, animacion) {
        final entra = hijo.key == ValueKey(valor);
        return ClipRect(
          child: SlideTransition(
            position: Tween(begin: Offset(0, entra ? 0.8 : -0.8), end: Offset.zero)
                .animate(CurvedAnimation(parent: animacion, curve: Curves.easeOutBack)),
            child: FadeTransition(opacity: animacion, child: hijo),
          ),
        );
      },
      child: Text('$valor', key: ValueKey(valor), style: estilo),
    );
  }
}

/// Lo nuevo (una jugada en el jugada a jugada) entra con un fundido y deslizándose.
class EntradaSuave extends StatelessWidget {
  const EntradaSuave({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duracionLbc(context, const Duration(milliseconds: 380)),
      curve: Curves.easeOutCubic,
      builder: (_, v, hijo) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(-14 * (1 - v), 0), child: hijo),
      ),
      child: child,
    );
  }
}
