# Atajos de desarrollo. Cada objetivo es un paso que luego automatiza el pipeline.
# En Windows usa Git Bash, WSL o un Codespace.

PYTHON ?= python
IMAGE ?= tienda-agora-api
VERSION ?= 0.1.0
GIT_SHA ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo local)
BASE_URL ?= http://127.0.0.1:8000

.PHONY: install lint test test-unit test-api coverage run docker-build docker-run smoke clean

install:
	$(PYTHON) -m pip install -r requirements-dev.txt

lint:
	flake8 app tests

test:
	$(PYTHON) -m pytest -q

test-unit:
	$(PYTHON) -m pytest -q -m unit --junitxml=reports/unit.xml

test-api:
	$(PYTHON) -m pytest -q -m api --junitxml=reports/api.xml

coverage:
	$(PYTHON) -m pytest -q --cov=app --cov-report=term-missing --cov-report=xml --cov-report=html

run:
	uvicorn app.main:app --reload

docker-build:
	docker build --build-arg APP_VERSION=$(VERSION) --build-arg GIT_SHA=$(GIT_SHA) -t $(IMAGE):$(VERSION) .

docker-run:
	docker run --rm -p 8000:8000 -e APP_ENV=local $(IMAGE):$(VERSION)

smoke:
	BASE_URL=$(BASE_URL) $(PYTHON) -m pytest -q -m smoke
	BASE_URL=$(BASE_URL) bash scripts/smoke_test.sh

clean:
	rm -rf .pytest_cache htmlcov reports .coverage coverage.xml
