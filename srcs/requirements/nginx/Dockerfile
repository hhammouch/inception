FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*


# nodes no password is required for the private key
RUN  mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=MA/L=Morocco/O=1337/OU=Student/CN=hhammouc.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]


