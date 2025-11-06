FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y php-fpm php-mysql wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer

RUN wget -O /var/www/adminer/adminer.php https://www.adminer.org/latest.php

RUN mv /var/www/adminer/adminer.php /var/www/adminer/index.php

RUN chown -R www-data:www-data /var/www/adminer

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]