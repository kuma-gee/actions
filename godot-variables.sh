#!/bin/sh

PROJECT_PATH=$1
GAME_CODE=$2
ASSETS_PASSWORD=$3
STEAM_APP=$4
STEAM_DEMO_APP=$5

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