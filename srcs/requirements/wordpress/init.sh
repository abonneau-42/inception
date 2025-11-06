#!/bin/bash
set -e

if [ ! -d wp-content ]; then
  wp core download --path=/var/www/html --allow-root
fi

if [ ! -f wp-config.php ]; then
  echo "⚙️  Creating wp-config.php via WP-CLI..."
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --path=/var/www/html \
    --allow-root

  wp config shuffle-salts --allow-root
else
  echo "✅ wp-config.php already exists, no changes."
fi

if ! wp core is-installed --allow-root; then
  echo "🌍 Installing WordPress..."
  wp core install \
    --url="abonneau.42.fr" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    --skip-email \
    --allow-root
else
  echo "✅ WordPress already installed."
fi

if ! wp user get "$WORDPRESS_RANDOM_USER" --allow-root &> /dev/null; then
  echo "👤 Random user creation..."
  wp user create "$WORDPRESS_RANDOM_USER" "$WORDPRESS_RANDOM_EMAIL" \
    --role=author \
    --user_pass="$WORDPRESS_RANDOM_PASSWORD" \
    --allow-root
else
  echo "✅ Random user already exists."
fi

chown -R www-data:www-data /var/www/html

echo "🚀 Starting PHP-FPM..."
exec php-fpm8.2 -F