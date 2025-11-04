# Image de base Debian stable
FROM debian:bookworm-slim

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive

# Mise à jour et installation de nginx + openssl
RUN apt update && apt install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Création des répertoires
RUN mkdir -p /etc/nginx/certs /var/www/html

# Copie du fichier de configuration nginx
COPY default.conf /etc/nginx/conf.d/default.conf

# Activation du port HTTPS
EXPOSE 443

# Démarrage de nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]
