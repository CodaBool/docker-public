#!/bin/bash

# exit on error
set -e

# - assumes using docker-compose
# - assumes you want to always run stable
# - assumes you have `curl` and `jq`
# - assumes you called your host data mount data

# you can use the cron of "0 * * * * /hdd/dock/factorio/auto_update.sh" to automate

# set this path to where you docker compose file is
DOCKER_PATH="/hdd/dock/factorio"

CURRENT_TAG=$(docker inspect factorio | jq -r '.[].Config.Labels."factorio.version"')
STABLE_TAG=$(curl -s https://factorio.com/api/latest-releases | jq -r '.stable.headless')

# Compare the versions
if [ "$CURRENT_TAG" == "$STABLE_TAG" ]; then
  echo "Factorio running latest stable version of $CURRENT_TAG"
  exit 0
fi

cd "$DOCKER_PATH"
TIMESTAMP=$(date '+%Y-%m-%d')
mkdir -p backup
cp -r data/saves "backup/$TIMESTAMP-v$CURRENT_TAG"
echo "Saves backed up"
echo "Updating from $CURRENT_TAG to $STABLE_TAG"

sed -i -E "s|(factoriotools/factorio:?)([0-9]+\.[0-9]+\.[0-9]+)?|\1$STABLE_TAG|g" "docker-compose.yml"

docker compose up -d
echo -e "\n ☝️  Pierce the Heavens"
