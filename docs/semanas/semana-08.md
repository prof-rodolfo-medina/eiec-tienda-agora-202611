# Semana 8 · 25 – 31 de enero de 2027

**Tema:** T10 Modelos de despliegue (II): rolling, blue/green, canary, feature flags, rollback · Cierre del curso
**Sesión síncrona (propuesta):** jueves 28 de enero
**Pregunta guía:** ¿Cómo expones una versión nueva a usuarios reales limitando el daño si sale mal?

## Propósito

Practicar modelos de despliegue que separan *desplegar* de *liberar*, cerrar el proyecto con una demostración de punta a punta y dejar la nube limpia.

## Antes de la sesión

- Tema 10: 10.3 (modelos de despliegue), 10.4 (feature flags) y 10.5 (actualización incremental en Kubernetes).
- Tener al menos dos versiones de la imagen en GHCR (por ejemplo `1.0.0` y `1.1.0`).

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | Rolling update, blue/green, canary, *dark launch* | Cada modelo compra seguridad con recursos o con tiempo |
| 10–25 | Demo: canary al 10 % en Container Apps, promoción y rollback | El tráfico se mueve; los binarios no se tocan |
| 25–32 | Demo: feature flag encendido en producción sin redeploy | Desplegar es técnico; liberar es una decisión de negocio |
| 32–45 | Demostraciones de equipos (3–4 minutos cada una, por sorteo) | Del commit a producción, con evidencia |
| 45–50 | Cierre: diagnóstico de madurez final y limpieza de recursos | Lo que no se apaga, cobra |

## Laboratorio

### Nivel base

1. **Feature flag en producción**: enciende `FEATURE_DISCOUNT_CODES` en producción (App Service → *Environment variables* o `az webapp config appsettings set`) y verifica que el comportamiento cambia sin un despliegue nuevo. Apágalo y verifica de nuevo.
2. **Rollback ensayado**: publica `v1.1.0` con un cambio visible, despliégalo y vuelve a `1.0.0` re-ejecutando el run anterior. Mide el tiempo.
3. **Diagnóstico de madurez final** en la bitácora, con la misma tabla de la semana 1 y evidencia por dimensión.
4. **Limpieza**: elimina los recursos de Azure (`ALIAS=<alias> bash infra/azure/limpiar.sh`) y termina las instancias de AWS. Deja constancia en la bitácora.

### Nivel intermedio — canary con Azure Container Apps

Desde Azure Cloud Shell (no requiere identidades en Entra ID):

```bash
export ALIAS=<alias> IMAGE_REPO=ghcr.io/<usuario>/eiec-tienda-agora-202611
bash infra/azure/containerapps-canary.sh setup 1.0.0     # una vez
bash infra/azure/containerapps-canary.sh canary 1.1.0 10 # 10 % a la nueva versión
for i in $(seq 1 20); do curl -s https://<fqdn>/version; echo; done   # observa la mezcla
bash infra/azure/containerapps-canary.sh promote          # o: rollback
```

Explica en la bitácora qué métrica observarías en un sistema real para decidir entre *promote* y *rollback*.

### Nivel avanzado

- Ejecuta el canary desde el pipeline con `pipelines/github-actions/semana-08-canary-containerapps.yml` (requiere inicio de sesión OIDC; ver [nube/azure.md](../nube/azure.md#opcional-inicio-de-sesión-oidc-para-container-apps)).
- **Blue/green** con etiquetas de revisión de Container Apps: dos revisiones (`blue`, `green`), una con 0 % de tráfico accesible por su URL de etiqueta para probarla antes del cambio.
- **Rolling update en Kubernetes** (caso 10.5) con `kind` dentro de un Codespace: `Deployment` de 5 réplicas y `kubectl rollout status` / `rollout undo`.

## Demostración final (3–4 minutos por equipo)

1. Un commit pequeño en una rama.
2. El PR con todos los checks (fase de commit + quality gate) y una revisión.
3. La fusión, la imagen o paquete generado y su versión.
4. Staging → aprobación → producción, y `/version` coincidiendo con el commit.
5. Una cosa de la que estén orgullosos y una deuda que dejarían anotada.

## Evidencia de la semana

- Diagnóstico de madurez final con comparación frente a la semana 1.
- Demo final (en vivo o video corto enlazado en la bitácora).
- Constancia de recursos de nube eliminados.

## Preguntas para reflexionar

1. ¿Qué modelo de despliegue elegirías para Tienda Ágora con 10 usuarios? ¿Y con 100 000?
2. Si tuvieras que mejorar una sola dimensión de madurez de tu proyecto, ¿cuál sería y por qué?

## Notas para el docente

- Hacer el sorteo de demostraciones al inicio de la semana para que los equipos se preparen.
- Recordar la limpieza de recursos en el anuncio de cierre y verificarla en las bitácoras.
