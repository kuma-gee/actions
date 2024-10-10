#!/bin/sh

FOLDER="$1"
OUTPUT="$2"
PASSWORD="$3"

7z a "$OUTPUT" "$FOLDER" -p"$PASSWORD" -mhe=on