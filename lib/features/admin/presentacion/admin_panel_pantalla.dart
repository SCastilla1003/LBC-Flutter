import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/vista_async.dart';
import '../../../liga/datos/liga_repositorio.dart';
import '../../../liga/datos/modelos_liga.dart';
import '../../../liga/presentacion/widgets_liga.dart';

/// Temporada sobre la que trabaja el panel de administración.
class TemporadaAdmin extends Notifier<int?> {
  @override
  int? build() => null;

  void elegir(int? id) => state = id;
}

final temporadaAdminProvider = NotifierProvider<TemporadaAdmin, int?>(
  TemporadaAdmin.new,
);

/// Panel de administración (contrato v1): catálogos de la liga y, por temporada,
/// plantillas y partidos.
class AdminPanelPantalla extends ConsumerWidget {
  const AdminPanelPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temporadas = ref.watch(temporadasLigaProvider);
    // Si se llegó pasando por el login no hay pantalla anterior: "atrás" lleva a Cuenta.
    final puedeVolver = Navigator.of(context).canPop();
    return PopScope(
      canPop: puedeVolver,
      onPopInvokedWithResult: (salio, _) {
        if (!salio) context.go('/cuenta');
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Panel de administración'),
          leading: puedeVolver
              ? null
              : IconButton(
                  tooltip: 'Volver a Cuenta',
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => context.go('/cuenta'),
                ),
        ),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(temporadasLigaProvider.future),
          child: VistaAsync<List<TemporadaLiga>>(
            valor: temporadas,
            onReintentar: () => ref.invalidate(temporadasLigaProvider),
            datos: (lista) => _Contenido(temporadas: lista),
          ),
        ),
      ),
    );
  }
}

class _Contenido extends ConsumerWidget {
  const _Contenido({required this.temporadas});

  final List<TemporadaLiga> temporadas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elegida = ref.watch(temporadaAdminProvider);
    // La más reciente arriba (por año y, a igual año, la última creada) y elegida
    // por defecto.
    final ordenadas = [...temporadas]
      ..sort((a, b) => b.anio != a.anio ? b.anio.compareTo(a.anio) : b.id.compareTo(a.id));
    final actual =
        ordenadas.where((t) => t.id == elegida).firstOrNull ??
        ordenadas.firstOrNull;

    Widget opcion(IconData icono, String titulo, String detalle, String ruta) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: ListTile(
              leading: _InsigniaMenu(icono: icono),
              title: Text(titulo, style: _estiloMenu),
              subtitle: Text(detalle),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => context.push(ruta),
            ),
          ),
        );

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        AnchoMaximo(
          ancho: 760,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroLbc(
                compacto: true,
                etiqueta: 'Solo administradores',
                titulo: 'Panel de administración',
                subtitulo: 'Temporadas, equipos, jugadores, estadios, partidos y usuarios de la liga.',
                icono: Icons.admin_panel_settings_rounded,
                contenido: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    PastillaHero(
                      icono: Icons.calendar_month_rounded,
                      texto: '${temporadas.length} temporadas',
                    ),
                    if (actual != null)
                      PastillaHero(
                        icono: Icons.push_pin_rounded,
                        texto: actual.nombre,
                      ),
                  ],
                ),
              ),
              const EncabezadoSeccion('La liga'),
              opcion(
                Icons.calendar_month_rounded,
                'Temporadas',
                'Crear, activar y cerrar temporadas',
                '/admin/temporadas',
              ),
              opcion(
                Icons.shield_outlined,
                'Equipos',
                'Nombre, abreviatura, ciudad y color',
                '/admin/equipos',
              ),
              opcion(
                Icons.person_rounded,
                'Jugadores',
                'Datos personales, bateo y lanzamiento',
                '/admin/jugadores',
              ),
              opcion(
                Icons.stadium_rounded,
                'Estadios',
                'Dónde se juegan los partidos',
                '/admin/estadios',
              ),
              opcion(
                Icons.manage_accounts_rounded,
                'Usuarios',
                'Cuentas registradas y su rol: aficionado, anotador o admin',
                '/admin/usuarios',
              ),
              opcion(
                Icons.history_edu_rounded,
                'Registro de auditoría',
                'Quién creó, movió, editó o eliminó cada cosa y cuándo',
                '/admin/auditoria',
              ),
              EncabezadoSeccion(
                actual == null ? 'Temporada' : 'Temporada ${actual.anio}',
              ),
              if (actual == null)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Crea una temporada para inscribir jugadores y programar partidos.',
                    ),
                  ),
                )
              else ...[
                DropdownButtonFormField<int>(
                  key: ValueKey(actual.id),
                  initialValue: actual.id,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Temporada'),
                  items: [
                    for (final t in ordenadas)
                      DropdownMenuItem(
                        value: t.id,
                        child: Text(
                          '${t.nombre} · ${t.anio} · ${etiquetaEstadoTemporada(t.estado)}',
                        ),
                      ),
                  ],
                  onChanged: (id) =>
                      ref.read(temporadaAdminProvider.notifier).elegir(id),
                ),
                const SizedBox(height: 14),
                opcion(
                  Icons.groups_rounded,
                  'Equipos y rosters',
                  'Inscribir equipos y actualizar sus rosters',
                  '/admin/t/${actual.id}/plantilla',
                ),
                opcion(
                  Icons.person_search_rounded,
                  'Agentes libres',
                  'Inscritos sin equipo',
                  '/admin/t/${actual.id}/agentes-libres',
                ),
                opcion(
                  Icons.sports_baseball_rounded,
                  'Partidos',
                  'Programar, mover y borrar partidos',
                  '/admin/t/${actual.id}/partidos',
                ),
              ],
              const EncabezadoSeccion('Zona de peligro'),
              Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: ListTile(
                  leading: Icon(Icons.delete_forever_rounded, color: Theme.of(context).colorScheme.error),
                  title: Text('Eliminar por completo', style: _estiloMenu),
                  subtitle: const Text('Jugadores o partidos con todo lo que depende de ellos'),
                  trailing: Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.error),
                  onTap: () => context.push('/admin/eliminar${actual == null ? '' : '?t=${actual.id}'}'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const _estiloMenu = TextStyle(
  fontFamily: FuentesLbc.titular,
  fontSize: 19,
  fontWeight: FontWeight.w700,
);

/// Icono de menú sobre una placa verde suave.
class _InsigniaMenu extends StatelessWidget {
  const _InsigniaMenu({required this.icono});

  final IconData icono;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: esquema.primaryContainer,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(icono, size: 20, color: esquema.primary),
    );
  }
}
