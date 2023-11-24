#!/bin/bash

PROJECT_PATH=$(cd $(dirname "$(readlink -f "$0")")/../ && pwd)
cd $PROJECT_PATH

bash $PROJECT_PATH/scripts/sync_default_extensions.sh

echo "=====> Installing dependencies & setting up git hook ..."
npm ci --silent

echo "=====> Running formatter ..."
npx prettier . --write

if [ -n "$(git status --porcelain=v1)" ]; then
  echo "=====> Pushing changes in $PROJECT_PATH to Git ..."
  git add -A
  git commit -m "chore: sync changes"
  git push
else
  echo "=====> No changes detected."
fi

echo "=====> Done."
