#!/bin/bash

set -eu # fail whole script if one step fails

for var in DB_NAME DB_USERNAME DB_PASSWORD DOMAIN_NAME WP_TITLE WP_ADMIN_USERNAME WP_ADMIN_PASSWORD WP_ADMIN_EMAIL WP_USERNAME WP_PASSWORD WP_EMAIL; do
  if [ -z "${!var+x}" ]; then
		echo "Error: $var is not set"
		exit 1
	fi
	if [ -z "${!var}" ]; then
		echo "Error: $var is empty"
		exit 1
	fi
done

mkdir -p /var/www/html

cd /var/www/html

rm -rf *

curl -o wp-cli.phar https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar
chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

cp /wp-config.php /var/www/html/wp-config.php

sed -i -r "s/database_name/$DB_NAME/1" wp-config.php
sed -i -r "s/database_user/$DB_USERNAME/1" wp-config.php
sed -i -r "s/database_password/$DB_PASSWORD/1" wp-config.php

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USERNAME $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root

wp theme install astra --activate --allow-root

wp plugin install redis-cache --activate --allow-root

sed -i 's/listen = \/run\/php\/php8.4-fpm.sock/listen = 9000/g' /etc/php/8.4/fpm/pool.d/www.conf

mkdir -p /run/php

wp redis enable --allow-root

echo "Starting php-fpm"

/usr/sbin/php-fpm8.4 -F