import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/sesion/sesion.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/hero_lbc.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroLbc(
                  compacto: true,
                  etiqueta: sesion.autenticado
                      ? 'Tu lugar en la tribuna'
                      : 'Liga de Béisbol de Cartagena',
                  titulo: sesion.autenticado
                      ? sesion.usuario!.username
                      : 'Tu cuenta LBC',
                  subtitulo: sesion.autenticado
                      ? '${sesion.esAdmin ? 'Administrador' : 'Aficionado'} · ${sesion.usuario!.proveedor == 'google' ? 'Cuenta de Google' : 'Cuenta local'}'
                      : 'Entra para seguir a tu equipo, comparar jugadores y guardar tus favoritos.',
                  icono: sesion.autenticado
                      ? Icons.person_rounded
                      : Icons.sports_baseball_rounded,
                  contenido: sesion.autenticado
                      ? Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            PastillaHero(
                              icono: sesion.esAdmin
                                  ? Icons.admin_panel_settings_rounded
                                  : Icons.favorite_rounded,
                              texto: sesion.esAdmin
                                  ? 'Acceso al panel'
                                  : 'Aficionado de la liga',
                            ),
                          ],
                        )
                      : const Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            PastillaHero(
                              icono: Icons.lock_outline_rounded,
                              texto: 'Sesión segura',
                            ),
                            PastillaHero(
                              icono: Icons.insights_rounded,
                              texto: 'Datos de la liga',
                            ),
                          ],
                        ),
                ),
                if (!sesion.autenticado) ...[
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 4,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFB5121B), Color(0xFFFFD166)],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: tema.colorScheme.primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      size: 28,
                                      color:
                                          tema.colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Inicia sesión para continuar',
                                          style: tema.textTheme.titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        Text(
                                          'Tu sesión se guarda de forma segura en este dispositivo.',
                                          style: tema.textTheme.bodySmall
                                              ?.copyWith(
                                                color: tema
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (sesion.motivoCierre != null) ...[
                                const SizedBox(height: 14),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: tema.colorScheme.errorContainer,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline_rounded,
                                        size: 18,
                                        color:
                                            tema.colorScheme.onErrorContainer,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          sesion.motivoCierre!,
                                          style: TextStyle(
                                            color: tema
                                                .colorScheme
                                                .onErrorContainer,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              const SizedBox(height: 20),
                              FilledButton.icon(
                                onPressed: () => context.push('/login'),
                                icon: const Icon(Icons.login_rounded),
                                label: const Text('Iniciar sesión'),
                              ),
                              const SizedBox(height: 8),
                              OutlinedButton(
                                onPressed: () => context.push('/registro'),
                                child: const Text('Crear cuenta'),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                        child: Text(
                          sesion.usuario!.username
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      title: Text(
                        sesion.usuario!.username,
                        style: tema.textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        [
                          sesion.esAdmin ? 'Administrador' : 'Aficionado',
                          sesion.usuario!.proveedor == 'google'
                              ? 'Cuenta de Google'
                              : 'Cuenta local',
                        ].join(' · '),
                      ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
