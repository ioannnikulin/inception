FROM debian:trixie
RUN apt-get update -y 
	&& apt-get install php-fpm=2:8.4+96 php-mysql curl -y
    && rm -rf /var/lib/apt/lists/*
COPY ./tools/startup.sh /
ENTRYPOINT ["/startup.sh"]
CMD ["php-fpm8.4", "-F"]
