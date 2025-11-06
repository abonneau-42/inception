FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION_NGINX="1.22.1-9+deb12u3"

RUN apt update && apt install -y --no-install-recommends \
    nginx=${VERSION_NGINX} && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/nginx/certs /var/www/html

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
