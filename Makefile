COMPOSE=@docker compose -f ./srcs/docker-compose.yml

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

wp:
	$(COMPOSE) build --no-cache wordpress

inside_wp:
	docker exec -it wordpress sh

all: up
