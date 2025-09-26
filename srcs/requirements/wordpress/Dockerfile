FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install php8.4-fpm php-mysql curl -y \
    && rm -rf /var/lib/apt/lists/*
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
ENTRYPOINT ["startup.sh"]
CMD ["php-fpm8.4", "-F"]
