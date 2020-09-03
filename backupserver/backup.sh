#!/usr/bin/env bash

echo Starting backups - $(date +%d.%m.%Y-%H:%M:%S)

source mainserver.sh
#source apserver.sh

backup_mainserver
#backup_apserver

echo Finished backups - $(date +%d.%m.%Y-%H:%M:%S)
