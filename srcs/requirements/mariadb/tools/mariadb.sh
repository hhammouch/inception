#!/bin/bash

chown -R mysql:mysql /var/lib/mysql
mysqld_safe &

until mysqladmin ping --silent; do
    sleep 1
done


mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

sleep 2

exec mysqld_safe
