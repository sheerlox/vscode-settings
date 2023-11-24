#!/bin/bash

set -e

echo "Setting up Anacron job ..."

mkdir -p ~/.local/etc/cron.weekly ~/.var/spool/anacron ~/.var/logs/cron.weekly

BASH_PROFILE=$(realpath ~/.profile)
ANACRON_WEEKLY_DIR=$(realpath ~/.local/etc/cron.weekly)
ANACRON_TAB_FILE=$(realpath ~/.local/etc/anacrontab)
ANACRON_SPOOL_DIR=$(realpath ~/.var/spool/anacron)
ANACRON_SCRIPT_SYMLINK=$ANACRON_WEEKLY_DIR/vscode_settings_push_changes
ANACRON_COMMAND="anacron -t $ANACRON_TAB_FILE -S $ANACRON_SPOOL_DIR"

PROJECT_PATH=$(cd $(dirname "$(readlink -f "$0")")/../ && pwd)
RUN_SCRIPT_PATH=$PROJECT_PATH/scripts/run_cron_job.sh

test -f $ANACRON_SCRIPT_SYMLINK || ln -s $RUN_SCRIPT_PATH $ANACRON_SCRIPT_SYMLINK

if ! [ -f $ANACRON_TAB_FILE ]; then
  tee $ANACRON_TAB_FILE > /dev/null <<EOT
SHELL=/bin/bash

EOT
fi

grep -q "local/etc/cron.weekly" $ANACRON_TAB_FILE || echo "7 0 weekly run-parts $ANACRON_WEEKLY_DIR" | tee -a $ANACRON_TAB_FILE  > /dev/null

if ! grep -q "$ANACRON_COMMAND" $BASH_PROFILE; then
  tee -a $BASH_PROFILE > /dev/null <<EOT

# run anacron
$ANACRON_COMMAND
EOT
fi

echo "Done."
