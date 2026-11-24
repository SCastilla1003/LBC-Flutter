import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/entorno.dart';
import '../../../core/red/fallo_api.dart';
import '../../../core/sesion/sesion.dart';
import '../../../core/widgets/comunes.dart';
import '../../../core/widgets/hero_lbc.dart';
import '../../../core/widgets/logo_lbc.dart';
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
      if (mounted) {
        setState(
          () => _error = 'No se pudo preparar el inicio de sesión con Google.',
        );
      }
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
    _completar(
      () => ref
          .read(authRepositorioProvider)
          .login(_usuario.text.trim(), _password.text),
    );
  }

  void _entrarConGoogle(String idToken) {
    if (_enviando) return;
    _completar(() => ref.read(authRepositorioProvider).google(idToken));
  }

  Future<void> _botonGooglePropio() async {
    try {
      await ref.read(servicioGoogleProvider).autenticar();
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = 'Se canceló o falló el inicio de sesión con Google.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final motivo = ref.watch(sesionProvider).motivoCierre;
    final formulario = Form(
      key: _form,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: tema.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    Icons.login_rounded,
                    color: tema.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido al diamante',
                        style: tema.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Entra para vivir la liga desde dentro.',
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: tema.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (motivo != null) ...[
              const SizedBox(height: 16),
              _Aviso(texto: motivo),
            ],
            const SizedBox(height: 22),
            TextFormField(
              controller: _usuario,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Usuario',
                prefixIcon: const Icon(Icons.person_outline_rounded),
                errorText: _camposError['username'],
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Escribe tu usuario' : null,
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
                  tooltip: _ocultar
                      ? 'Mostrar contraseña'
                      : 'Ocultar contraseña',
                  icon: Icon(
                    _ocultar
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setState(() => _ocultar = !_ocultar),
                ),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Escribe tu contraseña' : null,
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tema.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 18,
                      color: tema.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: tema.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _enviando ? null : _entrar,
              icon: _enviando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.arrow_forward_rounded),
              label: const Text('Entrar'),
            ),
            if (Entorno.googleHabilitado && _googleListo) ...[
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('o'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
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
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.go(
                Uri(
                  path: '/registro',
                  queryParameters: widget.destino == null
                      ? null
                      : {'destino': widget.destino!},
                ).toString(),
              ),
              child: const Text('¿No tienes cuenta? Crear una'),
            ),
          ],
        ),
      ),
    );

    final portada = HeroLbc(
      compacto: true,
      etiqueta: 'Liga de Béisbol de Cartagena',
      titulo: 'La casa del béisbol',
      subtitulo: 'Récords, líderes, predicciones y la historia de cada temporada en un solo lugar.',
      marca: const LogoLbc(tamano: 48, radio: 14),
      contenido: const Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          PastillaHero(icono: Icons.bolt_rounded, texto: 'Datos al instante'),
          PastillaHero(
            icono: Icons.insights_rounded,
            texto: 'Gráficas de la liga',
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: LayoutBuilder(
        builder: (context, c) {
          final ancha = c.maxWidth >= 860;
          final tarjeta = Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: formulario,
            ),
          );
          if (!ancha) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                AnchoMaximo(
                  ancho: 520,
                  child: Column(children: [portada, tarjeta]),
                ),
              ],
            );
          }
          return ListView(
            padding: const EdgeInsets.all(28),
            children: [
              AnchoMaximo(
                ancho: 980,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: portada),
                    const SizedBox(width: 28),
                    Expanded(flex: 5, child: tarjeta),
                  ],
                ),
              ),
            ],
          );
        },
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
      decoration: BoxDecoration(
        color: esquema.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: esquema.onPrimaryContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              texto,
              style: TextStyle(color: esquema.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
