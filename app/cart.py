"""Carrito de compras en memoria.

La lógica vive aquí, separada de FastAPI, para poder probarla con
pruebas unitarias rápidas (Tema 5) sin levantar un servidor HTTP.
"""

from typing import Any

from app.products import get_product

DISCOUNT_CODES: dict[str, float] = {"AGORA10": 0.10}


class CartError(ValueError):
    """Error de negocio al operar un carrito."""


class CartStore:
    """Almacén de carritos en memoria (se reinicia con cada despliegue)."""

    def __init__(self) -> None:
        self._carts: dict[int, dict[int, int]] = {}
        self._next_id = 1

    def create(self) -> int:
        """Crea un carrito vacío y devuelve su identificador."""
        cart_id = self._next_id
        self._carts[cart_id] = {}
        self._next_id += 1
        return cart_id

    def exists(self, cart_id: int) -> bool:
        return cart_id in self._carts

    def add_item(self, cart_id: int, product_id: int, quantity: int) -> None:
        """Agrega unidades de un producto validando cantidad y stock."""
        if not self.exists(cart_id):
            raise CartError("Cart not found")
        if quantity <= 0:
            raise CartError("Quantity must be positive")
        product = get_product(product_id)
        if product is None:
            raise CartError("Product not found")
        current = self._carts[cart_id].get(product_id, 0)
        if current + quantity > product["stock"]:
            raise CartError("Insufficient stock")
        self._carts[cart_id][product_id] = current + quantity

    def items(self, cart_id: int) -> list[dict[str, Any]]:
        """Devuelve las líneas del carrito con subtotal por producto."""
        if not self.exists(cart_id):
            raise CartError("Cart not found")
        lines = []
        for product_id, quantity in self._carts[cart_id].items():
            product = get_product(product_id)
            lines.append(
                {
                    "product_id": product_id,
                    "name": product["name"],
                    "quantity": quantity,
                    "subtotal": round(product["price"] * quantity, 2),
                }
            )
        return lines


def cart_total(lines: list[dict[str, Any]], discount_code: str | None = None) -> float:
    """Calcula el total de un carrito, aplicando un código si es válido."""
    total = sum(line["subtotal"] for line in lines)
    if discount_code:
        rate = DISCOUNT_CODES.get(discount_code.upper())
        if rate is None:
            raise CartError("Invalid discount code")
        total = total * (1 - rate)
    return round(total, 2)
