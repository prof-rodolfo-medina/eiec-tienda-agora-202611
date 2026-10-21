# Checklist del docente

## Antes del 23 de noviembre de 2026

- [ ] Confirmar con la coordinación horario de sesiones síncronas y receso (actualizar la tabla del [plan](../plan-del-curso.md#4-calendario) y el README).
- [ ] Preguntar si se puede habilitar un aula de **AWS Academy Learner Lab** para la asignatura.
- [ ] Probar con una cuenta `@comunidadunir.net` que Azure for Students se activa y que Cloud Shell funciona.
- [ ] Probar `infra/azure/crear-app-service.sh` y el workflow de la semana 7 en un fork de prueba (ver "Validación pendiente" abajo).
- [ ] Publicar en Moodle: anuncio de bienvenida, enlace al repositorio, guía de la semana 1 y foro de dudas técnicas.
- [ ] Abrir un Codespace del repositorio para verificar que todo corre desde el navegador.

## Cada semana

- [ ] Publicar la guía de la semana en Moodle el lunes (texto breve + enlace a `docs/semanas/semana-NN.md`).
- [ ] Preparar ramas de demostración en el repositorio del curso (`demo/sNN-rojo`, `demo/sNN-verde`) y sus PR, por si GitHub Actions tarda en vivo.
- [ ] Tener capturas de respaldo del pipeline.
- [ ] Revisar una muestra de bitácoras y dejar retroalimentación de semáforo.

## Validación pendiente antes de usar cada plantilla

Lo siguiente se validó localmente (pruebas, lint, sintaxis YAML y shell), pero **no** contra servicios reales:

| Pieza | Qué validar | Cuándo |
|---|---|---|
| `Dockerfile` y `semana-06-release-imagen.yml` | Primer run en GitHub: imagen publicada en GHCR y job `smoke-image` en verde | Antes de la semana 6 |
| `pipelines/jenkins/` | Construcción de la imagen y primer build del Jenkinsfile | Antes de la semana 5 |
| `pipelines/gitlab/.gitlab-ci.yml` | Pipeline completo en GitLab.com (runners compartidos con Docker-in-Docker) | Antes de la semana 6 |
| `infra/azure/crear-app-service.sh` + `semana-07-deploy-azure-appservice.yml` | Creación del plan F1, despliegue con perfil de publicación y smoke test | Antes de la semana 7 |
| `infra/azure/containerapps-canary.sh` | `setup`, `canary`, `promote`, `rollback` en una suscripción Azure for Students | Antes de la semana 8 |

## Cierre del curso

- [ ] Verificar en las bitácoras la constancia de limpieza de recursos de nube.
- [ ] Recoger lecciones aprendidas para la siguiente edición en `docs/docente/`.
