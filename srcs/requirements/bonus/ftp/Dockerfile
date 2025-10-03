FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install -y vsftpd \
    && rm -rf /var/lib/apt/lists/*
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
ENTRYPOINT ["startup.sh"]
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
