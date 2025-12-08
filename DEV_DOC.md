# Developer Documentation

## Instructions

Ensure that **Docker** and **Docker Compose** are installed:

```bash
docker --version
docker compose version
```

Clone the repository:

```bash
git clone <your-repository-url>
cd <project-folder>
```

## Implementation

Give execution rights to the certificate creation script:

```bash
chmod +x create_certs.sh
```

Run the script to generate the TLS certificates:

```bash
./create_certs.sh
```

This will create your SSL keys and certificates in the appropriate directory before the containers start.

You must create a .env file in both directories:

- /srcs
- /srcs_bonus

Create .env in srcs and srcs_bonus:

Here is an example template:

```bash
# Database Settings
MYSQL_ROOT_PASSWORD=
WORDPRESS_DB_NAME=wp_db
WORDPRESS_DB_USER=
WORDPRESS_DB_PASSWORD=
WORDPRESS_DB_HOST=mariadb

# WordPress Site Settings
WORDPRESS_URL=http://localhost
WORDPRESS_TITLE=

# WordPress Admin Credentials
WORDPRESS_ADMIN_USER=
WORDPRESS_ADMIN_PASSWORD=
WORDPRESS_ADMIN_EMAIL=

WORDPRESS_RANDOM_USER=
WORDPRESS_RANDOM_PASSWORD=
WORDPRESS_RANDOM_EMAIL=
```

Then, run a make command.

## Relevant Commands to Manage Containers and Volumes

### Check container status
Use:

```bash
make ls
```

### Inspect logs
Use:

```bash
docker logs <container-name>
```

### Verify database container health
Use:

```bash
docker exec -it mariadb mysql -u root -p
```

### Show detailed information about a container
Use:

```bash
docker inspect <container-name>
```

### Open a shell inside a container
Use:

```bash
docker exec -it <container-name> bash
```

### Start the entire stack  
Use:

```bash
make up
```

### Stop everything
Use:

```bash
make down
```

### Rebuild

Use:

```bash
make re
```

### Clean (remove volumes, images, containers.)

Use:

```bash
make destroy
```

## Persistent Storage

This project uses persistent storage to ensure that critical data — such as database content, WordPress files, uploaded media, static website content, and portfolio data — is preserved even if containers are stopped, restarted, or rebuilt.

Docker achieves persistence using volumes. Specifically, this project uses bind-mounted volumes, which are volumes that map a container directory directly to a directory on the host machine. This means that all read and write operations inside the container are actually performed on the host filesystem, ensuring data is preserved independently of the container’s lifecycle.

### Project Volumes

- mariadb_data
- wordpress_data
- static_website_data
- portfolio_data

### How Data is Stored

Each volume maps a host directory to a container path. For example:

```bash
mariadb_data:
  driver: local
  driver_opts:
    type: volume
    device: /home/abonneau/data/mariadb_data
    o: bind
```

/var/lib/mysql inside the MariaDB container is linked directly to /home/abonneau/data/mariadb_data on your host.

Any changes inside the container are immediately reflected in the host folder, and vice versa.

Stopping, restarting, or removing a container does not delete data, because the data resides on the host.

Rebuilding the container or pulling a new image does not affect existing data.