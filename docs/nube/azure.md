# Azure for Students en el curso

## Alta

1. Entra a <https://azure.microsoft.com/es-es/free/students/> y regístrate con tu correo **@comunidadunir.net**.
2. No se pide tarjeta. Obtienes **100 USD de crédito** para usar en 12 meses y servicios con cuota gratuita.
3. Verifica en el portal (<https://portal.azure.com>) que aparece la suscripción *Azure for Students* y abre **Cloud Shell** (icono `>_`, modo Bash). Todo el curso se puede hacer desde ahí, sin instalar la CLI.

> Hazlo en la semana 1. Si la activación falla, avisa en el foro: se puede trabajar en equipo con la suscripción de otra persona.

## Qué usamos y cuánto cuesta

| Servicio | Semana | Configuración del curso | Costo esperado |
|---|---|---|---|
| App Service (Linux) | 7–8 | Plan **F1** con dos Web Apps: staging y production | Gratuito (F1: 60 min de CPU/día, sin slots ni escalado) |
| Container Apps | 8 (opcional) | Plan de consumo, `min-replicas 0`, sin Log Analytics | Dentro de la concesión mensual gratuita para un uso de laboratorio |
| Máquina virtual | 5 (opcional) | Para un Jenkins con URL pública | Consume crédito mientras está encendida: apágala o elimínala |

Todo se crea en un grupo de recursos `rg-agora-<alias>`, y se elimina completo con `infra/azure/limpiar.sh`.

## Despliegue desde GitHub Actions: perfil de publicación

El workflow de la semana 7 usa el **perfil de publicación** de cada Web App, que se descarga con la CLI (lo hace `infra/azure/crear-app-service.sh`) y se guarda como secreto del entorno en GitHub. Se eligió así porque:

- no requiere registrar aplicaciones ni identidades en Microsoft Entra ID, algo que el tenant institucional puede restringir;
- es suficiente para practicar entornos, aprobaciones, smoke tests y marcha atrás.

El script habilita las credenciales básicas de publicación (SCM), que Azure desactiva por defecto en apps nuevas. Si las desactivas, el despliegue con perfil fallará con un error de autenticación.

**Seguridad:** el perfil es una credencial. No lo pegues en issues ni lo subas al repositorio; bórralo de Cloud Shell tras copiarlo. Si se filtra, regenéralo desde el portal (*Download publish profile → Reset*).

## Opcional: inicio de sesión OIDC para Container Apps

Para ejecutar el canary desde el pipeline (`semana-08-canary-containerapps.yml`) GitHub debe iniciar sesión en Azure sin contraseña mediante OIDC:

```bash
# En Cloud Shell. Si el primer comando falla por permisos, tu tenant no lo permite:
# usa containerapps-canary.sh directamente desde Cloud Shell.
APP_ID=$(az ad app create --display-name "gh-agora-<alias>" --query appId -o tsv)
az ad sp create --id "$APP_ID"
SUB_ID=$(az account show --query id -o tsv)
az role assignment create --assignee "$APP_ID" --role Contributor \
  --scope "/subscriptions/$SUB_ID/resourceGroups/rg-agora-<alias>"
az ad app federated-credential create --id "$APP_ID" --parameters '{
  "name": "gh-production",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:<usuario>/eiec-tienda-agora-202611:environment:production",
  "audiences": ["api://AzureADTokenExchange"]
}'
echo "AZURE_CLIENT_ID=$APP_ID"
echo "AZURE_TENANT_ID=$(az account show --query tenantId -o tsv)"
echo "AZURE_SUBSCRIPTION_ID=$SUB_ID"
```

Guarda los tres valores como secretos del repositorio y define las variables `AZURE_RESOURCE_GROUP` y `AZURE_CONTAINERAPP_NAME`.

## Problemas frecuentes

| Síntoma | Causa probable | Solución |
|---|---|---|
| El smoke test falla los primeros intentos | Arranque en frío del plan F1 | El script reintenta; si persiste, revisa *Log stream* de la Web App |
| `ModuleNotFoundError: fastapi` en la Web App | No se instalaron dependencias al desplegar | Verifica el ajuste `SCM_DO_BUILD_DURING_DEPLOYMENT=true` |
| 401 en `azure/webapps-deploy` | Credenciales básicas SCM desactivadas o perfil equivocado | Vuelve a ejecutar la parte `az resource update` del script o regenera el perfil |
| "The subscription is not registered to use namespace…" | Proveedor no registrado | `az provider register --namespace Microsoft.Web` (o `Microsoft.App`) |
| Región no disponible | Restricción de la suscripción | Cambia `LOCATION` (p. ej. `eastus`, `centralus`) |
