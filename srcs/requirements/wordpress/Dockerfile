FROM debian:trixie
RUN apt-get update -y && apt-get install php-fpm=2:8.4+96 php-mysql curl -y
COPY ./conf/wp-config.php /
COPY ./tools/startup.sh /
ENTRYPOINT ["/startup.sh"]
