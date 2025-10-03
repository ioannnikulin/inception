#!/bin/bash

set -eu # fail whole script if one step fails

for var in DOMAIN_NAME; do
  if [ -z "${!var+x}" ]; then
		echo "Error: $var is not set"
		exit 1
	fi
	if [ -z "${!var}" ]; then
		echo "Error: $var is empty"
		exit 1
	fi
done

: "${SSL_CERT:=/etc/ssl/private/nginx-selfsigned.crt}"
: "${SSL_KEY:=/etc/ssl/private/nginx-selfsigned.key}"

if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]; then
    echo "Generating self-signed SSL certificate..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$SSL_KEY" \
        -out "$SSL_CERT" \
        -subj "/C=DE/L=Berlin/O=42Berlin/OU=student/CN=localhost"
fi

export DOMAIN_NAME SSL_CERT SSL_KEY # otherwise envsubst can't see ssl vars

envsubst '$DOMAIN_NAME $SSL_CERT $SSL_KEY' \
    < /etc/nginx/templates/default.conf.template \
    > /etc/nginx/conf.d/default.conf

echo "Starting nginx..."

exec "$@"