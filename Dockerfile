FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive PACKER_NO_COLOR=1 ANSIBLE_HOST_KEY_CHECKING=False

RUN apt-get -qq -o=Dpkg::Use-Pty=0 update && apt-get -qq -o=Dpkg::Use-Pty=0 install --no-install-recommends curl jq netcat-openbsd openssh-client python3.5 ruby && apt-get -qq -o=Dpkg::Use-Pty=0 upgrade && apt-get -qq autoremove && apt-get -qq clean

COPY packer /bin/

COPY get-pip.py /tmp/

ARG ansible_version

RUN python3.5 /tmp/get-pip.py && pip install --no-cache-dir ansible${ansible_version:+==$ansible_version} awscli

RUN gem install -N --clear-sources serverspec

RUN rm -rf -- /tmp/*
