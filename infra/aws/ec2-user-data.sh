#!/bin/bash
# User data para una instancia EC2 Amazon Linux 2023 (semana 7, ruta AWS).
# Pega este contenido en "Advanced details > User data" al lanzar la instancia
# desde el laboratorio de AWS Educate / AWS Academy.
#
# Antes de pegarlo, sustituye IMAGE por la imagen publicada en la semana 6, p. ej.:
#   ghcr.io/tu-usuario/eiec-tienda-agora-202611:1.0.0
# La imagen debe ser pública en GHCR (Package settings > Change visibility > Public).
#
# Abre el puerto 80 en el security group y verifica desde tu equipo:
#   BASE_URL=http://<IP-pública> bash scripts/smoke_test.sh
#
# Despliegue inmutable: para una nueva versión no "parcheas" la instancia; lanzas
# otra con la nueva etiqueta, la verificas y terminas la anterior.
IMAGE="ghcr.io/TU_USUARIO/eiec-tienda-agora-202611:1.0.0"

dnf install -y docker
systemctl enable --now docker
docker run -d --restart always --name agora -p 80:8000 \
  -e APP_ENV=production \
  "$IMAGE"
