FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION_MARIADB="1:10.11.14-0+deb12u2"
ENV VERSION_GOSU="1.14-1+b10"
ENV VERSION_WGET="1.21.3-1+deb12u1"
ENV VERSION_CURL="7.88.1-10+deb12u14"
ENV VERSION_LESS="590-2.1~deb12u2"
ENV VERSION_PHP="2:8.2+93"
ENV VERSION_UNZIP="6.0-28"
ENV VERSION_CA_CERTS="20230311+deb12u1"
ENV VERSION_WP_CLI="2.12.0"

RUN apt update && apt install -y \
    php-fpm=${VERSION_PHP} \
    php-mysql=${VERSION_PHP} \
    mariadb-client=${VERSION_MARIADB} \
    wget=${VERSION_WGET} \
    curl=${VERSION_CURL} \
    less=${VERSION_LESS} \
    unzip=${VERSION_UNZIP} \
    ca-certificates=${VERSION_CA_CERTS} \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://github.com/wp-cli/wp-cli/releases/download/v${VERSION_WP_CLI}/wp-cli-${VERSION_WP_CLI}.phar \
    && chmod +x wp-cli-${VERSION_WP_CLI}.phar \
    && mv wp-cli-${VERSION_WP_CLI}.phar /usr/local/bin/wp

COPY setup-wp.sh /usr/local/bin/setup-wp.sh
RUN chmod +x /usr/local/bin/setup-wp.sh

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's/listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/local/bin/setup-wp.sh"]
