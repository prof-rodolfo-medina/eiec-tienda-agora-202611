# Semana 2 · 30 de noviembre – 6 de diciembre de 2026

**Temas:** T3 Flujos de trabajo con Git · T4 Fases de la entrega continua
**Sesión síncrona (propuesta):** jueves 3 de diciembre
**Pregunta guía:** ¿Qué tiene que pasar para que un cambio pueda entrar en `main`?

## Propósito

Convertir `main` en una rama siempre desplegable: todo cambio entra por Pull Request y solo si la fase de commit (Tema 4) termina en verde.

## Antes de la sesión

- Tema 3: 3.3 flujos (centralizado, feature branching, Gitflow, GitHub flow, state branching) y 3.4 pull requests.
- Tema 4: 4.2 a 4.5 (qué es un pipeline, compilación única, smoke test, fase de commit, feedback en menos de 10 minutos).
- Abrir `.github/workflows/ci.yml` y señalar qué paso corresponde a cada actividad de la fase de commit.

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | Flujos de Git: ¿cuál conviene a Tienda Ágora? Trunk-based vs. Gitflow | El flujo es una plantilla que el equipo adapta |
| 10–20 | Anatomía de `ci.yml`: disparadores, job, pasos, artefacto de informes | El pipeline es código versionado junto a la app |
| 20–30 | Demo: proteger `main` y exigir el check `commit-stage` | Las reglas viven en la plataforma, no en la buena voluntad |
| 30–42 | Demo: PR rojo (rompo `/health`) y PR verde; leer el log | Rojo no castiga: informa dónde se rompió la promesa |
| 42–50 | Laboratorio y niveles | — |

## Laboratorio

### Nivel base

1. En tu fork: **Settings → Branches → Add branch ruleset** (o *branch protection rule*) para `main`:
   - Exigir Pull Request antes de fusionar.
   - Exigir que pase el check **commit-stage**.
   - Bloquear *force push*.
2. Crea `semana-02/pr-rojo`, cambia `/health` para que devuelva `{"status": "fail"}`, abre el PR y observa cómo el check bloquea la fusión. Copia en la bitácora la línea del log que explica el fallo. Cierra el PR sin fusionar.
3. Crea `semana-02/pr-verde` con un cambio correcto (por ejemplo, un producto nuevo en el catálogo y su prueba), espera el verde y fusiona.

### Nivel intermedio

Aplica el principio de **compilación única** (Tema 4.3) dentro de la fase de commit: añade a `ci.yml` un paso que empaquete la app una sola vez y la publique como artefacto con el SHA en el nombre.

```yaml
      - name: Empaquetar una vez
        run: zip -r agora-${{ github.sha }}.zip app requirements.txt
      - uses: actions/upload-artifact@v7
        with:
          name: paquete-${{ github.sha }}
          path: agora-${{ github.sha }}.zip
```

### Nivel avanzado

- Agrega `concurrency` con `cancel-in-progress: true` para cancelar runs obsoletos de la misma rama.
- Agrega una matriz con Python 3.11 y 3.12 y discute en la bitácora si vale el tiempo extra de feedback.
- Mide la duración del run: ¿cumple la meta de menos de 10 minutos? ¿Qué paso es el más lento?

## Evidencia de la semana

- Captura o enlace de la regla de protección de `main`.
- Enlace al PR rojo (cerrado) y al PR verde (fusionado) con sus runs.
- En la bitácora: qué flujo de ramas eligieron y por qué.

## Preguntas para reflexionar

1. ¿Qué ventaja y qué costo tiene ejecutar el pipeline sobre el PR y otra vez sobre `main` (Tema 4.3)?
2. ¿Quién debería ser "dueño" de la fase de commit en un equipo y por qué?

## Notas para el docente

- Preparar en el repositorio del curso las ramas `demo/s2-rojo` y `demo/s2-verde` con sus PR abiertos por si GitHub Actions tarda.
- Si un estudiante no ve el check para exigirlo, debe ejecutar el workflow al menos una vez en su fork.
