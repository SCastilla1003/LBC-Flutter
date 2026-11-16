import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/entorno.dart';
import '../../../core/red/fallo_api.dart';
import '../../../core/sesion/sesion.dart';
import '../../../core/widgets/comunes.dart';
import '../datos/auth_repositorio.dart';
import '../datos/servicio_google.dart';
import 'google/boton_google_oficial.dart';

class LoginPantalla extends ConsumerStatefulWidget {
  const LoginPantalla({super.key, this.destino});

  /// Ruta a la que volver tras iniciar sesión (p. ej. /admin).
  final String? destino;

  @override
  ConsumerState<LoginPantalla> createState() => _LoginPantallaState();
}

class _LoginPantallaState extends ConsumerState<LoginPantalla> {
  final _form = GlobalKey<FormState>();
  final _usuario = TextEditingController();
  final _password = TextEditingController();
  bool _ocultar = true;
  bool _enviando = false;
  String? _error;
  Map<String, String> _camposError = const {};
  StreamSubscription<String>? _suscripcionGoogle;
  bool _googleListo = false;

  @override
  void initState() {
    super.initState();
    if (Entorno.googleHabilitado) _prepararGoogle();
  }

  Future<void> _prepararGoogle() async {
    final google = ref.read(servicioGoogleProvider);
    try {
      await google.iniciar();
      _suscripcionGoogle = google.idTokens.listen(_entrarConGoogle);
      if (mounted) setState(() => _googleListo = true);
    } catch (_) {
      if (mounted) setState(() => _error = 'No se pudo preparar el inicio de sesión con Google.');
    }
  }

  @override
  void dispose() {
    _suscripcionGoogle?.cancel();
    _usuario.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _completar(Future<RespuestaAuth> Function() llamada) async {
    setState(() {
      _enviando = true;
      _error = null;
      _camposError = const {};
    });
    try {
      final r = await llamada();
      await ref.read(sesionProvider.notifier).iniciar(r);
      if (!mounted) return;
      context.go(widget.destino ?? (r.usuario.esAdmin ? '/admin' : '/cuenta'));
    } catch (e) {
      final fallo = FalloApi.desde(e);
      if (!mounted) return;
      setState(() {
        _error = fallo.mensaje;
        if (fallo is FalloValidacion) _camposError = fallo.campos;
      });
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  void _entrar() {
    if (!_form.currentState!.validate()) return;
    _completar(() => ref.read(authRepositorioProvider).login(_usuario.text.trim(), _password.text));
  }

  void _entrarConGoogle(String idToken) {
    if (_enviando) return;
    _completar(() => ref.read(authRepositorioProvider).google(idToken));
  }

  Future<void> _botonGooglePropio() async {
    try {
      await ref.read(servicioGoogleProvider).autenticar();
    } catch (_) {
      if (mounted) setState(() => _error = 'Se canceló o falló el inicio de sesión con Google.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final motivo = ref.watch(sesionProvider).motivoCierre;
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AnchoMaximo(
            ancho: 440,
            child: Form(
              key: _form,
              child: AutofillGroup(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Icon(Icons.sports_baseball_rounded, size: 56),
                  const SizedBox(height: 12),
                  Text('LBC', textAlign: TextAlign.center, style: tema.textTheme.headlineSmall),
                  if (motivo != null) ...[
                    const SizedBox(height: 16),
                    _Aviso(texto: motivo),
                  ],
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _usuario,
                    autofillHints: const [AutofillHints.username],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      errorText: _camposError['username'],
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe tu usuario' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    obscureText: _ocultar,
                    autofillHints: const [AutofillHints.password],
                    onFieldSubmitted: (_) => _entrar(),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      errorText: _camposError['password'],
                      suffixIcon: IconButton(
                        tooltip: _ocultar ? 'Mostrar contraseña' : 'Ocultar contraseña',
                        icon: Icon(_ocultar ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () => setState(() => _ocultar = !_ocultar),
                      ),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'Escribe tu contraseña' : null,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: TextStyle(color: tema.colorScheme.error)),
                  ],
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _enviando ? null : _entrar,
                    child: _enviando
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Entrar'),
                  ),
                  if (Entorno.googleHabilitado && _googleListo) ...[
                    const SizedBox(height: 16),
                    const Row(children: [
                      Expanded(child: Divider()),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('o')),
                      Expanded(child: Divider()),
                    ]),
                    const SizedBox(height: 16),
                    if (ref.read(servicioGoogleProvider).usaBotonPropio)
                      OutlinedButton.icon(
                        onPressed: _enviando ? null : _botonGooglePropio,
                        icon: const Icon(Icons.g_mobiledata_rounded, size: 28),
                        label: const Text('Continuar con Google'),
                      )
                    else
                      Center(child: botonGoogleOficial()),
                  ],
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => context.go(Uri(
                      path: '/registro',
                      queryParameters: widget.destino == null ? null : {'destino': widget.destino!},
                    ).toString()),
                    child: const Text('Crear cuenta'),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Aviso extends StatelessWidget {
  const _Aviso({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: esquema.tertiaryContainer, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(Icons.info_outline_rounded, color: esquema.onTertiaryContainer),
        const SizedBox(width: 8),
        Expanded(child: Text(texto, style: TextStyle(color: esquema.onTertiaryContainer))),
      ]),
    );
  }
}
