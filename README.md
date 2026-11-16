# LBC · App de la Liga de Béisbol de Cartagena

App Flutter (Android y Web) que consume **exclusivamente** la API REST de la liga
(proyecto Spring Boot `proaula-lbc-main`, contrato en su `docs/API.md`). No tiene datos
de ejemplo ni base de datos local: si la API no responde, cada pantalla muestra un error
con la opción de reintentar.

## Requisitos

- Flutter 3.47 o superior (Dart 3.13).
- La API de LBC corriendo: en Railway o en local (`./mvnw spring-boot:run -Dspring-boot.run.profiles=local`).
- Para Android: SDK con `cmdline-tools` y licencias aceptadas (`flutter doctor --android-licenses`).

## Ejecutar

La URL de la API **no está en el código**: se pasa al compilar.

Web contra la API local (el perfil `local` de la API ya permite CORS desde `http://localhost:*`):

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8080
```

Emulador de Android contra la API local (`10.0.2.2` es el PC visto desde el emulador; el HTTP sin cifrar solo está permitido en debug):

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

Contra Railway:

```bash
flutter run --dart-define=API_BASE_URL=https://<app>.up.railway.app
```

Compilación web de producción (sin depender del CDN de Flutter):

```bash
flutter build web --release --no-web-resources-cdn --dart-define=API_BASE_URL=https://<app>.up.railway.app
```

Variables `--dart-define`:

| Variable | Obligatoria | Uso |
|---|---|---|
| `API_BASE_URL` | Sí | URL base de la API, sin `/api/v1`. Sin ella la app muestra una pantalla de configuración. |
| `GOOGLE_CLIENT_ID` | No | Client ID **web** de Google. Activa "Continuar con Google" (botón oficial en web; en Android se usa como `serverClientId`). El backend necesita el mismo ID en `GOOGLE_CLIENT_IDS`. |

## Tests

```bash
flutter test
```

Modelos (`fromJson` con respuestas reales capturadas de la API en `test/fixtures/`), errores tipados,
repositorios con el cliente HTTP simulado, el interceptor de sesión (401), la guardia de rutas y los
estados de pantalla.

Si cambias un modelo, regenera el código de freezed / json_serializable:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Estructura

```
lib/
  core/      config (dart-define), red (dio + errores tipados), sesion (JWT en almacenamiento seguro),
             router (go_router, /admin solo para ADMIN), tema (marca y colores de equipo), widgets comunes
  features/  temporadas, equipos, jugadores, partidos, prediccion, auth, admin
             └ datos/ (modelos y repositorio) · presentacion/ (pantallas)
```

Estado con Riverpod; cada pantalla maneja explícitamente cargando (esqueleto), error (reintentar), vacío y datos.
