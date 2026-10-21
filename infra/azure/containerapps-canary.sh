#!/usr/bin/env bash
# Modelos de despliegue con Azure Container Apps (semana 8, Tema 10).
# Funciona desde Azure Cloud Shell o desde el workflow semana-08-canary-containerapps.yml.
#
# Preparación (una vez):
#   ALIAS=jperez IMAGE_REPO=ghcr.io/usuario/eiec-tienda-agora-202611 bash infra/azure/containerapps-canary.sh setup sha-1a2b3c4
# Canary con 10 % del tráfico hacia la nueva imagen:
#   ... containerapps-canary.sh canary 1.1.0 10
# Promover (100 % a la nueva) o revertir (100 % a la estable):
#   ... containerapps-canary.sh promote
#   ... containerapps-canary.sh rollback
#
# Nota de costos: el plan de consumo tiene una concesión mensual gratuita y con
# min-replicas 0 la app escala a cero cuando nadie la usa. El entorno se crea sin
# Log Analytics para no generar cargos de ingesta de logs.
set -euo pipefail

ACCION="${1:?Uso: containerapps-canary.sh setup|canary|promote|rollback [tag] [porcentaje]}"
TAG="${2:-}"
PCT="${3:-10}"

ALIAS="${ALIAS:-}"
RESOURCE_GROUP="${RESOURCE_GROUP:-rg-agora-${ALIAS}}"
APP_NAME="${APP_NAME:-ca-agora-${ALIAS}}"
ENV_NAME="${ENV_NAME:-cae-agora-${ALIAS}}"
LOCATION="${LOCATION:-westus2}"
IMAGE_REPO="${IMAGE_REPO:?Define IMAGE_REPO, por ejemplo ghcr.io/usuario/repo}"

traffic() {
  az containerapp ingress traffic show -g "$RESOURCE_GROUP" -n "$APP_NAME" -o json
}

latest_revision() {
  az containerapp show -g "$RESOURCE_GROUP" -n "$APP_NAME" \
    --query properties.latestRevisionName -o tsv
}

case "$ACCION" in
  setup)
    : "${TAG:?Indica la etiqueta inicial de la imagen}"
    az extension add --name containerapp --upgrade -o none
    az group create -n "$RESOURCE_GROUP" -l "$LOCATION" -o none
    az containerapp env create -g "$RESOURCE_GROUP" -n "$ENV_NAME" -l "$LOCATION" \
      --logs-destination none -o none
    az containerapp create -g "$RESOURCE_GROUP" -n "$APP_NAME" --environment "$ENV_NAME" \
      --image "${IMAGE_REPO}:${TAG}" --target-port 8000 --ingress external \
      --min-replicas 0 --max-replicas 2 --revisions-mode multiple \
      --env-vars APP_ENV=production -o none
    az containerapp show -g "$RESOURCE_GROUP" -n "$APP_NAME" \
      --query properties.configuration.ingress.fqdn -o tsv
    ;;

  canary)
    : "${TAG:?Indica la etiqueta de la nueva imagen}"
    STABLE=$(traffic | python3 -c "import json,sys; t=json.load(sys.stdin); \
print(max(t, key=lambda r: r.get('weight', 0))['revisionName'])")
    SUFFIX=$(echo "$TAG" | tr -c 'a-z0-9\n' '-' | cut -c1-20)
    az containerapp update -g "$RESOURCE_GROUP" -n "$APP_NAME" \
      --image "${IMAGE_REPO}:${TAG}" --revision-suffix "v-${SUFFIX}-$(date +%H%M%S)" -o none
    NEW=$(latest_revision)
    az containerapp ingress traffic set -g "$RESOURCE_GROUP" -n "$APP_NAME" \
      --revision-weight "${STABLE}=$((100 - PCT))" "${NEW}=${PCT}" -o table
    echo "Canary: ${NEW} recibe ${PCT} %; ${STABLE} sigue con $((100 - PCT)) %."
    ;;

  promote)
    NEW=$(latest_revision)
    az containerapp ingress traffic set -g "$RESOURCE_GROUP" -n "$APP_NAME" \
      --revision-weight "${NEW}=100" -o table
    echo "Promovida: ${NEW} recibe el 100 %."
    ;;

  rollback)
    NEW=$(latest_revision)
    STABLE=$(traffic | NEW="$NEW" python3 -c "import json,os,sys; t=json.load(sys.stdin); \
c=[r['revisionName'] for r in t if r.get('revisionName') and r['revisionName']!=os.environ['NEW']]; \
print(c[0] if c else '')")
    if [ -z "$STABLE" ]; then
      echo "No hay una revisión estable en la tabla de tráfico; usa: az containerapp revision list" >&2
      exit 1
    fi
    az containerapp ingress traffic set -g "$RESOURCE_GROUP" -n "$APP_NAME" \
      --revision-weight "${STABLE}=100" "${NEW}=0" -o table
    echo "Rollback: ${STABLE} vuelve a recibir el 100 %."
    ;;

  *)
    echo "Acción desconocida: $ACCION" >&2
    exit 1
    ;;
esac
