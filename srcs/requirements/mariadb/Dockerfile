FROM debian:trixie
RUN apt-get update -y && apt-get install mariadb-server -y
COPY ./conf/55-override.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/startup.sh /
CMD ["/startup.sh"]
