FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install \
        php8.4-cli \
        php8.4-fpm \
        php8.4-mysql \
        php8.4-xml \
        php8.4-mbstring \
        php8.4-curl \
        php8.4-zip \
        php8.4-phar \
        curl \
        default-mysql-client \
        unzip \
        tar \
        -y \
    && rm -rf /var/lib/apt/lists/*
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
ENTRYPOINT ["startup.sh"]
CMD ["php-fpm8.4", "-F"]
