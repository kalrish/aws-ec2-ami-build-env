FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && apt-get -qq install --no-install-recommends jq python3 ruby && apt-get -qq upgrade && apt-get autoremove && apt-get clean

COPY packer /bin/

COPY get-pip.py /tmp/

RUN python3 /tmp/get-pip.py && pip install --no-cache-dir ansible awscli

RUN gem install -N serverspec

RUN rm -rf -- /tmp/*
