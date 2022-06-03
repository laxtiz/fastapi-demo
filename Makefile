SRC := fastapi_demo/
TESTS := tests/

.PHONY: all clean

all: format test build

build:
	poetry build

format:
	poetry run isort ${SRC} ${TESTS}
	poetry run black ${SRC} ${TESTS}

test:
	poetry run pytest ${TESTS}

run:
	poetry run uvicorn --reload main:app

clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	rm -rf .pytest_cache/
	rm -rf dist/

deploy: requirements.txt
	deta deploy

requirements.txt: poetry.lock
	poetry export --without-hashes -f requirements.txt > requirements.txt
