# Actividades del aula y proyecto Tienda Ágora

> [!IMPORTANT]
> Los **enunciados oficiales, las fechas y las entregas** de las actividades están en el **aula virtual**. Esta página solo explica cómo el proyecto te ayuda a prepararlas. No reproduce los enunciados ni publica soluciones. Si algo aquí no coincide con el aula, **vale el aula**.

## Resumen de la evaluación continua

La suma de todas las actividades es de **15 puntos**; puedes hacer las que prefieras hasta conseguir un **máximo de 10** en la evaluación continua.

| Actividad | Puntos | Se presenta | Entrega* | Se resuelve |
|---|---|---|---|---|
| Actividad 1. Caso práctico: pull requests en GitHub | 6.0 | Clase 2 | 14/12/2026 | Clase 4 |
| Actividad 2. Caso práctico: primer servidor de Jenkins y primer pipeline | 5.0 | Clase 5 | 18/01/2027 | Clase 7 |
| Microtests 1.1 a 10.5 (54) | 4.0 | Con cada tema | 31/01/2027 | — |

\* Según la programación semanal publicada. Revisa siempre el aula.

El proyecto Tienda Ágora **no suma puntos**: es tu espacio para practicar con más profundidad lo que piden las actividades y el examen.

## Actividad 1 · Pull requests en GitHub

**Qué ejercita:** el flujo de GitHub con forks y pull requests (Tema 3): un repositorio principal, una persona colaboradora sin permiso de escritura y un cambio que llega por PR.

**Cómo te prepara Tienda Ágora**

| Semana | Lo que haces en el proyecto | Concepto que llevas a la actividad |
|---|---|---|
| 1 | Fork del repositorio del curso, clonado, rama de trabajo, commit y PR de registro **dentro de tu fork** | Diferencia entre `origin` (tu fork) y el repositorio original; ciclo rama → commit → push → PR |
| 2 | PR rojo y PR verde con un check obligatorio en `main` | Un PR es una propuesta revisable; la plataforma decide si se puede fusionar |

**Antes de entregar, comprueba que sabes explicar:**

- Por qué la persona colaboradora necesita un fork.
- Qué repositorio es el origen y cuál el destino del PR.
- Desde qué rama trabajaste y por qué no conviene trabajar en la rama principal.

## Actividad 2 · Primer servidor de Jenkins y primer pipeline

**Qué ejercita:** la arquitectura de Jenkins (controlador, agentes, etiquetas), un trabajo de tipo *Pipeline* definido en un Jenkinsfile del repositorio y la lectura de sus resultados (Tema 7).

**Cómo te prepara Tienda Ágora**

| Semana | Lo que haces en el proyecto | Concepto que llevas a la actividad |
|---|---|---|
| 2 | Lees `ci.yml` fase por fase | Un pipeline es código versionado con fases que se detienen ante un fallo |
| 3 | Separas baterías de pruebas y publicas informes JUnit | Por qué Jenkins puede mostrar *Test Results* |
| 5 | Ejecutas el pipeline de Tienda Ágora en Jenkins (`pipelines/jenkins/`) | *Pipeline script from SCM*, *Stage View*, *Console Output*, artefactos |

**Recomendación:** monta primero la infraestructura que indica el enunciado de la actividad y entrégala; después, como nivel intermedio, apunta tu Jenkins a tu fork de Tienda Ágora.

**Requisitos técnicos:** Docker en tu equipo o en un GitHub Codespace. Si no puedes instalar Docker, pregunta en el foro "Pregúntale a tu profesor" con tiempo.

## Microtests

Cada guía semanal indica qué apartados del tema leer **antes** de la clase. Hacer los microtests del tema esa misma semana es la mejor preparación para el examen; todos cierran el 31/01/2027 (consulta el aula).

## Dudas

En el foro **"Pregúntale a tu profesor"** del aula o en la clase síncrona. Ver [SUPPORT.md](../../SUPPORT.md).
