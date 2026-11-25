# Semana 7 · 18 – 22 de enero de 2027

**Tema:** T10 Modelos de despliegue: entrega continua hacia la nube, feature flags, canary y marcha atrás
**Clase 7** y resolución de la actividad 2 (90 min) · **jueves 21 de enero de 2027, 20:00 h** (si hay cambios, vale el aula)
**En el aula esta semana:** **entrega de la actividad 2** (según la programación, 18/01) · microtests 10.1–10.5
**Pregunta guía:** ¿Qué tendría que pasar para que despliegues a producción un viernes por la tarde sin miedo?

> Las fechas vigentes son siempre las del aula virtual. Dudas: foro "Pregúntale a tu profesor".

## Propósito

Completar la entrega continua: el mismo artefacto pasa por **staging** (automático) y **producción** (con aprobación manual), con smoke tests después de cada despliegue y configuración por entorno. Se practica en Azure (automatizado desde el pipeline) y en AWS (manual e inmutable).

## Antes de la sesión

- Tema 10 completo: 10.2 (despliegue continuo, staging, marcha atrás), 10.3 (modelos de despliegue), 10.4 (despliegue de características) y 10.5 (actualización incremental en Kubernetes).
- Tema 4.3: "usar el mismo proceso de despliegue en todos los entornos" y "probar los despliegues con un smoke test".
- **Tener activa la suscripción Azure for Students** y probar Azure Cloud Shell. Ver [nube/azure.md](../nube/azure.md).

## Clase 7 (90 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–8 | Entrega vs. despliegue; staging parecido a producción | Desplegar a menudo baja el riesgo de cada despliegue |
| 8–20 | Demo: workflow staging → aprobación → producción; smoke en cada paso (entornos creados de antemano) | Mismo artefacto, misma receta, distinta configuración |
| 20–28 | Marcha atrás: volver a desplegar el artefacto anterior | Revertir debe ser tan rutinario como desplegar |
| 28–40 | Blue/green, canary, rolling update; demo de feature flag sin redeploy | Desplegar es técnico; liberar es una decisión de negocio |
| 40–48 | Ruta AWS: EC2 con la imagen de GHCR; laboratorio y niveles | El despliegue inmutable reemplaza, no parchea |
| 48–83 | **Resolución de la actividad 2**: servidor, agente, trabajo desde SCM, *Stage View* y *Test Results* | El feedback debe llegar al desarrollador |
| 83–90 | Anuncio de la semana 8: repaso, simulacro en Wooclap y examen | — |

## Laboratorio

### Nivel base — Azure App Service (ruta principal)

1. En **Azure Cloud Shell (Bash)** clona tu fork y crea los entornos:

   ```bash
   git clone https://github.com/<usuario>/eiec-tienda-agora-202611.git && cd eiec-tienda-agora-202611
   ALIAS=<tu-alias> bash infra/azure/crear-app-service.sh
   ```

2. En GitHub, **Settings → Environments**:
   - `staging`: secreto `AZURE_WEBAPP_PUBLISH_PROFILE` (contenido de `publish-profile-staging.xml`), variables `AZURE_WEBAPP_NAME` y `BASE_URL`.
   - `production`: lo mismo con sus valores y **Required reviewers** activado.
   - Borra los `.xml` de Cloud Shell: `rm publish-profile-*.xml`.
3. Copia `pipelines/github-actions/semana-07-deploy-azure-appservice.yml` a `.github/workflows/deploy-azure.yml` y fusiónalo por PR.
4. Observa la cadena: CI verde → paquete → staging → smoke → **espera tu aprobación** → producción → smoke.
5. Visita `https://agora-<alias>-production.azurewebsites.net/version`: ¿coinciden versión y commit con el run?

> El plan F1 es gratuito pero tiene 60 minutos de CPU al día y arranque en frío: el primer acceso puede tardar. El smoke test reintenta varias veces por eso.

### Nivel base — ruta AWS (en paralelo o como alternativa)

1. Entra a tu laboratorio de AWS Educate (o AWS Academy, si está habilitado) y abre el laboratorio de cómputo (EC2).
2. Lanza una instancia Amazon Linux 2023 con el contenido de `infra/aws/ec2-user-data.sh` en *User data* (sustituye la imagen por la tuya de la semana 6) y abre el puerto 80 en el *security group*.
3. Desde tu equipo: `BASE_URL=http://<IP-pública> bash scripts/smoke_test.sh`.
4. Para "desplegar" la versión `1.1.0`: lanza **otra** instancia con la nueva etiqueta, verifica, y termina la anterior. Anota en la bitácora por qué esto es un despliegue inmutable.

### Nivel intermedio

- **Release ≠ deploy** (Tema 10.4): activa el código de descuento solo en staging sin redesplegar:

  ```bash
  az webapp config appsettings set -g rg-agora-<alias> -n agora-<alias>-staging \
    --settings FEATURE_DISCOUNT_CODES=true
  ```

  Comprueba `GET /carts/{id}/total?code=AGORA10` en staging (200) y en producción (400).
- **Marcha atrás**: vuelve a ejecutar el workflow sobre el commit anterior (*Re-run* del run anterior) y verifica con `/version` que producción volvió a la versión previa.

### Nivel avanzado — canary con Azure Container Apps

Desde Azure Cloud Shell (no requiere identidades en Entra ID):

```bash
export ALIAS=<alias> IMAGE_REPO=ghcr.io/<usuario>/eiec-tienda-agora-202611
bash infra/azure/containerapps-canary.sh setup 1.0.0     # una vez
bash infra/azure/containerapps-canary.sh canary 1.1.0 10 # 10 % a la nueva versión
for i in $(seq 1 20); do curl -s https://<fqdn>/version; echo; done   # observa la mezcla
bash infra/azure/containerapps-canary.sh promote          # o: rollback
```

Explica en la bitácora qué métrica observarías en un sistema real para decidir entre *promote* y *rollback*.

Otros retos para quien quiera ir más lejos (también después del curso):

- **Feature flag en producción**: enciende `FEATURE_DISCOUNT_CODES` en producción sin un despliegue nuevo, verifica y vuelve a apagarlo.
- **Rollback cronometrado**: publica `v1.1.0` con un cambio visible, despliégalo y vuelve a `1.0.0` re-ejecutando el run anterior. Anota el tiempo.
- Ejecuta el canary desde el pipeline con `pipelines/github-actions/semana-07-canary-containerapps.yml` (requiere inicio de sesión OIDC; ver [nube/azure.md](../nube/azure.md#opcional-inicio-de-sesión-oidc-para-container-apps)).
- **Blue/green** con etiquetas de revisión de Container Apps: dos revisiones (`blue`, `green`), una con 0 % de tráfico accesible por su URL de etiqueta.
- **Rolling update en Kubernetes** (caso 10.5) con `kind` dentro de un Codespace: `Deployment` de 5 réplicas y `kubectl rollout status` / `rollout undo`.
- Añade al workflow un comentario automático en el PR con la URL y la versión desplegada.
- Si tu institución habilita AWS Academy Learner Lab, adapta el despliegue a EC2/ECR desde el pipeline con las credenciales temporales del laboratorio como secretos (caducan: documenta el costo operativo de eso).

## Evidencia de la semana (en tu bitácora; no se entrega)

- URL de staging y de producción respondiendo `/version`, y el run con la aprobación manual.
- (AWS) IP pública de la instancia y salida del smoke test.
- En la bitácora: una marcha atrás ejecutada y cuánto tardó.

## Preguntas para reflexionar

1. ¿En qué se parece y en qué se diferencia tu staging de tu producción? ¿Basta? (Tema 10.2).
2. ¿Qué información mínima debería mostrar un smoke test cuando falla? (Tema 4.3).

## Notas para el docente

- Hacer la demo con una suscripción ya probada y los entornos creados de antemano; mostrar el script, no esperar a que termine.
- Pedir a los equipos que usen **una** suscripción por equipo para ahorrar crédito.
- Para la resolución de la actividad 2, tener Jenkins y el agente ya levantados y un build verde y uno rojo de respaldo.
- Recordar que los recursos de nube se eliminan en la semana 8.
