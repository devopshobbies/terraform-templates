#!/bin/bash

if [ -f "/data/index.html" ]; then
  echo "Using /data as volume"
  HOST_PATH="/data"
else
  echo "Using current directory as volume"
  HOST_PATH=$(pwd)
fi

if nc -z localhost 2376; then
  DOCKER_HOST="tcp://localhost:2376"
  echo "Docker TCP socket detected at $DOCKER_HOST"
else
  DOCKER_HOST="unix:///var/run/docker.sock"
  echo "Docker TCP socket not detected, using Unix socket at $DOCKER_HOST"
fi

terraform plan -var="docker_host=$DOCKER_HOST" -var="host_path=$HOST_PATH"
read -p "Press Enter to continue with terraform apply or Ctrl+C to cancel..."
terraform apply -var="docker_host=$DOCKER_HOST" -var="host_path=$HOST_PATH"