# Plan B: completar el curso sin nube

Si una cuenta de nube no se activa a tiempo, ningún laboratorio se pierde.

| Semana | Con nube | Sin nube |
|---|---|---|
| 5 | Jenkins en una VM | Jenkins en Docker local o en **GitHub Codespaces** |
| 6 | Imagen en GHCR | Igual (GHCR es gratuito y no depende de Azure/AWS) |
| 7 | App Service staging/production | Dos contenedores locales de la misma imagen (`APP_ENV=staging` en el puerto 8001 y `APP_ENV=production` en el 8002) y smoke test contra cada uno |
| 8 | Canary en Container Apps | Canary con `docker compose` y un proxy nginx que reparte 90/10 entre dos contenedores (o `kind` en un Codespace) |

**Codespaces:** abre tu fork en GitHub → *Code → Codespaces → Create codespace*. Incluye Python y Docker. Los puertos se publican desde la pestaña *Ports*. Detén el Codespace cuando no lo uses para no consumir la cuota mensual gratuita.

En la bitácora, documenta qué habría cambiado en la nube real: qué secreto, qué entorno, qué comando.
