# Guía de la terminal y Git para el curso

**Para quién:** si nunca o casi nunca has usado una terminal, Git o Python. Si ya trabajas con ellos a diario, basta con la sección [5. El flujo del curso](#5-el-flujo-del-curso-paso-a-paso).

> [!IMPORTANT]
> Las fechas, las entregas y los avisos están en el **aula virtual**. Si algo de esta guía no te funciona, pregunta en el foro **"Pregúntale a tu profesor"** e indica tu sistema operativo, el comando que escribiste y el mensaje completo que apareció.

## Índice

1. [Elige tu entorno](#1-elige-tu-entorno)
2. [Instala lo necesario](#2-instala-lo-necesario)
3. [La terminal en 10 minutos](#3-la-terminal-en-10-minutos)
4. [Configura Git una sola vez](#4-configura-git-una-sola-vez)
5. [El flujo del curso, paso a paso](#5-el-flujo-del-curso-paso-a-paso)
6. [Tabla de equivalencias por sistema](#6-tabla-de-equivalencias-por-sistema)
7. [Problemas frecuentes](#7-problemas-frecuentes)

---

## 1. Elige tu entorno

Hay cuatro caminos y todos sirven para el curso. Elige **uno** y quédate con él.

| Si usas… | Tu terminal será… | Ventaja | A tener en cuenta |
|---|---|---|---|
| **GitHub Codespaces** (en el navegador) | La terminal de VS Code en el navegador | No instalas nada: el repositorio ya trae Python 3.12, Docker y las dependencias (`.devcontainer`) | Necesitas conexión; GitHub da una cuota mensual gratuita de horas |
| **Windows** | **Git Bash** (se instala con Git) | Los mismos comandos que en Linux y en el pipeline | No trae `make`: usa los comandos equivalentes (sección 6) |
| **Linux** (Ubuntu, Debian, Fedora…) | **Terminal** (bash) | Todo funciona tal cual | Python puede llamarse `python3` |
| **macOS** | **Terminal** (zsh) | Casi todo funciona tal cual | Python puede llamarse `python3` |

**VS Code** no es un sistema más: es el editor recomendado en los tres sistemas y trae una terminal integrada (menú **Terminal → Nuevo terminal**). En Windows, configúralo para que esa terminal sea Git Bash (sección 2.4).

> [!TIP]
> **¿Poca experiencia o un equipo de la empresa con restricciones?** Empieza con **Codespaces**: en tu fork, botón verde **Code → Codespaces → Create codespace on main**. Al minuto tienes un VS Code en el navegador con la terminal lista. Puedes pasar a tu equipo más adelante.

## 2. Instala lo necesario

Necesitas cuatro cosas: **Git**, **Python 3.12**, **VS Code** y una **cuenta de GitHub**. Docker solo hará falta desde la semana 5 (y Codespaces ya lo trae).

### 2.1 Windows

1. **Git (incluye Git Bash):** descarga el instalador de <https://git-scm.com/download/win>. Acepta las opciones por defecto, salvo estas pantallas:
   - *Choosing the default editor used by Git*: elige **Use Visual Studio Code as Git's default editor** (si ya tienes VS Code) o deja Vim y lee el problema 7.6.
   - *Adjusting the name of the initial branch*: elige **Override** y escribe `main`.
   - *Adjusting your PATH environment*: deja **Git from the command line and also from 3rd-party software** (la recomendada).
   - El instalador incluye **Git Credential Manager**, que te pedirá entrar a GitHub desde el navegador la primera vez que hagas `git push`.
2. **Python 3.12:** descarga el instalador de <https://www.python.org/downloads/windows/>. En la primera pantalla marca **Add python.exe to PATH** antes de pulsar *Install Now*.
3. **VS Code:** <https://code.visualstudio.com/>. Durante la instalación deja marcada la opción **Agregar a PATH**.
4. **Abre Git Bash:** menú Inicio → escribe *Git Bash*. Comprueba la instalación:

   ```bash
   git --version
   python --version      # debe decir Python 3.12.x
   code --version
   ```

   Si `python --version` no responde o abre la Microsoft Store, mira el problema 7.1.

### 2.2 Linux (Ubuntu o Debian)

```bash
sudo apt update
sudo apt install -y git python3 python3-venv python3-pip make
git --version
python3 --version
```

- Si tu distribución trae una versión de Python anterior a 3.12 y algo falla, usa Codespaces o instala 3.12 con el gestor de tu distribución.
- VS Code: descarga el paquete `.deb` o `.rpm` desde <https://code.visualstudio.com/>.
- En Fedora, cambia `apt` por `dnf` (`sudo dnf install git python3 python3-pip make`).

### 2.3 macOS

```bash
xcode-select --install      # instala git y make
git --version
python3 --version
```

- Si no tienes Python 3.12, instálalo desde <https://www.python.org/downloads/macos/>.
- VS Code: <https://code.visualstudio.com/>. Para poder escribir `code .` en la terminal: abre VS Code, pulsa `Cmd+Shift+P` y ejecuta **Shell Command: Install 'code' command in PATH**.

### 2.4 VS Code (todos los sistemas)

1. Instala la extensión **Python** (de Microsoft): icono de cuadrados a la izquierda → busca *Python* → *Install*.
2. Abre la terminal integrada: menú **Terminal → Nuevo terminal**.
3. **Solo en Windows:** pulsa `Ctrl+Shift+P`, escribe **Terminal: Select Default Profile** y elige **Git Bash**. Cierra la terminal (icono de papelera) y abre una nueva: el título debe decir *bash*, no *powershell*.

> [!NOTE]
> Todos los comandos del curso están escritos para **bash** (Git Bash, Linux, macOS, Codespaces). En PowerShell o en `cmd` muchos no funcionan igual: si tu terminal dice *PowerShell*, cámbiala.

## 3. La terminal en 10 minutos

La terminal es una ventana donde escribes órdenes en lugar de hacer clic. Siempre estás "dentro" de una carpeta, que se llama **directorio de trabajo**.

### 3.1 Comandos imprescindibles

| Comando | Qué hace | Ejemplo |
|---|---|---|
| `pwd` | Muestra en qué carpeta estás | `pwd` → `/c/Users/ana/cursos` |
| `ls` | Lista lo que hay en la carpeta | `ls` |
| `ls -a` | Lista también los archivos ocultos (los que empiezan con punto) | `ls -a` → `.git  .github  app …` |
| `cd carpeta` | Entra en una carpeta | `cd eiec-tienda-agora-202611` |
| `cd ..` | Sube a la carpeta anterior | `cd ..` |
| `cd ~` | Vuelve a tu carpeta personal | `cd ~` |
| `mkdir nombre` | Crea una carpeta | `mkdir cursos` |
| `code .` | Abre la carpeta actual en VS Code | `code .` |
| `clear` | Limpia la pantalla | `clear` |

### 3.2 Trucos que ahorran tiempo

- **Tab** completa nombres de carpetas y archivos: escribe `cd eiec` y pulsa Tab.
- **Flecha arriba** recupera los comandos anteriores.
- **Ctrl+C** detiene lo que se esté ejecutando (por ejemplo, la API con `make run`). No copia texto.
- **Copiar y pegar en Git Bash:** selecciona con el ratón para copiar; pega con **clic derecho → Paste** o **Shift+Insert**. `Ctrl+V` no siempre funciona.
- En la terminal de VS Code sí funcionan `Ctrl+C`/`Ctrl+V` para copiar y pegar cuando hay texto seleccionado (en macOS, `Cmd+C`/`Cmd+V`).
- Los comandos distinguen **mayúsculas y minúsculas** y los **espacios**. Si una ruta tiene espacios, ponla entre comillas: `cd "Mis documentos"`.
- El signo `#` inicia un comentario: lo que va detrás no se ejecuta. En la documentación del curso lo usamos para explicar los comandos.
- Al copiar comandos de la documentación, **no copies el `$`** que a veces aparece al inicio: solo indica que es un comando.

### 3.3 Rutas en Git Bash (Windows)

Git Bash escribe las rutas de Windows al estilo Linux:

| En el Explorador de Windows | En Git Bash |
|---|---|
| `C:\Users\Ana\Documents` | `/c/Users/Ana/Documents` |
| `D:\cursos` | `/d/cursos` |

**Recomendación:** crea una carpeta sin espacios ni acentos para el curso y trabaja siempre ahí:

```bash
cd ~
mkdir -p cursos
cd cursos
pwd        # Windows: /c/Users/tu_usuario/cursos · Linux: /home/tu_usuario/cursos
```

## 4. Configura Git una sola vez

### 4.1 Tu nombre y tu correo

Git firma cada commit con un nombre y un correo. **Usa el correo privado que te da GitHub** para no publicar tu correo personal: en GitHub, **Settings → Emails**, activa *Keep my email addresses private* y copia la dirección que termina en `@users.noreply.github.com`.

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "12345678+tu-usuario@users.noreply.github.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"   # usa VS Code para los mensajes de commit
git config --global --list                       # comprueba lo que guardaste
```

### 4.2 Acceso a GitHub

Usa siempre la dirección **HTTPS** del repositorio (empieza con `https://github.com/…`).

- **Windows:** no hagas nada más. La primera vez que hagas `git push`, Git Credential Manager abrirá el navegador para que entres a GitHub.
- **Linux y macOS:** instala GitHub CLI (<https://cli.github.com/>) y ejecuta una vez:

  ```bash
  gh auth login        # elige GitHub.com, HTTPS y "Login with a web browser"
  gh auth setup-git    # Git usará esa sesión al hacer push
  ```

- **Codespaces:** ya estás autenticado.

> [!WARNING]
> GitHub ya **no acepta tu contraseña** al hacer `git push`. Si la terminal te pide usuario y contraseña, cancela con Ctrl+C y usa uno de los métodos anteriores.

## 5. El flujo del curso, paso a paso

Es lo que haces en el laboratorio de la semana 1. Las semanas siguientes repiten los pasos 5.4 y 5.5.

### 5.1 Haz tu fork y clónalo

1. En GitHub, abre el repositorio del curso y pulsa **Fork** → **Create fork**. Ahora tienes una copia en `github.com/TU_USUARIO/eiec-tienda-agora-202611`.
2. En **tu fork**, botón verde **Code → HTTPS** → copia la dirección.
3. En la terminal:

   ```bash
   cd ~/cursos
   git clone https://github.com/TU_USUARIO/eiec-tienda-agora-202611.git
   cd eiec-tienda-agora-202611
   code .            # abre el proyecto en VS Code (opcional)
   ```

> En Codespaces no clonas: el Codespace ya está dentro de tu fork. Salta al paso 5.3.

### 5.2 Crea y activa el entorno de Python

Un **entorno virtual** (`.venv`) guarda las librerías del proyecto sin mezclarlas con las de tu equipo. Se crea una vez y se **activa cada vez que abres una terminal nueva**.

```bash
python -m venv .venv                 # Linux/macOS: python3 -m venv .venv

source .venv/Scripts/activate        # Windows (Git Bash)
source .venv/bin/activate            # Linux y macOS

pip install -r requirements-dev.txt
```

Sabrás que está activo porque la línea de la terminal empieza con **`(.venv)`**. Para salir del entorno: `deactivate`.

> En Codespaces no hace falta: las dependencias se instalaron al crearlo.

### 5.3 Comprueba que todo funciona

```bash
make lint test                                  # Linux, macOS y Codespaces
flake8 app tests && python -m pytest -q         # Windows (Git Bash no trae make)
```

Debe terminar con algo como `30 passed`. Después levanta la API:

```bash
make run                                        # Linux, macOS y Codespaces
uvicorn app.main:app --reload                   # Windows
```

Abre <http://127.0.0.1:8000/docs> en el navegador (en Codespaces, VS Code te ofrecerá abrir el puerto 8000). Para detener la API, vuelve a la terminal y pulsa **Ctrl+C**.

### 5.4 Trabaja en una rama

Nunca trabajes directamente en `main`: crea una rama para cada cambio.

```bash
git switch main                      # vuelve a main
git pull                             # trae lo último de tu fork
git switch -c semana-01/registro     # crea la rama y entra en ella
# … edita archivos en VS Code y guárdalos …
git status                           # ¿qué cambió?
git diff                             # ¿cómo cambió?
git add BITACORA.md                  # elige qué entra en el commit
git commit -m "Registra el equipo y la entrada de la semana 1"
git push -u origin semana-01/registro
```

**El ciclo es siempre el mismo:** `status` → `add` → `commit` → `push`. Si dudas, ejecuta `git status`: casi siempre te dice el siguiente paso.

### 5.5 Abre el pull request dentro de tu fork

1. En GitHub aparecerá un aviso amarillo con el botón **Compare & pull request**.
2. **Revisa el destino antes de crear el PR.** La línea de arriba debe decir:
   `base repository: TU_USUARIO/eiec-tienda-agora-202611` · `base: main` ← `compare: semana-01/registro`.
   GitHub propone por omisión el repositorio **del curso**: cámbialo a **tu fork**.
3. Pulsa **Create pull request** y espera a que el check **commit-stage** termine en verde antes de fusionar.

## 6. Tabla de equivalencias por sistema

| Para… | Windows (Git Bash) | Linux | macOS | Codespaces |
|---|---|---|---|---|
| Abrir la terminal | Inicio → *Git Bash*, o terminal de VS Code con perfil Git Bash | *Terminal* (`Ctrl+Alt+T` en Ubuntu) | *Terminal* (Spotlight: `Cmd+Espacio`) | Ya está abierta abajo |
| Ejecutar Python | `python` | `python3` | `python3` | `python` |
| Crear el entorno | `python -m venv .venv` | `python3 -m venv .venv` | `python3 -m venv .venv` | No hace falta |
| Activar el entorno | `source .venv/Scripts/activate` | `source .venv/bin/activate` | `source .venv/bin/activate` | No hace falta |
| Revisar y probar | `flake8 app tests && python -m pytest -q` | `make lint test` | `make lint test` | `make lint test` |
| Levantar la API | `uvicorn app.main:app --reload` | `make run` | `make run` | `make run` |
| Autenticarse en GitHub | Automático al primer `push` | `gh auth login` | `gh auth login` | Ya autenticado |
| Pegar en la terminal | Clic derecho → Paste o `Shift+Insert` | `Ctrl+Shift+V` | `Cmd+V` | `Ctrl+V` |

Cuando una guía del curso diga `make algo`, en Git Bash busca esa línea en el `Makefile` del repositorio y ejecuta el comando que aparece debajo.

## 7. Problemas frecuentes

**7.1 `python: command not found`, o se abre la Microsoft Store (Windows).**
Reinstala Python marcando **Add python.exe to PATH**. Si se abre la Store, ve a *Configuración → Aplicaciones → Configuración avanzada de aplicaciones → Alias de ejecución de aplicaciones* y desactiva `python.exe` y `python3.exe`. Cierra y vuelve a abrir Git Bash. Alternativa: usa `py` en lugar de `python`.

**7.2 `make: command not found` (Windows).**
Es normal: Git Bash no incluye `make`. Usa la columna de Windows de la tabla de la sección 6.

**7.3 `No such file or directory` al activar el entorno.**
Estás usando la ruta del otro sistema: en Windows es `.venv/Scripts/activate` y en Linux/macOS `.venv/bin/activate`. Comprueba también con `pwd` que estás dentro de la carpeta del proyecto y con `ls -a` que existe `.venv`.

**7.4 `ModuleNotFoundError: No module named 'fastapi'` (o `pytest`, `flake8`).**
El entorno no está activo (no ves `(.venv)` al inicio de la línea) o no instalaste las dependencias. Actívalo y ejecuta `pip install -r requirements-dev.txt`.

**7.5 `Author identity unknown` al hacer commit.**
Falta configurar tu nombre y correo: sección 4.1.

**7.6 Al hacer `git commit` se abrió una pantalla extraña y no sé salir.**
Es el editor Vim, porque olvidaste `-m "mensaje"`. Escribe `:q!` y pulsa Enter para salir sin guardar, y repite el commit con `-m`. Para que no vuelva a pasar: `git config --global core.editor "code --wait"`.

**7.7 `Permission denied (publickey)` o `Authentication failed` al hacer push.**
Clonaste con una dirección SSH (`git@github.com:…`) o intentaste usar tu contraseña. Cambia a HTTPS y usa el método de la sección 4.2:

```bash
git remote -v                                                          # revisa la dirección
git remote set-url origin https://github.com/TU_USUARIO/eiec-tienda-agora-202611.git
```

**7.8 `remote: Permission to prof-rodolfo-medina/… denied`.**
Estás intentando subir al repositorio **del curso**, no a tu fork. Clona tu fork (sección 5.1) o corrige `origin` con el comando anterior.

**7.9 `warning: LF will be replaced by CRLF` (Windows).**
Es un aviso, no un error: Git ajusta los finales de línea entre Windows y Linux. Puedes seguir.

**7.10 `Address already in use` o el puerto 8000 está ocupado.**
Ya tienes la API corriendo en otra terminal. Búscala y pulsa Ctrl+C, o cierra esa terminal.

**7.11 `fatal: not a git repository`.**
No estás dentro de la carpeta del proyecto. Usa `cd ~/cursos/eiec-tienda-agora-202611` (o la ruta donde clonaste) y vuelve a intentarlo.

**7.12 Nada de lo anterior funciona.**
Usa **Codespaces** para no perder la semana y pregunta en el foro "Pregúntale a tu profesor" con: sistema operativo, terminal que usas, comando exacto y el mensaje de error completo (cópialo como texto, no solo una captura).

---

Siguiente paso: la [guía de la semana 1](../semanas/semana-01.md) y el [resumen de la clase 1](../sesiones/sesion-01.md).
