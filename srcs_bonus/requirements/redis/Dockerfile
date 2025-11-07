FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

ENV VERSION_REDIS_SERVER="5:7.0.15-1~deb12u6"

RUN apt update \
    && apt install -y --no-install-recommends \
        redis-server=${VERSION_REDIS_SERVER} \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]