#!/usr/bin/env bash

function backup_mainserver() {
	echo Updating remote backup scripts - $(date +%d.%m.%Y-%H:%M:%S)
	ssh vs '~/backup-scripts/update.sh'

	echo Preparing backup - $(date +%d.%m.%Y-%H:%M:%S)
	ssh vs '~/backup-scripts/mainserver/prepare_backup.sh'

	echo Backing up syscy.de files - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/var/www/syscy.de /mnt/backupdata/mainserver/syscy.de

	echo Backing up NextCloud data - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/var/nextclouddata /mnt/backupdata/mainserver/nextclouddata

	echo Backing up NextCloud config - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/var/www/cloud.syscy.de/config /mnt/backupdata/mainserver/nextcloudconfigs

	echo Backing up databases - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/home/moritz/backup/*.tar.xz /mnt/backupdata/mainserver/databasedump

	echo Finishing backup - $(date +%d.%m.%Y-%H:%M:%S)
	ssh vs '~/backup-scripts/mainserver/finish_backup.sh'
	echo Done! - $(date +%d.%m.%Y-%H:%M:%S)
}
