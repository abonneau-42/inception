# User Documentation

## 📌 Overview

This Docker-based project provides a fully functional web stack including:
- **Nginx** (with TLS support)
- **WordPress** (PHP-FPM)
- **MariaDB** (database)

The system allows a user or administrator to:
- Access a WordPress website
- Log into the WordPress administration panel
- Manage database and WordPress credentials
- Start, stop, and monitor the stack

This document explains everything you need to use the project safely.

---

## 🧩 1. Services Provided

| Service | Description | Access |
|---------|-------------|--------|
| **Nginx** | HTTPS reverse proxy, serves WordPress | https://localhost |
| **WordPress** | CMS website, PHP-FPM powered | https://localhost |
| **MariaDB** | Database storing WordPress data | Not directly exposed |

---

## ▶️ 2. Start and Stop the Project

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

Prefix the make command with “b” to launch with a bonus

### 3. Access the Website and Admin Panel
Access the website

Once the containers are running:

👉 https://abonneau.42.fr

Access the WordPress admin panel

Go to:

👉 https://abonneau.42.fr/wp-admin

Use the credentials from your .env file:

WORDPRESS_ADMIN_USER
WORDPRESS_ADMIN_PASSWORD

### 4. Locate and Manage Credentials

All credentials are stored in the .env file

Never push your .env file to Git.

If you need to change credentials:

- Edit the .env file

- Rebuild the containers:

```bash
make re
```

### 5. Check That Services Are Running

#### Check container status
Use:

```bash
make ls
```

#### Inspect logs
Use:

```bash
docker logs <container-name>
```

#### Verify database container health
Use:

```bash
docker exec -it mariadb mysql -u root -p
```