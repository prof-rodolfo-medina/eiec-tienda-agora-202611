import pytest

from app.cart import CartError, CartStore, cart_total

pytestmark = pytest.mark.unit


@pytest.fixture
def store():
    return CartStore()


def test_new_cart_is_empty(store):
    cart_id = store.create()

    assert store.items(cart_id) == []


def test_add_item_accumulates_quantity(store):
    cart_id = store.create()
    store.add_item(cart_id, product_id=1, quantity=2)
    store.add_item(cart_id, product_id=1, quantity=1)

    assert store.items(cart_id)[0]["quantity"] == 3


@pytest.mark.parametrize("quantity", [0, -1])
def test_add_item_rejects_non_positive_quantity(store, quantity):
    cart_id = store.create()

    with pytest.raises(CartError, match="Quantity must be positive"):
        store.add_item(cart_id, product_id=1, quantity=quantity)


def test_add_item_rejects_insufficient_stock(store):
    cart_id = store.create()

    with pytest.raises(CartError, match="Insufficient stock"):
        store.add_item(cart_id, product_id=2, quantity=1000)


def test_add_item_rejects_unknown_product(store):
    cart_id = store.create()

    with pytest.raises(CartError, match="Product not found"):
        store.add_item(cart_id, product_id=999, quantity=1)


def test_unknown_cart_raises(store):
    with pytest.raises(CartError, match="Cart not found"):
        store.items(42)


def test_cart_total_without_discount():
    lines = [{"subtotal": 10.0}, {"subtotal": 5.5}]

    assert cart_total(lines) == 15.5


def test_cart_total_with_valid_discount():
    lines = [{"subtotal": 100.0}]

    assert cart_total(lines, "agora10") == 90.0


def test_cart_total_rejects_invalid_discount():
    with pytest.raises(CartError, match="Invalid discount code"):
        cart_total([{"subtotal": 1.0}], "NOPE")
