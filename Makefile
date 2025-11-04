up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

#delete volumes with --volumes flag




all: up

destroy: down
	docker system prune -a --volumes -f
	docker volume rm $$(docker volume ls -q) 2> /dev/null || true

.PHONY: up down all