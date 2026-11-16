import 'package:flutter/material.dart';

import '../../../core/widgets/imagen_api.dart';

class OpcionComparar {
  const OpcionComparar({required this.id, required this.nombre, this.detalle, this.urlFoto, this.color});

  final String id;
  final String nombre;
  final String? detalle;
  final String? urlFoto;
  final Color? color;
}

/// Hoja inferior para elegir contra quién comparar. Devuelve el id elegido.
Future<String?> elegirParaComparar(BuildContext context, List<OpcionComparar> opciones) {
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (c) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(c).height * 0.7),
        child: _ListaFiltrable(opciones: opciones),
      ),
    ),
  );
}

class _ListaFiltrable extends StatefulWidget {
  const _ListaFiltrable({required this.opciones});

  final List<OpcionComparar> opciones;

  @override
  State<_ListaFiltrable> createState() => _ListaFiltrableState();
}

class _ListaFiltrableState extends State<_ListaFiltrable> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    final lista = widget.opciones
        .where((o) => _filtro.isEmpty || o.nombre.toLowerCase().contains(_filtro.toLowerCase()))
        .toList();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: TextField(
          autofocus: false,
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Buscar', isDense: true),
          onChanged: (v) => setState(() => _filtro = v),
        ),
      ),
      Flexible(
        child: ListView(shrinkWrap: true, children: [
          for (final o in lista)
            ListTile(
              leading: ImagenApi(urlFoto: o.urlFoto, nombre: o.nombre, tamano: 36, color: o.color),
              title: Text(o.nombre),
              subtitle: o.detalle == null ? null : Text(o.detalle!),
              onTap: () => Navigator.pop(context, o.id),
            ),
        ]),
      ),
    ]);
  }
}
