FROM debian:trixie
RUN apt-get update -y && apt-get install nginx openssl -y
COPY ./tools/startup.sh /
ENTRYPOINT ["/startup.sh"]
