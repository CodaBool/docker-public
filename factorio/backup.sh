#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "overwritting backup with newer backup...\n"
mv backup storage
cp -r ./data/saves ./backup
echo -e "saves backuped up...\n"


CURRENT_TAG=$(grep -Eo 'factoriotools/factorio:[0-9]+\.[0-9]+\.[0-9]+' "docker-compose.yml" | sed 's/factoriotools\/factorio://')
echo -e "Current tag in docker-compose.yml: ${RED}$CURRENT_TAG${NC}"

# Fetch the tags from the Docker registry using curl and jq

LATEST_TAG=$(curl -s https://registry.hub.docker.com/v2/repositories/factoriotools/factorio/tags?page_size=100 | \
  jq -r '.results | map(.name)[]' | \
  grep -E '^2\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1
)

# Ask the user for confirmation
read -p "$(echo -e "Latest patch appears to be ${RED}$LATEST_TAG${NC}, update from ${RED}$CURRENT_TAG${NC} -> ${RED}$LATEST_TAG${NC}? [Y/n] ")" CONFIRM

# Default to 'Y' if the user presses enter
CONFIRM=${CONFIRM:-Y}

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  if [[ -f "docker-compose.yml" ]]; then
    # Update the version tag in docker-compose.yml
    sed -i -E "s|(factoriotools/factorio:)[0-9]+\.[0-9]+\.[0-9]+|\1$LATEST_TAG|g" "docker-compose.yml"
    echo -e "docker-compose.yml has been updated with tag ${RED}$LATEST_TAG${NC}. Run dcupd to apply changes"
  fi
else
  # check if the user wants to manually type a tag
  echo -e "Visit https://hub.docker.com/r/factoriotools/factorio/tags for available tags."
  read -p "$(echo -e "Enter the tag you want to set manually: ")" MANUAL_TAG
  sed -i -E "s|(factoriotools/factorio:)[0-9]+\.[0-9]+\.[0-9]+|\1$MANUAL_TAG|g" "docker-compose.yml"
  echo -e "docker-compose.yml has been updated with tag ${RED}$MANUAL_TAG${NC}. Run dcupd to apply changes"
fi
