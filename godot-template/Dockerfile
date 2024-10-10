FROM ubuntu:24.10

RUN apt-get update && apt-get install -y \
  git \
  build-essential \
  scons \
  pkg-config \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libasound2-dev \
  libpulse-dev \
  libudev-dev \
  libxi-dev \
  libxrandr-dev \
  libwayland-dev \
  gcc-mingw-w64 \
  g++-mingw-w64

RUN update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix

COPY build-template.sh /build-template.sh

ENTRYPOINT ["/build-template.sh"]
