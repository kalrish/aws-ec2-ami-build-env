FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq -o=Dpkg::Use-Pty=0 update && apt-get -qq -o=Dpkg::Use-Pty=0 install --no-install-recommends jq openssh-client python-minimal ruby && apt-get -qq -o=Dpkg::Use-Pty=0 upgrade && apt-get -qq autoremove && apt-get -qq clean

COPY packer /bin/

COPY get-pip.py /tmp/

RUN python /tmp/get-pip.py && pip install --no-cache-dir ansible awscli

RUN gem install -N --clear-sources serverspec

RUN rm -rf -- /tmp/*
