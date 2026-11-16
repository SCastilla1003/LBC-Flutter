import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Barra inferior en móvil y riel lateral en tablet/web.
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

  void _ir(int i) => shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    if (ancho >= 720) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: _ir,
              extended: ancho >= 1200,
              labelType: ancho >= 1200 ? NavigationRailLabelType.none : NavigationRailLabelType.all,
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Icon(Icons.sports_baseball_rounded, size: 32),
              ),
              destinations: [
                for (final d in _destinos)
                  NavigationRailDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: Text(d.$3)),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: shell),
          ],
        ),
      );
    }
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: _ir,
        destinations: [
          for (final d in _destinos) NavigationDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: d.$3),
        ],
      ),
    );
  }
}
