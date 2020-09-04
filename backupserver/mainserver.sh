#!/usr/bin/env bash

function backup_mainserver() {
	echo Updating remote backup scripts - $(date +%d.%m.%Y-%H:%M:%S)
	ssh vs '~/backup-scripts/update.sh'

	echo Backing up syscy.de files - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/var/www/syscy.de /mnt/backupdata/mainserver/syscy.de

	echo Preparing NextCloud backup - $(date +%d.%m.%Y-%H:%M:%S)
	ssh vs '~/backup-scripts/mainserver/prepare_nextcloud_backup.sh'

	echo Backing up databases - $(date +%d.%m.%Y-%H:%M:%S)
	scp vs:/home/moritz/backup/nextclouddb.tar.xz /mnt/backupdata/mainserver/databasedump/nextclouddb-$(date +%w).tar.xz

	echo Backing up NextCloud data - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/var/nextclouddata /mnt/backupdata/mainserver/nextclouddata

	echo Backing up NextCloud config - $(date +%d.%m.%Y-%H:%M:%S)
	rdiff-backup -v4 vs::/var/www/cloud.syscy.de/config /mnt/backupdata/mainserver/nextcloudconfigs

	echo Finishing NextCloud backup - $(date +%d.%m.%Y-%H:%M:%S)
	ssh vs '~/backup-scripts/mainserver/finish_nextcloud_backup.sh'
	echo Done! - $(date +%d.%m.%Y-%H:%M:%S)
}
