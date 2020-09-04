#!/usr/bin/env bash

cd ~/backup-scripts/mainserver

source .env

sudo -u www-data /var/www/cloud.syscy.de/occ maintenance:mode --on

cd ~/backup

rm -f nextclouddb.sql
rm -f nextclouddb.tar.xz

mysqldump --single-transaction -h localhost -unextcloud -p$NEXTCLOUD_DB_PW nextcloud > nextclouddb.sql

tar cJf nextclouddb.tar.xz nextclouddb.sql
