# EIEC · Tienda Ágora · Edición nov 2026 – ene 2027

Repositorio complementario del curso **Entornos de Integración y Entrega Continua** (Maestría en Desarrollo y Operaciones de Software, UNIR).
Es el **proyecto conductor** del curso: cada estudiante o equipo hace fork y lo hace madurar durante ocho semanas, de "código que funciona en mi máquina" a "entrega cualquier día, con evidencia y con marcha atrás".

**Docente:** Dr. Rodolfo Rafael Medina Ramírez · **Del 23 de noviembre de 2026 al 29 de enero de 2027** · **Proyecto:** formativo, no sumativo, individual o en equipo

[![CI - fase de commit](https://github.com/prof-rodolfo-medina/eiec-tienda-agora-202611/actions/workflows/ci.yml/badge.svg)](https://github.com/prof-rodolfo-medina/eiec-tienda-agora-202611/actions/workflows/ci.yml)

> [!IMPORTANT]
> **El aula virtual es el único canal oficial.** Las fechas vigentes son siempre las del aula, las actividades se entregan en el aula y el único medio de contacto, además de las clases por Zoom, es el foro **"Pregúntale a tu profesor"**. Este repositorio no es canal de contacto ni de entrega. → [SUPPORT.md](SUPPORT.md)

> [!TIP]
> **Como estudiante de UNIR tienes acceso gratuito a Microsoft Azure y a AWS**, sin tarjeta bancaria, registrándote con tu correo `@comunidadunir.net`. Hazlo en la semana 1: [instrucciones de registro](docs/nube/registro-aws-azure.md).

## Calendario

Según la programación semanal del aula. **Clases por Zoom los jueves a las 20:00 h**, excepto la clase 8, que se programará entre el lunes 25 y el miércoles 27 de enero de 2027, según la disponibilidad del grupo y del docente; el día y la hora se publicarán en el aula. Si hay cambios, vale lo que diga el aula.

| Sem. | Fechas | Temas | Clase | En el aula | En Tienda Ágora… | Guía |
|---|---|---|---|---|---|---|
| 1 | 23 – 27 nov | T1 Introducción · T2 Control de versiones | Clase 1 · jue 26 nov · presentación (90 min) | Microtests T1–T2 | Fork, entorno, diagnóstico de madurez, `git bisect` | [semana-01](docs/semanas/semana-01.md) |
| 2 | 30 nov – 4 dic | T3 Flujos con Git · T4 Fases de la entrega continua | Clase 2 · jue 3 dic · presentación act. 1 (60 min) | **Actividad 1** · Microtests T3–T4 | `main` protegida, fase de commit, PR rojo/verde | [semana-02](docs/semanas/semana-02.md) |
| 3 | 7 – 11 dic | T5 Pruebas | Clase 3 · jue 10 dic (60 min) | Microtests T5 | Historia del backlog con pruebas; baterías separadas | [semana-03](docs/semanas/semana-03.md) |
| 4 | 14 – 18 dic | T6 Calidad del código | Clase 4 · jue 17 dic · resolución act. 1 (90 min) | **Entrega act. 1** · Microtests T6 | Quality gate, revisión entre pares | [semana-04](docs/semanas/semana-04.md) |
| — | 21 dic – 3 ene | **Periodo no lectivo** | — | — | Solo opcional | [receso](docs/semanas/receso.md) |
| 5 | 4 – 8 ene | T7 Jenkins | Clase 5 · jue 7 ene · presentación act. 2 (60 min) | **Actividad 2** · Microtests T7 | El mismo pipeline como Jenkinsfile | [semana-05](docs/semanas/semana-05.md) |
| 6 | 11 – 15 ene | T8 GitLab · T9 Artefactos | Clase 6 · jue 14 ene (60 min) | Microtests T8–T9 | Imagen única versionada en GHCR; GitLab CI | [semana-06](docs/semanas/semana-06.md) |
| 7 | 18 – 22 ene | T10 Modelos de despliegue | Clase 7 · jue 21 ene · resolución act. 2 (90 min) | **Entrega act. 2** · Microtests T10 | Staging → aprobación → producción; feature flags; marcha atrás | [semana-07](docs/semanas/semana-07.md) |
| 8 | 25 – 29 ene | Repaso | Clase 8 · entre lun 25 y mié 27 ene, por confirmar · repaso y **simulacro en Wooclap** (90 min) | **Examen final** | Diagnóstico final y limpieza de la nube | [semana-08](docs/semanas/semana-08.md) · [simulacro](docs/semanas/simulacro-wooclap.md) · [repaso](docs/semanas/repaso-examen.md) |

- Cómo se relaciona el proyecto con las actividades evaluables: **[docs/actividades](docs/actividades/README.md)**.
- Plan completo (resultados de aprendizaje, enfoque, nube, riesgos): **[docs/plan-del-curso.md](docs/plan-del-curso.md)**.

## Empieza aquí (semana 1)

```bash
# 1. Haz fork en GitHub y clona TU fork (o abre un Codespace sobre él)
git clone https://github.com/TU_USUARIO/eiec-tienda-agora-202611.git
cd eiec-tienda-agora-202611

# 2. Entorno
python -m venv .venv
source .venv/bin/activate        # Windows (Git Bash): source .venv/Scripts/activate
pip install -r requirements-dev.txt

# 3. Verifica y ejecuta
make lint test                   # o: flake8 app tests && python -m pytest -q
make run                         # http://127.0.0.1:8000/docs
```

¿Primera vez con la terminal, Git o Python? Lee antes la **[guía de la terminal y Git](docs/guias/terminal-y-git.md)** (Windows con Git Bash, Linux, macOS, VS Code y Codespaces).

Después: habilita **Actions** en tu fork, completa [`BITACORA.md`](BITACORA.md) y sigue la [guía de la semana 1](docs/semanas/semana-01.md).

## La aplicación

API FastAPI deliberadamente pequeña: el reto está en el flujo de entrega, no en el negocio.

```text
GET  /health                  GET  /products            POST /carts
GET  /version                 GET  /products/{id}       GET  /carts/{id}
                                                        POST /carts/{id}/items
                                                        GET  /carts/{id}/total?code=   (feature flag)
```

`/version` devuelve versión, commit y entorno: es la pieza de trazabilidad que conecta commit → artefacto → despliegue.

## Estructura del repositorio

```text
README.md · SUPPORT.md        portada del curso y canal oficial (aula virtual)
CONTRIBUTING.md               cómo trabajar en tu fork
BITACORA.md                   evidencia semanal de cada fork (no se entrega: es tu registro)

app/                          código de la API (lógica separada de FastAPI para probarla)
tests/unit|api|smoke          baterías de pruebas por marcador (pytest.ini)
.github/workflows/            pipeline activo: fase de commit
.devcontainer/                entorno listo para GitHub Codespaces (Python 3.12 + Docker)
pipelines/                    plantillas por semana: GitHub Actions, Jenkins, GitLab, CircleCI
infra/azure|aws               scripts de nube (App Service, Container Apps, EC2) y limpieza
scripts/                      smoke test de despliegue y laboratorio de git bisect

docs/
├── plan-del-curso.md         planeación completa
├── actividades/              cómo se conecta el proyecto con las actividades del aula
├── guias/                    guía de la terminal y Git (Windows, Linux, macOS, VS Code)
├── semanas/                  guía de cada semana, receso, repaso y simulacro Wooclap
├── sesiones/                 resumen de cada clase por Zoom: objetivos, agenda y tareas
├── proyecto/                 enunciado, backlog, equipos y rúbrica formativa
├── nube/                     registro en Azure y AWS, guías por nube y plan B
└── docente/                  checklist del profesor
```

## Nube

| | Uso en el curso | Guía |
|---|---|---|
| **Azure for Students** | Despliegue automatizado desde el pipeline (App Service F1; Container Apps opcional) | [docs/nube/azure.md](docs/nube/azure.md) |
| **AWS Educate** | Laboratorios guiados en consola: la misma imagen en EC2 (despliegue inmutable) | [docs/nube/aws.md](docs/nube/aws.md) |
| **Sin nube** | Codespaces + Docker + GHCR | [docs/nube/plan-b.md](docs/nube/plan-b.md) |

Lo que se crea en la nube se elimina al terminar (`infra/azure/limpiar.sh`).

## Proyecto

- [Enunciado, backlog y definición de terminado](docs/proyecto/enunciado.md)
- [Trabajo individual o en equipo y roles rotativos](docs/proyecto/equipos.md)
- [Rúbrica formativa y modelo de madurez](docs/proyecto/rubrica-formativa.md)
- [Cómo trabajar en tu fork](CONTRIBUTING.md)
