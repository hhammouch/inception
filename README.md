*This project has been created as part of the 42 curriculum by hhammouc.

## Description

This project is a System Administration related exercise aimed at broadening knowledge of system administration by using Docker. It consists of setting up a small infrastructure composed of different services (NGINX, MariaDB, and WordPress) under specific rules within a personal virtual machine. 

### Design Choices & Core Concepts

This project relies heavily on Docker to isolate services into dedicated containers rather than running them directly on the host[cite: 1]. Below is a comparison of the core technologies and design choices utilized in this infrastructure:

**Virtual Machines vs Docker:**
*   **Virtual Machines:** Virtualize the entire physical hardware and require a complete, separate guest operating system for every instance. 
*   **Docker:** Containerizes the application and shares the host's operating system kernel. This makes containers significantly more lightweight, resource-efficient, and faster to boot than VMs.

**Secrets vs Environment Variables:**
*   **Environment Variables:** Used to configure standard settings (like domain names) across containers via a `.env` file. 
*   **Secrets:** Strongly recommended for storing confidential information (like database passwords or API keys). Unlike standard environment variables, properly configured secrets are not easily exposed in process lists or logs.

**Docker Network vs Host Network:**
*   **Host Network:** Binds the container directly to the host machine's network stack (e.g., `network: host`), which provides no isolation and is strictly forbidden in this project.
*   **Docker Network:** Creates an isolated internal network that establishes a secure connection between containers. It allows WordPress to communicate with MariaDB internally, while only NGINX is exposed to the outside host via port 443.

**Docker Volumes vs Bind Mounts:**
*   **Bind Mounts:** Rely on the host machine's specific directory structure and file paths, which can cause portability issues. They are not allowed for the persistent storage in this project.
*   **Docker Volumes:** Native named volumes managed directly by Docker. They are required for this project to persistently store the WordPress database and website files inside the `/home/<login>/data` directory on the host machine.

---

## Instructions

### Prerequisites
*   A Virtual Machine with Docker and Docker Compose installed.
*   Your local hosts file must be configured so that your domain name (`hhammouc.42.fr`) points to your local IP address.
*   Required data directories must be created at `/home/<hhammouc>/data/wordpress` and `/home/<hhammouc>/data/mariadb`.

### Execution
1.  Clone the repository and ensure your `.env` file is properly configured with your credentials.
2.  Run the following command at the root of the directory to build and start the infrastructure:
    ```bash
    make all
    ```
3.  The NGINX web server will be accessible solely via HTTPS on port 443.
4.  To cleanly stop and remove all containers, networks, and images, run:
    ```bash
    make fclean
    ```

---

## Bonus Features

In addition to the mandatory infrastructure, this project includes several bonus services, each running in its own dedicated container and utilizing custom network configurations where necessary.

*   **Redis Cache:** A Redis container configured as an in-memory cache for the WordPress website. This intercepts database queries to significantly speed up page load times and reduce the load on the MariaDB container.
*   **FTP Server (vsftpd):** A lightweight, secure FTP server pointing directly to the WordPress volume. It is configured dynamically to handle passive mode (PASV) connections across the Docker network, allowing external file transfers directly to the web root.
*   **Adminer:** A fast, single-file database management tool written in PHP. It provides a visual, web-based UI to inspect and manage the MariaDB database without needing to use the command line.
*   **Static Website:** A custom, lightweight showcase website built without PHP. It is served on its own dedicated port, proving the ability to host multiple distinct web services on the same infrastructure.
*   **Glances (Service of Choice):** An industry-standard system monitoring dashboard written in Python. It connects directly to the Docker socket to provide a real-time web UI displaying CPU, RAM, and Disk I/O usage for every individual container in the infrastructure.

## Resources

*   [Docker Official Documentation](https://docs.docker.com/)
*   [NGINX SSL/TLS Configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
*   [WordPress CLI Documentation](https://developer.wordpress.org/cli/commands/)

**AI Usage:** Artificial Intelligence tools were utilized during the development of this project to assist with troubleshooting Docker network routing between containers, resolving dependency issues for bonus services (like Glances), and drafting the structure of this README to comply with the evaluation requirements.