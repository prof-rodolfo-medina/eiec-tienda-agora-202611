# Clase 1 · Presentación del curso, Tema 1 y Tema 2

**Semana 1 · 23 – 27 de noviembre de 2026** · Clase por Zoom, 90 min · Día y hora: **consulta el aula virtual**
**Guía de la semana:** [semana-01.md](../semanas/semana-01.md)

> Las fechas vigentes son siempre las del aula. Las actividades se entregan en el aula. Contacto: foro "Pregúntale a tu profesor" y las clases por Zoom. Este repositorio es complementario y no es canal de contacto.

## Objetivos

1. Conocer cómo funciona el curso: canal oficial, calendario, evaluación y ritmo semanal.
2. Conocer el proyecto formativo Tienda Ágora y elegir modalidad (individual o en equipo).
3. Darte de alta en Azure for Students y AWS Educate con tu correo `@comunidadunir.net`.
4. Distinguir integración, entrega y despliegue continuos y reconocer antipatrones (Tema 1).
5. Hacer el diagnóstico de madurez inicial de Tienda Ágora.
6. Tener tu fork funcionando y usar `git bisect` para encontrar un error (Tema 2).

## Agenda

| Min | Bloque | Mensaje clave |
|---|---|---|
| 0–15 | Presentación del curso | Las fechas vigentes son las del aula |
| 15–25 | Proyecto Tienda Ágora | Un solo proyecto, ocho mejoras visibles |
| 25–30 | Acceso a Azure y AWS | Date de alta esta semana |
| 30–45 | Tema 1 y antipatrones | Si desplegar duele, hay que hacerlo más a menudo |
| 45–55 | Diagnóstico de madurez | Medir el punto de partida para ver el avance |
| 55–70 | Tema 2 · Demo de fork y Codespace | El repositorio es la única fuente de verdad |
| 70–80 | Demo de `git bisect` | Commits pequeños = errores fáciles de encontrar |
| 80–90 | Modalidad, laboratorio y dudas | La evidencia vive en tu fork |

## Evaluación (resumen)

| Elemento | Puntos | Se presenta |
|---|---|---|
| Actividad 1 | 6 | Clase 2 |
| Actividad 2 | 5 | Clase 5 |
| Microtests (54) | 4 | Con cada tema |
| **Suma disponible** | **15** | Máximo **10** en evaluación continua |

Examen final en la semana 8; en la clase 8 haremos un simulacro en Wooclap que no cuenta para la nota. Enunciados y fechas de entrega: **en el aula**. Tienda Ágora es formativo: no se entrega ni se califica. Más detalle en [actividades](../actividades/README.md).

## Ideas clave

**Tema 1**

- La integración continua verifica cada integración con construcción y pruebas automáticas; la entrega continua deja cada cambio listo para producción (desplegar es una decisión); el despliegue continuo lo lleva a producción sin intervención.
- Antipatrones: despliegue manual, desplegar en un entorno similar a producción solo al final y gestionar a mano la configuración de producción.
- El modelo de madurez (Humble y Farley, 2010) va de −1 (regresivo) a 3 (optimizado) en cinco dimensiones: [rúbrica formativa](../proyecto/rubrica-formativa.md).

**Tema 2**

- Si no está en control de versiones, no existe.
- Commits pequeños y frecuentes, revisados antes de confirmarlos, probados y con mensajes descriptivos; trabajo en ramas.
- Se versionan código, pruebas, scripts, configuración y dependencias; no los binarios ni los informes generados.

## Comandos de las demostraciones

Fork, entorno y pruebas (o abre un Codespace sobre tu fork: el entorno se prepara solo con [`.devcontainer`](../../.devcontainer/devcontainer.json)):

```bash
git clone https://github.com/TU_USUARIO/eiec-tienda-agora-202611.git
cd eiec-tienda-agora-202611
python -m venv .venv
source .venv/bin/activate          # Windows (Git Bash): source .venv/Scripts/activate
pip install -r requirements-dev.txt
make lint test                     # o: flake8 app tests && python -m pytest -q
make run                           # http://127.0.0.1:8000/docs
```

`git bisect` (nivel intermedio):

```bash
bash scripts/lab_bisect.sh /tmp/lab-bisect
cd /tmp/lab-bisect
git bisect start HEAD v1.0
git bisect run python check.py     # si no tienes "python": git bisect run python3 check.py
git bisect reset
```

## Tareas de la semana

- [ ] Alta en Azure for Students y AWS Educate con tu correo `@comunidadunir.net` ([instrucciones](../nube/registro-aws-azure.md)).
- [ ] Fork de Tienda Ágora funcionando, en tu equipo o en un Codespace.
- [ ] CI "fase de commit" en verde en la pestaña **Actions** de tu fork.
- [ ] Diagnóstico de madurez inicial en tu `BITACORA.md`.
- [ ] Microtests del aula: Tema 1 (1.1 a 1.6) y Tema 2 (2.1 a 2.6). Fecha de cierre: consulta el aula.

**Pregunta de reflexión:** ¿Qué le falta a Tienda Ágora para poder entregarse con confianza cualquier día? Respóndela en la entrada de la semana 1 de tu bitácora.

## Próxima clase

Clase 2 (60 min): Tema 3 (flujos con Git) y Tema 4 (fases de la entrega continua), y presentación de la actividad 1. En Tienda Ágora: `main` protegida con un check obligatorio, un PR rojo bloqueado y uno verde fusionado. Ven con tu fork funcionando y el CI en verde.
