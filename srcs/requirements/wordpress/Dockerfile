FROM debian:bookworm

RUN apt-get update && apt-get install -y php8.2-fpm php8.2-mysql curl mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

#php-fmp (php engine) folder
RUN mkdir -p /run/php && mkdir -p /var/www/html

COPY tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

WORKDIR /var/www/html

CMD ["/usr/local/bin/wordpress.sh"]
