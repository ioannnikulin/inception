FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install -y \
    ca-certificates \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/google/cadvisor/releases/download/v0.53.0/cadvisor-v0.53.0-linux-amd64 -o /usr/local/bin/cadvisor
RUN chmod +x /usr/local/bin/cadvisor
EXPOSE 8080
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
ENTRYPOINT ["startup.sh"]
CMD ["/usr/local/bin/cadvisor", "-port", "8080", "-logtostderr"]
