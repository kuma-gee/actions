#!/bin/sh

FOLDER="$1"
OUTPUT="$2"
PASSWORD="$3"

cd "$FOLDER"
7z a "$OUTPUT" * -p"$PASSWORD" -mhe=on