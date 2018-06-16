FROM base/archlinux

RUN pacman --noconfirm -Sqyu python3 ruby && pacman --noconfirm -Sc

COPY packer /bin/

COPY get-pip.py /tmp/

RUN python /tmp/get-pip.py && pip install --no-cache-dir ansible awscli

RUN gem install -N serverspec

RUN rm -rf -- /tmp/*
