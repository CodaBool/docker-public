#!/bin/bash

FACT_PATH="/hdd/dock/factorio"
CURRENT_TAG=$(grep -Eo 'factoriotools/factorio:[0-9]+\.[0-9]+\.[0-9]+' "$FACT_PATH/docker-compose.yml" | sed 's/factoriotools\/factorio://')
STABLE_TAG=$(curl -s https://factorio.com/api/latest-releases | jq -r '.stable.headless')

# Compare the versions
if [ "$CURRENT_TAG" != "$STABLE_TAG" ]; then
    echo -e "Update available to STABLE_TAG"
else
    echo -e "factorio up to date"
    exit 0
fi

echo -e "overwritting backup with newer backup...\n"
rm -rf "$FACT_PATH/storage"
mv "$FACT_PATH/backup" "$FACT_PATH/storage"
cp -r "$FACT_PATH/data/saves" "$FACT_PATH/backup"
echo -e "saves backuped up...\n"


echo -e "Current tag in docker-compose.yml: $CURRENT_TAG"

sed -i -E "s|(factoriotools/factorio:)[0-9]+\.[0-9]+\.[0-9]+|\1$STABLE_TAG|g" "$FACT_PATH/docker-compose.yml"
cd $FACT_PATH
docker compose up -d
echo -e "\n☝️  $Perce the Heavens "
