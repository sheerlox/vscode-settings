#!/bin/bash

PROJECT_PATH=$(cd $(dirname $0) && pwd)

echo "Syncing default extensions to $PROJECT_PATH"
cp ~/.vscode/extensions/extensions.json $PROJECT_PATH/extensions.json
