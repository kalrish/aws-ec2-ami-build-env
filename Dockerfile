FROM alpine:latest

RUN apk --no-cache add ansible python3 ruby

COPY packer /bin/

RUN pip3 install --no-cache-dir awscli

RUN gem install -N serverspec

RUN rm -rf -- /tmp/*
