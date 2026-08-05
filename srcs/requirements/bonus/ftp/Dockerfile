FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/ftp.sh /tmp/ftp.sh
RUN chmod +x /tmp/ftp.sh

EXPOSE 21

CMD ["/tmp/ftp.sh"]
