#!/usr/bin/env bash

function backup_mainserver() {
	ssh vs '~/backup-scripts/mainserver/prepare_backup.sh'

	rdiff-backup vs::/var/www/syscy.de /mnt/backupdata/mainserver/syscy.de

	rdiff-backup vs::/var/nextclouddata /mnt/backupdata/mainserver/nextclouddata

	rdiff-backup vs::/var/www/cloud.syscy.de/config /mnt/backupdata/mainserver/nextcloudconfigs

	rdiff-backup vs::/home/moritz/backup/*.tar.xz /mnt/backupdata/mainserver/databasedump

	ssh vs '~/backup-scripts/mainserver/finish_backup.sh'
}
