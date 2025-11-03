# Image de base Debian stable
FROM debian:bookworm-slim

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive

# Mise à jour et installation de nginx + openssl
RUN apt update && apt install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Création des répertoires
RUN mkdir -p /etc/nginx/certs /var/www/html

# Copie du certificat et de la clé (tu peux aussi les générer à la volée)
# COPY certs/server.crt /etc/nginx/certs/server.crt
# COPY certs/server.key /etc/nginx/certs/server.key

# Copie du fichier de configuration nginx
COPY default.conf /etc/nginx/conf.d/default.conf

# Activation du port HTTPS
EXPOSE 443

# Démarrage de nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]
