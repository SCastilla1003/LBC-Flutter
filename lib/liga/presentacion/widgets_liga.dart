import 'package:flutter/material.dart';

import '../../core/config/entorno.dart';
import '../../core/tema/colores_equipo.dart';
import '../../core/tema/tema_lbc.dart';
import '../../core/widgets/animaciones.dart';
import '../datos/modelos_liga.dart';

String nombreJugador(JugadorResumenLiga j) => '${j.nombres} ${j.apellidos}';

String etiquetaEstadoTemporada(EstadoTemporadaLiga e) => switch (e) {
  EstadoTemporadaLiga.borrador => 'Borrador',
  EstadoTemporadaLiga.activa => 'En curso',
  EstadoTemporadaLiga.finalizada => 'Finalizada',
};

/// Escudo del equipo: la imagen completa (sin recortar) sobre una placa blanca
/// de esquinas redondeadas; si no hay escudo, la abreviatura sobre su color.
class EscudoLiga extends StatelessWidget {
  const EscudoLiga({super.key, required this.equipo, this.tamano = 44});

  final EquipoRefLiga equipo;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final color = ColoresEquipo.de(context, equipo.color);
    final radio = BorderRadius.circular(tamano * 0.24);
    final url = Entorno.urlAbsoluta(equipo.escudoUrl);
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
    return Container(
      width: tamano,
      height: tamano,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        // Placa blanca: los escudos suelen venir sobre fondo blanco o transparente.
        color: ColoresMarca.blanco,
        borderRadius: radio,
        border: Border.all(color: esquema.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: url == null
          ? iniciales
          : Padding(
              padding: EdgeInsets.all(tamano * 0.08),
              child: Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => iniciales,
              ),
            ),
    );
  }
}

/// Píldora con el estado del partido. EN VIVO va en rojo sólido con un punto. Si se detuvo,
/// dice por qué (retrasado, pospuesto o cancelado).
class ChipEstadoPartido extends StatelessWidget {
  const ChipEstadoPartido({super.key, required this.estado, this.motivo});

  final EstadoPartidoLiga estado;
  final MotivoDetencion? motivo;

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
        motivo == null ? 'FINAL' : 'FINAL · ${motivo!.etiqueta.toUpperCase()}',
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
        motivo?.etiqueta.toUpperCase() ?? 'SUSPENDIDO',
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
            const PuntoEnVivo(color: ColoresMarca.blanco),
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
