FROM debian:trixie

RUN apt-get update && apt-get install -y --no-install-recommends \
        nginx \
        openssl \
        gettext-base \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf.template /etc/nginx/templates/default.conf.template

RUN mkdir -p /etc/ssl/private

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]