#!/usr/bin/env bash
# This script creates a MySQL user named holberton_user with the required permissions.

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="" # Leave empty if no password is set for root
NEW_USER="holberton_user"
NEW_USER_PASSWORD="projectcorrection280hbtn"
HOST="localhost"

# SQL commands to create the user and grant permissions
SQL_COMMANDS=$(cat <<EOF
CREATE USER IF NOT EXISTS '${NEW_USER}'@'${HOST}' IDENTIFIED BY '${NEW_USER_PASSWORD}';
GRANT REPLICATION CLIENT ON *.* TO '${NEW_USER}'@'${HOST}';
FLUSH PRIVILEGES;
EOF
)

# Execute the SQL commands on MySQL
if [ -z "${MYSQL_PASSWORD}" ]; then
    mysql -u "${MYSQL_USER}" -e "${SQL_COMMANDS}"
else
    mysql -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "${SQL_COMMANDS}"
fi

# Check if the user was created successfully
if [ $? -eq 0 ]; then
    echo "MySQL user '${NEW_USER}' created successfully with the required permissions."
else
    echo "Failed to create MySQL user '${NEW_USER}'."
fi
