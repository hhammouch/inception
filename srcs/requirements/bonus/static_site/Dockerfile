FROM debian:bookworm

RUN apt-get update && apt-get install -y python3 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
COPY tools/index.html /var/www/html/
COPY tools/js/ /var/www/html/js/

WORKDIR /var/www/html

EXPOSE 8000

CMD ["python3", "-m", "http.server", "8000"]