FROM debian:trixie
RUN apt-get update -y \
	&& apt-get install redis-server -y \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/local/etc/redis
RUN echo "maxmemory 256mb" >> /usr/local/etc/redis/redis.conf
RUN echo "maxmemory-policy allkeys-lru" >> /usr/local/etc/redis/redis.conf
RUN sed -i -r "s/^bind 127\.0\.0\.1/#bind 127.0.0.1/" /usr/local/etc/redis/redis.conf
EXPOSE 6379
COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh
ENTRYPOINT ["startup.sh"]
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
