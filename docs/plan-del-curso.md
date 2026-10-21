# Plan del curso · Entornos de Integración y Entrega Continua

**Maestría en Desarrollo y Operaciones de Software · UNIR**
**Docente:** Dr. Rodolfo Rafael Medina Ramírez
**Edición:** del 23 de noviembre de 2026 al 31 de enero de 2027 (8 semanas lectivas + receso)
**Proyecto conductor:** Tienda Ágora API (formativo, no sumativo; individual o en equipo)

---

## 1. Propósito

Que cada estudiante construya, mejore y defienda un flujo completo de integración y entrega continuas, desde el primer commit hasta un despliegue verificable en la nube, usando un mismo proyecto que madura semana a semana. El temario de la asignatura (10 temas) se comprime en 8 semanas con un enfoque aplicado: cada concepto se convierte, esa misma semana, en un cambio visible en el pipeline de Tienda Ágora.

## 2. Resultados de aprendizaje

Al terminar el curso, la persona estudiante será capaz de:

| # | Resultado | Temas |
|---|---|---|
| RA1 | Distinguir integración, entrega y despliegue continuos, reconocer antipatrones y ubicar un proyecto en un modelo de madurez. | 1 |
| RA2 | Usar Git y un flujo de trabajo colaborativo (ramas, Pull Requests, protección de ramas, revisión). | 2, 3 |
| RA3 | Diseñar un pipeline por fases con compilación única, retroalimentación rápida y detención ante fallos. | 4 |
| RA4 | Automatizar baterías de pruebas (unitarias, de API, de humo) y usarlas como llaves de paso. | 5 |
| RA5 | Incorporar señales de calidad (estilo, cobertura, revisión de código, análisis estático) como quality gates. | 6 |
| RA6 | Implementar el mismo pipeline en herramientas distintas (GitHub Actions, Jenkins, GitLab CI) y gestionar artefactos versionados en un registro. | 7, 8, 9 |
| RA7 | Desplegar en la nube con entornos de staging y producción, smoke tests, feature flags, modelos de despliegue y marcha atrás. | 10 |

## 3. Enfoque didáctico

- **Proyecto conductor.** Tienda Ágora API es una API pequeña (FastAPI) a propósito: la complejidad está en el flujo de entrega, no en el negocio. Cada semana añade una capa al pipeline.
- **Aula invertida en tres tiempos.** *Antes*: lectura del tema y preparación técnica. *Durante* (sesión síncrona): demostración guiada, lectura de un pipeline rojo y uno verde, decisiones de criterio. *Después*: laboratorio en el fork propio y evidencia en la bitácora.
- **Perfeccionamiento por niveles.** Cada laboratorio tiene un nivel **base** (lo mínimo para avanzar), **intermedio** y **avanzado**. Quien termina el base puede seguir puliendo su proyecto; nadie se queda atrás por no hacer el avanzado.
- **Modalidad libre.** Individual o en equipos de 2 a 4 personas. En equipo se rotan roles (build master, revisor, release manager). Ver [proyecto/equipos.md](proyecto/equipos.md).
- **Madurez como brújula.** En la semana 1 cada equipo diagnostica Tienda Ágora con el modelo de madurez de Humble y Farley (Tema 1); en la semana 8 repite el diagnóstico y argumenta su avance.
- **Evaluación formativa.** Retroalimentación tipo semáforo (logrado / en proceso / requiere apoyo), sin calificación numérica. Ver [proyecto/rubrica-formativa.md](proyecto/rubrica-formativa.md).

## 4. Calendario

Las fechas de sesión síncrona son una **propuesta** (jueves, como en la edición anterior) y se ajustarán cuando se publique la programación oficial.

| Sem. | Fechas | Sesión síncrona (propuesta) | Temas | Laboratorio en Tienda Ágora | Evidencia mínima | Nube |
|---|---|---|---|---|---|---|
| 1 | 23 – 29 nov 2026 | jue 26 nov | T1 Introducción · T2 Control de versiones | Cuentas, fork, ejecución local, diagnóstico de madurez, laboratorio `git bisect` | Fork + PR de registro + diagnóstico inicial | Alta en Azure for Students y AWS Educate |
| 2 | 30 nov – 6 dic | jue 3 dic | T3 Flujos con Git · T4 Fases de la entrega continua | Protección de `main`, check obligatorio, PR rojo y verde, fase de commit | `main` protegida + PR con CI verde | — |
| 3 | 7 – 13 dic | jue 10 dic | T5 Pruebas | Nueva funcionalidad con pruebas; baterías separadas por marcadores; informes JUnit | PR con pruebas unitarias y de API | — |
| 4 | 14 – 20 dic | jue 17 dic | T6 Evaluación y calidad del código | Quality gate de cobertura, revisión entre pares, SonarQube Cloud (opcional) | PR revisado por otra persona + quality gate activo | — |
| — | 21 dic 2026 – 3 ene 2027 | — | **Receso** (probable) | Solo actividades opcionales de puesta al día | — | — |
| 5 | 4 – 10 ene 2027 | jue 7 ene | T7 Jenkins | Jenkins en contenedor y el mismo pipeline como Jenkinsfile | Captura del Stage View + informe JUnit en Jenkins | Opcional: Jenkins en VM de Azure o EC2 |
| 6 | 11 – 17 ene | jue 14 ene | T8 GitLab · T9 Otras herramientas y artefactos | Imagen Docker única en GHCR con versión semántica; pipeline equivalente en GitLab | Etiqueta `v1.0.0` + imagen publicada + pipeline de GitLab verde | GHCR (gratuito) |
| 7 | 18 – 24 ene | jue 21 ene | T10 Modelos de despliegue (I): entrega continua | Staging y producción en Azure App Service con aprobación manual y smoke tests; ruta AWS con EC2 | URL de staging y producción respondiendo `/version` | **Azure** App Service F1 · **AWS** EC2 (laboratorio) |
| 8 | 25 – 31 ene | jue 28 ene | T10 Modelos de despliegue (II): canary, blue/green, feature flags, rollback · Cierre | Feature flag sin redeploy, canary y rollback; demostración final; diagnóstico de madurez final; limpieza de recursos | Demo final + retrospectiva + recursos de nube eliminados | Azure Container Apps (opcional) |

> **Si el receso no ocurre**, las semanas 5 a 8 se recorren dos semanas: el curso terminaría la semana del 11 de enero de 2027 y las dos semanas sobrantes quedarían como colchón para la demostración final. El contenido no cambia.

Guías detalladas: [semana 1](semanas/semana-01.md) · [2](semanas/semana-02.md) · [3](semanas/semana-03.md) · [4](semanas/semana-04.md) · [receso](semanas/receso.md) · [5](semanas/semana-05.md) · [6](semanas/semana-06.md) · [7](semanas/semana-07.md) · [8](semanas/semana-08.md)

## 5. Cómo madura el pipeline

```text
Sem 1  código + pruebas locales                       (despliegue manual: antipatrón de partida)
Sem 2  + fase de commit en cada PR · main protegida   (integración continua)
Sem 3  + baterías unit/api separadas · JUnit          (pruebas como llaves de paso)
Sem 4  + quality gate de cobertura · revisión         (calidad desde el principio)
Sem 5  = mismo pipeline en Jenkins                    (pipeline como código, otra herramienta)
Sem 6  + imagen única versionada en GHCR · GitLab CI  (artefactos y trazabilidad)
Sem 7  + staging -> aprobación -> producción · smoke  (entrega continua en la nube)
Sem 8  + feature flags · canary · rollback            (despliegue continuo controlado)
```

Las plantillas listas para copiar están en [`pipelines/`](../pipelines/).

## 6. Nube: qué se usa y para qué

| Recurso | Para qué en el curso | Costo para el estudiante |
|---|---|---|
| **GitHub** (Actions, GHCR, Codespaces) | Repositorio, pipeline principal, registro de imágenes, entorno de desarrollo en el navegador | Gratuito para repositorios públicos (Codespaces con cuota mensual gratuita) |
| **Azure for Students** | Ruta principal de despliegue automatizado desde el pipeline: App Service F1 (staging y producción) y, opcionalmente, Container Apps para canary | 100 USD de crédito sin tarjeta; App Service F1 es gratuito y Container Apps tiene concesión mensual gratuita |
| **AWS Educate** | Ruta guiada: laboratorios en consola (EC2, S3) para desplegar la misma imagen de forma inmutable | Sin tarjeta; laboratorios con entorno controlado |
| **AWS Academy (Learner Lab)** | Opcional, si la institución habilita un aula: credenciales temporales para desplegar desde el pipeline | Sin costo para el estudiante |
| **GitLab.com, SonarQube Cloud, CircleCI** | Comparación de herramientas (Temas 6, 8 y 9) | Planes gratuitos |

**Principio:** la nube es un destino de despliegue, no una dependencia del aprendizaje. Si una cuenta falla, el laboratorio se completa con Codespaces + Docker + GHCR y se documenta qué cambiaría en la nube ([nube/plan-b.md](nube/plan-b.md)).

Guías: [Azure](nube/azure.md) · [AWS](nube/aws.md) · [Plan B](nube/plan-b.md)

## 7. Evidencias y seguimiento

- Cada fork mantiene una [`BITACORA.md`](../BITACORA.md) con una entrada por semana: enlace al PR, enlace al run del pipeline, decisión técnica tomada y aprendizaje.
- La entrega en Moodle de cada semana es un texto corto con el enlace al PR y a la entrada de la bitácora.
- La semana 4 y la semana 8 cierran con una retrospectiva breve (qué mejoró, qué duele, qué sigue).

## 8. Riesgos y contingencias

| Riesgo | Respuesta |
|---|---|
| La activación de Azure for Students o AWS Educate tarda o falla | Alta desde la semana 1; Plan B con Codespaces + GHCR; el despliegue en nube se puede hacer en equipo con una sola cuenta |
| El tenant institucional no permite crear identidades en Entra ID | El despliegue usa perfil de publicación de App Service (no requiere identidades); el canary se ejecuta desde Cloud Shell |
| Los laboratorios de AWS Educate no permiten credenciales para el pipeline | La ruta AWS es manual y guiada en consola; la automatización completa se hace en Azure |
| Estudiantes sin Docker en su equipo | GitHub Codespaces incluye Docker y se usa desde el navegador |
| Consumo de crédito por recursos olvidados | Recursos con etiquetas, plan F1 y escalado a cero; script de limpieza obligatorio en la semana 8 |
| El receso desplaza el calendario | Tabla alternativa en la sección 4 |

## 9. Pendientes de confirmar con la coordinación

- Programación oficial de sesiones síncronas (día, hora y duración).
- Confirmación del receso del 21 de diciembre al 3 de enero.
- Si la institución puede habilitar un aula de AWS Academy Learner Lab para esta asignatura (UNIR es miembro de AWS Academy a través de Grupo ProEduca).
- Si las suscripciones Azure for Students creadas con `comunidadunir.net` permiten registrar aplicaciones en Entra ID (solo afecta a la parte opcional de la semana 8).

## 10. Referencias base

- Humble, J. y Farley, D. (2010). *Continuous Delivery*. Addison-Wesley.
- Forsgren, N., Humble, J. y Kim, G. (2018). *Accelerate*. IT Revolution Press.
- Fowler, M. (2006). *Continuous Integration*. martinfowler.com.
- Vocke, H. (2018). *The Practical Test Pyramid*. martinfowler.com.
- Driessen, V. (2010). *A successful Git branching model*. nvie.com.
- Temario oficial de la asignatura, Temas 1 a 10 (UNIR).
