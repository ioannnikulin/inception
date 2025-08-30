COMPOSE=@docker compose -f ./srcs/docker-compose.yml
up:
	$(COMPOSE) up -d
