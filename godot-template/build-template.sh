#!/bin/sh

GODOT_VERSION="$1"
PLATFORM="$2"
ENCRYPTION_KEY="$3"

BUILD_PLATFORM="$PLATFORM"
if [ $BUILD_PLATFORM == 'linux' ]; then
    BUILD_PLATFORM='linuxbsd'
fi

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
scons platform=$BUILD_PLATFORM target=$TARGET arch=$ARCH tools=no debug_symbols=no \
    optimize=size \
    module_text_server_adv_enabled=no module_text_server_fb_enabled=yes # Use fallback text server
# lto=full 

cd ../

TEMPLATE_FILE=""
FILE=""
mkdir custom_templates

if [ $PLATFORM == 'windows' ]; then
    FILE=godot/bin/godot.$BUILD_PLATFORM.$TARGET.$ARCH.exe
    TEMPLATE_FILE=custom_templates/template.$TARGET.$PLATFORM.exe
elif [ $PLATFORM == 'linux' ]; then
    FILE=godot/bin/godot.$BUILD_PLATFORM.$TARGET.$ARCH
    TEMPLATE_FILE=custom_templates/template.$TARGET.$PLATFORM.x86_64
fi

mv $FILE $TEMPLATE_FILE
strip $TEMPLATE_FILE

echo "file=$TEMPLATE_FILE" >> $GITHUB_OUTPUT