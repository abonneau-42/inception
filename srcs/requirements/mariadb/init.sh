#!/bin/bash
set -e

echo "🔧 Configuring MariaDB..."

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "🆕 Initializing the database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -f /var/lib/mysql/.initialized ]; then
    cat > /tmp/init.sql <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
        CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
    touch /var/lib/mysql/.initialized
    exec mysqld --datadir=/var/lib/mysql --init-file=/tmp/init.sql --bind-address=0.0.0.0 --user=mysql
else
    echo "📡 Launching MariaDB..."
    exec mysqld --datadir=/var/lib/mysql --bind-address=0.0.0.0 --user=mysql
fi
