import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/entorno.dart';
import '../tema/tema_lbc.dart';

/// Foto servida por la API (`urlFoto` relativa) con caché. Si no hay foto, o falla la
/// descarga, muestra las iniciales sobre el color del equipo (o un neutro).
class ImagenApi extends StatelessWidget {
  const ImagenApi({
    super.key,
    required this.urlFoto,
    required this.nombre,
    this.tamano = 44,
    this.color,
    this.cuadrada = false,
    this.completa = false,
  });

  final String? urlFoto;
  final String nombre;
  final double tamano;
  final Color? color;
  final bool cuadrada;

  /// Muestra la imagen entera (escudos) en lugar de recortarla para llenar el marco.
  final bool completa;

  @override
  Widget build(BuildContext context) {
    final url = Entorno.urlAbsoluta(urlFoto);
    final radio = BorderRadius.circular(cuadrada ? tamano * 0.22 : tamano / 2);
    final respaldo = _Iniciales(
      nombre: nombre,
      tamano: tamano,
      color: color,
      radio: radio,
    );
    if (url == null) return respaldo;
    return ClipRRect(
      borderRadius: radio,
      child: CachedNetworkImage(
        imageUrl: url,
        width: tamano,
        height: tamano,
        fit: completa ? BoxFit.contain : BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: (_, _) => respaldo,
        errorWidget: (_, _, _) => respaldo,
      ),
    );
  }
}

const _conectores = {'de', 'del', 'la', 'las', 'el', 'los', 'y'};

/// Iniciales de la primera y la última palabra significativa:
/// "Faroleros del Cabrero" → "FC", "Juan Pérez" → "JP", "Tigres" → "T".
String inicialesDe(String nombre) {
  final partes = nombre
      .trim()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty && !_conectores.contains(p.toLowerCase()))
      .toList();
  if (partes.isEmpty) return '?';
  if (partes.length == 1) return partes.first.substring(0, 1).toUpperCase();
  return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
}

class _Iniciales extends StatelessWidget {
  const _Iniciales({
    required this.nombre,
    required this.tamano,
    required this.radio,
    this.color,
  });

  final String nombre;
  final double tamano;
  final BorderRadius radio;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final fondo = color ?? esquema.secondaryContainer;
    final tinta = ThemeData.estimateBrightnessForColor(fondo) == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final iniciales = inicialesDe(nombre);
    return Container(
      width: tamano,
      height: tamano,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: fondo, borderRadius: radio),
      child: Text(
        iniciales,
        style: TextStyle(
          color: tinta,
          fontFamily: FuentesLbc.titular,
          fontWeight: FontWeight.w800,
          fontSize: tamano * 0.42,
          height: 1,
        ),
      ),
    );
  }
}
