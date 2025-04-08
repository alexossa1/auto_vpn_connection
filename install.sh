#!/bin/bash

# Script to copy a file to the OpenVPN client configuration directory
# Usage: ./install.sh <file_path>

# Check if the file path is provided as a command-line argument
if [ -z "$1" ]; then
  echo "Usage: $0 <file_path>"
  echo "Error: Please provide the full path of the file to copy as an argument."
  exit 1
fi

# Get the file path from the first command-line argument
file_path="$1"
# Check if the file exists
if [ ! -f "$file_path" ]; then
  echo "Error: File '$file_path' not found."
  exit 1
fi

# if file exist install dependencies
sudo apt-get update
sudo apt-get install openvpn

# Construct the destination path
destination="/etc/openvpn/client/client.conf"

# Execute the copy command with sudo
sudo cp "$file_path" "$destination"

# Check the exit status of the sudo command
if [ $? -eq 0 ]; then
  echo "File '$file_path' successfully copied to '$destination'."
else
  echo "Error: Failed to copy file. Please check your sudo permissions."
  exit 1
fi

echo vpn service created. Not started

sudo npm install -g n
sudo n 16
sudo npm install pm2@latest -g
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 2
sudo env PATH=$PATH:/usr/local/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u $USER --hp /home/$USER
sudo pm2 startup
pm2 start internet_checker.sh --name internetChecker
pm2 save