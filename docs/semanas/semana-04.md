# Semana 4 · 14 – 20 de diciembre de 2026

**Tema:** T6 Evaluación y calidad del código
**Sesión síncrona (propuesta):** jueves 17 de diciembre
**Pregunta guía:** ¿Debe fusionarse un PR que pasa las pruebas pero baja la cobertura?

## Propósito

Añadir señales de calidad que no dependen del comportamiento funcional (estilo, cobertura, revisión humana, análisis estático) y acordarlas como equipo antes de convertirlas en una puerta automática. Cierra el primer bloque del curso.

## Antes de la sesión

- Tema 6 completo: métricas de Accelerate (6.2), revisiones de código (6.3 y 6.4), convenciones de estilo (6.5), cobertura (6.6) y SonarQube (6.7 y 6.8).
- Ejecutar `make coverage` y abrir `htmlcov/index.html`. Hay líneas de `app/main.py` sin cubrir **a propósito**.

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | Las cuatro métricas (frecuencia, tiempo de entrega, MTTR, tasa de fallos) | Velocidad y estabilidad no se oponen |
| 10–20 | Revisión de código en un PR real: comentarios, sugerencias, *request changes* | Un PR es una conversación con evidencia |
| 20–32 | Umbral absoluto vs. "la cobertura no baja" (Tema 4.5 y 6.6) | La regla debe ser evidente y acordada |
| 32–42 | Demo: quality gate en el PR y vista de SonarQube Cloud | Varias señales, una sola pantalla |
| 42–50 | Retrospectiva del bloque I y plan para el receso | — |

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

## Evidencia de la semana

- PR con el quality gate activo y revisado por otra persona.
- Cobertura antes y después.
- Retrospectiva del bloque I en la bitácora.

## Preguntas para reflexionar

1. Responde la pregunta guía con un argumento a favor y uno en contra.
2. ¿Qué métrica de calidad podría "engañarse" y qué comportamiento indeseado provocaría (Tema 6.2, "todos son responsables")?

## Notas para el docente

- Esta es la última sesión antes del receso: dejar claro que el receso no tiene entregas.
- Publicar en Moodle las actividades opcionales del [receso](receso.md).
