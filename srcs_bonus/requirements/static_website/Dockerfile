FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY ./data /var/www/html

WORKDIR /var/www/html

RUN apt update && apt install -y python3 && rm -rf /var/lib/apt/lists/*

CMD ["python3", "-m", "http.server", "8000", "--bind", "0.0.0.0"]