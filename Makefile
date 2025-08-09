.PHONY: build up down logs test

build:
<TAB>docker build -t my-node-app .

up:
<TAB>docker compose up --build

down:
<TAB>docker compose down

logs:
<TAB>docker compose logs -f

test:
<TAB>npm test
