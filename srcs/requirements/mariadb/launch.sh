#!/bin/bash
set -e

echo "🔧 Configuration de MariaDB..."

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "🆕 Initialisation de la base de données..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

echo "🚀 Démarrage temporaire de MariaDB pour initialisation..."
mysqld_safe --datadir=/var/lib/mysql &
sleep 5

echo "🧩 Exécution des commandes SQL supplémentaires..."
mariadb -uroot -p${MYSQL_ROOT_PASSWORD} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
    CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "✅ Initialisation terminée."
killall mariadbd || true
sleep 3

echo "📡 Lancement de MariaDB..."
exec gosu mysql mariadbd --datadir=/var/lib/mysql --bind-address=0.0.0.0
