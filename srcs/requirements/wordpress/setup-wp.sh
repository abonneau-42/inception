#!/bin/bash
set -e

WP_PATH="/var/www/html"

cd "$WP_PATH"

if [ -z "$(ls -A $WP_PATH)" ]; then
  wp core download --path=/var/www/html --allow-root
fi

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
else
  echo "✅ WordPress déjà installé."
fi

chown -R www-data:www-data "$WP_PATH"

echo "🚀 Démarrage de PHP-FPM..."
exec php-fpm8.2 -F