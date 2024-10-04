FROM alpine:3.20.3

RUN apk add --no-cache \
  scons \
  pkgconf \
  gcc \
  g++ \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libxi-dev \
  libxrandr-dev \
  mesa-dev \
  eudev-dev \
  alsa-lib-dev \
  pulseaudio-dev

COPY setup-template.sh /setup-template.sh

ENTRYPOINT ["/setup-template.sh"]
