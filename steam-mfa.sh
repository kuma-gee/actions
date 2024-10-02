#!/bin/sh

username=$1
org=$2

read -s -p "Password: " password
steamcmd +login $username $password +quit

STEAM_CONFIG="$HOME/.local/share/Steam/config/config.vdf"
if [ ! -f $STEAM_CONFIG ]; then
    echo "Steam config VDF not found"
    exit 1
fi

ENCODED="$(base64 $STEAM_CONFIG -w 0)"
if [ -z $org ]; then
    gh secret set STEAM_CONFIG_VDF -b $ENCODED
else
    gh secret set STEAM_CONFIG_VDF --org $org -v all -b $ENCODED
fi
echo "Set Steam config VDF as secret"