#!/bin/sh

username=$1
org=$2

ARGS=""
if [ ! -z $org ]; then
    ARGS="--org $org -v all"
fi

read -s -p "Password: " password
steamcmd +login $username $password +quit

STEAM_CONFIG="$HOME/.local/share/Steam/config/config.vdf"
if [ ! -f $STEAM_CONFIG ]; then
    echo "Steam config VDF not found"
    exit 1
fi

ENCODED="$(base64 $STEAM_CONFIG -w 0)"
gh secret set STEAM_USERNAME $ARGS -b $username
gh secret set STEAM_CONFIG_VDF $ARGS -b $ENCODED
echo "Set Steam config VDF as secret"