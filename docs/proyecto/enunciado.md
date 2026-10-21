# Proyecto Tienda Ágora

**Carácter:** formativo, no sumativo · **Modalidad:** individual o en equipo (2 a 4 personas) · **Duración:** 8 semanas

## Historia

Ágora es una tienda en línea pequeña que vende artículos para equipos de desarrollo. Su API alimenta la web y una app móvil de clientes empresariales. Hoy el código funciona y tiene pruebas, pero:

- no hay reglas para integrar cambios en `main`;
- cada despliegue lo hace "quien sabe cómo", a mano;
- nadie puede decir con certeza qué versión corre en producción ni de qué commit salió;
- encender una funcionalidad nueva implica desplegar código nuevo.

La dirección te contrata para que, en ocho semanas, Ágora pueda **entregar cualquier día, con evidencia y con marcha atrás**. No buscamos una tienda completa: buscamos un flujo de entrega confiable.

## Lo que recibes

| Pieza | Ubicación | Estado inicial |
|---|---|---|
| API FastAPI: salud, versión, catálogo y carrito | `app/` | Funcional |
| Pruebas unitarias, de API y de humo | `tests/` | 30 pruebas, ~95 % de cobertura (con huecos a propósito) |
| Fase de commit en GitHub Actions | `.github/workflows/ci.yml` | Activa |
| Dockerfile y docker-compose | raíz | Listos para la semana 6 |
| Plantillas de pipelines por semana | `pipelines/` | Para copiar cuando toque |
| Scripts de nube | `infra/` | Para las semanas 7 y 8 |
| Bitácora | `BITACORA.md` | Vacía: es tuya |

### Endpoints iniciales

```text
GET  /health                     smoke test
GET  /version                    nombre, versión, commit y entorno
GET  /products                   catálogo
GET  /products/{id}              detalle (404 si no existe)
POST /carts                      crea un carrito
GET  /carts/{id}                 líneas del carrito
POST /carts/{id}/items           agrega {product_id, quantity}; valida stock (422)
GET  /carts/{id}/total?code=     total; los códigos de descuento dependen del flag FEATURE_DISCOUNT_CODES
```

## Reglas del juego

1. Trabaja siempre en **tu fork**. Todo cambio entra a tu `main` por Pull Request.
2. Desde la semana 2, `main` está protegida: sin check verde no se fusiona.
3. Cada semana deja **una mejora visible** en el pipeline o en el proyecto y **una entrada** en `BITACORA.md`.
4. Ningún secreto se versiona: credenciales y perfiles de publicación van en *GitHub Secrets*.
5. Lo que se crea en la nube se etiqueta y se elimina al terminar.

## Hoja de ruta y definición de terminado

| Sem. | Mejora | Definición de terminado (nivel base) |
|---|---|---|
| 1 | Punto de partida | Fork funcionando, CI verde, PR de registro, diagnóstico de madurez inicial |
| 2 | Integración continua | `main` protegida con check obligatorio; un PR rojo bloqueado y uno verde fusionado |
| 3 | Pruebas como llaves de paso | Una historia del backlog con pruebas unitarias y de API, fusionada en verde |
| 4 | Calidad | Quality gate de cobertura activo; PR aprobado por otra persona; retrospectiva del bloque I |
| 5 | Otra herramienta | El pipeline corre en Jenkins desde el Jenkinsfile del repositorio |
| 6 | Artefactos | Imagen `1.0.0` en GHCR trazable a su commit |
| 7 | Entrega continua | Staging y producción en la nube, con aprobación manual y smoke tests |
| 8 | Despliegue controlado | Antes del miércoles 27 (el examen es el jueves 28 o viernes 29): feature flag sin redeploy, demo final en video, diagnóstico final y nube limpia |

Cada guía semanal en [`docs/semanas/`](../semanas/) detalla además los niveles **intermedio** y **avanzado** para quien quiera perfeccionar su proyecto.

## Backlog

Historias para elegir en la semana 3 y para perfeccionar el proyecto después. Toda historia lleva pruebas.

| ID | Historia | Pista técnica | Temas que ejercita |
|---|---|---|---|
| H1 | Como cliente quiero saber cuántos productos hay (`GET /products/count`) | Orden de rutas en FastAPI | 5 |
| H2 | Como cliente quiero buscar productos por nombre (`GET /products?search=`) | Búsqueda sin distinguir mayúsculas ni acentos | 5 |
| H3 | Como cliente quiero quitar un producto del carrito (`DELETE /carts/{id}/items/{product_id}`) | 404 si no está en el carrito | 5 |
| H4 | Como cliente quiero confirmar mi pedido (`POST /orders`) y que se descuente el stock | Separar lógica en `app/orders.py` | 5, 6 |
| H5 | Como operador quiero que los carritos sobrevivan a un reinicio | SQLite + scripts de migración versionados | 2, 4 |
| H6 | Como operador quiero un endpoint `/ready` que verifique dependencias | Diferencia entre *liveness* y *readiness* | 4, 10 |
| H7 | Como negocio quiero activar el envío gratis con un flag (`FEATURE_FREE_SHIPPING`) | Mismo patrón que los descuentos | 10 |
| H8 | Como operador quiero logs estructurados en JSON con el commit en cada línea | Trazabilidad en producción | 9, 10 |
| H9 | Como cliente móvil quiero que la API exija una API key | Secretos por entorno, nunca en el repositorio | 4, 10 |

## Trabajo en equipo

Ver [equipos.md](equipos.md) para la organización, los roles rotativos y cómo usar un solo fork por equipo.

## Seguimiento

Retroalimentación formativa con semáforo: [rubrica-formativa.md](rubrica-formativa.md).
