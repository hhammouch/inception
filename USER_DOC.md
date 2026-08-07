# User Documentation (USER_DOC.md)

Welcome to the **Inception** infrastructure documentation. This document provides a simple, end-user guide to understanding, starting, accessing, and monitoring the services provided by this stack.

---

## 1. Services Provided

This infrastructure runs as a set of isolated microservices using Docker:

*   **NGINX:** The secure entry point for the web application, handling HTTPS connections over port `443` using TLS v1.2/v1.3.
*   **WordPress + PHP-FPM:** The core Content Management System (CMS) serving the website frontend[cite: 1].
*   **MariaDB:** The database storing WordPress posts, user accounts, and configuration data[cite: 1].
*   **Redis:** An in-memory caching system that speeds up WordPress database queries.
*   **FTP Server (vsftpd):** An FTP service allowing file transfer directly into the WordPress directory on port `21`.
*   **Adminer:** A web-based database management interface accessible on port `8080`.
*   **Static Website:** A showcase webpage accessible on port `8000`.
*   **Glances:** A real-time system and container performance monitoring dashboard accessible on port `61208`.

---

## 2. Starting and Stopping the Project

All service management is handled through the root `Makefile`[cite: 1]:

*   **To start all services:**
    ```bash
    make
    ```
    *(or `make all` / `make up`)*

*   **To stop all services:**
    ```bash
    make down
    ```

*   **To clean up containers, networks, and images:**
    ```bash
    make clean
    ```

*   **To perform a complete reset (including stored data volumes):**
    ```bash
    make fclean
    ```

---

## 3. Accessing the Website and Admin Panels

Ensure your local hosts file (`/etc/hosts`) maps `127.0.0.1` or your VM IP to `hhammouc.42.fr`[cite: 1]:

*   **Main WordPress Site:** `https://hhammouc.42.fr`
*   **WordPress Admin Panel:** `https://hhammouc.42.fr/wp-admin`
*   **Adminer (Database GUI):** `http://hhammouc.42.fr:8080`
*   **Static Showcase Site:** `http://hhammouc.42.fr:8000`
*   **Glances System Dashboard:** `http://hhammouc.42.fr:61208`

---

## 4. Locating and Managing Credentials

All sensitive credentials and environment parameters are stored securely inside the non-committed `.env` file at the root of the project (or inside the `secrets/` directory if configured):

*   **WordPress Admin:** Username and password defined in `.env` (`WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`).
*   **WordPress Normal User:** Defined in `.env` (`WP_USER`, `WP_PASSWORD`).
*   **MariaDB Root & User:** Defined in `.env` (`MYSQL_ROOT_PASSWORD`, `MYSQL_USER`, `MYSQL_PASSWORD`).
*   **FTP Credentials:** Defined in `.env` (`FTP_USER`, `FTP_PASSWORD`).

> **Note:** To change credentials, modify the values in `.env` and restart the stack using `make re`.

---

## 5. Checking Service Health

To verify that all services are up and running properly:

1.  **Check Container Status:**
    ```bash
    docker ps
    ```
    All containers (`nginx`, `wordpress`, `mariadb`, `redis`, `ftp`, `adminer`, `static_site`, `glances`) should show a `Up` status.

2.  **View Live Performance:**
    Navigate to `http://hhammouc.42.fr:61208` in your web browser to open **Glances**, which displays live CPU, memory, and container status.

3.  **Check Redis Cache Connection:**
    ```bash
    docker exec -it wordpress wp redis status --allow-root --path=/var/www/html
    ```
	