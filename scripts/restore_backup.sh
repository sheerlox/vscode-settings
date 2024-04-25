#!/bin/bash

PROJECT_PATH=$(cd $(dirname "$(readlink -f "$0")")/../ && pwd)
cd $PROJECT_PATH

echo "=====> Restoring default extensions from $PROJECT_PATH/backups ..."
mkdir -p ~/.vscode/extensions/
cp $PROJECT_PATH/backups/extensions.json ~/.vscode/extensions/extensions.json

echo "=====> Restoring default storage from $PROJECT_PATH/backups ..."
mkdir -p $PROJECT_PATH/globalStorage/
cp $PROJECT_PATH/backups/storage.json $PROJECT_PATH/globalStorage/storage.json

declare -A profiles="($(cat globalStorage/storage.json | jq -r '.userDataProfiles | to_entries | .[] | "[\"" + .value.location + "\"]=" + (.value.name | @sh)'))"

echo "=====> Reinstalling extensions for profile \"Default\" ..."
for ext in $(cat ~/.vscode/extensions/extensions.json | jq '. | map(.identifier.id)' | jq -r @sh); do
  code --profile Default --install-extension "${ext//\'/}"
done

for id in "${!profiles[@]}"; do
  echo "=====> Reinstalling extensions for profile \"${profiles[$id]}\" (${id}) ..."
  for ext in $(cat $PROJECT_PATH/profiles/$id/extensions.json | jq '. | map(.identifier.id)' | jq -r @sh); do
    code --profile ${profiles[$id]} --install-extension "${ext//\'/}"
  done
done
