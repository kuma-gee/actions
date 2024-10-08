#!/bin/sh

GAME_NAME=$1
GODOT_VERSION=$2
PROJECT_PATH=$3
STEAM_APP=$4
GAME_CODE=$5
ASSETS_PASSWORD=$6

gh variable set GAME_NAME -b $GAME_NAME
gh variable set GODOT_VERSION -b $GODOT_VERSION
gh variable set PROJECT_PATH -b $PROJECT_PATH
gh variable set STEAM_APP -b $STEAM_APP

CODE=$(openssl rand -hex 32)
gh secret set ENCRYPTION_KEY -b $CODE
gh secret set GAME_CODE -b $GAME_CODE
gh secret set ASSETS_PASSWORD -b $ASSETS_PASSWORD

echo "Set variables for game"
