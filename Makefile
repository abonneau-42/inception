up:
	mkdir -p /home/abonneau/data/wordpress_data /home/abonneau/data/mariadb_data
	docker compose -p inception -f srcs/docker-compose.yml up -d --build

down:
	docker compose -p inception -f srcs/docker-compose.yml down

all: up

destroy: down
	docker system prune -a --volumes -f
	(docker volume rm inception_mariadb_data || true)
	(docker volume rm inception_wordpress_data || true)
	rm -rf /home/abonneau/data

re: destroy up

ls:
	@printf "\033[0;36m=== Container in use ===\033[0m\n"
	docker ps
	@printf "\n\033[0;36m=== Docker Images ===\033[0m\n"
	docker image ls
	@printf "\n\033[0;36m=== Docker containers ===\033[0m\n"
	docker container ls -a
	@printf "\n\033[0;36m=== Docker networks ===\033[0m\n"
	docker network ls
	@printf "\n\033[0;36m=== Docker volumes ===\033[0m\n"
	docker volume ls

.PHONY: up down all destroy re ls