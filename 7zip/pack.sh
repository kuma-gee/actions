#!/bin/sh

FOLDER="$1"
OUTPUT="$2"
PASSWORD="$3"

CURRENT="$(pwd)"

cd "$FOLDER"
7z a "$CURRENT/$OUTPUT" * -p"$PASSWORD" -mhe=on