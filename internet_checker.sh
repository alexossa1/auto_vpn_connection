#!/bin/bash

# Define the service name
service_name="openvpn-client@client"

# Flag to track if the start/stop command has been executed
started=false
stopped=false

while true; do
  # Attempt to ping a reliable external server
  if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    # Internet connection is available
    if [ "$started" = false ]; then
      echo "Internet connection detected. Starting $service_name..."
      sudo systemctl start "$service_name"
      started=true
      stopped=false # Reset the stopped flag
    fi
  else
    # No internet connection
    if [ "$stopped" = false ]; then
      echo "No internet connection. Stopping $service_name..."
      sudo systemctl stop "$service_name"
      stopped=true
      started=false # Reset the started flag
    fi
  fi

  # Adjust the sleep duration as needed (in seconds)
  sleep 5
done
