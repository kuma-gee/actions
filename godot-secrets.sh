#!/bin/sh

GAME_CODE=$1
ASSETS_PASSWORD=$2

if [ ! -z "$GAME_CODE" ]; then
    gh secret set GAME_CODE -b $GAME_CODE
fi
if [ ! -z "$ASSETS_PASSWORD" ]; then
    gh secret set ASSETS_PASSWORD -b $ASSETS_PASSWORD
fi