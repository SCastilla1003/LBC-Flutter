import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/tema/colores_equipo.dart';
import '../../core/widgets/comunes.dart';
import '../../core/widgets/estados.dart';
import '../../core/widgets/vista_async.dart';
import '../../features/jugadores/presentacion/cabecera_jugador.dart';
import '../datos/liga_repositorio.dart';
import '../datos/modelos_liga.dart';

/// Perfil de un jugador en una temporada (contrato v1): foto en cromo, equipo,
/// número, posición y datos personales. [idEquipo] nulo = agente libre.
class JugadorLigaPantalla extends ConsumerWidget {
  const JugadorLigaPantalla({super.key, required this.idTemporada, required this.idJugador, this.idEquipo});

  final int idTemporada;
  final int idJugador;
  final int? idEquipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugador = ref.watch(jugadorLigaProvider(idJugador));
    // La inscripción (número, posición y equipo) viene de la plantilla de la temporada.
    final plantilla = idEquipo == null
        ? ref.watch(agentesLibresLigaProvider(idTemporada))
        : ref.watch(plantillaLigaProvider((idTemporada, idEquipo!)));
    final entrada = plantilla.value?.where((p) => p.jugador.id == idJugador).firstOrNull;
    return Scaffold(
      appBar: AppBar(title: const Text('Jugador')),
      body: RecargableSimple(
        onRefresh: () async => ref.invalidate(jugadorLigaProvider(idJugador)),
        child: VistaAsync<JugadorLiga>(
          valor: jugador,
          cargando: const EsqueletoDetalle(),
          onReintentar: () => ref.invalidate(jugadorLigaProvider(idJugador)),
          datos: (j) => Padding(
            padding: const EdgeInsets.all(16),
            child: AnchoMaximo(
              ancho: 760,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CabeceraJugador(
                    nombre: '${j.nombres} ${j.apellidos}',
                    urlFoto: j.fotoUrl,
                    detalle: [
                      if (entrada?.posicion != null) _nombrePosicion(entrada!.posicion!),
                      if (j.edad != null) '${j.edad} años',
                      if (j.lanza != null) 'Lanzador' else 'Jugador de posición',
                    ].join(' · '),
                    idTemporada: '$idTemporada',
                    idEquipo: entrada?.equipo == null ? null : '${entrada!.equipo!.id}',
                    nombreEquipo: entrada?.equipo?.nombre,
                    agenteLibre: entrada != null && entrada.equipo == null,
                    color: entrada?.equipo?.color == null ? null : ColoresEquipo.de(context, entrada!.equipo!.color),
                  ),
                  Seccion(
                    titulo: 'Ficha',
                    icono: Icons.badge_outlined,
                    child: RejillaCifras(
                      hijos: [
                        Cifra(valor: entrada?.numero == null ? '—' : '#${entrada!.numero}', etiqueta: 'Número', destacada: true),
                        Cifra(valor: entrada?.posicion ?? '—', etiqueta: 'Posición'),
                        Cifra(valor: j.edad == null ? '—' : '${j.edad}', etiqueta: 'Edad'),
                        Cifra(valor: _lado(j.batea), etiqueta: 'Batea'),
                        Cifra(valor: j.lanza == null ? '—' : _lado(j.lanza), etiqueta: 'Lanza'),
                        if (j.fechaNacimiento != null)
                          Cifra(valor: Formato.fecha(j.fechaNacimiento), etiqueta: 'Nacimiento'),
                      ],
                    ),
                  ),
                  const Seccion(
                    titulo: 'Estadísticas',
                    icono: Icons.query_stats_rounded,
                    child: EstadoVacio(
                      icono: Icons.query_stats_rounded,
                      mensaje: 'Las estadísticas se calculan con las jugadas que registra el anotador en vivo.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static String _lado(Object? l) => switch (l) {
        LadoBateo.derecho || LadoLanzamiento.derecho => 'Derecho',
        LadoBateo.zurdo || LadoLanzamiento.zurdo => 'Zurdo',
        LadoBateo.ambidiestro => 'Ambidiestro',
        _ => '—',
      };

  static String _nombrePosicion(String p) => switch (p) {
        'P' => 'Lanzador',
        'C' => 'Receptor',
        '1B' => 'Primera base',
        '2B' => 'Segunda base',
        '3B' => 'Tercera base',
        'SS' => 'Campocorto',
        'LF' => 'Jardín izquierdo',
        'CF' => 'Jardín central',
        'RF' => 'Jardín derecho',
        'DH' => 'Bateador designado',
        _ => p,
      };
}
