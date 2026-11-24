import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/red/fallo_api.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/estados.dart';
import '../../../core/widgets/imagen_api.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import 'admin_comun.dart';

/// Dónde está cada jugador en la temporada.
sealed class Situacion {
  const Situacion();
}

/// No está inscrito en la temporada: se inscribe con POST.
class SinInscribir extends Situacion {
  const SinInscribir();
}

/// Inscrito como agente libre: se asigna al equipo con PUT sobre su inscripción.
class AgenteLibre extends Situacion {
  const AgenteLibre(this.entradaId);

  final int entradaId;
}

/// Ya juega en otro equipo esta temporada (se cambia desde su plantilla).
class EnOtroEquipo extends Situacion {
  const EnOtroEquipo(this.equipo);

  final EquipoRefLiga equipo;
}

/// Candidato a inscribir con su situación actual.
class Candidato {
  const Candidato(this.jugador, this.situacion, {this.numero, this.posicion});

  final JugadorLiga jugador;
  final Situacion situacion;

  /// Número y posición de su inscripción actual (si es agente libre), para precargarlos.
  final int? numero;
  final String? posicion;

  String get nombre => '${jugador.nombres} ${jugador.apellidos}';
}

/// (temporadaId, equipoId o null para agentes libres)
final _candidatosProvider = FutureProvider.autoDispose.family<List<Candidato>, (int, int?)>((ref, clave) async {
  final repo = ref.watch(ligaRepositorioProvider);
  final (t, e) = clave;
  final jugadores = await repo.jugadores();
  final libres = await repo.agentesLibres(t);
  final equiposTemporada = await repo.equiposDeTemporada(t);
  final plantillas = await Future.wait([for (final eq in equiposTemporada) repo.plantilla(t, eq.id)]);

  final situacion = <int, Candidato>{};
  for (final p in libres) {
    situacion[p.jugador.id] = Candidato(
      jugadores.firstWhere((j) => j.id == p.jugador.id, orElse: () => _desde(p.jugador)),
      AgenteLibre(p.id),
      numero: p.numero,
      posicion: p.posicion,
    );
  }
  final enEsteEquipo = <int>{};
  for (var i = 0; i < equiposTemporada.length; i++) {
    for (final p in plantillas[i]) {
      if (equiposTemporada[i].id == e) {
        enEsteEquipo.add(p.jugador.id);
      } else {
        situacion[p.jugador.id] = Candidato(_desde(p.jugador), EnOtroEquipo(equiposTemporada[i]));
      }
    }
  }
  final lista = [
    for (final j in jugadores)
      if (!enEsteEquipo.contains(j.id)) situacion[j.id] ?? Candidato(j, const SinInscribir()),
  ];
  // Para agentes libres solo sirven los que no están inscritos.
  final utiles = e == null ? lista.where((c) => c.situacion is SinInscribir).toList() : lista;
  int orden(Candidato c) => switch (c.situacion) {
        SinInscribir() => 0,
        AgenteLibre() => 1,
        EnOtroEquipo() => 2,
      };
  return utiles
    ..sort((a, b) {
      final o = orden(a).compareTo(orden(b));
      return o != 0 ? o : a.jugador.apellidos.toLowerCase().compareTo(b.jugador.apellidos.toLowerCase());
    });
});

JugadorLiga _desde(JugadorResumenLiga r) => JugadorLiga(
      id: r.id,
      nombres: r.nombres,
      apellidos: r.apellidos,
      batea: r.batea,
      lanza: r.lanza,
      fotoUrl: r.fotoUrl,
    );

/// Selección de un jugador en la lista: número y posición que tendrá en el equipo.
class _Eleccion {
  _Eleccion({int? numero, this.posicion}) : numero = TextEditingController(text: numero?.toString() ?? '');

  final TextEditingController numero;
  String? posicion;
}

/// Inscribe varios jugadores a la vez en un equipo de la temporada (o como agentes libres).
class AdminInscripcionPantalla extends ConsumerStatefulWidget {
  const AdminInscripcionPantalla({super.key, required this.idTemporada, required this.idEquipo});

  final int idTemporada;
  final int? idEquipo;

  @override
  ConsumerState<AdminInscripcionPantalla> createState() => _AdminInscripcionPantallaState();
}

class _AdminInscripcionPantallaState extends ConsumerState<AdminInscripcionPantalla> {
  final _elegidos = <int, _Eleccion>{};
  String _filtro = '';
  bool _guardando = false;

  @override
  void dispose() {
    for (final e in _elegidos.values) {
      e.numero.dispose();
    }
    super.dispose();
  }

  void _alternar(Candidato c) => setState(() {
        final quitado = _elegidos.remove(c.jugador.id);
        if (quitado != null) {
          quitado.numero.dispose();
        } else {
          _elegidos[c.jugador.id] = _Eleccion(numero: c.numero, posicion: c.posicion);
        }
      });

  Future<void> _inscribir(List<Candidato> candidatos) async {
    setState(() => _guardando = true);
    final repo = ref.read(ligaRepositorioProvider);
    final fallos = <String>[];
    var hechos = 0;
    for (final c in candidatos.where((c) => _elegidos.containsKey(c.jugador.id))) {
      final e = _elegidos[c.jugador.id]!;
      final numero = int.tryParse(e.numero.text);
      try {
        switch (c.situacion) {
          case AgenteLibre(:final entradaId):
            await repo.actualizarInscripcion(widget.idTemporada, entradaId,
                equipoId: widget.idEquipo, numero: numero, posicion: e.posicion);
          case SinInscribir():
            await repo.inscribir(widget.idTemporada,
                jugadorId: c.jugador.id, equipoId: widget.idEquipo, numero: numero, posicion: e.posicion);
          case EnOtroEquipo():
            continue;
        }
        hechos++;
        _elegidos.remove(c.jugador.id)?.numero.dispose();
      } catch (err) {
        fallos.add('${c.nombre}: ${FalloApi.desde(err).mensaje}');
      }
    }
    if (!mounted) return;
    refrescarLiga(ref);
    ref.invalidate(_candidatosProvider((widget.idTemporada, widget.idEquipo)));
    setState(() => _guardando = false);
    if (fallos.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(hechos == 1 ? '1 jugador inscrito' : '$hechos jugadores inscritos')));
      Navigator.of(context).pop();
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(hechos == 0 ? 'No se pudo inscribir' : 'Se inscribieron $hechos; algunos fallaron'),
        content: Text(fallos.map((f) => '• $f').join('\n')),
        actions: [FilledButton(onPressed: () => Navigator.pop(c), child: const Text('Entendido'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clave = (widget.idTemporada, widget.idEquipo);
    final equipos = ref.watch(equiposLigaProvider).value ?? const <EquipoLiga>[];
    final equipo = equipos.where((e) => e.id == widget.idEquipo).firstOrNull;
    final valor = ref.watch(_candidatosProvider(clave));
    final n = _elegidos.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idEquipo == null ? 'Inscribir agentes libres' : 'Inscribir en ${equipo?.abreviatura ?? 'el equipo'}'),
      ),
      body: VistaAsync<List<Candidato>>(
        valor: valor,
        onReintentar: () => ref.invalidate(_candidatosProvider(clave)),
        datos: (lista) {
          final f = _filtro.toLowerCase();
          final visibles = f.isEmpty ? lista : lista.where((c) => c.nombre.toLowerCase().contains(f)).toList();
          return Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: AnchoMaximo(
                ancho: 760,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar jugador',
                    suffixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(RadioLbc.pildora)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(RadioLbc.pildora),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(RadioLbc.pildora),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                  onChanged: (v) => setState(() => _filtro = v.trim()),
                ),
              ),
            ),
            Expanded(
              child: lista.isEmpty
                  ? const EstadoVacio(
                      mensaje: 'No hay jugadores para inscribir. Créalos primero en "Jugadores".',
                      icono: Icons.person_add_disabled_outlined,
                    )
                  : visibles.isEmpty
                      ? const EstadoVacio(mensaje: 'Ningún jugador coincide con la búsqueda.', icono: Icons.search_off)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          itemCount: visibles.length,
                          itemBuilder: (_, i) => AnchoMaximo(
                            ancho: 760,
                            child: _FilaCandidato(
                              candidato: visibles[i],
                              eleccion: _elegidos[visibles[i].jugador.id],
                              alTocar: () => _alternar(visibles[i]),
                              alCambiar: () => setState(() {}),
                            ),
                          ),
                        ),
            ),
            Material(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              elevation: 6,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: AnchoMaximo(
                    ancho: 760,
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          n == 0 ? 'Toca jugadores para elegirlos' : (n == 1 ? '1 seleccionado' : '$n seleccionados'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: n == 0 || _guardando ? null : () => _inscribir(lista),
                        icon: _guardando
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.how_to_reg_rounded),
                        label: Text(n <= 1 ? 'Inscribir' : 'Inscribir $n'),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

/// Fila de la lista (como en el boceto): foto, nombre, #número • posición.
class _FilaCandidato extends StatelessWidget {
  const _FilaCandidato({
    required this.candidato,
    required this.eleccion,
    required this.alTocar,
    required this.alCambiar,
  });

  final Candidato candidato;
  final _Eleccion? eleccion;
  final VoidCallback alTocar;
  final VoidCallback alCambiar;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    final elegido = eleccion != null;
    final bloqueado = candidato.situacion is EnOtroEquipo;
    final detalle = switch (candidato.situacion) {
      AgenteLibre() => 'Agente libre',
      EnOtroEquipo(:final equipo) => 'Ya juega en ${equipo.nombre}',
      SinInscribir() => null,
    };
    final cifra = estiloMarcador(tema.textTheme.titleMedium)?.copyWith(fontSize: 18);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: bloqueado ? 0.5 : 1,
        child: Material(
          color: elegido ? esquema.primaryContainer : esquema.surfaceContainerLowest,
          shape: StadiumBorder(
            side: BorderSide(color: elegido ? esquema.primary : esquema.outlineVariant, width: elegido ? 2 : 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: bloqueado ? null : alTocar,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
              child: Row(children: [
                Stack(clipBehavior: Clip.none, children: [
                  ImagenApi(urlFoto: candidato.jugador.fotoUrl, nombre: candidato.nombre, tamano: 46),
                  if (elegido)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: esquema.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: esquema.surfaceContainerLowest, width: 2),
                        ),
                        child: Icon(Icons.check_rounded, size: 14, color: esquema.onPrimary),
                      ),
                    ),
                ]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      candidato.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: tema.textTheme.titleMedium?.copyWith(fontFamily: FuentesLbc.titular, fontSize: 18),
                    ),
                    if (detalle != null)
                      Text(detalle, maxLines: 1, overflow: TextOverflow.ellipsis, style: tema.textTheme.bodySmall),
                  ]),
                ),
                if (!bloqueado) ...[
                  // #número
                  Text('#', style: cifra?.copyWith(color: esquema.onSurfaceVariant)),
                  SizedBox(
                    width: 34,
                    child: TextField(
                      controller: eleccion?.numero,
                      enabled: elegido,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                      textAlign: TextAlign.center,
                      style: cifra,
                      decoration: const InputDecoration(
                        isDense: true,
                        filled: false,
                        hintText: '–',
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text('•', style: cifra?.copyWith(color: esquema.onSurfaceVariant)),
                  ),
                  // Posición
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: eleccion?.posicion,
                      isDense: true,
                      hint: Text('POS', style: cifra?.copyWith(color: esquema.onSurfaceVariant, fontSize: 15)),
                      style: cifra?.copyWith(color: esquema.primary),
                      items: [
                        const DropdownMenuItem<String?>(value: null, child: Text('—')),
                        for (final p in posicionesLiga) DropdownMenuItem<String?>(value: p, child: Text(p)),
                      ],
                      onChanged: !elegido
                          ? null
                          : (v) {
                              eleccion!.posicion = v;
                              alCambiar();
                            },
                    ),
                  ),
                ],
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
