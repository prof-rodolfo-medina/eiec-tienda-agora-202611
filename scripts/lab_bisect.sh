#!/usr/bin/env bash
# Laboratorio de "diff debugging" (Tema 2) con git bisect.
# Crea un repositorio local de juguete con 8 commits; uno de ellos introduce un error.
# Tu misión: encontrar ese commit sin leer el historial a mano.
#
#   bash scripts/lab_bisect.sh /tmp/lab-bisect
#   cd /tmp/lab-bisect
#   git bisect start HEAD v1.0          # HEAD está roto, v1.0 funcionaba
#   git bisect run python check.py      # Git prueba por ti en ~3 pasos
#   git bisect reset
set -euo pipefail

DIR="${1:-/tmp/lab-bisect}"
rm -rf "$DIR" && mkdir -p "$DIR" && cd "$DIR"
git init -q -b main
git config user.name "Laboratorio EIEC"
git config user.email "lab@example.com"

cat > precios.py <<'EOF'
def total(precios, descuento=0.0):
    return round(sum(precios) * (1 - descuento), 2)
EOF
cat > check.py <<'EOF'
import sys
from precios import total
ok = total([10, 20]) == 30 and total([100], 0.1) == 90
print("OK" if ok else "ROTO")
sys.exit(0 if ok else 1)
EOF
git add . && git commit -qm "Versión inicial del cálculo de total" && git tag v1.0

cambios=(
  "Documenta la función total"
  "Agrega comentario de licencia"
  "Renombra variable interna"
  "BUG: aplica el descuento dos veces"
  "Mejora mensaje de check"
  "Agrega README"
  "Ajusta formato"
)
for i in "${!cambios[@]}"; do
  msg="${cambios[$i]}"
  if [[ "$msg" == BUG* ]]; then
    cat > precios.py <<'EOF'
def total(precios, descuento=0.0):
    subtotal = sum(precios) * (1 - descuento)
    return round(subtotal * (1 - descuento), 2)
EOF
    msg="Refactoriza el cálculo del subtotal"   # el mensaje no delata el error, como en la vida real
  else
    echo "# cambio $i: ${msg}" >> notas.txt
  fi
  git add . && git commit -qm "$msg"
done

echo "Repositorio listo en ${DIR}"
git log --oneline
python3 check.py || echo "HEAD está roto. ¿Qué commit lo rompió? Usa git bisect."
