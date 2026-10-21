"""API principal de Tienda Ágora."""

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

from app.cart import CartError, CartStore, cart_total
from app.config import get_environment, is_enabled
from app.products import get_product, list_products
from app.version import API_NAME, get_commit, get_version

app = FastAPI(
    title=API_NAME,
    version=get_version(),
    description="API didáctica para el curso Entornos de Integración y Entrega Continua.",
)

carts = CartStore()

ERROR_STATUS = {
    "Cart not found": 404,
    "Product not found": 404,
}


class CartItemIn(BaseModel):
    product_id: int
    quantity: int = Field(default=1)


def _raise_http(error: CartError) -> None:
    message = str(error)
    raise HTTPException(status_code=ERROR_STATUS.get(message, 422), detail=message)


@app.get("/health")
def health() -> dict[str, str]:
    """Endpoint de smoke test: confirma que la API responde."""
    return {"status": "ok"}


@app.get("/version")
def version() -> dict[str, str]:
    """Trazabilidad: qué versión y qué commit están desplegados y dónde."""
    return {
        "name": API_NAME,
        "version": get_version(),
        "commit": get_commit(),
        "environment": get_environment(),
    }


@app.get("/products")
def products() -> list[dict]:
    """Devuelve el catálogo de productos."""
    return list_products()


@app.get("/products/{product_id}")
def product_detail(product_id: int) -> dict:
    """Devuelve el detalle de un producto."""
    product = get_product(product_id)
    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    return product


@app.post("/carts", status_code=201)
def create_cart() -> dict[str, int]:
    """Crea un carrito vacío."""
    return {"cart_id": carts.create()}


@app.get("/carts/{cart_id}")
def get_cart(cart_id: int) -> dict:
    """Devuelve las líneas de un carrito."""
    try:
        return {"cart_id": cart_id, "items": carts.items(cart_id)}
    except CartError as error:
        _raise_http(error)


@app.post("/carts/{cart_id}/items", status_code=201)
def add_item(cart_id: int, item: CartItemIn) -> dict:
    """Agrega un producto al carrito."""
    try:
        carts.add_item(cart_id, item.product_id, item.quantity)
        return {"cart_id": cart_id, "items": carts.items(cart_id)}
    except CartError as error:
        _raise_http(error)


@app.get("/carts/{cart_id}/total")
def get_total(cart_id: int, code: str | None = None) -> dict:
    """Total del carrito. Los códigos de descuento dependen de un feature flag."""
    if code and not is_enabled("discount_codes"):
        raise HTTPException(status_code=400, detail="Discount codes are disabled")
    try:
        total = cart_total(carts.items(cart_id), code)
    except CartError as error:
        _raise_http(error)
    return {"cart_id": cart_id, "total": total, "discount_code": code}
