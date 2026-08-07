# Developer Documentation (DEV_DOC.md)

Welcome to the **Inception** developer documentation. This document is designed for developers who wish to set up, build, manage, and understand the technical architecture and data persistence of this infrastructure.

---

## 1. Environment Setup

To set up the environment from scratch, you need to ensure the following prerequisites and configuration files are prepared.

### Prerequisites
*   **Operating System:** Linux (typically an Alpine or Debian VM as per project requirements).
*   **Software:** Docker and Docker Compose must be installed. `make` is also required to run the automated commands.
*   **Hosts File:** Your local `/etc/hosts` must contain an entry mapping `127.0.0.1` to your domain name (e.g., `hhammouc.42.fr`).
*   **Data Directories:** The directories `/home/hhammouc/data/wordpress` and `/home/hhammouc/data/mariadb` must exist on the host machine. (The provided `Makefile` handles this automatically).

### Configuration Files & Secrets
*   **.env File:** You must create a `.env` file at the root of the repository (`srcs/.env` or root depending on your exact setup structure, but generally passed to docker-compose). This file should contain all the environment variables and secrets (e.g., `MYSQL_ROOT_PASSWORD`, `WP_ADMIN_PASSWORD`). 
*   **Important:** Never commit the `.env` file to version control. If you use Docker Secrets, configure them appropriately to inject the credentials securely.

---

## 2. Build and Launch

The project infrastructure is orchestrated via Docker Compose and wrapped in a standard `Makefile` at the root of the repository.

*   **Build and Start (Detached):**
    ```bash
    make all
    ```
    *(This command will automatically create the necessary host data directories and run `docker compose up -d --build`)*

*   **Start without Rebuilding:**
    ```bash
    make up
    ```

*   **Stop Services:**
    ```bash
    make down
    ```

---

## 3. Container and Volume Management

Here are relevant commands to manage and monitor the infrastructure during development:

*   **View Running Containers:**
    ```bash
    docker ps
    ```
*   **View Container Logs:**
    ```bash
    docker logs <container_name>
    # Example: docker logs wordpress
    ```
*   **Access a Container Shell:**
    ```bash
    docker exec -it <container_name> /bin/bash
    # Example: docker exec -it mariadb /bin/bash
    # (Note: Alpine containers might use /bin/sh instead)
    ```
*   **Clean Up Volumes and Containers:**
    ```bash
    make clean
    ```
*   **Complete System Reset (fclean):**
    ```bash
    make fclean
    ```
    *(This command safely takes down the containers, forcefully removes the host data directories contents, and prunes all Docker system resources including images and volumes).*

---

## 4. Data Storage and Persistence

Data persistence is a critical requirement. The infrastructure uses **Docker Named Volumes** (configured with the local driver) to store persistent data, rather than simple host bind mounts.

### Where is the data stored?
*   **WordPress Website Files:** Stored in the `wordpress_data` named volume, physically mapped to `/home/hhammouc/data/wordpress` on the host machine.
*   **MariaDB Database:** Stored in the `mariadb_data` named volume, physically mapped to `/home/hhammouc/data/mariadb` on the host machine.

### How does it persist?
By utilizing Docker named volumes mapped to specific paths on the host, data safely persists even if the `wordpress` or `mariadb` containers crash, are stopped, or are entirely removed. When the containers are rebuilt or restarted, Docker remounts the volumes, ensuring that the database records, WordPress configurations, and uploaded media are retained.
