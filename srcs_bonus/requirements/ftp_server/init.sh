#!/bin/bash
set -e

if ! id "$FTP_USER" &>/dev/null; then
    echo "Creating FTP user: $FTP_USER"
    useradd -m "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    usermod -aG www-data "$FTP_USER"
fi

echo "Starting vsftpd for user $FTP_USER..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf