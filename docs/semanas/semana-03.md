# Semana 3 · 7 – 13 de diciembre de 2026

**Tema:** T5 Pruebas
**Sesión síncrona (propuesta):** jueves 10 de diciembre
**Pregunta guía:** Si una prueba es una promesa ejecutable, ¿qué promesas hace hoy Tienda Ágora?

## Propósito

Usar la pirámide de pruebas para decidir qué probar y dónde, separar las baterías para paralelizarlas y entregar informes que el desarrollador pueda leer sin entrar al servidor de CI.

## Antes de la sesión

- Tema 5 completo, en especial 5.3 (tipos de pruebas), 5.4 (automatización: versionar, paralelizar, separar baterías, cuarentena) y 5.5 (caso práctico).
- Revisar en el repositorio: `tests/unit`, `tests/api`, `tests/smoke`, los marcadores en `pytest.ini` y el `conftest.py`.

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–8 | La pirámide aplicada a Tienda Ágora: ¿qué hay en cada nivel? | Muchas unitarias, menos de API, pocas de humo |
| 8–18 | Unitaria sobre `CartStore` vs. prueba de API del flujo de carrito | La unitaria localiza; la de API protege el contrato |
| 18–28 | Marcadores, fixtures y el `conftest.py` que aísla cada prueba | Una prueba que depende de otra es una prueba frágil |
| 28–40 | Demo: dividir el pipeline en jobs `unit` y `api` en paralelo con informes JUnit | Paralelizar acorta el feedback |
| 40–50 | Laboratorio: elegir una historia del backlog | — |

## Laboratorio

### Nivel base

Elige **una** historia del [backlog](../proyecto/enunciado.md#backlog) (por ejemplo `GET /products/count` o `GET /products?search=café`) y desarróllala con pruebas primero:

1. Escribe la prueba unitaria y la de API; verifica que fallan (`python -m pytest -q -m unit`).
2. Implementa lo mínimo para que pasen.
3. Abre el PR; el pipeline debe quedar verde.

> Si eliges `/products/count`, cuidado con el orden de rutas: FastAPI evalúa en orden y `/products/{product_id}` podría capturar `count`. Es una buena microlección de diseño de rutas.

### Nivel intermedio

Separa la fase de commit en jobs que corran en paralelo, cada uno con su informe:

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps: [ ... flake8 ... ]
  unit:
    needs: lint
    runs-on: ubuntu-latest
    steps: [ ... python -m pytest -m unit --junitxml=reports/unit.xml ... ]
  api:
    needs: lint
    runs-on: ubuntu-latest
    steps: [ ... python -m pytest -m api --junitxml=reports/api.xml ... ]
```

Publica los XML con `actions/upload-artifact` y, si quieres verlos en el resumen del run, con una acción de informes JUnit.

### Nivel avanzado

- **Pruebas de aceptación** en lenguaje natural (Tema 5.3) con `pytest-bdd`: un escenario *Dado / Cuando / Entonces* para "comprar con código de descuento".
- **Cuarentena** (Tema 5.4): marca una prueba como `@pytest.mark.skip(reason=...)` con un issue asociado y explica cuándo se justifica.
- Ejecuta los smoke tests contra tu API local: `make run` en una terminal y `make smoke` en otra.

## Evidencia de la semana

- PR de la historia con pruebas unitarias y de API.
- Run del pipeline con informes JUnit publicados.
- En la bitácora: qué promesa nueva hace tu API y qué prueba la protege.

## Preguntas para reflexionar

1. ¿Qué prueba de Tienda Ágora es más frágil y por qué? (pista: dependencia de datos exactos del catálogo).
2. ¿Qué debería pasar con un PR cuyas pruebas pasan pero añade código sin probar? (puente a la semana 4).

## Notas para el docente

- Material de la edición anterior reutilizable: guion del Tema 5 con la demo roja/verde de `/health`.
- Tener lista una rama con `/products/count` mal ordenado para mostrar el error 422.
