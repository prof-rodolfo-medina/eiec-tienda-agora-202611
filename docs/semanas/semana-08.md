# Semana 8 · 25 – 29 de enero de 2027

**Tema:** Repaso de los Temas 1 a 10 · Examen final
**Clase 8:** repaso y simulacro del examen en Wooclap (90 min) · **esta semana no es en jueves:** se programará entre el lunes 25 y el miércoles 27 de enero de 2027, según la disponibilidad del grupo y del docente; el día y la hora se publicarán en el aula
**Examen final:** esta semana; fecha, hora y condiciones **en el aula virtual**
**Pregunta guía:** ¿Puedes recorrer tu pipeline de izquierda a derecha y nombrar el tema que explica cada pieza?

> Las fechas vigentes son siempre las del aula. Dudas: foro "Pregúntale a tu profesor".

## Propósito

Consolidar el temario completo antes del examen, detectar los temas con más dudas mediante un simulacro y cerrar el proyecto dejando la nube limpia. Esta semana **no hay laboratorio nuevo**: el tiempo es para estudiar.

## Antes de la clase

- Repasar la [guía de repaso](repaso-examen.md) y traer dudas concretas.
- Leer la guía del [simulacro en Wooclap](simulacro-wooclap.md) y tener a mano el celular o un navegador.
- Avanzar los microtests pendientes (cierran el 31/01/2027; consulta el aula).

## Clase 8 (90 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | Bienvenida, reglas del simulacro y conexión a Wooclap con un alias | Es un ensayo: equivocarse hoy es barato |
| 10–25 | **Simulacro · Ronda 1** (T1–T4): 7 preguntas, explicación tras cada una, clasificación | Integrar, entregar y desplegar no son sinónimos |
| 25–40 | **Simulacro · Ronda 2** (T5–T7): 7 preguntas, explicación, clasificación | Las pruebas y la calidad son llaves de paso |
| 40–55 | **Simulacro · Ronda 3** (T8–T10): 6 preguntas, explicación, clasificación final | Se construye una vez y se promueve |
| 55–80 | Repaso dirigido: los temas con menor acierto, sobre el pipeline de Tienda Ágora | Cada tema dejó una pieza del pipeline |
| 80–90 | Cierre del curso: recordatorios del aula, limpieza de la nube, diagnóstico final | Lo que no se apaga, cobra |

## Cierre del proyecto (opcional, recomendado antes del examen)

Una o dos horas como máximo:

1. **Diagnóstico de madurez final** en la bitácora, con la misma tabla de la semana 1 y evidencia por dimensión. Compara con las semanas 1 y 4.
2. **Limpieza de la nube**: elimina los recursos de Azure (`ALIAS=<alias> bash infra/azure/limpiar.sh`) y termina las instancias de AWS. Deja constancia en la bitácora.
3. **Retrospectiva** en tres líneas: lo que mejoró, lo que más costó y la siguiente mejora que harías.

Para quien quiera seguir después del curso: los retos de canary, blue/green y rolling update de la [semana 7](semana-07.md#nivel-avanzado--canary-con-azure-container-apps) y el [backlog](../proyecto/enunciado.md#backlog).

## Preguntas para reflexionar

1. ¿Qué modelo de despliegue elegirías para Tienda Ágora con 10 usuarios? ¿Y con 100 000?
2. Si tuvieras que mejorar una sola dimensión de madurez de tu proyecto, ¿cuál sería y por qué?

## Notas para el docente

- Publicar el lunes en el aula un anuncio con la fecha de la clase 8, el examen y el recordatorio de microtests.
- Preparar el evento de Wooclap con al menos un día de anticipación: *Settings → Interactivity → Competition mode* activado y la opción de mostrar la clasificación automáticamente desactivada (se muestra al final de cada ronda con el trofeo).
- Probar el enlace del evento desde un celular. Compartir pantalla en Zoom con el modo presentación de Wooclap.
- Tras la clase, descargar el informe de Wooclap (resultados por pregunta) para identificar los temas débiles y, si conviene, publicar en el aula un aviso con las lecturas recomendadas.
- El banco de preguntas del simulacro **no se publica** en este repositorio.
