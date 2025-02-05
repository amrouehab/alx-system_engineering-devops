#!/usr/bin/env bash
# This script installs MySQL on an Ubuntu 16.04 LTS server.

# Update the package list
sudo apt-get update

# Install MySQL Server
sudo apt-get install -y mysql-server

# Secure the MySQL installation
sudo mysql_secure_installation

# Enable MySQL to start on boot
sudo systemctl enable mysql

# Start MySQL service
sudo systemctl start mysql

# Print MySQL version to confirm installation
mysql --version
