FROM debian:bookworm-slim

ENV VERSION_PHP="2:8.2+93"
ENV VERSION_WGET="1.21.3-1+deb12u1"
ENV VERSION_UNZIP="6.0-28"
ENV VERSION_ADMINER="5.4.1"

RUN apt-get update && \
    apt-get install -y php-fpm=${VERSION_PHP} php-mysql=${VERSION_PHP} wget=${VERSION_WGET} unzip=${VERSION_UNZIP} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer

RUN wget -O /var/www/adminer/adminer.php https://github.com/vrana/adminer/releases/download/v${VERSION_ADMINER}/adminer-${VERSION_ADMINER}-en.php

RUN mv /var/www/adminer/adminer.php /var/www/adminer/index.php

RUN chown -R www-data:www-data /var/www/adminer

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]