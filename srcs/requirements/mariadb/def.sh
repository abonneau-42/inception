# #!/bin/bash
# set -e

# # Initialize data directory if empty
# if [ ! -d /var/lib/mysql/mysql ]; then
#     echo "Initializing MariaDB data directory..."
#     mariadb-install-db --user=mysql --datadir=/var/lib/mysql
# fi

# # Start MariaDB as 'mysql' user, replace shell process
# exec gosu mysql mariadbd --datadir=/var/lib/mysql