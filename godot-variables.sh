#!/bin/sh

GAME_NAME=$1
GODOT_VERSION=$2
STEAM_APP=$3
GAME_CODE=$4

gh variable set GAME_NAME -b $GAME_NAME
gh variable set GODOT_VERSION -b $GODOT_VERSION
gh variable set STEAM_APP -b $STEAM_APP

CODE=$(openssl rand -hex 32)
gh secret set ENCRYPTION_KEY -b $CODE
gh secret set GAME_CODE -b $GAME_CODE

echo "Set variables for game"
