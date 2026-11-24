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

/// No está inscrito en la temporada: entra con POST.
class SinInscribir extends Situacion {
  const SinInscribir();
}

/// Inscrito como agente libre: entra al equipo con PUT sobre su inscripción.
class AgenteLibre extends Situacion {
  const AgenteLibre(this.entradaId);

  final int entradaId;
}

/// Ya está en el roster de este equipo.
class EnEsteEquipo extends Situacion {
  const EnEsteEquipo(this.entradaId);

  final int entradaId;
}

/// Juega en otro equipo esta temporada (se cambia desde el roster de ese equipo).
class EnOtroEquipo extends Situacion {
  const EnOtroEquipo(this.equipo);

  final EquipoRefLiga equipo;
}

/// Jugador de la liga con su situación en la temporada.
class Candidato {
  const Candidato(this.jugador, this.situacion, {this.numero, this.posicion});

  final JugadorLiga jugador;
  final Situacion situacion;

  /// Número y posición de su inscripción actual en la temporada, si la tiene.
  final int? numero;
  final String? posicion;

  String get nombre => '${jugador.nombres} ${jugador.apellidos}';
}

/// Estado de todos los jugadores de la liga respecto a la temporada y el equipo.
Future<List<Candidato>> candidatosDeTemporada(LigaRepositorio repo, int t, int? e) async {
  final jugadores = await repo.jugadores();
  final porId = {for (final j in jugadores) j.id: j};
  JugadorLiga completo(JugadorResumenLiga r) =>
      porId[r.id] ??
      JugadorLiga(id: r.id, nombres: r.nombres, apellidos: r.apellidos, batea: r.batea, lanza: r.lanza, fotoUrl: r.fotoUrl, esLanzador: r.esLanzador);

  final libres = await repo.agentesLibres(t);
  final equipos = await repo.equiposDeTemporada(t);
  final plantillas = await Future.wait([for (final eq in equipos) repo.plantilla(t, eq.id)]);

  final situacion = <int, Candidato>{
    for (final p in libres)
      p.jugador.id: Candidato(completo(p.jugador), AgenteLibre(p.id), numero: p.numero, posicion: p.posicion),
  };
  for (var i = 0; i < equipos.length; i++) {
    for (final p in plantillas[i]) {
      situacion[p.jugador.id] = Candidato(
        completo(p.jugador),
        equipos[i].id == e ? EnEsteEquipo(p.id) : EnOtroEquipo(equipos[i]),
        numero: p.numero,
        posicion: p.posicion,
      );
    }
  }
  final lista = [for (final j in jugadores) situacion[j.id] ?? Candidato(j, const SinInscribir())];
  int orden(Candidato c) => switch (c.situacion) {
        EnEsteEquipo() => 0,
        SinInscribir() => 1,
        AgenteLibre() => 2,
        EnOtroEquipo() => 3,
      };
  return lista
    ..sort((a, b) {
      final o = orden(a).compareTo(orden(b));
      return o != 0 ? o : a.jugador.apellidos.toLowerCase().compareTo(b.jugador.apellidos.toLowerCase());
    });
}

/// Un cambio del roster, listo para enviar a la API.
sealed class CambioRoster {
  const CambioRoster(this.nombre);

  final String nombre;
}

/// Entra al equipo (o a la temporada como agente libre si no hay equipo).
class Entra extends CambioRoster {
  const Entra(super.nombre, {required this.jugadorId, required this.entradaLibre, this.numero, this.posicion});

  final int jugadorId;

  /// Inscripción como agente libre, si ya estaba en la temporada.
  final int? entradaLibre;
  final int? numero;
  final String? posicion;
}

/// Sale del equipo: queda en la temporada como agente libre.
class Sale extends CambioRoster {
  const Sale(super.nombre, {required this.entradaId, this.numero, this.posicion});

  final int entradaId;
  final int? numero;
  final String? posicion;
}

/// Sigue en el equipo con otro número o posición.
class Cambia extends CambioRoster {
  const Cambia(super.nombre, {required this.entradaId, this.numero, this.posicion});

  final int entradaId;
  final int? numero;
  final String? posicion;
}

/// Aplica los cambios uno a uno. Devuelve los que fallaron ("Nombre: motivo").
Future<List<String>> aplicarCambiosRoster(LigaRepositorio repo, int t, int? e, List<CambioRoster> cambios) async {
  final fallos = <String>[];
  for (final c in cambios) {
    try {
      switch (c) {
        case Entra(:final jugadorId, :final entradaLibre, :final numero, :final posicion):
          if (entradaLibre != null) {
            await repo.actualizarInscripcion(t, entradaLibre, equipoId: e, numero: numero, posicion: posicion);
          } else {
            await repo.inscribir(t, jugadorId: jugadorId, equipoId: e, numero: numero, posicion: posicion);
          }
        case Sale(:final entradaId, :final numero, :final posicion):
          await repo.actualizarInscripcion(t, entradaId, equipoId: null, numero: numero, posicion: posicion);
        case Cambia(:final entradaId, :final numero, :final posicion):
          await repo.actualizarInscripcion(t, entradaId, equipoId: e, numero: numero, posicion: posicion);
      }
    } catch (err) {
      fallos.add('${c.nombre}: ${FalloApi.desde(err).mensaje}');
    }
  }
  return fallos;
}

/// Aviso antes de aplicar: quién entra, quién sale y quién cambia.
Future<bool> confirmarCambiosRoster(
  BuildContext context, {
  required String titulo,
  required List<CambioRoster> cambios,
  List<String> omitidos = const [],
}) async {
  final entran = cambios.whereType<Entra>().toList();
  final salen = cambios.whereType<Sale>().toList();
  final cambian = cambios.whereType<Cambia>().toList();
  final tema = Theme.of(context);
  Widget bloque(IconData icono, Color color, String titulo, List<String> nombres) => nombres.isEmpty
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(icono, size: 18, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text('$titulo (${nombres.length})', style: tema.textTheme.titleSmall?.copyWith(color: color)),
              ),
            ]),
            const SizedBox(height: 4),
            for (final n in nombres) Text('• $n'),
          ]),
        );
  final ok = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(titulo),
      content: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          bloque(Icons.login_rounded, tema.colorScheme.primary, 'Entran al roster', [
            for (final e in entran) e.nombre + (e.numero == null ? '' : ' · #${e.numero}') + (e.posicion == null ? '' : ' · ${e.posicion}'),
          ]),
          bloque(Icons.logout_rounded, tema.colorScheme.error, 'Salen del roster (quedan como agentes libres)',
              [for (final s in salen) s.nombre]),
          bloque(Icons.edit_rounded, tema.colorScheme.onSurfaceVariant, 'Cambian número o posición', [
            for (final c in cambian)
              '${c.nombre} → ${c.numero == null ? 'sin número' : '#${c.numero}'} · ${c.posicion ?? 'sin posición'}',
          ]),
          bloque(Icons.block_rounded, tema.colorScheme.onSurfaceVariant, 'No se pueden traer (ya juegan en otro equipo)',
              omitidos),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
        FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Confirmar')),
      ],
    ),
  );
  return ok ?? false;
}

/// (temporadaId, equipoId o null para agentes libres)
final _datosProvider = FutureProvider.autoDispose
    .family<({List<Candidato> candidatos, ({TemporadaLiga temporada, List<PlantillaLiga> plantilla})? anterior}), (int, int?)>(
        (ref, clave) async {
  final repo = ref.watch(ligaRepositorioProvider);
  final (t, e) = clave;
  final candidatos = await candidatosDeTemporada(repo, t, e);
  final anterior = e == null ? null : await repo.rosterAnterior(t, e);
  return (candidatos: candidatos, anterior: anterior);
});

/// Selección de un jugador: número y posición que tendrá en el roster.
class _Eleccion {
  _Eleccion({int? numero, this.posicion}) : numero = TextEditingController(text: numero?.toString() ?? '');

  final TextEditingController numero;
  String? posicion;
}

/// Roster de un equipo en la temporada: arranca con el roster actual marcado; se
/// marcan o desmarcan jugadores, se ajusta número y posición, y antes de guardar
/// se muestra quién entra, quién sale y quién cambia. Con [idEquipo] nulo, inscribe
/// jugadores en la temporada como agentes libres.
class AdminInscripcionPantalla extends ConsumerStatefulWidget {
  const AdminInscripcionPantalla({super.key, required this.idTemporada, required this.idEquipo});

  final int idTemporada;
  final int? idEquipo;

  @override
  ConsumerState<AdminInscripcionPantalla> createState() => _AdminInscripcionPantallaState();
}

class _AdminInscripcionPantallaState extends ConsumerState<AdminInscripcionPantalla> {
  final _elegidos = <int, _Eleccion>{};
  bool _iniciado = false;
  String _filtro = '';
  bool _guardando = false;

  @override
  void dispose() {
    for (final e in _elegidos.values) {
      e.numero.dispose();
    }
    super.dispose();
  }

  void _iniciar(List<Candidato> lista) {
    if (_iniciado) return;
    _iniciado = true;
    for (final c in lista.where((c) => c.situacion is EnEsteEquipo)) {
      _elegidos[c.jugador.id] = _Eleccion(numero: c.numero, posicion: c.posicion);
    }
  }

  void _alternar(Candidato c) => setState(() {
        final quitado = _elegidos.remove(c.jugador.id);
        if (quitado != null) {
          quitado.numero.dispose();
        } else {
          _elegidos[c.jugador.id] = _Eleccion(numero: c.numero, posicion: c.posicion);
        }
      });

  /// Marca a los jugadores del roster anterior (con su número y posición de entonces).
  void _cargarAnterior(List<Candidato> lista, List<PlantillaLiga> anterior) => setState(() {
        final porId = {for (final c in lista) c.jugador.id: c};
        for (final p in anterior) {
          final c = porId[p.jugador.id];
          if (c == null || c.situacion is EnOtroEquipo) continue;
          _elegidos.putIfAbsent(c.jugador.id, () => _Eleccion(numero: p.numero, posicion: p.posicion));
        }
      });

  List<CambioRoster> _cambios(List<Candidato> lista) {
    final cambios = <CambioRoster>[];
    for (final c in lista) {
      final el = _elegidos[c.jugador.id];
      final numero = el == null ? null : int.tryParse(el.numero.text);
      switch (c.situacion) {
        case EnEsteEquipo(:final entradaId):
          if (el == null) {
            cambios.add(Sale(c.nombre, entradaId: entradaId, numero: c.numero, posicion: c.posicion));
          } else if (numero != c.numero || el.posicion != c.posicion) {
            cambios.add(Cambia(c.nombre, entradaId: entradaId, numero: numero, posicion: el.posicion));
          }
        case AgenteLibre(:final entradaId):
          if (el != null) {
            cambios.add(Entra(c.nombre, jugadorId: c.jugador.id, entradaLibre: entradaId, numero: numero, posicion: el.posicion));
          }
        case SinInscribir():
          if (el != null) {
            cambios.add(Entra(c.nombre, jugadorId: c.jugador.id, entradaLibre: null, numero: numero, posicion: el.posicion));
          }
        case EnOtroEquipo():
          break;
      }
    }
    return cambios;
  }

  Future<void> _guardar(List<Candidato> lista, String titulo) async {
    final cambios = _cambios(lista);
    if (cambios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay cambios en el roster')));
      return;
    }
    if (!await confirmarCambiosRoster(context, titulo: titulo, cambios: cambios)) return;
    setState(() => _guardando = true);
    final fallos = await aplicarCambiosRoster(ref.read(ligaRepositorioProvider), widget.idTemporada, widget.idEquipo, cambios);
    if (!mounted) return;
    refrescarLiga(ref);
    ref.invalidate(_datosProvider((widget.idTemporada, widget.idEquipo)));
    setState(() => _guardando = false);
    final hechos = cambios.length - fallos.length;
    if (fallos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.idEquipo == null ? 'Jugadores inscritos' : 'Roster actualizado ($hechos cambios)')),
      );
      Navigator.of(context).pop();
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(hechos == 0 ? 'No se pudo actualizar' : 'Se aplicaron $hechos cambios; algunos fallaron'),
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
    final valor = ref.watch(_datosProvider(clave));
    final rosterEquipo = widget.idEquipo != null;
    final titulo = rosterEquipo ? 'Actualizar roster · ${equipo?.abreviatura ?? ''}' : 'Inscribir agentes libres';
    final anterior = valor.value?.anterior;
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        actions: [
          if (anterior != null)
            TextButton.icon(
              onPressed: () => _cargarAnterior(valor.value!.candidatos, anterior.plantilla),
              icon: const Icon(Icons.history_rounded),
              label: Text('Roster ${anterior.temporada.anio}'),
            ),
        ],
      ),
      body: VistaAsync(
        valor: valor,
        onReintentar: () => ref.invalidate(_datosProvider(clave)),
        datos: (d) {
          _iniciar(d.candidatos);
          // Sin equipo (agentes libres) solo sirven los no inscritos.
          final lista = rosterEquipo ? d.candidatos : d.candidatos.where((c) => c.situacion is SinInscribir).toList();
          final f = _filtro.toLowerCase();
          final visibles = f.isEmpty ? lista : lista.where((c) => c.nombre.toLowerCase().contains(f)).toList();
          final n = _elegidos.length;
          final pendientes = _cambios(lista).length;
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
                        flex: 2,
                        child: Text(
                          rosterEquipo ? '$n en el roster' : (n == 1 ? '1 seleccionado' : '$n seleccionados'),
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 3,
                        child: FilledButton.icon(
                          onPressed: pendientes == 0 || _guardando ? null : () => _guardar(lista, titulo),
                          icon: _guardando
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.fact_check_rounded),
                          label: Text(
                            pendientes == 0 ? 'Sin cambios' : 'Revisar cambios ($pendientes)',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
      EnEsteEquipo() => elegido ? 'En el roster' : 'Sale del roster',
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
                      Text(
                        detalle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: candidato.situacion is EnEsteEquipo && !elegido ? esquema.error : null,
                        ),
                      ),
                  ]),
                ),
                if (!bloqueado) ...[
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
                      onChanged: (_) => alCambiar(),
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
