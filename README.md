# EIEC · Tienda Ágora · Edición nov 2026 – ene 2027

Repositorio del curso **Entornos de Integración y Entrega Continua** (Maestría en Desarrollo y Operaciones de Software, UNIR).
Es, a la vez, la **portada del curso** y el **proyecto conductor**: cada estudiante o equipo hace fork y lo hace madurar durante ocho semanas, de "código que funciona en mi máquina" a "entrega cualquier día, con evidencia y con marcha atrás".

**Docente:** Dr. Rodolfo Rafael Medina Ramírez · **Inicio:** semana del 23 de noviembre de 2026 · **Proyecto:** formativo, no sumativo, individual o en equipo

[![CI - fase de commit](https://github.com/prof-rodolfo-medina/eiec-tienda-agora-202611/actions/workflows/ci.yml/badge.svg)](https://github.com/prof-rodolfo-medina/eiec-tienda-agora-202611/actions/workflows/ci.yml)

> [!IMPORTANT]
> **Como estudiante de UNIR tienes acceso gratuito a Microsoft Azure y a AWS**, sin pagos personales y sin tarjeta bancaria. Solo tienes que registrarte con tu correo **@comunidadunir.net**.
> Cómo hacerlo, paso a paso: **[Registro para uso de AWS y Microsoft Azure](docs/nube/registro-aws-azure.md)**. Hazlo en la semana 1.

## Calendario

Sesiones síncronas: **propuesta** de jueves; se confirmará con la programación oficial.

| Sem. | Fechas | Temas | En Tienda Ágora… | Guía |
|---|---|---|---|---|
| 1 | 23 – 29 nov | T1 Introducción · T2 Control de versiones | Fork, entorno, diagnóstico de madurez, `git bisect` | [semana-01](docs/semanas/semana-01.md) |
| 2 | 30 nov – 6 dic | T3 Flujos con Git · T4 Fases de la entrega continua | `main` protegida, fase de commit, PR rojo/verde | [semana-02](docs/semanas/semana-02.md) |
| 3 | 7 – 13 dic | T5 Pruebas | Historia del backlog con pruebas; baterías separadas | [semana-03](docs/semanas/semana-03.md) |
| 4 | 14 – 20 dic | T6 Calidad del código | Quality gate, revisión entre pares, SonarQube | [semana-04](docs/semanas/semana-04.md) |
| — | 21 dic – 3 ene | **Receso** | Solo actividades opcionales | [receso](docs/semanas/receso.md) |
| 5 | 4 – 10 ene | T7 Jenkins | El mismo pipeline como Jenkinsfile | [semana-05](docs/semanas/semana-05.md) |
| 6 | 11 – 17 ene | T8 GitLab · T9 Artefactos | Imagen única versionada en GHCR; GitLab CI | [semana-06](docs/semanas/semana-06.md) |
| 7 | 18 – 24 ene | T10 Despliegue (I) | Staging → aprobación → producción en **Azure**; EC2 en **AWS** | [semana-07](docs/semanas/semana-07.md) |
| 8 | 25 – 31 ene | T10 Despliegue (II) · Cierre · **Examen final (jue 28 o vie 29)** | Feature flags, canary, demo final en video; repaso para el examen | [semana-08](docs/semanas/semana-08.md) · [repaso](docs/semanas/repaso-examen.md) |

Plan completo (resultados de aprendizaje, enfoque, nube, riesgos): **[docs/plan-del-curso.md](docs/plan-del-curso.md)**

## Empieza aquí (semana 1)

```bash
# 1. Fork en GitHub y clona tu fork (o abre un Codespace sobre él)
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
app/                    código de la API (lógica separada de FastAPI para probarla)
tests/unit|api|smoke    baterías de pruebas por marcador (pytest.ini)
.github/workflows/      pipeline activo: fase de commit
pipelines/              plantillas por semana: GitHub Actions, Jenkins, GitLab, CircleCI
infra/azure|aws         scripts de nube (App Service, Container Apps, EC2) y limpieza
scripts/                smoke test de despliegue y laboratorio de git bisect
docs/                   plan, guías semanales, proyecto, rúbrica, nube, notas docentes
BITACORA.md             evidencia semanal de cada fork
```

## Nube

| | Uso en el curso | Guía |
|---|---|---|
| **Azure for Students** | Despliegue automatizado desde el pipeline (App Service F1; Container Apps opcional) | [docs/nube/azure.md](docs/nube/azure.md) |
| **AWS Educate** | Laboratorios guiados en consola: misma imagen en EC2 (despliegue inmutable) | [docs/nube/aws.md](docs/nube/aws.md) |
| **Sin nube** | Codespaces + Docker + GHCR | [docs/nube/plan-b.md](docs/nube/plan-b.md) |

Regístrate en ambas con tu correo **@comunidadunir.net** durante la semana 1 ([instrucciones de registro](docs/nube/registro-aws-azure.md)). Lo que se crea en la nube se elimina al terminar (`infra/azure/limpiar.sh`).

## Proyecto

- [Enunciado, backlog y definición de terminado](docs/proyecto/enunciado.md)
- [Trabajo individual o en equipo y roles rotativos](docs/proyecto/equipos.md)
- [Rúbrica formativa y modelo de madurez](docs/proyecto/rubrica-formativa.md)
- [Cómo trabajar en el repositorio](CONTRIBUTING.md)
