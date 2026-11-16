import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/sesion/sesion.dart';
import '../../../core/widgets/comunes.dart';
import '../datos/servicio_google.dart';

class CuentaPantalla extends ConsumerWidget {
  const CuentaPantalla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sesion = ref.watch(sesionProvider);
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AnchoMaximo(
            ancho: 640,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              if (!sesion.autenticado) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      Icon(Icons.person_outline_rounded, size: 48, color: tema.colorScheme.outline),
                      if (sesion.motivoCierre != null) ...[
                        const SizedBox(height: 12),
                        Text(sesion.motivoCierre!, style: TextStyle(color: tema.colorScheme.tertiary)),
                      ],
                      const SizedBox(height: 20),
                      FilledButton.icon(
                        onPressed: () => context.push('/login'),
                        icon: const Icon(Icons.login_rounded),
                        label: const Text('Iniciar sesión'),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(onPressed: () => context.push('/registro'), child: const Text('Crear cuenta')),
                    ]),
                  ),
                ),
              ] else ...[
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: tema.colorScheme.primaryContainer,
                      foregroundColor: tema.colorScheme.onPrimaryContainer,
                      child: Text(sesion.usuario!.username.substring(0, 1).toUpperCase(),
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    ),
                    title: Text(sesion.usuario!.username, style: tema.textTheme.titleLarge),
                    subtitle: Text([
                      sesion.esAdmin ? 'Administrador' : 'Aficionado',
                      sesion.usuario!.proveedor == 'google' ? 'Cuenta de Google' : 'Cuenta local',
                    ].join(' · ')),
                  ),
                ),
                const SizedBox(height: 12),
                if (sesion.esAdmin)
                  FilledButton.icon(
                    onPressed: () => context.push('/admin'),
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: const Text('Panel de administración'),
                  ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    await ref.read(servicioGoogleProvider).cerrar();
                    await ref.read(sesionProvider.notifier).cerrar();
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Cerrar sesión'),
                ),
              ],
            ]),
          ),
        ],
      ),
    );
  }
}
