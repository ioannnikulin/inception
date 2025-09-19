COMPOSE=@docker compose -f ./srcs/docker-compose.yml

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

maria:
	$(COMPOSE) build --no-cache mariadb

inside_maria:
	docker exec -it mariadb sh

all: up
