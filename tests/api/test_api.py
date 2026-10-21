"""Pruebas de contrato HTTP: rutas, códigos de estado y JSON."""

import pytest

pytestmark = pytest.mark.api


def test_health_endpoint_returns_ok(client):
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_version_endpoint_exposes_traceability(client):
    body = client.get("/version").json()

    assert {"name", "version", "commit", "environment"} <= body.keys()


def test_products_endpoint_returns_catalog(client):
    response = client.get("/products")

    assert response.status_code == 200
    assert len(response.json()) >= 1


def test_product_detail_returns_404_when_missing(client):
    response = client.get("/products/999")

    assert response.status_code == 404
    assert response.json()["detail"] == "Product not found"


def test_cart_flow_create_add_and_total(client):
    cart_id = client.post("/carts").json()["cart_id"]

    added = client.post(f"/carts/{cart_id}/items", json={"product_id": 1, "quantity": 2})
    total = client.get(f"/carts/{cart_id}/total")

    assert added.status_code == 201
    assert total.json()["total"] == 25.0


def test_add_item_to_missing_cart_returns_404(client):
    response = client.post("/carts/999/items", json={"product_id": 1, "quantity": 1})

    assert response.status_code == 404


def test_add_item_with_insufficient_stock_returns_422(client):
    cart_id = client.post("/carts").json()["cart_id"]

    response = client.post(f"/carts/{cart_id}/items", json={"product_id": 2, "quantity": 1000})

    assert response.status_code == 422
    assert response.json()["detail"] == "Insufficient stock"


def test_discount_code_rejected_when_flag_is_off(client, monkeypatch):
    monkeypatch.delenv("FEATURE_DISCOUNT_CODES", raising=False)
    cart_id = client.post("/carts").json()["cart_id"]

    response = client.get(f"/carts/{cart_id}/total", params={"code": "AGORA10"})

    assert response.status_code == 400


def test_discount_code_applied_when_flag_is_on(client, monkeypatch):
    monkeypatch.setenv("FEATURE_DISCOUNT_CODES", "true")
    cart_id = client.post("/carts").json()["cart_id"]
    client.post(f"/carts/{cart_id}/items", json={"product_id": 2, "quantity": 2})

    response = client.get(f"/carts/{cart_id}/total", params={"code": "AGORA10"})

    assert response.json()["total"] == 81.0
