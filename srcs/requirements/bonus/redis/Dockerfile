FROM debian:bookworm

RUN apt-get update && apt-get install -y redis-server && rm -rf /var/lib/apt/lists/*

# Copy your clean configuration file directly
COPY conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]