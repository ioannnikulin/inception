FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install -y \
    curl \
    php \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/www/html/index.html
RUN curl -L https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php -o /var/www/html/index.php
RUN chmod +x /var/www/html/index.php
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
EXPOSE 80
ENTRYPOINT ["startup.sh"]
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
