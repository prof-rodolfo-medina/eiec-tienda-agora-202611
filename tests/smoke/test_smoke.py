"""Smoke tests contra un entorno desplegado (Temas 4 y 10).

Se ejecutan después de cada despliegue:

    BASE_URL=https://mi-app.azurewebsites.net python -m pytest -m smoke

Si BASE_URL no está definida, se omiten.
"""

import os

import httpx
import pytest

pytestmark = pytest.mark.smoke

BASE_URL = os.getenv("BASE_URL", "").rstrip("/")
EXPECTED_VERSION = os.getenv("EXPECTED_VERSION")

requires_url = pytest.mark.skipif(not BASE_URL, reason="BASE_URL no definida")


@requires_url
def test_deployed_health_is_ok():
    response = httpx.get(f"{BASE_URL}/health", timeout=10)

    assert response.status_code == 200
    assert response.json()["status"] == "ok"


@requires_url
def test_deployed_version_matches_artifact():
    body = httpx.get(f"{BASE_URL}/version", timeout=10).json()

    if EXPECTED_VERSION:
        assert body["version"] == EXPECTED_VERSION
    assert body["environment"] in {"staging", "production", "ci", "local"}


@requires_url
def test_deployed_catalog_is_served():
    response = httpx.get(f"{BASE_URL}/products", timeout=10)

    assert response.status_code == 200
    assert len(response.json()) >= 1
