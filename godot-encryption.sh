#!/bin/sh

CODE=$(openssl rand -hex 32)
gh secret set ENCRYPTION_KEY -b $CODE