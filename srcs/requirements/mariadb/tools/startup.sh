#!/bin/bash

set -eu # fail whole script if one step fails or if ny variable is not set (which is, no env file)

mkdir -p /var/run/mysqld # if it doesn't exist or belongs to root, daemon fails
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Database not found, initializing"
	mariadb-install-db --user=mysql --datadir='/var/lib/mysql'

	/usr/bin/mariadbd-safe --user=mysql --datadir='/var/lib/mysql'
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
fi

exec mysqld --user=mysql
