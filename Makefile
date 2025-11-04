up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

all: up

destroy: down
	docker system prune -a --volumes -f
	rm -rf /home/abonneau/data

re: destroy up

.PHONY: up down all destroy re