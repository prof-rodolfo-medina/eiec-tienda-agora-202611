"""Fixtures compartidas por las baterías de pruebas."""

import pytest
from fastapi.testclient import TestClient

from app import main


@pytest.fixture
def client():
    """Cliente HTTP en memoria con un almacén de carritos limpio por prueba."""
    main.carts = main.CartStore()
    return TestClient(main.app)
