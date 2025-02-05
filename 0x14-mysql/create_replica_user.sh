#!/usr/bin/env bash
# This script creates a MySQL user named replica_user with replication permissions.

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="" # Leave empty if no password is set for root
REPLICA_USER="replica_user"
REPLICA_PASSWORD="replica_password" # Set your desired password here
HOST="%"

# SQL commands to create the replica user and grant permissions
SQL_COMMANDS=$(cat <<EOF
CREATE USER IF NOT EXISTS '${REPLICA_USER}'@'${HOST}' IDENTIFIED BY '${REPLICA_PASSWORD}';
GRANT REPLICATION SLAVE ON *.* TO '${REPLICA_USER}'@'${HOST}';
GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';
FLUSH PRIVILEGES;
EOF
)

# Execute the SQL commands on MySQL
if [ -z "${MYSQL_PASSWORD}" ]; then
    mysql -u "${MYSQL_USER}" -e "${SQL_COMMANDS}"
else
    mysql -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "${SQL_COMMANDS}"
fi

# Check if the commands were executed successfully
if [ $? -eq 0 ]; then
    echo "MySQL user '${REPLICA_USER}' created successfully with replication permissions."
    echo "holberton_user granted SELECT privileges on mysql.user table."
else
    echo "Failed to create MySQL user '${REPLICA_USER}' or grant permissions."
fi
