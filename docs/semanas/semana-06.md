# Semana 6 · 11 – 17 de enero de 2027

**Temas:** T8 GitLab · T9 Otras herramientas de CI/CD (registros de artefactos)
**Sesión síncrona (propuesta):** jueves 14 de enero
**Pregunta guía:** ¿Qué es exactamente lo que se despliega, y cómo sé de qué commit salió?

## Propósito

Pasar de "código que pasa pruebas" a **artefacto versionado**: una imagen de contenedor construida una sola vez, etiquetada con el SHA y con una versión semántica, guardada en un registro y trazable hasta su commit. Además, comparar el pipeline en GitLab CI/CD.

## Antes de la sesión

- Tema 8: GitLab CI/CD, runners, `.gitlab-ci.yml`, registro de contenedores (8.3 y 8.4).
- Tema 9: Bitbucket, CircleCI, Nexus como repositorio de artefactos (9.2 a 9.6).
- Leer el `Dockerfile` del repositorio: ¿dónde se inyectan la versión y el commit?

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | El registro como fuente de verdad de las versiones (Tema 8.4) | Git guarda el código; el registro guarda lo que se despliega |
| 10–25 | Demo: workflow de release → imagen en GHCR con etiquetas `sha-…` y `1.0.0` | Se construye una vez y se promueve |
| 25–35 | Demo: `docker run` de la imagen publicada y `curl /version` | El artefacto dice quién es |
| 35–45 | Demo: el mismo pipeline en GitLab (espejo del repo), jobs, artefactos, registro | Mismas fases, otra sintaxis |
| 45–50 | Nexus y CircleCI en dos minutos; laboratorio | Elegir herramienta es deuda técnica a largo plazo |

## Laboratorio

### Nivel base

1. Copia `pipelines/github-actions/semana-06-release-imagen.yml` a `.github/workflows/release.yml` y fusiónalo por PR.
2. Crea la primera versión:

   ```bash
   git checkout main && git pull
   git tag -a v1.0.0 -m "Primera versión entregable de Tienda Ágora"
   git push origin v1.0.0
   ```

3. Verifica en **Packages** de tu perfil la imagen `ghcr.io/<usuario>/eiec-tienda-agora-202611` con las etiquetas `sha-…`, `1.0.0`, `1.0` y `latest`. Cambia su visibilidad a **pública** (la necesitarás en la semana 7 para AWS).
4. Descarga el artefacto `release-manifest` del run y pégalo en la bitácora.
5. Prueba la imagen donde tengas Docker (equipo o Codespace):

   ```bash
   docker run --rm -p 8000:8000 ghcr.io/<usuario>/eiec-tienda-agora-202611:1.0.0
   curl http://localhost:8000/version
   ```

### Nivel intermedio — GitLab CI/CD

1. En GitLab.com: **New project → Run CI/CD for external repository** (o importa tu fork).
2. Copia `pipelines/gitlab/.gitlab-ci.yml` a la raíz del proyecto en GitLab.
3. Verifica que el pipeline pase por `static-analysis → test → build` y revisa los informes de pruebas y cobertura en la merge request.

### Nivel avanzado

- Agrega un escaneo de vulnerabilidades de la imagen (por ejemplo Trivy) que falle si hay vulnerabilidades críticas.
- Genera un SBOM de la imagen y publícalo como artefacto.
- Levanta **Nexus** en contenedor como repositorio privado de paquetes Python y publica un *wheel* de la app (réplica del caso práctico 9.6 con PyPI en lugar de npm).
- Prueba `pipelines/circleci/config.yml` y anota en la bitácora tres diferencias con GitHub Actions.

## Evidencia de la semana

- Enlace a la imagen en GHCR y manifiesto de la versión `1.0.0` en la bitácora.
- (Intermedio) Enlace al pipeline verde en GitLab.

## Preguntas para reflexionar

1. ¿Por qué no se reconstruye la imagen para producción aunque el código sea el mismo? (Tema 4.3).
2. ¿Qué política de retención aplicarías al registro y qué imágenes conservarías siempre? (Tema 8.4).

## Notas para el docente

- La primera publicación en GHCR crea el paquete como privado: recordar cambiar la visibilidad.
- Si el workflow falla en `docker/login-action`, revisar que el workflow tenga `permissions: packages: write`.
