FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive PACKER_NO_COLOR=1 ANSIBLE_HOST_KEY_CHECKING=False

RUN apt-get -qq -o=Dpkg::Use-Pty=0 update && apt-get -qq -o=Dpkg::Use-Pty=0 install --no-install-recommends curl jq netcat-openbsd openssh-client python3.5 python3-pip python3-setuptools ruby && apt-get -qq -o=Dpkg::Use-Pty=0 upgrade && apt-get -qq autoremove && apt-get -qq clean

COPY packer /bin/

ARG ansible_version

RUN pip3 install --no-cache-dir ansible${ansible_version:+==$ansible_version} awscli

ARG serverspec_version

RUN gem install -N --clear-sources serverspec${serverspec_version:+:$serverspec_version}

RUN rm -rf -- /tmp/*
