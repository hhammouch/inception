#!/bin/bash

if ! id "$FTP_USER" &>/dev/null; then
    # assign user  to WordPress volume
    useradd -m -d /var/www/html $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    usermod -aG www-data $FTP_USER
fi

sed -i "s/REPLACE_ME_WITH_HOST_IP/$HOST_IP/g" /etc/vsftpd.conf



# vsftpd requires this secure empty directory to run
mkdir -p /var/run/vsftpd/empty

exec vsftpd /etc/vsftpd.conf
