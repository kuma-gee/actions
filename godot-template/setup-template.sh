#!/bin/sh

GODOT_VERSION="$1"
PLATFORM="$2"
ENCRYPTION_KEY="$3"

TARGET="template_release"
ARCH="x86_64"

if [ ${#ENCRYPTION_KEY} -ne 64 ]; then
    echo "Invalid encryption key"
    exit 1
fi

if [ ! -d godot ]; then
    git clone -b "$GODOT_VERSION-stable" --single-branch https://github.com/godotengine/godot.git
fi

cd godot

# Ensure we don't include editor code in export template builds.
rm -rf editor

export SCRIPT_AES256_ENCRYPTION_KEY="$ENCRYPTION_KEY"
scons platform=$PLATFORM target=$TARGET arch=$ARCH tools=no debug_symbols=no \
    lto=full optimize=size \
    module_text_server_adv_enabled=no module_text_server_fb_enabled=yes # Use fallback text server

cd -

FILE=godot/bin/godot.$PLATFORM.$TARGET.$ARCH
strip $FILE

echo "file=$FILE" >> $GITHUB_OUTPUT