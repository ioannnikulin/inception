#!/bin/bash

set -eu # fail whole script if one step fails

for var in FTP_USERNAME FTP_PASSWORD; do
  if [ -z "${!var+x}" ]; then
        echo "Error: $var is not set"
        exit 1
    fi
    if [ -z "${!var}" ]; then
        echo "Error: $var is empty"
        exit 1
    fi
done

if ! id "$FTP_USERNAME" &>/dev/null; then
    adduser --disabled-password --gecos "" "$FTP_USERNAME"
    echo "$FTP_USERNAME:$FTP_PASSWORD" | /usr/sbin/chpasswd
    echo "$FTP_USERNAME" > /etc/vsftpd.userlist
fi

chown -R www-data:$FTP_USERNAME /var/www/html
chmod -R 755 /var/www/html

cat > /etc/vsftpd.conf <<EOF
listen=YES
listen_ipv6=NO
local_enable=YES
write_enable=YES
chroot_local_user=NO
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30009

anonymous_enable=NO
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd.userlist

local_root=/var/www/html

xferlog_file=/var/log/vsftpd.log
xferlog_enable=YES
log_ftp_protocol=YES
dual_log_enable=YES
EOF

echo "Starting vsftpd..."

exec "$@"