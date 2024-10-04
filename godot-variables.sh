#!/bin/sh

GAME_NAME=$1

gh variable set GAME_NAME -b $GAME_NAME

CODE=$(openssl rand -hex 32)
gh secret set ENCRYPTION_KEY -b $CODE

echo "Set variables for game"
