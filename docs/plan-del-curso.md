# Plan del curso · Entornos de Integración y Entrega Continua

**Maestría en Desarrollo y Operaciones de Software · UNIR**
**Docente:** Dr. Rodolfo Rafael Medina Ramírez
**Edición:** del 23 de noviembre de 2026 al 29 de enero de 2027 · 8 semanas lectivas · periodo no lectivo del 21 de diciembre de 2026 al 3 de enero de 2027
**Proyecto conductor:** Tienda Ágora API (formativo, **no sumativo**; individual o en equipo)

> [!IMPORTANT]
> **El aula virtual es el único canal oficial del curso.** Las fechas vigentes son siempre las del aula, las actividades se entregan en el aula y el contacto con el profesor es por el foro **"Pregúntale a tu profesor"** y en las clases síncronas por Zoom. Este repositorio es material complementario. Ver [SUPPORT.md](../SUPPORT.md).

---

## 1. Propósito

Que cada estudiante construya, mejore y defienda un flujo completo de integración y entrega continuas, desde el primer commit hasta un despliegue verificable en la nube, usando **un mismo proyecto que madura semana a semana**. Cada tema del temario (10 temas en 8 semanas) se convierte esa misma semana en un cambio visible en el pipeline de Tienda Ágora, y ese avance prepara las actividades evaluables del aula y el examen final.

## 2. Resultados de aprendizaje

| # | Al terminar, la persona estudiante será capaz de… | Temas |
|---|---|---|
| RA1 | Distinguir integración, entrega y despliegue continuos, reconocer antipatrones y ubicar un proyecto en un modelo de madurez. | 1 |
| RA2 | Usar Git y un flujo de trabajo colaborativo (ramas, forks, pull requests, protección de ramas, revisión). | 2, 3 |
| RA3 | Diseñar un pipeline por fases con compilación única, retroalimentación rápida y detención ante fallos. | 4 |
| RA4 | Automatizar baterías de pruebas (unitarias, de API, de humo) y usarlas como llaves de paso. | 5 |
| RA5 | Incorporar señales de calidad (estilo, cobertura, revisión de código, análisis estático) como quality gates. | 6 |
| RA6 | Implementar el mismo pipeline en herramientas distintas (GitHub Actions, Jenkins, GitLab CI) y gestionar artefactos versionados en un registro. | 7, 8, 9 |
| RA7 | Desplegar en la nube con staging y producción, smoke tests, feature flags, modelos de despliegue y marcha atrás. | 10 |

## 3. Proyecto y evaluación oficial: cómo encajan

El proyecto **no se entrega ni se califica**. Lo que cuenta para la calificación está en el aula virtual:

| Elemento del aula | Puntos | Se presenta | Fecha de entrega* | Se resuelve | Cómo te prepara Tienda Ágora |
|---|---|---|---|---|---|
| **Actividad 1.** Caso práctico: pull requests en GitHub | 6.0 | Clase 2 (semana 2) | 14/12/2026 | Clase 4 (semana 4) | Semanas 1 y 2: fork, ramas, commits, PR, protección de `main` |
| **Actividad 2.** Caso práctico: primer servidor de Jenkins y primer pipeline | 5.0 | Clase 5 (semana 5) | 18/01/2027 | Clase 7 (semana 7) | Semanas 2 a 5: fases del pipeline, informes JUnit, Jenkinsfile |
| **Microtests** 1.1 a 10.5 (54 en total) | 4.0 | Cada semana, con su tema | 31/01/2027 | — | La guía semanal indica qué apartados leer antes de cada clase |
| **Total de evaluación continua** | **15.0** | | | | Se puede sumar hasta un máximo de 10 |
| **Examen final** | — | | Semana 8 | | Clase 8: repaso y simulacro en Wooclap |

\* Fechas tomadas de la programación semanal publicada. **Si cambian, vale lo que diga el aula.**

Reglas de convivencia entre proyecto y actividades:

- Los **enunciados oficiales** de las actividades están en el aula. El repositorio no los reproduce ni los sustituye, y no publica soluciones.
- Las actividades usan los repositorios que indica su enunciado; Tienda Ágora es el lugar para practicar lo mismo con más profundidad.
- Recomendación de orden: primero la actividad del aula (cuenta para la nota), después el nivel intermedio o avanzado del proyecto.

## 4. Enfoque didáctico

- **Proyecto conductor.** Tienda Ágora API es pequeña a propósito (FastAPI): la complejidad está en el flujo de entrega, no en el negocio. Cada semana añade una capa al pipeline.
- **Aula invertida en tres tiempos.** *Antes*: lectura del tema y microtests. *Durante* (clase síncrona por Zoom): demostración guiada, lectura de un pipeline rojo y uno verde, decisiones de criterio. *Después*: laboratorio en el fork propio y entrada en la bitácora.
- **Niveles de logro.** Cada laboratorio tiene nivel **base** (lo mínimo para seguir al grupo), **intermedio** y **avanzado**. Nadie se queda atrás por no hacer el avanzado.
- **Modalidad libre.** Individual o en equipos de 2 a 4 personas con roles rotativos (build master, revisor, release manager, cronista). Ver [proyecto/equipos.md](proyecto/equipos.md).
- **Madurez como brújula.** Diagnóstico con el modelo de Humble y Farley (Tema 1) en las semanas 1, 4 y 8.
- **Retroalimentación formativa.** Semáforo (logrado / en proceso / requiere apoyo), sin nota. La evidencia vive en la `BITACORA.md` de cada fork; quien quiera retroalimentación comparte el enlace en clase o en el foro del aula. Ver [proyecto/rubrica-formativa.md](proyecto/rubrica-formativa.md).

## 5. Calendario

Semanas y clases según la programación semanal del aula. **Clases por Zoom los jueves a las 20:00 h** (enlace en el aula), excepto la **clase 8**, que se programará entre el lunes 25 y el miércoles 27 de enero de 2027, según la disponibilidad del grupo y del docente; el día y la hora se publicarán en el aula. Si hay cambios, vale lo que diga el aula.

| Sem. | Fechas | Temas | Clase (duración) | Aula: actividades | Laboratorio en Tienda Ágora (nivel base) | Nube |
|---|---|---|---|---|---|---|
| 1 | 23 – 27 nov 2026 | T1 Introducción · T2 Control de versiones | **Clase 1** (jue 26 nov) y presentación del curso (90 min) | Microtests 1.1–1.6 y 2.1–2.6 | Fork, entorno local o Codespace, CI verde, diagnóstico de madurez, `git bisect` | Alta en Azure for Students y AWS Educate |
| 2 | 30 nov – 4 dic | T3 Flujos con Git · T4 Fases de la entrega continua | **Clase 2** (jue 3 dic) y presentación de la actividad 1 (60 min) | **Act. 1 publicada** · Microtests 3.x y 4.x | `main` protegida, check obligatorio, PR rojo y PR verde | — |
| 3 | 7 – 11 dic | T5 Pruebas | **Clase 3** (jue 10 dic, 60 min) | Microtests 5.x · Act. 1 en curso | Historia del backlog con pruebas unitarias y de API; JUnit | — |
| 4 | 14 – 18 dic | T6 Evaluación y calidad del código | **Clase 4** (jue 17 dic) y resolución de la actividad 1 (90 min) | **Act. 1: entrega 14/12** · Microtests 6.x | Quality gate de cobertura, revisión entre pares, retrospectiva | — |
| — | 21 dic – 3 ene | **Periodo no lectivo** | — | — | Solo opcional: ponerse al día ([receso](semanas/receso.md)) | — |
| 5 | 4 – 8 ene 2027 | T7 Jenkins | **Clase 5** (jue 7 ene) y presentación de la actividad 2 (60 min) | **Act. 2 publicada** · Microtests 7.x | El mismo pipeline como Jenkinsfile | Opcional: Jenkins en VM de Azure |
| 6 | 11 – 15 ene | T8 GitLab · T9 Otras herramientas y artefactos | **Clase 6** (jue 14 ene, 60 min) | Microtests 8.x y 9.x · Act. 2 en curso | Imagen única versionada en GHCR; pipeline equivalente en GitLab | GHCR |
| 7 | 18 – 22 ene | T10 Modelos de despliegue | **Clase 7** (jue 21 ene) y resolución de la actividad 2 (90 min) | **Act. 2: entrega 18/01** · Microtests 10.x | Staging → aprobación → producción con smoke tests; feature flag; marcha atrás | **Azure** App Service F1 · **AWS** EC2 |
| 8 | 25 – 29 ene | Repaso | **Clase 8** (entre lun 25 y mié 27 ene, por confirmar): repaso y **simulacro del examen en Wooclap** (90 min) | **Examen final** (fecha en el aula) · Microtests hasta el 31/01 | Cierre opcional: diagnóstico final y **limpieza de la nube** | Eliminar recursos |

Guías: [semana 1](semanas/semana-01.md) · [2](semanas/semana-02.md) · [3](semanas/semana-03.md) · [4](semanas/semana-04.md) · [receso](semanas/receso.md) · [5](semanas/semana-05.md) · [6](semanas/semana-06.md) · [7](semanas/semana-07.md) · [8](semanas/semana-08.md) · [repaso](semanas/repaso-examen.md) · [simulacro Wooclap](semanas/simulacro-wooclap.md) · [actividades del aula](actividades/README.md)

## 6. Estructura de las clases

Las clases de **60 minutos** (2, 3, 5 y 6) siguen este patrón:

| Min | Bloque |
|---|---|
| 0–5 | Dónde va el pipeline de Tienda Ágora y qué cambia hoy |
| 5–45 | Conceptos del tema con demostración en vivo (pipeline rojo → verde) |
| 45–50 | Laboratorio de la semana y niveles |
| 50–60 | Actividad del aula: presentación (clases 2 y 5) o dudas (clases 3 y 6) |

Las clases de **90 minutos** (1, 4, 7 y 8) reservan un bloque largo para el propósito especial de la semana: presentación del curso (clase 1), resolución de la actividad 1 (clase 4), resolución de la actividad 2 (clase 7) y repaso con simulacro (clase 8). Cada guía semanal detalla la agenda minuto a minuto.

## 7. Semana 8: repaso y simulacro en Wooclap

La clase 8 se dedica al repaso del temario completo con un **simulacro del examen final en Wooclap en modo competición**: los participantes ganan puntos por responder correctamente y por la rapidez de la respuesta, y se muestra una tabla de clasificación. Diseño:

| Min | Bloque |
|---|---|
| 0–10 | Bienvenida, reglas y conexión a Wooclap con un alias (no con el nombre completo ni el correo) |
| 10–55 | **Simulacro**: 3 rondas (T1–T4, T5–T7, T8–T10), 20 preguntas; explicación breve tras cada pregunta y clasificación al cierre de cada ronda |
| 55–80 | Repaso dirigido: los temas con menor acierto, recorriendo el pipeline de Tienda Ágora |
| 80–90 | Cierre: recordatorios del aula (examen, microtests al 31/01) y limpieza de la nube |

- El simulacro **no cuenta para la calificación** y no anticipa las preguntas ni el formato exacto del examen.
- La guía para estudiantes está en [semanas/simulacro-wooclap.md](semanas/simulacro-wooclap.md). El banco de preguntas no se publica en el repositorio.

## 8. Cómo madura el pipeline

```text
Sem 1  código + pruebas locales                           (despliegue manual: antipatrón de partida)
Sem 2  + fase de commit en cada PR · main protegida       (integración continua)
Sem 3  + baterías unit/api separadas · JUnit              (pruebas como llaves de paso)
Sem 4  + quality gate de cobertura · revisión             (calidad desde el principio)
Sem 5  = mismo pipeline en Jenkins                        (pipeline como código, otra herramienta)
Sem 6  + imagen única versionada en GHCR · GitLab CI      (artefactos y trazabilidad)
Sem 7  + staging → aprobación → producción · smoke        (entrega continua en la nube)
       + feature flags · canary · marcha atrás            (despliegue controlado)
Sem 8  diagnóstico final · repaso · nube limpia           (cierre)
```

Plantillas listas para copiar en [`pipelines/`](../pipelines/).

## 9. Nube

Como estudiantes de UNIR tienen acceso gratuito, sin tarjeta, registrándose con el correo institucional `@comunidadunir.net` ([instrucciones](nube/registro-aws-azure.md)).

| Recurso | Para qué en el curso | Costo para el estudiante |
|---|---|---|
| **GitHub** (Actions, GHCR, Codespaces) | Repositorio, pipeline principal, registro de imágenes, entorno en el navegador | Gratuito para repositorios públicos (Codespaces con cuota mensual) |
| **Azure for Students** | Ruta principal de despliegue automatizado: App Service F1 (staging y producción); Container Apps opcional para canary | Crédito de estudiante sin tarjeta; App Service F1 gratuito |
| **AWS Educate** | Ruta guiada en consola: la misma imagen en EC2 (despliegue inmutable) | Sin tarjeta |
| **AWS Academy** | Opcional, si la institución habilita un aula para la asignatura | Sin costo |
| **GitLab.com, SonarQube Cloud, CircleCI** | Comparación de herramientas (Temas 6, 8 y 9) | Planes gratuitos |

**Principio:** la nube es un destino de despliegue, no una dependencia del aprendizaje. Si una cuenta falla, el laboratorio se completa con Codespaces + Docker + GHCR ([Plan B](nube/plan-b.md)).

## 10. Comunicación

| Para… | Canal |
|---|---|
| Fechas, avisos y calificaciones | Aula virtual (las fechas del aula prevalecen sobre cualquier otra fuente) |
| Entregar actividades | Aula virtual |
| Preguntas al profesor (también errores en este repositorio) | Foro **"Pregúntale a tu profesor"** del aula |
| Resolver dudas en vivo | Clases síncronas por Zoom |
| Material complementario y proyecto | Este repositorio (solo lectura; no es canal de contacto) |

En el repositorio no hay *issues*, *discussions* ni correo de contacto del profesor. Los PR de estudiantes se abren **dentro de su propio fork**, no hacia este repositorio.

## 11. Riesgos y contingencias

| Riesgo | Respuesta |
|---|---|
| La activación de Azure for Students o AWS Educate tarda o falla | Alta en la semana 1; Plan B con Codespaces + GHCR; una sola suscripción por equipo |
| Los laboratorios de AWS Educate no permiten credenciales para el pipeline | Ruta AWS manual y guiada en consola; la automatización completa se hace en Azure |
| Estudiantes sin Docker en su equipo | GitHub Codespaces incluye Docker y funciona desde el navegador |
| Consumo de crédito por recursos olvidados | Plan F1, etiquetas, escalado a cero y script de limpieza en la semana 8 |
| El proyecto compite con las actividades del aula | Nivel base corto; las semanas de entrega (4 y 7) priorizan la actividad |
| Confusión de fechas entre repositorio y aula | Aviso en cada guía: las fechas del aula prevalecen |
| Conexión inestable en el simulacro | Wooclap funciona desde el navegador o el celular; quien no pueda conectarse sigue las preguntas en la pantalla compartida |

## 12. Pendientes de confirmar con la coordinación

- ~~Día y hora de las clases síncronas.~~ Confirmado: jueves a las 20:00 h (clases 1 a 7). La clase 8 se programará entre el lunes 25 y el miércoles 27 de enero según la disponibilidad del grupo y del docente.
- Fecha y hora del examen final (semana 8) y si hay restricción para hacer el simulacro en la clase 8.
- Licencia institucional de Wooclap (el modo competición en vivo y el número de participantes dependen del plan).
- Si la institución puede habilitar un aula de AWS Academy para la asignatura.

## 13. Referencias base

- Humble, J. y Farley, D. (2010). *Continuous Delivery*. Addison-Wesley.
- Forsgren, N., Humble, J. y Kim, G. (2018). *Accelerate*. IT Revolution Press.
- Fowler, M. (2006). *Continuous Integration*. martinfowler.com.
- Vocke, H. (2018). *The Practical Test Pyramid*. martinfowler.com.
- Driessen, V. (2010). *A successful Git branching model*. nvie.com.
- Temario oficial de la asignatura, Temas 1 a 10 (UNIR).
