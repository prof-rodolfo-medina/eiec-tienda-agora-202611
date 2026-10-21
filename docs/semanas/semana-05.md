# Semana 5 · 4 – 10 de enero de 2027

**Tema:** T7 Jenkins
**Sesión síncrona (propuesta):** jueves 7 de enero
**Pregunta guía:** Si cambio de herramienta, ¿qué se conserva del pipeline y qué cambia?

## Propósito

Implementar en Jenkins el mismo pipeline que ya funciona en GitHub Actions, como código versionado (Jenkinsfile declarativo), para separar los **conceptos** (fases, llaves de paso, artefactos, informes) de la **herramienta**.

## Antes de la sesión

- Tema 7: arquitectura controlador/agente y ejecutores (7.2), Jenkinsfiles y sintaxis declarativa (7.3) y caso práctico (7.4).
- Leer `pipelines/jenkins/Jenkinsfile` y compararlo, paso a paso, con `.github/workflows/ci.yml`.

## Dónde correr Jenkins

| Opción | Cuándo usarla |
|---|---|
| Tu equipo con Docker | La más directa si ya tienes Docker |
| **GitHub Codespaces** | Sin instalar nada; publica el puerto 8080 desde la pestaña *Ports* |
| VM en Azure (Azure for Students) | Si quieres un Jenkins accesible desde internet (permite webhooks). Apágala al terminar |
| Instancia EC2 en un laboratorio de AWS Educate/Academy | Misma idea, si tu laboratorio lo permite |

## Sesión síncrona (50 min)

| Min | Actividad | Mensaje clave |
|---|---|---|
| 0–10 | Controlador, agentes, ejecutores, etiquetas | El controlador distribuye; los agentes ejecutan |
| 10–22 | Demo: `docker compose up`, contraseña inicial, plugins recomendados | La primera vez de Jenkins es manual; lo demás, código |
| 22–35 | Demo: trabajo *Pipeline script from SCM* con el Jenkinsfile del repo | El pipeline viaja con el código |
| 35–45 | Stage View, Test Results, artefactos; un fallo provocado | El feedback debe ser accesible al desarrollador |
| 45–50 | Comparativa Actions vs. Jenkins y laboratorio | — |

## Laboratorio

### Nivel base

```bash
cd pipelines/jenkins
docker compose up -d --build
docker compose logs jenkins | grep -A2 initialAdminPassword
```

1. Abre `http://localhost:8080`, instala los plugins recomendados y crea tu usuario.
2. **Manage Jenkins → Nodes → Built-In Node → Configure** y añade la etiqueta `python`.
3. Crea un trabajo **Pipeline** → *Pipeline script from SCM* → Git → URL de tu fork → rama `*/main` → *Script Path* `pipelines/jenkins/Jenkinsfile`.
4. Ejecuta **Build Now**. Revisa *Stage View*, *Test Result* y el artefacto `agora-<sha>.tgz`.
5. Provoca un fallo en una rama, apunta el trabajo a esa rama y observa en qué etapa se detiene.

### Nivel intermedio

- Activa el disparador `pollSCM` (ya está en el Jenkinsfile) y verifica en el log del build cómo Jenkins detecta el commit nuevo.
- Escribe en la bitácora una tabla de equivalencias: `on:` ↔ `triggers`, `jobs/steps` ↔ `stages/steps`, `upload-artifact` ↔ `archiveArtifacts`, etc.

### Nivel avanzado

- Separa controlador y agente: un segundo contenedor `jenkins/inbound-agent` con Python, conectado por secreto (Tema 7.4, "Configuración del agente").
- Cambia a un trabajo **Multibranch Pipeline** para que cada rama y PR tenga su propio pipeline.
- Si tu Jenkins tiene URL pública (VM en la nube), configura un webhook de GitHub en lugar de `pollSCM`.

## Evidencia de la semana

- Captura del *Stage View* con al menos un build verde y uno rojo.
- Captura de *Test Result* con los informes JUnit.
- Tabla de equivalencias Actions ↔ Jenkins en la bitácora.

## Preguntas para reflexionar

1. ¿Qué ganas y qué pierdes al administrar tu propio servidor de CI frente a un servicio gestionado?
2. ¿Por qué el Tema 7 recomienda que el controlador no ejecute trabajos en entornos profesionales?

## Notas para el docente

- Construir la imagen de Jenkins antes de la sesión: la primera construcción descarga cerca de 1 GB.
- Si alguien usa una VM en la nube, recordar apagarla o eliminarla al final de la semana.
