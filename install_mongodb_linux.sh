#!/bin/bash
set -e

echo "Detecting Linux distribution..."

# Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot detect OS. Exiting."
    exit 1
fi

echo "Detected OS: $DISTRO"

if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
    echo "Installing MongoDB on Debian/Ubuntu..."

    # Import MongoDB GPG key
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

    # Add MongoDB repo
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

    # Update packages
    sudo apt-get update -y

    # Install MongoDB server, shell, database tools
    sudo apt-get install -y mongodb-org mongodb-database-tools

    # Start & enable service
    sudo systemctl enable mongod
    sudo systemctl start mongod

elif [[ "$DISTRO" == "centos" || "$DISTRO" == "rhel" || "$DISTRO" == "fedora" ]]; then
    echo "Installing MongoDB on RHEL/CentOS/Fedora..."

    # Create repo file
    sudo tee /etc/yum.repos.d/mongodb-org-6.0.repo > /dev/null <<EOL
[mongodb-org-6.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/6.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc
EOL

    # Install MongoDB server, shell, database tools
    sudo yum install -y mongodb-org mongodb-database-tools

    # Start & enable service
    sudo systemctl enable mongod
    sudo systemctl start mongod

else
    echo "Unsupported OS: $DISTRO"
    exit 1
fi

# Verify installation
echo "MongoDB version:"
mongod --version
echo "Mongo Shell version:"
mongosh --version
echo "Database Tools version (mongodump):"
mongodump --version

echo "MongoDB installation completed!"
echo "MongoDB service is running and enabled on boot."
echo "Use 'mongosh' to connect to MongoDB."
