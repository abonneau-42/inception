up:
	mkdir -p /home/abonneau/data/wordpress_data /home/abonneau/data/mariadb_data
	docker compose -p inception -f srcs/docker-compose.yml up -d --build

down:
	docker compose -p inception -f srcs/docker-compose.yml down

all: up

destroy: down
	docker system prune -a --volumes -f
	rm -rf /home/abonneau/data

re: destroy up

ls:
	@printf "\033[0;36m=== Containers en cours d'exécution ===\033[0m\n"
	docker ps
	@printf "\n\033[0;32m=== Images Docker disponibles ===\033[0m\n"
	docker image ls
	@printf "\n\033[1;33m=== Tous les containers ===\033[0m\n"
	docker container ls -a
	@printf "\n\033[0;36m=== Réseaux Docker ===\033[0m\n"
	docker network ls
	@printf "\n\033[0;32m=== Volumes Docker ===\033[0m\n"
	docker volume ls

.PHONY: up down all destroy re ls