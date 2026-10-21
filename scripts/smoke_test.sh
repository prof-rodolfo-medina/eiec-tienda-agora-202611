#!/usr/bin/env bash
# Smoke test de despliegue (Tema 4, "Probar los despliegues con un smoke test").
# Uso: BASE_URL=https://mi-app.azurewebsites.net bash scripts/smoke_test.sh
# Opcional: EXPECTED_VERSION=1.0.0 para verificar que corre el artefacto esperado.
set -euo pipefail

BASE_URL="${BASE_URL:?Define BASE_URL}"
RETRIES="${RETRIES:-10}"
SLEEP="${SLEEP:-6}"

echo "Smoke test contra ${BASE_URL}"

for attempt in $(seq 1 "${RETRIES}"); do
  if body=$(curl -fsS --max-time 10 "${BASE_URL}/health"); then
    echo "health -> ${body}"
    break
  fi
  echo "Intento ${attempt}/${RETRIES}: la app aún no responde; reintento en ${SLEEP}s"
  sleep "${SLEEP}"
  if [ "${attempt}" -eq "${RETRIES}" ]; then
    echo "FALLO: /health no respondió" >&2
    exit 1
  fi
done

version_json=$(curl -fsS --max-time 10 "${BASE_URL}/version")
echo "version -> ${version_json}"

if [ -n "${EXPECTED_VERSION:-}" ]; then
  if ! echo "${version_json}" | grep -q "\"version\":\"${EXPECTED_VERSION}\""; then
    echo "FALLO: se esperaba la versión ${EXPECTED_VERSION}" >&2
    exit 1
  fi
fi

curl -fsS --max-time 10 "${BASE_URL}/products" > /dev/null
echo "OK: el despliegue responde"
