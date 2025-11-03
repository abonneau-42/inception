# # Image de base Debian
# FROM debian:bookworm-slim

# # Variables d'environnement pour éviter les prompts lors de l'installation
# ENV DEBIAN_FRONTEND=noninteractive

# # Installer MariaDB server et utilitaires
# RUN apt update && \
#     apt install -y mariadb-server mariadb-client && \
#     rm -rf /var/lib/apt/lists/*

# # Créer le répertoire pour les données (MariaDB les utilise par défaut)
# RUN mkdir -p /var/lib/mysql 
# RUN chown -R 999:999 /var/lib/mysql

# # /docker-entrypoint-initdb.d && \
# #     chown -R 999:999 /var/lib/mysql /docker-entrypoint-initdb.d

# RUN mkdir -p /run/mysqld
# RUN chown -R 999:999 /run/mysqld
# # Copier un script d'initialisation si nécessaire
# # COPY init.sql /docker-entrypoint-initdb.d/

# # Exposer le port 3306
# EXPOSE 3306

# # Lancer MariaDB en premier plan
# CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]

FROM debian:bookworm-slim

# Variables d'environnement pour éviter les prompts lors de l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Installer MariaDB server et utilitaires
RUN apt update && \
    apt install -y mariadb-server mariadb-client gosu && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql 
RUN chown -R mysql:mysql /var/lib/mysql

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod 755 /var/run/mysqld

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

CMD ["/launch.sh"]
