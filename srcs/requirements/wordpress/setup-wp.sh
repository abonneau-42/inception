#!/bin/bash
set -e

WP_PATH="/var/www/html"



cd "$WP_PATH"

# Variables nécessaires
: "${WORDPRESS_DB_HOST:?Variable WORDPRESS_DB_HOST manquante}"
: "${WORDPRESS_DB_USER:?Variable WORDPRESS_DB_USER manquante}"
: "${WORDPRESS_DB_PASSWORD:?Variable WORDPRESS_DB_PASSWORD manquante}"
: "${WORDPRESS_DB_NAME:?Variable WORDPRESS_DB_NAME manquante}"

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
    --url="${WORDPRESS_URL:-http://localhost}" \
    --title="${WORDPRESS_TITLE:-Mon site WordPress}" \
    --admin_user="${WORDPRESS_ADMIN_USER:-admin}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD:-admin}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL:-admin@example.com}" \
    --skip-email \
    --allow-root
else
  echo "✅ WordPress déjà installé."
fi

# define('DB_NAME', 'mydatabase');
# define('DB_USER', 'user');
# define('DB_PASSWORD', 'userpassword');
# define('DB_HOST', 'mariadb');  // doit correspondre au nom du service Docker

# Droits
chown -R www-data:www-data "$WP_PATH"

# Lancer php-fpm
echo "🚀 Démarrage de PHP-FPM..."
exec php-fpm8.2 -F