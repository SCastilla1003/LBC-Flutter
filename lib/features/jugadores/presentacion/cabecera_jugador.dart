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
    final acento = color ?? ColoresMarca.dorado;
    const tinta = ColoresMarca.tintaBarra;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColoresMarca.rojoProfundo,
              Color.lerp(ColoresMarca.rojo, acento, 0.5)!,
              acento,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: acento.withValues(alpha: 0.22),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColoresMarca.dorado.withValues(alpha: 0.75),
                        width: 2,
                      ),
                    ),
                    child: ImagenApi(
                      urlFoto: urlFoto,
                      nombre: nombre,
                      tamano: 76,
                      color: acento,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombre,
                          style: tema.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: tinta,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          detalle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: tema.textTheme.bodyMedium?.copyWith(
                            color: tinta.withValues(alpha: 0.78),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (agenteLibre)
                          Chip(
                            visualDensity: VisualDensity.compact,
                            backgroundColor: tinta.withValues(alpha: 0.14),
                            side: BorderSide(
                              color: tinta.withValues(alpha: 0.22),
                            ),
                            avatar: const Icon(
                              Icons.person_search_outlined,
                              size: 16,
                              color: ColoresMarca.dorado,
                            ),
                            label: Text(
                              'Agente libre',
                              style: TextStyle(
                                color: tinta,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        else if (idEquipo != null)
                          ActionChip(
                            visualDensity: VisualDensity.compact,
                            backgroundColor: tinta.withValues(alpha: 0.14),
                            side: BorderSide(
                              color: tinta.withValues(alpha: 0.22),
                            ),
                            avatar: const Icon(
                              Icons.groups_outlined,
                              size: 16,
                              color: ColoresMarca.dorado,
                            ),
                            label: Text(
                              nombreEquipo ?? 'Equipo',
                              style: TextStyle(
                                color: tinta,
                                fontWeight: FontWeight.w700,
                              ),
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
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColoresMarca.dorado, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
