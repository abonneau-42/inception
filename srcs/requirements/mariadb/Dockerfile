# Image de base Debian
FROM debian:bookworm-slim

# Variables d'environnement pour éviter les prompts lors de l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Installer MariaDB server et utilitaires
RUN apt update && \
    apt install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Créer le répertoire pour les données (MariaDB les utilise par défaut)
RUN mkdir -p /var/lib/mysql /docker-entrypoint-initdb.d && \
    chown -R mysql:mysql /var/lib/mysql /docker-entrypoint-initdb.d

# Copier un script d'initialisation si nécessaire
# COPY init.sql /docker-entrypoint-initdb.d/

# Exposer le port 3306
EXPOSE 3306

# Lancer MariaDB en premier plan
CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]

