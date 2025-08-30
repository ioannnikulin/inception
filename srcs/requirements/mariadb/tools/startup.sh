#!/bin/bash

mkdir -p /var/run/mysqld # if it doesn't exist or belongs to root, daemon fails
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

mysqld --initialize-insecure --user=mysql

mysqld --skip-networking --socket=/var/run/mysqld/mysqld.sock &
pid="$!" # last background process ID

until mysqladmin ping --silent; do
  echo "Waiting for MariaDB..."
  sleep 1
done

mysql -u root <<-EOSQL
  CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
  GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
  FLUSH PRIVILEGES;
EOSQL

# stop temporary server
kill "$pid"
wait "$pid"

exec mysqld