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

mkdir -p /home/$FTP_USERNAME/ftp

chown $FTP_USERNAME:$FTP_USERNAME /home/$FTP_USERNAME
chown nobody:nogroup /home/$FTP_USERNAME/ftp
chmod a-w /home/$FTP_USERNAME/ftp

mkdir -p /home/$FTP_USERNAME/ftp/files
chown $FTP_USERNAME:$FTP_USERNAME /home/$FTP_USERNAME/ftp/files

cat > /etc/vsftpd.conf <<EOF
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30010
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
local_root=/home/$FTP_USERNAME/ftp
EOF

echo "Starting vsftpd..."

exec "$@"