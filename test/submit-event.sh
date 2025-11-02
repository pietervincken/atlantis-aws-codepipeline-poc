#!/bin/bash

set -e

WEBHOOK=$(cat demo-payload.json)
GITHUB_EVENT="push"

WEBHOOK_SECRET=""

USER_AGENT=$(openssl rand -hex 7)
UUID=$(openssl rand -hex 16)
REQUEST_ID=$(echo ${UUID:0:8}-${UUID:8:4}-${UUID:12:4}-${UUID:16:4}-${UUID:20:12})
SHA1=$(echo -n "$WEBHOOK" | openssl dgst -sha1 -hmac $WEBHOOK_SECRET | sed 's/.*= //')
SHA256=$(echo -n "$WEBHOOK" | openssl dgst -sha256 -hmac $WEBHOOK_SECRET | sed 's/.*= //')

curl --fail-with-body -v -sS -X POST \
    -H "Content-Type: application/json" \
    -H "User-Agent: GitHub-Hookshot/$USER_AGENT" \
    -H "X-GitHub-Delivery: $REQUEST_ID" \
    -H "X-Hub-Signature: sha1=$SHA1" \
    -H "X-Hub-Signature-256: sha256=$SHA256" \
    -H "X-GitHub-Event: $GITHUB_EVENT" \
    --data "$WEBHOOK" \
    http://localhost:4141/events