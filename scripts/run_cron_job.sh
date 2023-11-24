#!/bin/bash

# script to load the PATH from .bashrc
# when running via anacron

JOB_LOGS_DIR=$(realpath ~/.var/logs/cron.weekly)

SCRIPTS_PATH=$(cd $(dirname "$(readlink -f "$0")") && pwd)

# load the PATH so npm and npx works in cron
# https://askubuntu.com/a/1041348
eval "$(cat ~/.bashrc | tail -n +10)"

# run the actual script and exit
bash $SCRIPTS_PATH/push_changes.sh > $JOB_LOGS_DIR/vscode_settings_push_changes.logs 2>&1
