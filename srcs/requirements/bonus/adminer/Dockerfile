FROM debian:bookworm

RUN apt-get update && apt-get install -y php php-mysql wget && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/www/adminer
WORKDIR /var/www/adminer

RUN wget https://github.com/vrana/adminer/releases/download/v5.5.1/adminer-5.5.1.php -O index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080"]