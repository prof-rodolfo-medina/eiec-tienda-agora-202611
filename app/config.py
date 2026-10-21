"""Configuración por entorno y feature flags.

Principio del Tema 4: el script de despliegue es el mismo en todos los
entornos; lo que cambia es la configuración, que se lee del entorno.
Principio del Tema 10: desplegar no es lo mismo que liberar; una
funcionalidad puede viajar apagada y encenderse con un flag.
"""

import os

TRUE_VALUES = {"1", "true", "yes", "on", "si", "sí"}


def get_environment() -> str:
    """Nombre del entorno: local, ci, staging o production."""
    return os.getenv("APP_ENV", "local")


def is_enabled(flag_name: str) -> bool:
    """Indica si un feature flag está activo.

    Los flags se definen como variables de entorno con el prefijo
    FEATURE_, por ejemplo FEATURE_DISCOUNT_CODES=true.
    """
    value = os.getenv(f"FEATURE_{flag_name.upper()}", "false")
    return value.strip().lower() in TRUE_VALUES
