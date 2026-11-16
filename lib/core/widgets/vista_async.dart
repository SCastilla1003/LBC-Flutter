import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'estados.dart';

/// Pinta explícitamente los cuatro estados de una carga: cargando, error, vacío y datos.
///
/// Si hay datos previos y se está recargando (pull-to-refresh), se mantienen los
/// datos en pantalla en lugar de volver al esqueleto.
class VistaAsync<T> extends StatelessWidget {
  const VistaAsync({
    super.key,
    required this.valor,
    required this.datos,
    required this.onReintentar,
    this.cargando,
    this.esVacio,
    this.mensajeVacio = 'Todavía no hay datos.',
    this.iconoVacio = Icons.inbox_outlined,
  });

  final AsyncValue<T> valor;
  final Widget Function(T datos) datos;
  final VoidCallback onReintentar;
  final Widget? cargando;
  final bool Function(T datos)? esVacio;
  final String mensajeVacio;
  final IconData iconoVacio;

  @override
  Widget build(BuildContext context) {
    return valor.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      loading: () => cargando ?? const EsqueletoLista(),
      error: (e, _) => EstadoError(error: e, onReintentar: onReintentar),
      data: (d) {
        if (esVacio?.call(d) ?? false) {
          return EstadoVacio(mensaje: mensajeVacio, icono: iconoVacio);
        }
        return datos(d);
      },
    );
  }
}

/// Lista con pull-to-refresh que también funciona cuando el contenido es corto o un estado
/// (error / vacío): el contenido se coloca dentro de un scroll siempre desplazable.
class RecargableSimple extends StatelessWidget {
  const RecargableSimple({super.key, required this.onRefresh, required this.child});

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, c) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(constraints: BoxConstraints(minHeight: c.maxHeight), child: child),
        ),
      ),
    );
  }
}
