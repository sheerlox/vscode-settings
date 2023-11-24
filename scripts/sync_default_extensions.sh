#!/bin/bash

PROJECT_PATH=$(bash $(dirname $0)/get_project_path.sh)
cd $PROJECT_PATH

echo "=====> Syncing default extensions to $PROJECT_PATH ..."
cp ~/.vscode/extensions/extensions.json $PROJECT_PATH/extensions.json
