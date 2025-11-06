FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION_WGET="1.21.3-1+deb12u1"
ENV VERSION_PHP="2:8.2+93"
ENV VERSION_WP_CLI="2.12.0"
ENV VERSION_CA_CERTS="20230311+deb12u1"

WORKDIR /var/www/html

COPY setup-wp.sh /usr/local/bin/setup-wp.sh

RUN apt update \
    && apt install -y --no-install-recommends \
        php-fpm=${VERSION_PHP} \
        php-mysql=${VERSION_PHP} \
        wget=${VERSION_WGET} \
        ca-certificates=${VERSION_CA_CERTS} \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/wp-cli/wp-cli/releases/download/v${VERSION_WP_CLI}/wp-cli-${VERSION_WP_CLI}.phar \
        -O /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp /usr/local/bin/setup-wp.sh \
    && chown -R www-data:www-data /var/www/html \
    && sed -i 's/listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/local/bin/setup-wp.sh"]
