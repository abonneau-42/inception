# Image de base avec PHP-FPM
FROM debian:bookworm-slim

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive

# Installation de PHP, FPM, et extensions nécessaires à WordPress
RUN apt update && apt install -y \
    php-fpm php-mysql mariadb-client wget curl less unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Télécharger WordPress
WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Copier ton fichier de configuration personnalisé
# COPY ./wp-config.php /var/www/html/wp-config.php

# Copier le script de setup
COPY setup-wp.sh /usr/local/bin/setup-wp.sh
RUN chmod +x /usr/local/bin/setup-wp.sh

# Donner les bons droits
RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's/listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf
# Exposer le port du PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM en avant-plan
# CMD ["php-fpm8.2", "-F"]

# Lancer le setup avant php-fpm
CMD ["/usr/local/bin/setup-wp.sh"]
