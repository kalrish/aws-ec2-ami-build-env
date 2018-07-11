FROM alpine:edge

ENV PACKER_NO_COLOR=1 ANSIBLE_HOST_KEY_CHECKING=False

ARG ansible_version

RUN { for BRANCH in v3.3 v3.4 v3.5 v3.6 v3.7 v3.8 edge ; do echo "http://dl-cdn.alpinelinux.org/alpine/${BRANCH}/main" ; done && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" ; } >> /etc/apk/repositories

RUN apk --no-cache add ansible${ansible_version:+=$ansible_version} aws-cli curl git jq openssh-client netcat-openbsd ruby unzip

COPY packer /bin/

ARG serverspec_version

RUN gem install -N --clear-sources serverspec${serverspec_version:+:$serverspec_version}

RUN rm -rf -- /tmp/*
