# Cómo trabajar en este repositorio

## Para estudiantes

1. Haz **fork** de este repositorio y trabaja en tu fork (o en el fork de tu equipo). No abras pull requests hacia el repositorio del curso.
2. Nunca hagas commit directo a `main`: crea una rama, abre un Pull Request hacia **tu** `main` y espera el check verde.
3. Antes de hacer push:

   ```bash
   make lint test
   ```

4. Mensajes de commit en imperativo y con contexto: `Agrega endpoint /products/count con pruebas`, no `cambios` ni `fix`.
5. Un PR = un cambio con sentido. Si el PR tiene más de ~300 líneas, probablemente son dos.

Para mantener tu fork al día con las correcciones del curso:

```bash
git remote add upstream https://github.com/prof-rodolfo-medina/eiec-tienda-agora-202611.git
git fetch upstream
git checkout main && git merge upstream/main
```

## Para reportar un error en el material o hacer una pregunta

Escribe en el foro **"Pregúntale a tu profesor"** del aula virtual: indica el archivo, qué esperabas y qué pasó (con el log o una captura). Este repositorio no recibe *issues* ni pull requests de estudiantes. Ver [SUPPORT.md](SUPPORT.md).

## Privacidad

- No publiques en tu fork datos personales: ni correo, ni teléfono, ni matrícula. En la bitácora basta con tu usuario de GitHub.
- Para que tus commits no expongan tu correo, en GitHub activa **Settings → Emails → Keep my email addresses private** y configura en tu equipo el correo `noreply` que GitHub te asigna:

  ```bash
  git config --global user.email "ID+usuario@users.noreply.github.com"
  ```
