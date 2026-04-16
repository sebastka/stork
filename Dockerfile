# https://stork.readthedocs.io/en/v1.9.0/install.html#installing-on-alpine
# https://cloudsmith.io/~isc/repos/stork/setup/#formats-alpine
FROM alpine/curl:8.17.0 AS stork
LABEL org.opencontainers.image.version="2.4.0"
LABEL org.opencontainers.image.title="ISC Stork Server"
LABEL org.opencontainers.image.description="Stork Graphical Management for Kea DHCP"
LABEL org.opencontainers.image.authors="ISC <Internet Systems Consortium, Inc.>, Sebastian Karlsen <github.com/sebastka>"
LABEL org.opencontainers.image.url="https://github.com/sebastka/stork"
LABEL org.opencontainers.image.licenses="Mozilla Public License 2.0"
RUN curl -sL https://dl.cloudsmith.io/public/isc/stork/rsa.6914F776A579B428.key >/etc/apk/keys/stork@isc-6914F776A579B428.rsa.pub \
    && printf -- 'https://dl.cloudsmith.io/public/isc/stork/alpine/v3.23/main\n' >>/etc/apk/repositories \
    && apk add --no-cache tzdata isc-stork-server isc-stork-server-hook-ldap \
    && mkdir -p /var/lib/stork-server \
    && chown -R stork-server:stork-server /var/lib/stork-server
USER stork-server
WORKDIR /var/lib/stork-server
EXPOSE 8080
HEALTHCHECK NONE
ENTRYPOINT []
CMD ["stork-server"]
