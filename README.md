*This project has been created as part of the 42 curriculum by abonneau.*

# Inception — README

## Description

**Inception** is an infrastructure project introducing containerization using **Docker**.  
The objective is to set up a small-scale, fully functional environment composed of multiple services, each running in its own container and orchestrated using **Docker Compose**.

The project teaches:
- How containers work and how they differ from full virtual machines  
- How to build custom Docker images  
- How to configure secure and persistent databases  
- How to create a multi-container network  
- How to manage volumes, environment variables, and service dependencies  

You will deploy (minimum):
- A **WordPress** website with a custom configuration  
- A **MariaDB** database  
- An **Nginx** web server with SSL  
All of this using only **Dockerfiles**, without pulling pre-built images.

---

## Instructions

### Requirements

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

### Implementation

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

## Resources

AI was used to research how to set up the services and create this Readme.

## Project description

This project makes use of **Docker** to build a complete and isolated web infrastructure composed of multiple services.  
Each service runs inside its own container, built from a **custom Dockerfile**, and all containers are orchestrated using **Docker Compose**.  
The goal is to reproduce a realistic, modular, and reproducible server setup while understanding the principles of containerization.

### 🔧 Use of Docker in the Project
- **Custom Dockerfiles** are used to build every image (no pre-built images allowed).  
- **Docker Compose** orchestrates all services, handles startup order, environment variables, networking, and volumes.  
- **Docker Networks** isolate the containers while allowing them to communicate internally.  
- **Docker Volumes** ensure data persistence across restarts, especially for MariaDB and WordPress files.  
- The setup is fully reproducible on any machine supporting Docker, requiring no manual configuration.

### 🖥️ Virtual Machines vs Docker

| Virtual Machines | Docker |
|------------------|--------|
| Emulates full hardware and OS | Runs containers using host kernel |
| Heavy, large memory footprint | Lightweight, minimal resource use |
| Slow boot times | Near-instant boot |
| Very strong isolation | Isolation through namespaces/cgroups |
| Ideal for running diverse OSes | Ideal for running isolated services |

➡️ Docker is more efficient for service-oriented architecture.

---

### 🔑 Secrets vs Environment Variables

| Environment Variables | Docker Secrets |
|-----------------------|----------------|
| Easy to use and set | Encrypted and secured |
| Visible inside containers | Not stored inside images |
| Suitable for basic config | Intended for sensitive data (passwords, tokens) |
| Used in this project | Not required but more secure |

➡️ In this project, environment variables are sufficient and required.

---

### 🌐 Docker Network vs Host Network

| Docker Network | Host Network |
|----------------|--------------|
| Creates isolated virtual networks | Container uses host’s network stack |
| Prevents port conflicts | No isolation, port conflicts possible |
| Allows container-to-container communication | Same behavior as any local process |
| More secure | Less secure |

➡️ Docker networks are used to isolate services and control communication.

---

### 💾 Docker Volumes vs Bind Mounts

| Docker Volumes | Bind Mounts |
|----------------|-------------|
| Managed by Docker | Uses host filesystem paths |
| More stable and portable | Useful for dev but less secured |
| Ideal for persistent production data | Ideal for editing files live |
| Used for MariaDB & WordPress | Not used in mandatory part |

➡️ Volumes ensure persistence and isolation from the host.