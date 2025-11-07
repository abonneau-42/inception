FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt install -y --no-install-recommends \
        redis-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]