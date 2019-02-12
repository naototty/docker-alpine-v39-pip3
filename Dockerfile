# VERSION 1.10.2.1
# AUTHOR: Naoto "naototty" Gohko
# MAINTAINER: Naoto "naototty" Gohko
# DESCRIPTION: Basic Airflow container based alpine-v3.9-pip3 container
# BUILD: docker build --rm -t naototty/alpine-v39-pip3 .
# SOURCE: https://github.com/naototty/docker-alpine-v39-pip3

FROM alpine:3.9
LABEL maintainer="naototty"

# Never prompts the user for choices on installation/configuration of packages
ENV TERM linux

ARG PYTHON_DEPS=""

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

##     apk add --no-cache python3 python3-dev shadow build-base git openssl openssl-dev libxml-dev libffi-dev freetds freetds-dev postgresql-client py3-psycopg2 && \
RUN apk update && \
    apk add -u python3 python3-dev shadow build-base git openssl openssl-dev libxml2-dev libffi-dev freetds freetds-dev postgresql-client py3-psycopg2 && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache \
      && rm -rf \
         /tmp/* \
         /var/tmp/*
