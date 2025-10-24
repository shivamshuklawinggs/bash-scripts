#!/bin/bash
set -e

echo "Installing RabbitMQ on Linux..."

# 1. Update packages
sudo apt-get update -y

# 2. Install dependencies (Erlang)
echo "Installing Erlang..."
sudo apt-get install -y erlang-nox

# 3. Install RabbitMQ server
echo "Installing RabbitMQ..."
sudo apt-get install -y rabbitmq-server

# 4. Enable and start RabbitMQ service
echo "Starting RabbitMQ service..."
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# 5. Enable management plugin
echo "Enabling RabbitMQ management plugin..."
sudo rabbitmq-plugins enable rabbitmq_management

# 6. Show service status
sudo systemctl status rabbitmq-server

echo "RabbitMQ installation completed!"
echo "Access Management UI at http://localhost:15672 (user: guest, pass: guest)"
