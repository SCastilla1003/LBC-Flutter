import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/modelos/modelos_comunes.dart';
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          ImagenApi(urlFoto: urlFoto, nombre: nombre, tamano: 80, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(nombre, style: tema.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(detalle, style: tema.textTheme.bodyMedium),
              const SizedBox(height: 8),
              if (agenteLibre)
                const Chip(avatar: Icon(Icons.person_search_outlined, size: 16), label: Text('Agente libre'))
              else if (idEquipo != null)
                ActionChip(
                  avatar: const Icon(Icons.groups_outlined, size: 16),
                  label: Text(nombreEquipo ?? 'Equipo'),
                  onPressed: () => context.push('/temporadas/$idTemporada/equipos/$idEquipo'),
                ),
            ]),
          ),
        ]),
      ),
    );
  }
}

/// Cifra de un jugador con la referencia de la liga ("Liga: 0,68").
Widget cifraConLiga(String clave, num? valor, String etiqueta, Map<String, Referencia> referencias,
    {bool destacada = false}) {
  final ref = referencias[clave];
  return Cifra(
    valor: EtiquetasEstadistica.valor(clave, valor),
    etiqueta: etiqueta,
    referencia: ref?.promedio == null ? null : 'Liga ${EtiquetasEstadistica.valor(clave, ref!.promedio)}',
    destacada: destacada,
  );
}

String detalleJugador({String? posicion, required int edad, String? derechoZurdo, required String rol}) => [
      rol,
      ?posicion,
      if (edad > 0) '$edad años',
      ?derechoZurdo,
    ].join(' · ');
