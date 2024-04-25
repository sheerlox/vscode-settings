#!/bin/bash

PROJECT_PATH=$(cd $(dirname "$(readlink -f "$0")")/../ && pwd)

mkdir -p $PROJECT_PATH/backups

echo "=====> Syncing default extensions to $PROJECT_PATH/backups ..."
cp ~/.vscode/extensions/extensions.json $PROJECT_PATH/backups/extensions.json

echo "=====> Syncing default storage to $PROJECT_PATH/backups ..."
cat globalStorage/storage.json | jq -r '{userDataProfilesMigration: .userDataProfilesMigration, userDataProfiles: .userDataProfiles}' >$PROJECT_PATH/backups/storage.json
