FROM node:8-alpine
LABEL maintainer="vcp.sh"

RUN apk update && \
    apk add bash curl git openssh supervisor yarn --no-cache && \
    mkdir -p /var/wiki && \
    mkdir -p /logs

WORKDIR /etc
COPY ./tools/build/supervisord.conf .

WORKDIR /var/wiki
COPY . .

RUN yarn && \
    yarn run build

ENV WIKI_JS_HEROKU=1

EXPOSE 3000

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
