# Semana 4 · 14 – 18 de diciembre de 2026

**Tema:** T6 Evaluación y calidad del código
**Clase 4** y resolución de la actividad 1 (90 min) · día y hora: consulta el aula virtual
**En el aula esta semana:** **entrega de la actividad 1** (según la programación, 14/12) · microtests 6.1–6.8
**Pregunta guía:** ¿Debe fusionarse un PR que pasa las pruebas pero baja la cobertura?

> Las fechas vigentes son siempre las del aula virtual. Dudas: foro "Pregúntale a tu profesor".

## Propósito

Añadir señales de calidad que no dependen del comportamiento funcional (estilo, cobertura, revisión humana, análisis estático) y acordarlas como equipo antes de convertirlas en una puerta automática. Cierra el primer bloque del curso.

## Antes de la sesión

- Tema 6 completo: métricas de Accelerate (6.2), revisiones de código (6.3 y 6.4), convenciones de estilo (6.5), cobertura (6.6) y SonarQube (6.7 y 6.8).
- Ejecutar `make coverage` y abrir `htmlcov/index.html`. Hay líneas de `app/main.py` sin cubrir **a propósito**.

## Clase 4 (90 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | Las cuatro métricas (frecuencia, tiempo de entrega, MTTR, tasa de fallos) | Velocidad y estabilidad no se oponen |
| 10–20 | Revisión de código en un PR real: comentarios, sugerencias, *request changes* | Un PR es una conversación con evidencia |
| 20–32 | Umbral absoluto vs. "la cobertura no baja" (Tema 4.5 y 6.6) | La regla debe ser evidente y acordada |
| 32–45 | Demo: quality gate en el PR y vista de SonarQube Cloud | Varias señales, una sola pantalla |
| 45–80 | **Resolución de la actividad 1**: el flujo completo en vivo, errores frecuentes y preguntas | El PR conecta dos repositorios con permisos distintos |
| 80–90 | Retrospectiva del bloque I y plan para el periodo no lectivo | — |

## Laboratorio

### Nivel base

1. Copia `pipelines/github-actions/semana-04-quality-gate.yml` a `.github/workflows/quality.yml`. Ajusta `COVERAGE_MIN` al valor que acuerde tu equipo.
2. Encuentra las líneas sin cubrir de `app/main.py` (informe de cobertura) y escribe las pruebas que faltan.
3. **Revisión entre pares**: pide a otra persona (de tu equipo o de otro equipo) que revise tu PR. En la regla de `main` exige 1 aprobación.
4. Retrospectiva del bloque I en la bitácora: qué mejoró, qué duele, qué sigue. Repite el diagnóstico de madurez solo en las dimensiones que cambiaron.

### Nivel intermedio

- Crea un archivo `CODEOWNERS` para que ciertas rutas (por ejemplo `.github/` y `app/cart.py`) pidan revisión automática.
- Añade un formateador o linter más estricto (`black --check` o `ruff`) y documenta en la bitácora cuántos avisos aparecieron y cómo decidieron tratarlos (Tema 6.5: corregir poco a poco antes de bloquear).

### Nivel avanzado

- **SonarQube Cloud** (gratuito para repositorios públicos): importa tu fork, completa `sonar-project.properties`, guarda el secreto `SONAR_TOKEN` y verifica el análisis en el PR.
- Define un *quality gate* que bloquee si aparecen *bugs* nuevos o duplicación en el código nuevo.
- Mide en tu fork dos de las cuatro métricas de Accelerate con los datos de GitHub (frecuencia de fusión a `main`, tiempo desde el primer commit del PR hasta la fusión).

## Evidencia de la semana (en tu bitácora; no se entrega)

- PR con el quality gate activo y revisado por otra persona.
- Cobertura antes y después.
- Retrospectiva del bloque I en la bitácora.

## Preguntas para reflexionar

1. Responde la pregunta guía con un argumento a favor y uno en contra.
2. ¿Qué métrica de calidad podría "engañarse" y qué comportamiento indeseado provocaría (Tema 6.2, "todos son responsables")?

## Notas para el docente

- Esta es la última clase antes del periodo no lectivo: dejar claro que en ese periodo no hay clases.
- Para la resolución de la actividad 1, tener preparado un fork de demostración y un PR de ejemplo.
- Publicar en el aula el aviso con las actividades opcionales del [receso](receso.md).
