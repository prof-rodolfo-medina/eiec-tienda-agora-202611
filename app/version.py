"""Metadatos de versión de Tienda Ágora API.

La versión y el commit viajan con el artefacto para que cualquier entorno
pueda responder "qué estoy ejecutando" sin reconstruir nada:

1. Variables de entorno APP_VERSION y GIT_SHA (las inyecta el Dockerfile).
2. Si no existen, el archivo app/build_info.json (lo escribe el pipeline
   al empaquetar el zip que se despliega en Azure App Service).
3. Si tampoco existe, valores locales por defecto.
"""

import json
import os
from pathlib import Path

API_NAME = "Tienda Ágora API"
DEFAULT_VERSION = "0.1.0"
BUILD_INFO = Path(__file__).with_name("build_info.json")


def _build_info() -> dict[str, str]:
    try:
        return json.loads(BUILD_INFO.read_text(encoding="utf-8"))
    except (FileNotFoundError, ValueError):
        return {}


def get_version() -> str:
    """Devuelve la versión semántica del artefacto en ejecución."""
    return os.getenv("APP_VERSION") or _build_info().get("version", DEFAULT_VERSION)


def get_commit() -> str:
    """Devuelve el commit (SHA corto) con el que se construyó el artefacto."""
    return (os.getenv("GIT_SHA") or _build_info().get("commit", "local"))[:7]
