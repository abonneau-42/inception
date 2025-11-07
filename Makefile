up:
	mkdir -p /home/abonneau/data/wordpress_data /home/abonneau/data/mariadb_data
	docker compose -p inception -f srcs/docker-compose.yml up -d --build


down:
	docker compose -p inception -f srcs/docker-compose.yml down


destroy: down
	docker system prune -a --volumes -f
	(docker volume rm inception_mariadb_data || true)
	(docker volume rm inception_wordpress_data || true)
	rm -rf /home/abonneau/data

re: destroy up

all: up




bup:
	mkdir -p /home/abonneau/data/wordpress_data /home/abonneau/data/mariadb_data /home/abonneau/data/static_website_data /home/abonneau/data/portfolio_data
	docker compose -p inception -f srcs_bonus/docker-compose.yml up -d --build

bdown:
	docker compose -p inception -f srcs_bonus/docker-compose.yml down

bdestroy: bdown
	docker system prune -a --volumes -f
	(docker volume rm inception_mariadb_data || true)
	(docker volume rm inception_wordpress_data || true)
	(docker volume rm inception_static_website_data || true)
	(docker volume rm inception_portfolio_data || true)
	sudo rm -rf /home/abonneau/data

bre: bdestroy bup

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