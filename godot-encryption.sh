#!/bin/sh

GODOT_VERSION=$1

if [ ! -z "$GODOT_VERSION" ]; then
    gh variable set GODOT_VERSION -b $GODOT_VERSION
fi

CODE=$(openssl rand -hex 32)
gh secret set ENCRYPTION_KEY -b $CODE
