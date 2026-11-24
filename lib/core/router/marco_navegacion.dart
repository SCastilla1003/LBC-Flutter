import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../tema/tema_lbc.dart';
import '../widgets/logo_lbc.dart';

/// Barra inferior en móvil y riel lateral en tablet/web. La base es blanca;
/// la franja tricolor y los indicadores rojos aportan la identidad de la liga.
class MarcoNavegacion extends StatelessWidget {
  const MarcoNavegacion({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const _destinos = [
    (Icons.home_outlined, Icons.home_rounded, 'Inicio'),
    (Icons.calendar_month_outlined, Icons.calendar_month_rounded, 'Temporadas'),
    (Icons.emoji_events_outlined, Icons.emoji_events_rounded, 'Líderes'),
    (Icons.insights_outlined, Icons.insights_rounded, 'Predicción'),
    (Icons.person_outline_rounded, Icons.person_rounded, 'Cuenta'),
  ];

  void _ir(int i) =>
      shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    if (ancho >= 720) {
      final extendido = ancho >= 1200;
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: _ir,
              extended: extendido,
              minWidth: 78,
              labelType: extendido
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              groupAlignment: -0.62,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 22),
                child: _MarcaRail(extendido: extendido),
              ),
              trailing: extendido
                  ? Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'LBC · ${DateTime.now().year}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                    )
                  : null,
              destinations: [
                for (final d in _destinos)
                  NavigationRailDestination(
                    icon: Icon(d.$1),
                    selectedIcon: Icon(d.$2),
                    label: Text(d.$3),
                  ),
              ],
            ),
            VerticalDivider(
              width: 1,
              color: Theme.of(context).colorScheme.outlineVariant
                  .withValues(alpha: 0.7),
            ),
            Expanded(child: shell),
          ],
        ),
      );
    }
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: ColoresMarca.franjaInstitucional,
              ),
            ),
            NavigationBar(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: _ir,
              destinations: [
                for (final d in _destinos)
                  NavigationDestination(
                    icon: Icon(d.$1),
                    selectedIcon: Icon(d.$2),
                    label: d.$3,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MarcaRail extends StatelessWidget {
  const _MarcaRail({required this.extendido});

  final bool extendido;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    return Container(
      width: extendido ? 190 : 52,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: esquema.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: esquema.outlineVariant.withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: ColoresMarca.franjaInstitucional,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: extendido ? 12 : 8,
              vertical: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LogoLbc(
                  tamano: extendido ? 32 : 34,
                  radio: 10,
                  sombra: false,
                ),
                if (extendido) ...[
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LBC',
                          style: tema.textTheme.titleMedium?.copyWith(
                            color: esquema.onSurface,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.6,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Liga de Cartagena',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tema.textTheme.labelSmall?.copyWith(
                            color: esquema.onSurfaceVariant,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
