FROM alpine:3.12
MAINTAINER @Lordslair

RUN apk update --no-cache \
    && apk add --no-cache python3 py3-pip \
    && apk add --no-cache --virtual  .build-deps \
                                      python3-dev \
                                      libffi-dev \
                                      gcc \
                                      libc-dev \
                                      tzdata \
    && pip --no-cache-dir install -U  discord.py \
                                      pyMySQL \
                                      numpy \
                                      SQLAlchemy \
                                      termcolor \
    && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && apk del .build-deps

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
