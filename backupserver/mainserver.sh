#!/usr/bin/env bash

function backup_mainserver() {
	echo Updating remote backup scripts
	ssh vs '~/backup-scripts/update.sh'

	echo Preparing backup
	ssh vs '~/backup-scripts/mainserver/prepare_backup.sh'

	echo Backing up syscy.de files
	rdiff-backup vs::/var/www/syscy.de /mnt/backupdata/mainserver/syscy.de

	echo Backing up NextCloud data
	rdiff-backup vs::/var/nextclouddata /mnt/backupdata/mainserver/nextclouddata

	echo Backing up NextCloud config
	rdiff-backup vs::/var/www/cloud.syscy.de/config /mnt/backupdata/mainserver/nextcloudconfigs

	echo Backing up databases
	rdiff-backup vs::/home/moritz/backup/*.tar.xz /mnt/backupdata/mainserver/databasedump

	echo Finishing backup
	ssh vs '~/backup-scripts/mainserver/finish_backup.sh'
	echo Done!
}
