# Preparación del entorno de demostración (docente)

Las demostraciones en vivo se hacen en un **fork de demostración**, nunca en el repositorio del curso: así se repite exactamente lo que hace cada estudiante (fork, Actions, ruleset en `main`, PR rojo y PR verde) sin publicar ramas ni PR de prueba en el repositorio público.

## 1. Fork en una organización (una sola vez)

GitHub no permite hacer fork de un repositorio a la misma cuenta que lo posee, por eso el fork se hace en una **organización gratuita** del docente (no en una segunda cuenta personal: el plan gratuito admite una cuenta por persona).

- [ ] Crear la organización: foto de perfil → **Your organizations → New organization → Free**. Nombre sugerido: `eiec-demo`.
- [ ] En el repositorio del curso: **Fork → Owner: `eiec-demo`** → conservar el nombre `eiec-tienda-agora-202611` → **Create fork**.
- [ ] En el fork: pestaña **Actions → I understand my workflows, go ahead and enable them**; lanzar una vez **CI - fase de commit → Run workflow** y comprobar que termina en verde (así `commit-stage` aparece al crear el ruleset en la clase 2).

## 2. Entorno local con VS Code (una sola vez)

```bash
mkdir -p ~/demos && cd ~/demos
git clone https://github.com/eiec-demo/eiec-tienda-agora-202611.git
cd eiec-tienda-agora-202611
git remote add upstream https://github.com/prof-rodolfo-medina/eiec-tienda-agora-202611.git
gh repo set-default eiec-demo/eiec-tienda-agora-202611   # gh pr create apuntará al fork
code .
```

- [ ] En Windows: terminal de VS Code con perfil **Git Bash** (`Ctrl+Shift+P` → *Terminal: Select Default Profile*), como indica la [guía de la terminal](../guias/terminal-y-git.md).
- [ ] Entorno de Python y comprobación (`make lint test` o, en Git Bash, `flake8 app tests && python -m pytest -q`).
- [ ] `make run` (o `uvicorn app.main:app --reload`) y abrir `http://127.0.0.1:8000/docs`.
- [ ] `git remote -v` muestra `origin` → `eiec-demo/…` y `upstream` → `prof-rodolfo-medina/…`.

## 3. Presentación en Zoom (una sola vez)

- [ ] Crear un **perfil de VS Code** para clase (*Profiles → New Profile*, p. ej. «Clase») con:
  - `window.zoomLevel` en 1 o 2 (o `Ctrl` + `+` en vivo);
  - `terminal.integrated.fontSize` en 18 o más;
  - `editor.minimap.enabled` en `false`.
- [ ] Desactivar notificaciones del sistema durante la clase.
- [ ] En Zoom, compartir **solo la ventana** de VS Code o del navegador, no la pantalla completa.

## 4. Codespace de respaldo (una sola vez)

- [ ] En el fork: **Code → Codespaces → Create codespace on main**. Comprobar que `make lint test` pasa (el `.devcontainer` instala todo).
- [ ] Opcional: abrirlo desde VS Code local con la extensión **GitHub Codespaces**.
- [ ] Recordar detener el Codespace después de cada clase para no gastar la cuota.

## 5. Antes de cada clase (15 minutos)

- [ ] Sincronizar el fork con el repositorio del curso. Antes de proteger `main` (semana 1), basta el botón **Sync fork** de GitHub. Desde la semana 2, `main` del fork está protegida y solo admite PR, así que la sincronización se hace igual que cualquier cambio:

  ```bash
  git switch main && git pull
  git fetch upstream
  git switch -c sync/semana-NN
  git merge upstream/main
  git push -u origin sync/semana-NN
  gh pr create --base main --head sync/semana-NN --fill   # fusionar cuando esté en verde
  ```

- [ ] `make lint test` en verde en local y en Actions del fork.
- [ ] Preparar las ramas y los PR de respaldo de la semana dentro del fork (por ejemplo, en la semana 2, `semana-02/pr-rojo` y `semana-02/pr-verde`) por si Actions tarda en vivo.
- [ ] Tener abiertas las pestañas de la clase: fork en GitHub (Actions y, si toca, *Settings → Rules*), aula virtual, Wooclap (si hay diagnóstico o simulacro) y la guía de la semana.
- [ ] Abrir el Codespace de respaldo (tarda 1–2 minutos en arrancar).

## Clase 1: la demo del fork

Mostrar el botón **Fork** en el repositorio del curso hasta la ventana donde se elige el dueño, y cancelar. A partir de ahí, trabajar en el fork ya preparado de `eiec-demo`: los estudiantes ven el paso completo sin esperar en vivo.

## Después de cada clase

- [ ] Cerrar sin fusionar los PR rojos de la demo y dejar `main` del fork en verde.
- [ ] Detener el Codespace.
- [ ] Los PR verdes fusionados en la demo se quedan en el historial del fork; no hace falta revertirlos. La sincronización de la sección 5 incorpora encima los cambios del curso.
