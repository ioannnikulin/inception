FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install mariadb-server -y \
    && rm -rf /var/lib/apt/lists/*
COPY ./conf/55-override.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
ENTRYPOINT ["startup.sh"]
CMD ["mysqld", "--user=mysql"]
