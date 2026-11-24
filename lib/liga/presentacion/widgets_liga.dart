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
    final esquema = Theme.of(context).colorScheme;
    final color = ColoresEquipo.de(context, equipo.color);
    final iniciales = Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        equipo.abreviatura.toUpperCase(),
        style: TextStyle(
          color: ColoresMarca.blanco,
          fontFamily: FuentesLbc.titular,
          fontWeight: FontWeight.w800,
          fontSize: tamano * 0.34,
          letterSpacing: 0.6,
          height: 1,
        ),
      ),
    );
    // Aro blanco y contorno fino, como un parche de gorra.
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: esquema.surfaceContainerLowest,
        border: Border.all(color: esquema.surfaceContainerLowest, width: 2),
        boxShadow: [
          BoxShadow(color: esquema.outlineVariant, spreadRadius: 1),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
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

/// Píldora con el estado del partido. EN VIVO va en rojo sólido con un punto.
class ChipEstadoPartido extends StatelessWidget {
  const ChipEstadoPartido({super.key, required this.estado});

  final EstadoPartidoLiga estado;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    // (texto, fondo, tinta, borde, punto en vivo)
    final (texto, fondo, tinta, borde, enVivo) = switch (estado) {
      EstadoPartidoLiga.enJuego => (
        'EN VIVO',
        ColoresMarca.rojo,
        ColoresMarca.blanco,
        null,
        true,
      ),
      EstadoPartidoLiga.finalizado => (
        'FINAL',
        ColoresMarca.verdeNoche,
        ColoresMarca.tintaBarra,
        null,
        false,
      ),
      EstadoPartidoLiga.alineacionPublicada => (
        'ALINEACIÓN LISTA',
        ColoresMarca.amarillo,
        ColoresMarca.tintaSobreAmarillo,
        null,
        false,
      ),
      EstadoPartidoLiga.suspendido => (
        'SUSPENDIDO',
        esquema.surfaceContainerHigh,
        esquema.onSurfaceVariant,
        esquema.outlineVariant,
        false,
      ),
      EstadoPartidoLiga.programado => (
        'PROGRAMADO',
        esquema.primaryContainer,
        esquema.onPrimaryContainer,
        esquema.primary.withValues(alpha: 0.3),
        false,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(6),
        border: borde == null ? null : Border.all(color: borde),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (enVivo) ...[
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: ColoresMarca.blanco,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            texto,
            style: TextStyle(
              color: tinta,
              fontFamily: FuentesLbc.titular,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 1,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Título de sección: titular condensado con el subrayado amarillo de la marca.
class EncabezadoSeccion extends StatelessWidget {
  const EncabezadoSeccion(this.texto, {super.key});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            texto,
            style: tema.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  color: ColoresMarca.amarillo,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: tema.colorScheme.outlineVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Tarjeta blanca con borde fino (modo claro) o superficie oscura (modo oscuro).
class TarjetaLiga extends StatelessWidget {
  const TarjetaLiga({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
