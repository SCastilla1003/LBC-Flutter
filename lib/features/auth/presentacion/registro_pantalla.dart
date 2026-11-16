import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/red/fallo_api.dart';
import '../../../core/sesion/sesion.dart';
import '../../../core/widgets/comunes.dart';
import '../datos/auth_repositorio.dart';

class RegistroPantalla extends ConsumerStatefulWidget {
  const RegistroPantalla({super.key, this.destino});

  final String? destino;

  @override
  ConsumerState<RegistroPantalla> createState() => _RegistroPantallaState();
}

class _RegistroPantallaState extends ConsumerState<RegistroPantalla> {
  final _form = GlobalKey<FormState>();
  final _usuario = TextEditingController();
  final _password = TextEditingController();
  final _confirmacion = TextEditingController();
  bool _enviando = false;
  String? _error;
  Map<String, String> _camposError = const {};

  static final _patronUsuario = RegExp(r'^[\p{L}0-9._@-]+$', unicode: true);

  @override
  void dispose() {
    _usuario.dispose();
    _password.dispose();
    _confirmacion.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _enviando = true;
      _error = null;
      _camposError = const {};
    });
    try {
      final r = await ref.read(authRepositorioProvider).registro(_usuario.text.trim(), _password.text);
      await ref.read(sesionProvider.notifier).iniciar(r);
      if (mounted) context.go(widget.destino ?? '/cuenta');
    } catch (e) {
      final fallo = FalloApi.desde(e);
      if (!mounted) return;
      setState(() {
        _error = fallo is FalloConflicto ? 'Ese nombre de usuario ya está en uso.' : fallo.mensaje;
        if (fallo is FalloValidacion) _camposError = fallo.campos;
      });
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AnchoMaximo(
            ancho: 440,
            child: Form(
              key: _form,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usuario,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    errorText: _camposError['username'],
                  ),
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    if (t.length < 3 || t.length > 50) return 'Debe tener entre 3 y 50 caracteres';
                    if (!_patronUsuario.hasMatch(t)) return 'Solo letras, números y . _ @ -';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    errorText: _camposError['password'],
                  ),
                  validator: (v) => (v == null || v.length < 6) ? 'Debe tener al menos 6 caracteres' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmacion,
                  obscureText: true,
                  onFieldSubmitted: (_) => _registrar(),
                  decoration: const InputDecoration(
                      labelText: 'Repite la contraseña', prefixIcon: Icon(Icons.lock_outline_rounded)),
                  validator: (v) => v != _password.text ? 'Las contraseñas no coinciden' : null,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: TextStyle(color: tema.colorScheme.error)),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _enviando ? null : _registrar,
                  child: _enviando
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Crear cuenta'),
                ),
                const SizedBox(height: 12),
                TextButton(onPressed: () => context.go('/login'), child: const Text('Ya tengo cuenta')),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
