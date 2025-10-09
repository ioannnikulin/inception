COMPOSE=@docker compose -f ./srcs/docker-compose.yml

up:
	sudo mkdir -p ../storage/wordpress
	sudo chown -R 33:33 ../storage/wordpress
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

renginx: stop
	sudo rm -rf storage/nginx
	$(COMPOSE) build --no-cache nginx

recadvisor: stop
	$(COMPOSE) build --no-cache cadvisor

reftp: stop
	$(COMPOSE) build --no-cache ftp

rewebsite: stop
	$(COMPOSE) build --no-cache website

readminer: stop
	$(COMPOSE) build --no-cache adminer

inside_wp:
	docker exec -it wordpress bash

inside_mariadb:
	docker exec -it mariadb bash

inside_nginx:
	docker exec -it nginx bash

inside_ftp:
	docker exec -it ftp sh

connect_ftp:
	ftp 127.0.0.1

maximal_cleanup: stop
	sudo rm -rf storage
	docker system prune -a --volumes -f

all: up
