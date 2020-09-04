#!/usr/bin/env bash

cd ~/backup-scripts/backupserver

echo Starting backups - $(date +%d.%m.%Y-%H:%M:%S)

source mainserver.sh
#source apserver.sh

backup_mainserver
#backup_apserver

echo Finished backups - $(date +%d.%m.%Y-%H:%M:%S)
