import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/sesion/sesion.dart';
import '../../../core/tema/tema_lbc.dart';
import '../../../core/widgets/imagen_api.dart';
import '../datos/usuarios_repositorio.dart';
import 'admin_comun.dart';

IconData iconoRol(RolUsuario r) => switch (r) {
  RolUsuario.aficionado => Icons.person_rounded,
  RolUsuario.anotador => Icons.edit_note_rounded,
  RolUsuario.admin => Icons.admin_panel_settings_rounded,
};

/// Cuentas registradas (con usuario y contraseña o con Google), con buscador,
/// filtro por rol y cambio de rol.
class AdminUsuariosPantalla extends ConsumerStatefulWidget {
  const AdminUsuariosPantalla({super.key});

  @override
  ConsumerState<AdminUsuariosPantalla> createState() =>
      _AdminUsuariosPantallaState();
}

class _AdminUsuariosPantallaState extends ConsumerState<AdminUsuariosPantalla> {
  String _filtro = '';
  RolUsuario? _rol;

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(usuariosAdminProvider);
    final yo = ref.watch(sesionProvider).usuario?.username;
    final lista = todos.value ?? const <UsuarioAdmin>[];
    final valor = todos.whenData((l) {
      final f = _filtro.toLowerCase();
      return [
        for (final u in l)
          if ((_rol == null || u.rol == _rol) &&
              (f.isEmpty ||
                  u.username.toLowerCase().contains(f) ||
                  (u.email ?? '').toLowerCase().contains(f)))
            u,
      ];
    });

    Widget chip(String texto, RolUsuario? rol) {
      final n = rol == null
          ? lista.length
          : lista.where((u) => u.rol == rol).length;
      return ChoiceChip(
        label: Text('$texto · $n'),
        selected: _rol == rol,
        onSelected: (_) => setState(() => _rol = rol),
      );
    }

    return ListaAdmin<UsuarioAdmin>(
      titulo: 'Usuarios',
      valor: valor,
      onRecargar: () => ref.invalidate(usuariosAdminProvider),
      mensajeVacio: _filtro.isEmpty && _rol == null
          ? 'Todavía no hay usuarios registrados.'
          : 'Ningún usuario coincide con la búsqueda.',
      iconoVacio: Icons.manage_accounts_outlined,
      cabecera: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Buscar por usuario o correo',
              ),
              onChanged: (v) => setState(() => _filtro = v.trim()),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                chip('Todos', null),
                chip('Administradores', RolUsuario.admin),
                chip('Anotadores', RolUsuario.anotador),
                chip('Aficionados', RolUsuario.aficionado),
              ],
            ),
          ],
        ),
      ),
      fila: (u) => FilaAdmin(
        distintivo: ImagenApi(urlFoto: null, nombre: u.username, tamano: 40),
        titulo: u.username,
        detalle: [
          u.rol.etiqueta,
          u.esGoogle ? 'Google' : 'Usuario y contraseña',
          if (u.email != null && u.email != u.username) u.email!,
          if (!u.activa) 'Desactivada',
          if (u.username == yo) 'Tu cuenta',
        ].join(' · '),
        onTap: () => _editarRol(context, u, esMiCuenta: u.username == yo),
      ),
    );
  }

  Future<void> _editarRol(
    BuildContext context,
    UsuarioAdmin u, {
    required bool esMiCuenta,
  }) async {
    final nuevo = await showModalBottomSheet<RolUsuario>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _HojaRol(usuario: u, esMiCuenta: esMiCuenta),
    );
    if (nuevo == null || nuevo == u.rol || !context.mounted) return;
    final ok = await ejecutarAccion(
      context,
      ref,
      () => ref.read(usuariosRepositorioProvider).cambiarRol(u.id, nuevo),
      exito: '${u.username} ahora es ${nuevo.etiqueta.toLowerCase()}',
    );
    if (ok) ref.invalidate(usuariosAdminProvider);
  }
}

/// Hoja inferior para elegir el rol de una cuenta.
class _HojaRol extends StatefulWidget {
  const _HojaRol({required this.usuario, required this.esMiCuenta});

  final UsuarioAdmin usuario;
  final bool esMiCuenta;

  @override
  State<_HojaRol> createState() => _HojaRolState();
}

class _HojaRolState extends State<_HojaRol> {
  late RolUsuario _elegido = widget.usuario.rol;

  @override
  Widget build(BuildContext context) {
    final u = widget.usuario;
    final tema = Theme.of(context);
    final esquema = tema.colorScheme;
    final desde = u.creadoEn == null
        ? null
        : DateFormat('d MMM y', 'es').format(u.creadoEn!);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ImagenApi(urlFoto: null, nombre: u.username, tamano: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        u.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: FuentesLbc.titular,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        [
                          u.esGoogle
                              ? 'Cuenta de Google'
                              : 'Usuario y contraseña',
                          if (desde != null) 'desde $desde',
                        ].join(' · '),
                        style: tema.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Rol', style: tema.textTheme.titleSmall),
            const SizedBox(height: 8),
            for (final r in RolUsuario.values.reversed)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _elegido == r
                          ? esquema.primary
                          : esquema.outlineVariant,
                      width: _elegido == r ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    enabled: !widget.esMiCuenta,
                    leading: Icon(
                      iconoRol(r),
                      color: _elegido == r ? esquema.primary : null,
                    ),
                    title: Text(
                      r.etiqueta,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(r.descripcion),
                    trailing: _elegido == r
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: esquema.primary,
                          )
                        : null,
                    onTap: () => setState(() => _elegido = r),
                  ),
                ),
              ),
            if (widget.esMiCuenta)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  'Es tu cuenta: otro administrador tiene que cambiar tu rol.',
                  style: tema.textTheme.bodySmall,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  'El cambio vale de inmediato en la API. El menú de su app se actualiza cuando vuelva a iniciar sesión.',
                  style: tema.textTheme.bodySmall,
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: widget.esMiCuenta || _elegido == u.rol
                        ? null
                        : () => Navigator.pop(context, _elegido),
                    child: const Text('Guardar rol'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
