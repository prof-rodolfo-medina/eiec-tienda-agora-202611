#!/usr/bin/env bash
# Crea los entornos staging y production en Azure App Service (plan F1, gratuito).
# Ejecútalo en Azure Cloud Shell (Bash) con tu suscripción Azure for Students activa:
#
#   ALIAS=jperez bash infra/azure/crear-app-service.sh
#
# ALIAS hace únicos los nombres (las Web Apps comparten el dominio azurewebsites.net).
# Usa solo minúsculas, números y guiones.
set -euo pipefail

ALIAS="${ALIAS:?Define ALIAS, por ejemplo ALIAS=jperez}"
LOCATION="${LOCATION:-westus2}"   # cambia la región si la suscripción no la permite
RG="rg-agora-${ALIAS}"
PLAN="plan-agora-${ALIAS}"
STARTUP="python -m uvicorn app.main:app --host 0.0.0.0 --port 8000"

echo ">> Grupo de recursos ${RG} en ${LOCATION}"
az group create --name "$RG" --location "$LOCATION" --tags curso=eiec proyecto=agora -o none

echo ">> Plan App Service Linux F1 (gratuito: 60 min de CPU al día, sin slots)"
az appservice plan create --resource-group "$RG" --name "$PLAN" --is-linux --sku F1 -o none

for ENV in staging production; do
  APP="agora-${ALIAS}-${ENV}"
  echo ">> Web App ${APP}"
  az webapp create --resource-group "$RG" --plan "$PLAN" --name "$APP" --runtime "PYTHON:3.12" -o none
  az webapp config set --resource-group "$RG" --name "$APP" --startup-file "$STARTUP" -o none
  az webapp config appsettings set --resource-group "$RG" --name "$APP" -o none --settings \
    SCM_DO_BUILD_DURING_DEPLOYMENT=true \
    APP_ENV="$ENV" \
    FEATURE_DISCOUNT_CODES=false

  # El despliegue con perfil de publicación requiere credenciales básicas de SCM habilitadas.
  az resource update --resource-group "$RG" --name scm --namespace Microsoft.Web \
    --resource-type basicPublishingCredentialsPolicies --parent "sites/${APP}" \
    --set properties.allow=true -o none

  az webapp deployment list-publishing-profiles --resource-group "$RG" --name "$APP" --xml \
    > "publish-profile-${ENV}.xml"
  echo "   URL: https://${APP}.azurewebsites.net"
  echo "   Perfil de publicación: publish-profile-${ENV}.xml (pégalo como secreto del entorno ${ENV} y bórralo)"
done

cat <<EOF

Listo. Siguiente paso en GitHub (Settings > Environments):
  staging    -> secreto AZURE_WEBAPP_PUBLISH_PROFILE, variables AZURE_WEBAPP_NAME=agora-${ALIAS}-staging,
                BASE_URL=https://agora-${ALIAS}-staging.azurewebsites.net
  production -> lo mismo con agora-${ALIAS}-production, y "Required reviewers" activado.

IMPORTANTE: los archivos publish-profile-*.xml contienen credenciales. Bórralos tras copiarlos:
  rm publish-profile-*.xml
Para eliminar todo al terminar el curso:  ALIAS=${ALIAS} bash infra/azure/limpiar.sh
EOF
