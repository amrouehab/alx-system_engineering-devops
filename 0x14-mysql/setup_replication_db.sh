#!/usr/bin/env bash
# This script creates a database, a table, and grants SELECT permissions to holberton_user.

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="" # Leave empty if no password is set for root
DB_NAME="tyrell_corp"
TABLE_NAME="nexus6"
USER="holberton_user"
HOST="localhost"

# SQL commands to create the database, table, and grant permissions
SQL_COMMANDS=$(cat <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
USE ${DB_NAME};
CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
INSERT INTO ${TABLE_NAME} (name) VALUES ('Leon');
GRANT SELECT ON ${DB_NAME}.${TABLE_NAME} TO '${USER}'@'${HOST}';
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
    echo "Database '${DB_NAME}', table '${TABLE_NAME}', and permissions for '${USER}' set up successfully."
else
    echo "Failed to set up the database, table, or permissions."
fi
