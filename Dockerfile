FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && apt-get -qq install --no-install-recommends jq openssh-client python3 ruby && apt-get -qq upgrade && apt-get autoremove && apt-get clean

COPY packer /bin/

COPY get-pip.py /tmp/

RUN python3 /tmp/get-pip.py && pip install --no-cache-dir ansible awscli

RUN gem install -N --clear-sources serverspec

RUN rm -rf -- /tmp/*
