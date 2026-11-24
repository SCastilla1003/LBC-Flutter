import 'package:flutter/material.dart';

import '../../core/tema/colores_equipo.dart';
import '../../core/tema/tema_lbc.dart';
import '../datos/modelos_liga.dart';

String nombreJugador(JugadorResumenLiga j) => '${j.nombres} ${j.apellidos}';

String etiquetaEstadoTemporada(EstadoTemporadaLiga e) => switch (e) {
      EstadoTemporadaLiga.borrador => 'Borrador',
      EstadoTemporadaLiga.activa => 'En curso',
      EstadoTemporadaLiga.finalizada => 'Finalizada',
    };

/// Escudo circular: foto si el equipo tiene escudo, si no la abreviatura sobre su color.
class EscudoLiga extends StatelessWidget {
  const EscudoLiga({super.key, required this.equipo, this.tamano = 44});

  final EquipoRefLiga equipo;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    final color = ColoresEquipo.de(context, equipo.color);
    final iniciales = Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        equipo.abreviatura.toUpperCase(),
        style: TextStyle(
          color: ColoresMarca.blanco,
          fontWeight: FontWeight.w900,
          fontSize: tamano * 0.28,
          letterSpacing: 0.4,
        ),
      ),
    );
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColoresMarca.dorado, width: 2),
      ),
      child: ClipOval(
        child: equipo.escudoUrl == null
            ? iniciales
            : Image.network(
                equipo.escudoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => iniciales,
              ),
      ),
    );
  }
}

/// Píldora con el estado del partido. EN VIVO lleva un punto que pulsa.
class ChipEstadoPartido extends StatelessWidget {
  const ChipEstadoPartido({super.key, required this.estado});

  final EstadoPartidoLiga estado;

  @override
  Widget build(BuildContext context) {
    final (texto, color, enVivo) = switch (estado) {
      EstadoPartidoLiga.enJuego => ('EN VIVO', ColoresMarca.rojo, true),
      EstadoPartidoLiga.finalizado => ('FINAL', ColoresMarca.verde, false),
      EstadoPartidoLiga.alineacionPublicada => ('ALINEACIÓN LISTA', ColoresMarca.doradoOscuro, false),
      EstadoPartidoLiga.suspendido => ('SUSPENDIDO', const Color(0xFF7A7A7A), false),
      EstadoPartidoLiga.programado => ('PROGRAMADO', const Color(0xFF4A6FA5), false),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (enVivo) ...[
            Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 6),
          ],
          Text(
            texto,
            style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 0.6),
          ),
        ],
      ),
    );
  }
}

/// Título de sección con la franja institucional (rojo, amarillo, verde).
class EncabezadoSeccion extends StatelessWidget {
  const EncabezadoSeccion(this.texto, {super.key});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: const BoxDecoration(
              gradient: ColoresMarca.franjaInstitucionalVertical,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            texto,
            style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.2),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta blanca con sombra suave (modo claro) o superficie oscura (modo oscuro).
class TarjetaLiga extends StatelessWidget {
  const TarjetaLiga({super.key, required this.child, this.onTap, this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
