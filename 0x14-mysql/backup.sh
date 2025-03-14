#!/usr/bin/env bash
# Backup MySQL databases and compress to tar.gz

PASSWORD=$1
DATE=$(date +"%d-%m-%Y")
mysqldump -u root -p"$PASSWORD" --all-databases > backup.sql
tar -czf "$DATE.tar.gz" backup.sql
rm backup.sql

