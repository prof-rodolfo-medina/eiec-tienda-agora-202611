# Semana 1 · 23 – 29 de noviembre de 2026

**Temas:** T1 Introducción a la integración y entrega continuas · T2 Control de versiones
**Sesión síncrona (propuesta):** jueves 26 de noviembre
**Pregunta guía:** ¿Qué le falta a Tienda Ágora para poder entregarse con confianza cualquier día?

## Propósito

Arrancar con el entorno listo, el proyecto en las manos de cada equipo y un diagnóstico honesto de su punto de partida. Tienda Ágora llega como muchos proyectos reales: el código funciona y tiene pruebas, pero nadie sabe cómo llega a producción.

## Antes de la sesión

1. Leer el Tema 1 (apartados 1.3 a 1.5: antipatrones, integración vs. entrega vs. despliegue, madurez) y el Tema 2 (2.5 buenas prácticas).
2. Crear o verificar estas cuentas con el correo `@comunidadunir.net` cuando aplique:
   - GitHub (personal).
   - **Azure for Students**: <https://azure.microsoft.com/es-es/free/students/> (sin tarjeta). Ver [nube/azure.md](../nube/azure.md).
   - **AWS Educate**: <https://aws.amazon.com/es/education/awseducate/>. Ver [nube/aws.md](../nube/aws.md).
3. Elegir entorno de trabajo: equipo propio (Git, Python 3.12, VS Code) **o** GitHub Codespaces (no requiere instalar nada).

> Las altas en la nube pueden tardar. Hacerlas esta semana evita bloqueos en las semanas 6 y 7.

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–8 | Presentación del curso, el proyecto y el calendario | Un solo proyecto, ocho mejoras visibles |
| 8–18 | Antipatrones del Tema 1 sobre Tienda Ágora tal como está | "Si desplegar duele, hay que hacerlo más a menudo" |
| 18–30 | Demo: fork, Codespace, `make test`, `make run`, `/docs` | El repositorio es la única fuente de verdad |
| 30–42 | Demo: `git bisect` encuentra un error en 3 pasos | Commits pequeños = errores fáciles de encontrar |
| 42–50 | Modalidad (individual o equipo), bitácora y laboratorio | La evidencia vive en el repositorio |

## Laboratorio

### Nivel base

```bash
# 1. Haz fork del repositorio del curso en GitHub y clónalo (o abre un Codespace sobre tu fork)
git clone https://github.com/TU_USUARIO/eiec-tienda-agora-202611.git
cd eiec-tienda-agora-202611

# 2. Entorno y pruebas
python -m venv .venv
source .venv/bin/activate          # Windows Git Bash: source .venv/Scripts/activate
pip install -r requirements-dev.txt
make lint test                     # o: flake8 app tests && python -m pytest -q

# 3. Levanta la API y explora http://127.0.0.1:8000/docs
make run
```

4. En la pestaña **Actions** de tu fork, habilita los workflows y verifica que el run de "CI - fase de commit" termine en verde.
5. Crea la rama `semana-01/registro`, completa la sección "Equipo" y la entrada de la semana 1 en [`BITACORA.md`](../../BITACORA.md) y abre un Pull Request **dentro de tu fork** (de tu rama a tu `main`).
6. **Diagnóstico de madurez inicial**: con la tabla de [proyecto/rubrica-formativa.md](../proyecto/rubrica-formativa.md), ubica a Tienda Ágora en cada dimensión (nivel −1 a 3) y justifica con evidencia del repositorio. Anótalo en la bitácora.

### Nivel intermedio

Laboratorio de *diff debugging* (Tema 2, "viajar en el tiempo"):

```bash
bash scripts/lab_bisect.sh /tmp/lab-bisect
cd /tmp/lab-bisect
git bisect start HEAD v1.0
git bisect run python check.py
git bisect reset
```

Responde en la bitácora: ¿qué commit introdujo el error?, ¿por qué su mensaje no ayudaba?, ¿cómo cambiaría la búsqueda con un solo commit gigante?

### Nivel avanzado

- Escribe en `docs/decisiones/0001-flujo-de-ramas.md` (en tu fork) una decisión breve: qué flujo de ramas usarán y por qué (lo retomaremos en la semana 2).
- Configura la firma de commits o un `commit-msg` hook que exija mensajes descriptivos.

## Evidencia de la semana

- Enlace a tu fork y al PR de registro.
- Diagnóstico de madurez inicial en la bitácora.
- Confirmación (sí/no/en trámite) de las altas en Azure for Students y AWS Educate.

## Preguntas para reflexionar

1. ¿Cuál de los antipatrones del Tema 1 encuentras en Tienda Ágora hoy?
2. ¿Por qué el Tema 2 insiste en versionar también scripts, configuración y pruebas?

## Notas para el docente

- Tener abierto un Codespace del repositorio del curso antes de la sesión.
- Preparar la tabla de equipos en Moodle (o un issue fijado) para que cada equipo registre su fork.
- Recordar en la sesión que las altas en la nube se hacen con el correo institucional.
