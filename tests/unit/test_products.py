import pytest

from app.products import get_product, list_products

pytestmark = pytest.mark.unit


def test_list_products_returns_items():
    assert len(list_products()) >= 1


def test_get_product_returns_existing_product():
    product = get_product(1)

    assert product is not None
    assert product["id"] == 1
    assert {"name", "price", "stock"} <= product.keys()


def test_get_product_returns_none_when_missing():
    assert get_product(999) is None
