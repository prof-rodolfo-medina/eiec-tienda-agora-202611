# Checklist del docente

## Antes del 23 de noviembre de 2026

### Repositorio (canal oficial = aula virtual)

- [ ] **Settings → General → Features**: desactivar *Issues*, *Discussions*, *Wiki* y *Projects* del repositorio del curso.
- [ ] **Settings → Emails** (perfil): *Keep my email addresses private* y *Block command line pushes that expose my email* activados.
- [ ] Perfil público de GitHub sin correo visible (*Settings → Public profile → Public email*: no mostrar).
- [ ] Revisar que ningún archivo del repositorio contenga correos (`git grep -nE "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-z]{2,}"`; solo deben aparecer dominios genéricos como `@comunidadunir.net` o acciones `uses: ...@v`).

### Aula y coordinación

- [ ] Confirmar día y hora de las ocho clases síncronas y la fecha del examen final (semana 8).
- [ ] Confirmar la licencia institucional de Wooclap (modo competición en vivo y número de participantes).
- [ ] Preguntar si se puede habilitar un aula de **AWS Academy** para la asignatura.
- [ ] Publicar en el aula: anuncio de bienvenida con el enlace al repositorio y el aviso de canal oficial (aula, foro "Pregúntale a tu profesor", Zoom).

### Pruebas técnicas

- [ ] Probar con una cuenta `@comunidadunir.net` que Azure for Students se activa y que Cloud Shell funciona.
- [ ] Abrir un Codespace del repositorio para verificar que todo corre desde el navegador.
- [ ] Probar `infra/azure/crear-app-service.sh` y el workflow de la semana 7 en un fork de prueba (ver "Validación pendiente").

## Cada semana

- [ ] Publicar el anuncio de la semana en el aula el lunes (texto breve + enlace a `docs/semanas/semana-NN.md`). Las fechas se citan siempre desde el aula.
- [ ] Preparar ramas de demostración (`demo/sNN-rojo`, `demo/sNN-verde`) y capturas de respaldo por si GitHub Actions tarda en vivo.
- [ ] Responder dudas del proyecto solo en el foro "Pregúntale a tu profesor" o en la clase.

## Hitos

| Semana | Qué preparar |
|---|---|
| 2 | Presentación de la actividad 1 (10 min al final de la clase 2) |
| 4 | Resolución de la actividad 1 (35 min): fork de demostración y PR de ejemplo |
| 5 | Presentación de la actividad 2 (10 min al final de la clase 5) |
| 7 | Resolución de la actividad 2 (35 min): Jenkins y agente ya levantados, build verde y rojo de respaldo |
| 8 | Evento de Wooclap en modo competición con el banco de preguntas (guardado fuera del repositorio), probado desde un celular; descargar el informe al terminar |

## Validación pendiente antes de usar cada plantilla

Lo siguiente se validó localmente (pruebas, lint, sintaxis YAML y shell), pero **no** contra servicios reales:

| Pieza | Qué validar | Cuándo |
|---|---|---|
| ~~`Dockerfile` y `semana-06-release-imagen.yml`~~ | ✅ Validado el 21-oct-2026: imagen publicada en GHCR, manifiesto y smoke test en verde | — |
| `pipelines/jenkins/` | Construcción de la imagen y primer build del Jenkinsfile | Antes de la semana 5 |
| `pipelines/gitlab/.gitlab-ci.yml` | Pipeline completo en GitLab.com (runners compartidos con Docker-in-Docker) | Antes de la semana 6 |
| `infra/azure/crear-app-service.sh` + `semana-07-deploy-azure-appservice.yml` | Creación del plan F1, despliegue con perfil de publicación y smoke test | Antes de la semana 7 |
| `infra/azure/containerapps-canary.sh` + `semana-07-canary-containerapps.yml` | `setup`, `canary`, `promote`, `rollback` en una suscripción Azure for Students | Antes de la semana 7 |

## Cierre del curso

- [ ] Recordar en la clase 8 la limpieza de recursos de nube.
- [ ] Recoger lecciones aprendidas para la siguiente edición en `docs/docente/`.
