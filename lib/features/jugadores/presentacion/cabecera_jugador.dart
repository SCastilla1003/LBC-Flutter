import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/modelos/modelos_comunes.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/imagen_api.dart';
import 'etiquetas.dart';

/// Cabecera común de los perfiles de bateador y lanzador.
class CabeceraJugador extends StatelessWidget {
  const CabeceraJugador({
    super.key,
    required this.nombre,
    required this.urlFoto,
    required this.detalle,
    required this.idTemporada,
    this.idEquipo,
    this.nombreEquipo,
    this.agenteLibre = false,
    this.color,
  });

  final String nombre;
  final String? urlFoto;
  final String detalle;
  final String idTemporada;
  final String? idEquipo;
  final String? nombreEquipo;
  final bool agenteLibre;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final acento = color ?? ColoresMarca.verdeVivo;
    const tinta = ColoresMarca.tintaBarra;
    final estiloChip = TextStyle(
      color: ColoresMarca.tintaSobreAmarillo,
      fontWeight: FontWeight.w700,
      fontSize: 13,
    );
    // Cromo coleccionable: tablero verde noche, banda diagonal con el color del
    // equipo, foto enmarcada en blanco con esquina amarilla y canto amarillo.
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: ColoresMarca.tablero,
          boxShadow: [
            BoxShadow(
              color: ColoresMarca.verdeNoche.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _BandaCromo(acento: acento),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                child: Row(
                  children: [
                    _FotoCromo(
                      urlFoto: urlFoto,
                      nombre: nombre,
                      acento: acento,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: tema.textTheme.headlineSmall?.copyWith(
                              color: tinta,
                              fontSize: 28,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            detalle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: tema.textTheme.bodyMedium?.copyWith(
                              color: tinta.withValues(alpha: 0.82),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (agenteLibre)
                            Chip(
                              visualDensity: VisualDensity.compact,
                              backgroundColor: ColoresMarca.amarillo,
                              side: BorderSide.none,
                              avatar: const Icon(
                                Icons.person_search_outlined,
                                size: 16,
                                color: ColoresMarca.tintaSobreAmarillo,
                              ),
                              label: Text('Agente libre', style: estiloChip),
                            )
                          else if (idEquipo != null)
                            ActionChip(
                              visualDensity: VisualDensity.compact,
                              backgroundColor: ColoresMarca.amarillo,
                              side: BorderSide.none,
                              avatar: const Icon(
                                Icons.groups_outlined,
                                size: 16,
                                color: ColoresMarca.tintaSobreAmarillo,
                              ),
                              label: Text(
                                nombreEquipo ?? 'Equipo',
                                style: estiloChip,
                              ),
                              onPressed: () => context.push(
                                '/temporadas/$idTemporada/equipos/$idEquipo',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 5, color: ColoresMarca.amarillo),
            ],
          ),
        ),
      ),
    );
  }
}

/// Foto del cromo: marco blanco con una esquina amarilla recortada.
class _FotoCromo extends StatelessWidget {
  const _FotoCromo({
    required this.urlFoto,
    required this.nombre,
    required this.acento,
  });

  final String? urlFoto;
  final String nombre;
  final Color acento;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: ColoresMarca.blanco,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ImagenApi(
            urlFoto: urlFoto,
            nombre: nombre,
            tamano: 84,
            color: acento,
            cuadrada: true,
          ),
        ),
        Positioned(
          left: -1,
          top: -1,
          child: ClipPath(
            clipper: _Esquina(),
            child: Container(
              width: 22,
              height: 22,
              color: ColoresMarca.amarillo,
            ),
          ),
        ),
      ],
    );
  }
}

class _Esquina extends CustomClipper<Path> {
  @override
  Path getClip(Size s) => Path()
    ..moveTo(0, 0)
    ..lineTo(s.width, 0)
    ..lineTo(0, s.height)
    ..close();

  @override
  bool shouldReclip(_Esquina oldClipper) => false;
}

/// Banda diagonal con el color del equipo y un filo amarillo, a la derecha.
class _BandaCromo extends CustomPainter {
  _BandaCromo({required this.acento});

  final Color acento;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final banda = Path()
      ..moveTo(w * 0.80, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h)
      ..lineTo(w * 0.64, h)
      ..close();
    canvas.drawPath(banda, Paint()..color = acento.withValues(alpha: 0.55));
    final filo = Path()
      ..moveTo(w * 0.77, 0)
      ..lineTo(w * 0.79, 0)
      ..lineTo(w * 0.63, h)
      ..lineTo(w * 0.61, h)
      ..close();
    canvas.drawPath(
      filo,
      Paint()..color = ColoresMarca.amarillo.withValues(alpha: 0.85),
    );
  }

  @override
  bool shouldRepaint(_BandaCromo old) => old.acento != acento;
}

/// Cifra de un jugador con la referencia de la liga ("Liga: 0,68").
Widget cifraConLiga(
  String clave,
  num? valor,
  String etiqueta,
  Map<String, Referencia> referencias, {
  bool destacada = false,
}) {
  final ref = referencias[clave];
  return Cifra(
    valor: EtiquetasEstadistica.valor(clave, valor),
    etiqueta: etiqueta,
    referencia: ref?.promedio == null
        ? null
        : 'Liga ${EtiquetasEstadistica.valor(clave, ref!.promedio)}',
    destacada: destacada,
  );
}

String detalleJugador({
  String? posicion,
  required int edad,
  String? derechoZurdo,
  required String rol,
}) => [rol, ?posicion, if (edad > 0) '$edad años', ?derechoZurdo].join(' · ');
