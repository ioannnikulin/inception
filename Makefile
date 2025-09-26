COMPOSE=@docker compose -f ./srcs/docker-compose.yml

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

remaria: stop
	sudo rm -rf storage/mariadb
	$(COMPOSE) build --no-cache mariadb

rewp: stop
	sudo rm -rf storage/wordpress
	$(COMPOSE) build --no-cache wordpress

inside_wp:
	docker exec -it wordpress sh

inside_mariadb:
	docker exec -it mariadb sh

all: up
