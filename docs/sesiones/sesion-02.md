# Clase 2 · Flujos con Git, fases de la entrega continua y actividad 1

**Semana 2 · 30 de noviembre – 4 de diciembre de 2026** · Clase por Zoom, 60 min · Día y hora: **consulta el aula virtual**
**Guía de la semana:** [semana-02.md](../semanas/semana-02.md)
**Pregunta guía:** ¿Qué tiene que pasar para que un cambio pueda entrar en `main`?

> Las fechas vigentes son siempre las del aula. Las actividades se entregan en el aula. Contacto: foro "Pregúntale a tu profesor" y las clases por Zoom. Este repositorio es complementario y no es canal de contacto.

## Objetivos

1. Comparar los flujos de trabajo con Git y justificar cuál conviene a Tienda Ágora (Tema 3).
2. Leer `ci.yml` como la fase de commit de un pipeline: disparadores, job, pasos y artefacto (Tema 4).
3. Proteger `main` para que solo entre por Pull Request y con el check `commit-stage` en verde.
4. Leer el log de un PR en rojo y fusionar un PR en verde.
5. Conocer qué ejercita la actividad 1 y qué conceptos necesitas para resolverla.

## Agenda

| Min | Bloque | Mensaje clave |
|---|---|---|
| 0–10 | Flujos de Git: trunk-based vs. Gitflow, ¿cuál conviene a Ágora? | El flujo es una plantilla que el equipo adapta |
| 10–20 | Anatomía de `ci.yml`: disparadores, job, pasos, artefacto | El pipeline es código versionado junto a la app |
| 20–30 | Demo: proteger `main` y exigir el check `commit-stage` | Las reglas viven en la plataforma, no en la buena voluntad |
| 30–42 | Demo: PR rojo (se rompe `/health`) y PR verde; leer el log | Rojo no castiga: informa dónde se rompió la promesa |
| 42–50 | Laboratorio y niveles | — |
| 50–60 | Presentación de la actividad 1 | Lo que practicas en tu fork es el mismo flujo |

## Ideas clave

**Tema 3 · Flujos de trabajo con Git**

- Los flujos (centralizado, feature branching, Gitflow, GitHub flow, state branching) son plantillas que cada equipo adapta; lo habitual son flujos híbridos.
- Trunk-based (ramas cortas hacia `main`) reduce conflictos y encaja con la entrega continua, pero exige pruebas fiables, cambios pequeños y feature flags. Gitflow encaja con versiones planificadas y se desaconseja para despliegue continuo.
- El pull request es una funcionalidad de la plataforma, no de Git. Puede abrirse entre forks o entre ramas de un mismo repositorio, por ejemplo para proteger `main`.
- En Tienda Ágora: ramas cortas con la convención `semana-NN/descripcion-corta` hacia `main` por PR ([equipos.md](../proyecto/equipos.md)).

**Tema 4 · Fases de la entrega continua**

- Un pipeline mueve el código y los artefactos entre fases de forma automática, se repite con cada cambio y se detiene ante un fallo.
- La fase de commit descarta versiones que rompen, da feedback rápido (meta: menos de 10 minutos) y genera los paquetes para las fases siguientes.
- Compilación única: se empaqueta una vez y ese mismo paquete recorre todo el pipeline.
- Ejecutar el pipeline sobre el PR evita que entre en `main` algo sin probar; el costo es que hay que repetir las pruebas sobre `main` tras fusionar.
- El nombre del job (`commit-stage`) es el check que exige la regla de `main`.

## Comandos y pasos de las demostraciones

Proteger `main` en **tu fork**: *Settings → Rules → Rulesets → New ruleset → New branch ruleset* (o *Settings → Branches → Add branch ruleset*):

- *Enforcement status*: **Active** · *Target branches*: **Include default branch**.
- **Require a pull request before merging** (*Required approvals*: 0 si trabajas sola o solo; 1 en equipo).
- **Require status checks to pass** → *Add checks* → `commit-stage`. Si no aparece, ejecuta antes el workflow una vez (*Actions → Run workflow*).
- **Restrict deletions** y **Block force pushes** marcadas.

PR rojo:

```bash
git switch main && git pull
git switch -c semana-02/pr-rojo
# en app/main.py, el endpoint /health devuelve {"status": "fail"}
make lint test                       # verás el fallo en local
git commit -am "Rompe /health a propósito (PR rojo)"
git push -u origin semana-02/pr-rojo
gh pr create --repo TU_USUARIO/eiec-tienda-agora-202611 --base main --head semana-02/pr-rojo --fill
```

PR verde:

```bash
git switch main && git pull
git switch -c semana-02/pr-verde
# un producto nuevo en app/products.py y su prueba en tests/unit/test_products.py
make lint test
git add -A && git commit -m "Agrega un producto al catálogo con su prueba"
git push -u origin semana-02/pr-verde
gh pr create --repo TU_USUARIO/eiec-tienda-agora-202611 --base main --head semana-02/pr-verde --fill
gh pr merge --repo TU_USUARIO/eiec-tienda-agora-202611 --squash --delete-branch   # cuando esté en verde
```

> [!WARNING]
> En un fork, tanto el botón **Compare & pull request** como `gh pr create` proponen por omisión el repositorio del curso como destino. Cambia *base repository* a tu fork o usa `--repo`. Los PR se abren **dentro de tu fork**.

Cómo leer el log del PR rojo: paso en rojo → prueba que falló → línea `E` (esperado frente a obtenido) → archivo y línea. Por ejemplo:

```text
E       AssertionError: assert {'status': 'fail'} == {'status': 'ok'}
tests/api/test_api.py:12: AssertionError
FAILED tests/api/test_api.py::test_health_endpoint_returns_ok - AssertionErro...
```

## Laboratorio (resumen)

- **Base:** `main` protegida; PR rojo bloqueado y cerrado sin fusionar; PR verde fusionado.
- **Intermedio:** compilación única: empaquetar la app una vez y publicarla como artefacto con el SHA en el nombre.
- **Avanzado:** `concurrency` con `cancel-in-progress`; matriz Python 3.11 y 3.12; duración del run.
  - Con la matriz, el check pasa a llamarse `commit-stage (3.11)` y `commit-stage (3.12)`: actualiza los checks exigidos en la regla de `main`. Y cada artefacto necesita un nombre único.

Detalle y fragmentos de YAML en la [guía de la semana](../semanas/semana-02.md).

## Actividad 1 · Pull requests en GitHub

- **Qué ejercita:** el flujo de GitHub con forks y pull requests (Tema 3): un repositorio principal, una persona colaboradora sin permiso de escritura y un cambio que llega por PR.
- **Valor:** 6 puntos. Se presentó en esta clase y se resuelve en la clase 4.
- **Enunciado, entregables y fecha de entrega: consulta el aula.** Se entrega en el aula.

Antes de entregar, comprueba que sabes explicar:

- Por qué la persona colaboradora necesita un fork.
- Qué repositorio es el origen y cuál el destino del PR.
- Desde qué rama trabajaste y por qué no conviene trabajar en la rama principal.

Más en [actividades](../actividades/README.md).

## Tareas de la semana

- [ ] `main` protegida en tu fork con el check `commit-stage`.
- [ ] PR rojo cerrado sin fusionar y PR verde fusionado.
- [ ] La línea del log que explica el fallo, en tu `BITACORA.md`.
- [ ] Leer el enunciado de la actividad 1 en el aula (entregables y fecha: consulta el aula).
- [ ] Microtests del aula: Tema 3 (3.1 a 3.4) y Tema 4 (4.1 a 4.5). Fecha de cierre: consulta el aula.

**Pregunta de reflexión:** ¿Qué ventaja y qué costo tiene ejecutar el pipeline sobre el PR y otra vez sobre `main`? Respóndela en la entrada de la semana 2 de tu bitácora.

## Próxima clase

Clase 3 (60 min): Tema 5 (pruebas). La pirámide aplicada a Tienda Ágora y las baterías `unit` y `api` en jobs paralelos con informes JUnit; los últimos 10 minutos, dudas de la actividad 1. Lectura previa: Tema 5 (5.3 a 5.5). Ven con `main` protegida.
