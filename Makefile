COMPOSE=@docker compose -f ./srcs/docker-compose.yml

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

all: up
