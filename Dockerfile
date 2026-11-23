FROM caddy:2.11-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY v1/ /srv/v1/
COPY v2/ /srv/v2/
COPY v3/ /srv/v3/
COPY v4/ /srv/v4/
USER 10001:10001
EXPOSE 8080
