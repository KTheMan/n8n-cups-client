#!/bin/bash
set -e

REPO=n8nio/n8n
VERSION_FILE=version.txt

# Get latest tag from Docker Hub API (excluding 'latest')
LATEST_VERSION=$(curl -s "https://hub.docker.com/v2/repositories/$REPO/tags?page_size=100" \
  | jq -r '.results[] | select(.name != "latest") | .name' \
  | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
  | sort -Vr \
  | head -n 1)

if [ -z "$LATEST_VERSION" ]; then
  echo "Failed to fetch latest version from Docker Hub"
  exit 1
fi

echo "Latest available version: $LATEST_VERSION"

# Compare with local
if [ -f "$VERSION_FILE" ]; then
  CURRENT_VERSION=$(cat "$VERSION_FILE")
  if [ "$LATEST_VERSION" == "$CURRENT_VERSION" ]; then
    echo "No new version. Exiting."
    exit 78
  fi
fi

echo "$LATEST_VERSION" > "$VERSION_FILE"
echo "New version detected: $LATEST_VERSION"
