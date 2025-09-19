FROM debian:trixie
RUN apt-get update -y && apt-get install install php-fpm php-mysql curl -y
COPY ./conf/55-override.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/startup.sh /
ENTRYPOINT ["/startup.sh"]
