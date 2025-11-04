#!/bin/bash
set -e

WP_PATH="/var/www/html"

cd "$WP_PATH"

# Vérifie si wp-cli est accessible
if ! command -v wp &> /dev/null; then
  echo "❌ wp-cli introuvable"
  exit 1
fi

# Crée wp-config.php s'il n'existe pas
if [ ! -f wp-config.php ]; then
  echo "⚙️  Création de wp-config.php via WP-CLI..."
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --path="$WP_PATH" \
    --allow-root

  echo "🔑 Génération automatique des clés de sécurité..."
  wp config shuffle-salts --allow-root
else
  echo "✅ wp-config.php déjà présent, aucun changement."
fi

# Vérifie si WordPress est installé
if ! wp core is-installed --allow-root; then
  echo "🌍 Installation de WordPress..."
  wp core install \
    --url="abonneau.42.fr" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    --skip-email \
    --allow-root

  # echo "🔄 Mise à jour de l’URL du site..."
  # wp option update home 'https://abonneau.42.fr' --allow-root
  # wp option update siteurl 'https://abonneau.42.fr' --allow-root
else
  echo "✅ WordPress déjà installé."
fi

# Create a new wordpress user if it doesn't exist
if ! wp user get "$WORDPRESS_USER" --allow-root &> /dev/null; then
  echo "👤 Création de l’utilisateur WordPress '$WORDPRESS_USER'..."
  wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" --role=author --user_pass="$WORDPRESS_USER_PASSWORD" --allow-root
fi

# Droits
chown -R www-data:www-data "$WP_PATH"

# Lancer php-fpm
echo "🚀 Démarrage de PHP-FPM..."
exec php-fpm8.2 -F