import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../red/fallo_api.dart';

/// Error con mensaje claro y botón "Reintentar". Nunca se muestran datos falsos.
class EstadoError extends StatelessWidget {
  const EstadoError({super.key, required this.error, this.onReintentar, this.compacto = false});

  final Object error;
  final VoidCallback? onReintentar;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final fallo = FalloApi.desde(error);
    final esquema = Theme.of(context).colorScheme;
    final icono = switch (fallo) {
      FalloSinConexion() => Icons.wifi_off_rounded,
      FalloTiempoAgotado() => Icons.hourglass_empty_rounded,
      FalloNoEncontrado() => Icons.search_off_rounded,
      FalloAccesoDenegado() || FalloNoAutenticado() => Icons.lock_outline_rounded,
      _ => Icons.error_outline_rounded,
    };
    final titulo = switch (fallo) {
      FalloSinConexion() => 'Sin conexión',
      FalloTiempoAgotado() => 'El servidor no respondió',
      FalloNoEncontrado() => 'No encontrado',
      FalloAccesoDenegado() => 'Acceso restringido',
      FalloNoAutenticado() => 'Sesión requerida',
      FalloServidor() => 'Problema en el servidor',
      _ => 'Algo salió mal',
    };
    final contenido = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icono, size: compacto ? 32 : 56, color: esquema.tertiary),
        const SizedBox(height: 12),
        Text(titulo, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(fallo.mensaje,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: esquema.onSurfaceVariant),
            textAlign: TextAlign.center),
        if (onReintentar != null && fallo.reintentable) ...[
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onReintentar,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reintentar'),
          ),
        ],
      ],
    );
    return Center(
      child: Padding(padding: EdgeInsets.all(compacto ? 16 : 32), child: contenido),
    );
  }
}

/// Estado vacío: la API respondió bien pero no hay datos.
class EstadoVacio extends StatelessWidget {
  const EstadoVacio({super.key, required this.mensaje, this.icono = Icons.inbox_outlined, this.accion});

  final String mensaje;
  final IconData icono;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 48, color: esquema.outline),
            const SizedBox(height: 12),
            Text(mensaje,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: esquema.onSurfaceVariant)),
            if (accion != null) ...[const SizedBox(height: 16), accion!],
          ],
        ),
      ),
    );
  }
}

/// Bloques grises animados (shimmer) mientras llegan los datos.
class Esqueleto extends StatelessWidget {
  const Esqueleto({super.key, this.alto = 16, this.ancho, this.radio = 8});

  final double alto;
  final double? ancho;
  final double radio;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: alto,
      width: ancho,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radio),
      ),
    );
  }
}

class Brillo extends StatelessWidget {
  const Brillo({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: esquema.surfaceContainerHighest,
      highlightColor: esquema.surfaceContainerLow,
      child: child,
    );
  }
}

/// Esqueleto de lista: [filas] tarjetas con avatar y dos líneas.
class EsqueletoLista extends StatelessWidget {
  const EsqueletoLista({super.key, this.filas = 6, this.conAvatar = true});

  final int filas;
  final bool conAvatar;

  @override
  Widget build(BuildContext context) {
    return Brillo(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: filas,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) => Row(
          children: [
            if (conAvatar) ...[const Esqueleto(alto: 44, ancho: 44, radio: 22), const SizedBox(width: 12)],
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Esqueleto(alto: 14), SizedBox(height: 8), Esqueleto(alto: 12, ancho: 120)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Esqueleto de una pantalla de detalle: cabecera, fila de cifras y bloques.
class EsqueletoDetalle extends StatelessWidget {
  const EsqueletoDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    return Brillo(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const Row(children: [
            Esqueleto(alto: 72, ancho: 72, radio: 36),
            SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Esqueleto(alto: 20),
              SizedBox(height: 10),
              Esqueleto(alto: 14, ancho: 140),
            ])),
          ]),
          const SizedBox(height: 24),
          Row(children: List.generate(
              4, (i) => const Expanded(child: Padding(padding: EdgeInsets.all(4), child: Esqueleto(alto: 64, radio: 12))))),
          const SizedBox(height: 24),
          const Esqueleto(alto: 180, radio: 16),
          const SizedBox(height: 16),
          const Esqueleto(alto: 120, radio: 16),
        ],
      ),
    );
  }
}
