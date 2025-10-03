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

WP_ROOT="/var/www/html"

mkdir -p "$WP_ROOT"

chown -R www-data:www-data "$WP_ROOT"

cd "$WP_ROOT"

if ! command -v wp > /dev/null 2>&1; then
	echo "WP-CLI could not be found, installing..."
	curl -o wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar 
	mv wp-cli.phar /usr/local/bin/wp
fi

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -hmariadb -u"$DB_USERNAME" -p"$DB_PASSWORD" --silent; do
    echo -n "."
    sleep 2
done

if ! command -v tar >/dev/null && ! command -v unzip >/dev/null; then
  echo "Error: Neither tar nor unzip is installed, wp core download will fail"
  exit 1
fi

if [ ! -f index.php ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root
fi

ls -la /var/www/html

if [ ! -f wp-config.php ]; then
	echo "wp-config.php not found, creating..."
	wp config create \
	--dbname=$DB_NAME \
	--dbuser=$DB_USERNAME \
	--dbpass=$DB_PASSWORD \
	--dbhost=mariadb \
	--allow-root
fi

if ! wp core is-installed --allow-root >/dev/null 2>&1; then
	echo "WordPress not installed, installing..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USERNAME" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
fi

if ! wp user get "$WP_USERNAME" --allow-root >/dev/null 2>&1; then
	echo "User $WP_USERNAME does not exist, creating..."
    wp user create "$WP_USERNAME" "$WP_EMAIL" --role=author --user_pass="$WP_PASSWORD" --allow-root
fi

if ! wp theme is-active astra --allow-root 2>/dev/null; then
	echo "Installing Astra theme..."
    wp theme install astra --activate --allow-root
fi

if ! wp plugin is-active redis-cache --allow-root 2>/dev/null; then
	echo "Installing Redis plugin... hope you have a Redis container running. Nothing would break otherwise, but you'll get some spam logs."
    wp plugin install redis-cache --activate --allow-root
fi

if wp plugin is-installed redis-cache --allow-root; then
	echo "Enabling Redis plugin..."
    wp redis enable --allow-root || true
fi

chown -R www-data:www-data "$WP_ROOT"
sed -i 's|listen = /run/php/php8.4-fpm.sock|listen = 9000|' /etc/php/8.4/fpm/pool.d/www.conf
mkdir -p /run/php

echo "Starting WordPress..."

exec "$@"