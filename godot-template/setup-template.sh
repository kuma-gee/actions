#!/bin/sh

GODOT_VERSION="$1"
TOKEN="$2"
ENCRYPTION_KEY="$3"

git clone -b "$GODOT_VERSION-stable" --single-branch https://github.com/godotengine/godot.git

if [ -z "$ENCRYPTION_KEY" ]; then
    # assuming the default templates are installed
    # mkdir -v -p ~/.local/share/godot/export_templates
    # mv /root/.local/share/godot/export_templates/${GODOT_VERSION}.stable ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable
else
    export SCRIPT_AES256_ENCRYPTION_KEY="$ENCRYPTION_KEY"
    scons platform=linuxbsd target=template_release arch=x86_64
    scons platform=linuxbsd target=template_debug arch=x86_64
fi