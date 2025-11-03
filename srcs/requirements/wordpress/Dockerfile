# Image de base avec PHP-FPM
FROM debian:bookworm-slim

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive

# Installation de PHP, FPM, et extensions nécessaires à WordPress
RUN apt update && apt install -y \
    php-fpm php-mysql wget curl unzip mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Télécharger WordPress
WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Copier ton fichier de configuration personnalisé
# COPY ./wp-config.php /var/www/html/wp-config.php

# Donner les bons droits
RUN chown -R www-data:www-data /var/www/html

# Exposer le port du PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM en avant-plan
CMD ["php-fpm8.2", "-F"]
