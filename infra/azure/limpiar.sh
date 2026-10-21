#!/usr/bin/env bash
# Elimina TODOS los recursos del proyecto en Azure (grupo de recursos completo).
# Ejecútalo al terminar el curso para no consumir crédito de Azure for Students.
#   ALIAS=jperez bash infra/azure/limpiar.sh
set -euo pipefail
ALIAS="${ALIAS:?Define ALIAS}"
RG="rg-agora-${ALIAS}"
echo "Se eliminará el grupo de recursos ${RG} y todo su contenido."
read -r -p "Escribe el nombre del grupo para confirmar: " CONFIRM
[ "$CONFIRM" = "$RG" ] || { echo "Cancelado."; exit 1; }
az group delete --name "$RG" --yes --no-wait
echo "Eliminación solicitada. Verifica en el portal que el grupo desaparezca."
