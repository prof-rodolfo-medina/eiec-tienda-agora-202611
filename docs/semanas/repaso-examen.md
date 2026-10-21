# Guía de repaso para el examen final

**Examen:** jueves 28 o viernes 29 de enero de 2027 (semana 8)

El examen evalúa el temario de la asignatura (Temas 1 a 10). Esta guía conecta cada tema con lo que construiste en Tienda Ágora: si puedes explicar **por qué** tu pipeline tiene cada pieza, tienes buena parte del repaso hecho. Para cada tema: las ideas clave, dónde las aplicaste y preguntas para autoevaluarte.

> Esta guía orienta el estudio; no sustituye la lectura de los temas ni anticipa el formato del examen.

---

## Tema 1 · Introducción

**Ideas clave**
- ALM tiene tres aspectos: gobierno, desarrollo y operaciones. Es más amplio que el ciclo de vida de desarrollo (SDLC).
- Antipatrones: despliegue manual, desplegar en producción solo al terminar el desarrollo, gestión manual de la configuración de producción.
- **Integración continua** (integrar y verificar cada cambio con construcción y pruebas automáticas), **entrega continua** (el software está siempre listo para desplegarse) y **despliegue continuo** (cada cambio validado llega a producción) no son sinónimos.
- Requisitos para empezar: control de versiones, construcción automática, batería de pruebas completa y aceptación del equipo.
- Modelo de madurez de Humble y Farley: de nivel −1 (regresivo) a 3 (optimizado).

**En Tienda Ágora:** tu diagnóstico de madurez de las semanas 1 y 8.

**Autoevaluación**
1. ¿Por qué un despliegue con scripts sigue siendo "manual" si cada paso lo ejecuta una persona distinta?
2. Da un motivo de negocio para tener entrega continua sin despliegue continuo.
3. ¿Qué tres operaciones debería limitarse a hacer una persona en un despliegue bien automatizado?

## Tema 2 · Control de versiones

**Ideas clave**
- Vocabulario: repositorio, copia de trabajo, commit, rama, etiqueta, fusión, conflicto, rollback.
- Ventajas: edición simultánea, "viajar en el tiempo" (*diff debugging*), todo el proyecto en el repositorio.
- Qué **no** se versiona: artefactos generados (binarios, informes, paquetes). Sí se versionan scripts, configuración, pruebas y migraciones de base de datos.
- Buenas prácticas: commits pequeños y frecuentes, mensajes descriptivos, cada commit probado, un único código base (no duplicar por cliente).

**En Tienda Ágora:** `.gitignore`, el laboratorio de `git bisect`, las convenciones de `CONTRIBUTING.md`.

**Autoevaluación**
1. ¿Por qué `git bisect` es más eficaz cuando los commits son pequeños?
2. ¿Cómo se versiona una base de datos si la base de datos en sí no se versiona?
3. ¿Qué riesgo tiene crear una rama permanente por cada cliente?

## Tema 3 · Flujos de trabajo con Git

**Ideas clave**
- Sistemas locales, centralizados y distribuidos.
- Flujos: centralizado (*mainline*), *feature branching*, Gitflow (ramas `develop`, `release-*`, `hotfix-*`), flujo de GitHub con forks y pull requests, *state branching*.
- Gitflow encaja con versiones programadas; no es recomendable para despliegue continuo.
- Las pull requests son una función de la plataforma, no de Git.

**En Tienda Ágora:** tu fork, las ramas por semana y los PR.

**Autoevaluación**
1. ¿Qué flujo elegirías para un proyecto de código abierto con colaboradores desconocidos, y por qué?
2. ¿En qué se diferencian una rama `release-*` y una `hotfix-*` en Gitflow?
3. ¿Por qué la construcción de un PR puede dejar de ser válida después de fusionar otro PR?

## Tema 4 · Fases de la entrega continua

**Ideas clave**
- Pipeline: fases encadenadas que se repiten automáticamente; cada fase es una llave de paso que se detiene ante un fallo.
- Buenas prácticas: **compilación única**, mismo proceso de despliegue en todos los entornos, smoke test tras desplegar, entornos parecidos a producción, detener el pipeline ante fallos.
- Fase de commit: compilación, pruebas unitarias, análisis de código y empaquetado; feedback en menos de 10 minutos.
- Umbrales de métricas: mejor exigir que no empeoren que imponer un absoluto inalcanzable. Rol de *build master*.

**En Tienda Ágora:** `ci.yml`, el empaquetado único y `scripts/smoke_test.sh`.

**Autoevaluación**
1. ¿Qué puede salir mal si se compila el mismo commit varias veces a lo largo del pipeline?
2. ¿Qué debe verificar un buen smoke test, además de que el proceso esté en ejecución?
3. ¿Por qué se recomienda un script por fase?

## Tema 5 · Pruebas

**Ideas clave**
- Tipos: unitarias, de integración (sistema/servicio), de interfaz (GUI/E2E), de aceptación, smoke tests, manuales, de rendimiento y de seguridad.
- Pirámide de pruebas: muchas unitarias, rápidas y aisladas; pocas de interfaz, lentas y más integradas.
- Técnicas: *mocks*, *fixtures*, datos semilla.
- Automatización: versionar las pruebas, paralelizar, separar baterías, poner en cuarentena las pruebas erráticas, informes en formato JUnit.

**En Tienda Ágora:** `tests/unit`, `tests/api`, `tests/smoke`, los marcadores de `pytest.ini` y el `conftest.py`.

**Autoevaluación**
1. ¿Qué diferencia una prueba unitaria de una de API en tu proyecto? Da un ejemplo de cada una.
2. ¿Por qué deshabilitar una prueba errática es mejor que borrarla?
3. ¿Qué es una fixture y qué problema resuelve en las pruebas de integración?

## Tema 6 · Evaluación y calidad del código

**Ideas clave**
- Métricas de Forsgren, Humble y Kim (*Accelerate*): tiempo de entrega, frecuencia de despliegue, tiempo medio de recuperación y tasa de cambios fallidos. Velocidad y estabilidad mejoran juntas.
- Revisiones de código: qué buscan y qué beneficios aportan.
- Convenciones de estilo (PEP 8, Checkstyle), validadores y formateadores.
- Cobertura de pruebas y sus límites; SonarQube: perfiles, quality gates, *code smells*, complejidad ciclomática.

**En Tienda Ágora:** el quality gate de cobertura, la revisión entre pares y SonarQube Cloud.

**Autoevaluación**
1. Enumera las cuatro métricas y explica qué mide cada una.
2. ¿Por qué un 100 % de cobertura no garantiza ausencia de errores?
3. ¿Cómo introducirías un validador de estilo en un proyecto que nunca lo tuvo, sin frenar al equipo?

## Tema 7 · Jenkins

**Ideas clave**
- Arquitectura: controlador (*master*) y agentes; ejecutores; etiquetas para elegir agente.
- Estructura de un trabajo: disparadores, parámetros, tareas, tareas de finalización y artefactos.
- Disparadores por consulta periódica (`pollSCM`) frente a webhooks.
- Jenkinsfile: pipeline como código; sintaxis declarativa frente a *scripted*.

**En Tienda Ágora:** `pipelines/jenkins/Jenkinsfile` y tu tabla de equivalencias con GitHub Actions.

**Autoevaluación**
1. ¿Por qué no se recomienda que el controlador ejecute trabajos en un entorno profesional?
2. ¿Qué ventajas tiene un Jenkinsfile frente a un trabajo definido en formularios web?
3. ¿Cuándo usarías `pollSCM` en lugar de un webhook?

## Tema 8 · GitLab

**Ideas clave**
- GitLab integra repositorio, gestión de proyectos, CI/CD y registros de paquetes y contenedores.
- `.gitlab-ci.yml`: etapas (*stages*), trabajos y *runners*; cada trabajo corre en un runner distinto y comparte archivos mediante artefactos.
- El registro de contenedores es la fuente de verdad de las versiones publicadas; políticas de retención.

**En Tienda Ágora:** `pipelines/gitlab/.gitlab-ci.yml`.

**Autoevaluación**
1. ¿Qué implica que cada trabajo de GitLab se ejecute en un runner distinto?
2. Compara el `.gitlab-ci.yml` con un Jenkinsfile: una semejanza y una diferencia.

## Tema 9 · Otras herramientas de CI/CD

**Ideas clave**
- Bitbucket (repositorios integrados con Atlassian), CircleCI (CI/CD como servicio con plantillas), Nexus (repositorio privado de artefactos).
- Elegir herramientas mal puede generar deuda técnica de infraestructura a largo plazo.

**En Tienda Ágora:** la imagen versionada en GHCR, el manifiesto de la versión y `pipelines/circleci/config.yml`.

**Autoevaluación**
1. ¿Para qué sirve un repositorio de artefactos como Nexus si ya existe el control de versiones?
2. ¿Qué criterios usarías para elegir entre Jenkins, GitLab CI/CD y CircleCI?

## Tema 10 · Modelos de despliegue

**Ideas clave**
- Retos del despliegue continuo: seguir dando servicio durante el despliegue, un staging parecido a producción y la capacidad de marcha atrás. La marcha atrás exige especial cuidado cuando la versión cambia el esquema de datos o cuando se actualizan a la vez servicios que dependen entre sí.
- Tres modelos sin corte de servicio: **blue/green** (cambio rápido de todo el tráfico), **canary releasing** (unos pocos servidores con la versión nueva reciben un porcentaje del tráfico) y **despliegue incremental** o *rolling upgrade* (los servidores se sustituyen poco a poco). En la práctica se combinan.
- Canary no es lo mismo que una prueba A/B: el canario busca reducir el riesgo de una versión pensada para quedarse.
- **Feature flags**: desacoplan el despliegue de la activación de la funcionalidad; pueden ser temporales o permanentes.
- Actualización incremental con `Deployment` de Kubernetes: `maxUnavailable` y la sonda `readinessProbe`, que actúa como smoke test.

**En Tienda Ágora:** staging → aprobación → producción, `FEATURE_DISCOUNT_CODES` y el canary con Container Apps.

**Autoevaluación**
1. Compara blue/green y canary: costo en recursos, velocidad y riesgo.
2. ¿Por qué staging debe mantener al menos la misma complejidad que producción (por ejemplo, más de un servidor tras un balanceador)?
3. ¿Qué diferencia hay entre desplegar una versión y liberar una funcionalidad?
4. ¿Por qué un cambio de esquema de base de datos complica la marcha atrás?

---

## Repaso en una sola imagen

Si puedes recorrer este flujo y nombrar el tema que explica cada paso, tienes una buena visión del curso:

```text
commit (T2) → PR y flujo de ramas (T3) → fase de commit (T4)
→ pruebas unitarias y de API (T5) → quality gate (T6)
→ el mismo pipeline en Jenkins o GitLab (T7, T8)
→ artefacto versionado en un registro (T9)
→ staging → producción → canary / feature flags / rollback (T10)
→ ¿en qué nivel de madurez estamos? (T1)
```
