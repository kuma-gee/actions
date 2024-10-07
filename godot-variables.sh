#!/bin/sh

GAME_NAME=$1
GODOT_VERSION=$2

gh variable set GAME_NAME -b $GAME_NAME
gh variable set GODOT_VERSION -b $GODOT_VERSION

CODE=$(openssl rand -hex 32)
gh secret set ENCRYPTION_KEY -b $CODE

echo "Set variables for game"
