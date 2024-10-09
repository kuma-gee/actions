#!/bin/sh

GAME_NAME=$1
GODOT_VERSION=$2
PROJECT_PATH=$3
STEAM_APP=$4
STEAM_DEMO_APP=$5
GAME_CODE=$6
ASSETS_PASSWORD=$7

if [ ! -z "$GAME_NAME" ]; then
    gh variable set GAME_NAME -b $GAME_NAME
fi
if [ ! -z "$GODOT_VERSION" ]; then
    gh variable set GODOT_VERSION -b $GODOT_VERSION
fi
if [ ! -z "$PROJECT_PATH" ]; then
    gh variable set PROJECT_PATH -b $PROJECT_PATH
fi
if [ ! -z "$STEAM_APP" ]; then
    gh variable set STEAM_APP -b $STEAM_APP
fi
if [ ! -z "$STEAM_DEMO_APP" ]; then
    gh variable set STEAM_DEMO_APP -b $STEAM_DEMO_APP
fi

if [ ! -z "$GAME_CODE" ]; then
    gh secret set GAME_CODE -b $GAME_CODE
fi
if [ ! -z "$ASSETS_PASSWORD" ]; then
    gh secret set ASSETS_PASSWORD -b $ASSETS_PASSWORD
fi

echo "Set variables for game"
