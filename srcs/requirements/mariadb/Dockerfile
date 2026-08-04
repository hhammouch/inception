FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

# There can only be one CMD instruction in a Dockerfile.
CMD ["/usr/local/bin/mariadb.sh"]
