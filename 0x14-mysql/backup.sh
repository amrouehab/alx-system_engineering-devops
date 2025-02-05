#!/usr/bin/env bash
# This script generates a MySQL dump of all databases, compresses it, and creates a time-stamped archive.

# Check if password argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 your_password"
  exit 1
fi

mysql_password="$1"

# Get current date in day-month-year format
date_str=$(date +%d-%m-%Y)

# Create the dump file
mysqldump -u root -p"$mysql_password" --all-databases > backup.sql

# Check if the dump was successful
if [ $? -ne 0 ]; then
    echo "Error: MySQL dump failed."
    exit 1
fi


# Compress the dump file into a tar.gz archive
tar -czvf "$date_str.tar.gz" backup.sql

# Check if the compression was successful
if [ $? -ne 0 ]; then
    echo "Error: Compression failed."
    exit 1
fi

# Remove the uncompressed dump file (optional, but good practice)
rm backup.sql

echo "Backup created successfully: $date_str.tar.gz"

exit 0
