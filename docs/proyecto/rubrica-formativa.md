# Rúbrica formativa y modelo de madurez

Sin calificación numérica. Dos instrumentos: el **diagnóstico de madurez** (semanas 1, 4 y 8) y el **semáforo semanal**.

## 1. Diagnóstico de madurez de Tienda Ágora

Adaptación del modelo de madurez de Humble y Farley (2010) presentado en el Tema 1, apartado 1.5. Para cada dimensión, elige el nivel que describe mejor **tu fork** y enlaza la evidencia.

| Dimensión | −1 Regresivo | 0 Repetible | 1 Consistente | 2 Gestionado cuantitativamente | 3 Optimizado |
|---|---|---|---|---|---|
| **Construcción e integración** | Se construye a mano en la máquina de alguien | Construcción con script; CI ocasional | CI en cada cambio; `main` protegida; feedback < 10 min | Métricas del pipeline (duración, tasa de fallos) y se actúa sobre ellas | El equipo mejora el pipeline de forma continua y deliberada |
| **Entornos y despliegue** | Despliegue manual, distinto en cada entorno | Despliegue con script en algún entorno | Mismo proceso automatizado para staging y producción | Despliegues medidos (frecuencia, MTTR) y rollback ensayado | Despliegue continuo con modelos canary/blue-green |
| **Gestión de versiones** | No se sabe qué corre en producción | Versiones etiquetadas a mano | Artefacto único versionado y trazable a su commit | Historial de versiones con manifiestos y retención definida | Liberación desacoplada del despliegue (feature flags) |
| **Pruebas** | Pruebas manuales | Algunas pruebas automáticas locales | Unitarias y de API en cada cambio, con informes | Quality gates acordados (cobertura, calidad) | Pruebas de humo y aceptación en cada despliegue; cuarentena gestionada |
| **Configuración y datos** | Configuración editada a mano en servidores | Configuración en archivos sin versionar | Configuración por entorno fuera del código; secretos gestionados | Cambios de esquema versionados y probados | Cualquier entorno se recrea desde el repositorio |

**Plantilla para la bitácora:**

```markdown
| Dimensión | Nivel sem 1 | Nivel sem 8 | Evidencia (enlace) |
|---|---|---|---|
| Construcción e integración |  |  |  |
| Entornos y despliegue |  |  |  |
| Gestión de versiones |  |  |  |
| Pruebas |  |  |  |
| Configuración y datos |  |  |  |
```

## 2. Semáforo semanal

| Criterio | 🟢 Logrado | 🟡 En proceso | 🔴 Requiere apoyo |
|---|---|---|---|
| Cumple la definición de terminado del nivel base | Completa y verificable con enlaces | Parcial o sin evidencia | No iniciada |
| Usa el flujo profesional (rama, PR, checks) | Todo cambio entra por PR en verde | Algún cambio directo a `main` | Trabaja sin PR |
| Interpreta el feedback del pipeline | Explica la causa de un fallo con el log | Identifica el paso, no la causa | No revisa el pipeline |
| Documenta decisiones en la bitácora | Decisión + alternativa + razón | Describe lo hecho, sin razones | Bitácora vacía |
| Colabora (revisión, roles) | Revisa PR ajenos con comentarios útiles | Revisa sin comentarios | No participa |

## 3. Ejemplos de retroalimentación

- "Tu pipeline bloquea correctamente los PR rojos. Siguiente paso: separa unitarias y de API para acortar el feedback."
- "La imagen está publicada, pero `/version` muestra `local`: revisa que el workflow pase `APP_VERSION` y `GIT_SHA` como *build args*."
- "Excelente decisión documentada sobre el umbral de cobertura. ¿Qué harías si un hotfix urgente bajara la cobertura?"
