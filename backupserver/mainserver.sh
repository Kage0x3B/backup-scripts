#!/usr/bin/env bash

function backup_mainserver() {
	ssh vs '~/backup-scripts/mainserver/prepare_backup.sh'

	rdiff-backup --include-globbing-filelist mainserver-list vs::/ /mnt/backupdata/mainserver

	ssh vs '~/backup-scripts/mainserver/finish_backup.sh'
}
