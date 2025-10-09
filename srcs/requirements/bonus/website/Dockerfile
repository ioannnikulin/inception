FROM debian:trixie
RUN apt-get update -y && apt-get install -y \
    curl \
    ca-certificates \
    xz-utils \
    build-essential \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://nodejs.org/dist/v20.7.0/node-v20.7.0-linux-x64.tar.xz -o node.tar.xz \
    && tar -xf node.tar.xz -C /usr/local --strip-components=1 \
    && rm node.tar.xz

RUN npm install -g tiddlywiki

RUN mkdir -p /data
WORKDIR /data

EXPOSE 8080

COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["tiddlywiki", "/data", "--listen", "host=0.0.0.0", "port=8080"]
