# Cómo trabajar en este repositorio

## Para estudiantes

1. Haz **fork** de este repositorio y trabaja en tu fork (o en el fork de tu equipo).
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

## Para reportar un error en el material

Abre un *issue* en el repositorio del curso con la plantilla "Error en el material".
