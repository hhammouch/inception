#!/bin/bash

# Wait for MariaDB to fully boot up (Polling instead of sleeping)
echo "Waiting for MariaDB..."
# We keep trying to connect until it succeeds
while ! mysqladmin ping -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
    sleep 2
done
echo "MariaDB is ready!"

cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Configuring database connection..."
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    echo "Installing WordPress and creating Admin..."
    wp core install \
        --url=${DOMAIN_NAME} \
        --title="My Inception Site" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    echo "Creating a second regular user..."
    wp user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${WP_USER_PASSWORD} \
        --allow-root
        
    echo "Fixing permissions for the web server..."
    chown -R www-data:www-data /var/www/html
fi


exec /usr/sbin/php-fpm8.2 -F