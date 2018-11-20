FROM node:8-alpine
LABEL maintainer="vcp.sh"

RUN apk update && \
    apk add bash curl git openssh supervisor --no-cache && \
    mkdir -p /var/wiki && \
    mkdir -p /logs

WORKDIR /var/wiki

COPY ./tools/build/supervisord.conf /etc/supervisord.conf
COPY . /var/wiki

ENV WIKI_JS_HEROKU=1

EXPOSE 3000

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
