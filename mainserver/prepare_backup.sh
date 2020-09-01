#!/usr/bin/env bash

source .env

sudo -u www-data /var/www/cloud.syscy.de/occ maintenance:mode --on

mysqldump --single-transaction -h localhost -unextcloud -p$NEXTCLOUD_DB_PW nextcloud > ~/backup/nextclouddb.sql
