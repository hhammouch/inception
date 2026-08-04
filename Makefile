NAME = inception

COMPOSE = srcs/docker-compose.yml

all:
	@mkdir -p /home/hhammouc/data/mariadb
	@mkdir -p /home/hhammouc/data/wordpress
	@docker compose -f $(COMPOSE) up -d --build

up:
	@docker compose -f $(COMPOSE) up -d

down:
	@docker compose -f $(COMPOSE) down


clean:
	@docker compose -f $(COMPOSE) down -v

fclean: clean
	@sudo rm -rf /home/hhammouc/data/mariadb/*
	@sudo rm -rf /home/hhammouc/data/wordpress/*
	@docker system prune -a --force --volumes

re: fclean all

.PHONY: all up down clean fclean re