#!/bin/bash

echo "================================================="
echo "1. DOCKER INSTALLATION CHECK"
echo "================================================="

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is NOT installed on this server."
  exit 0
fi

echo "Docker is installed."

echo
echo "================================================="
echo "2. DOCKER VERSION"
echo "================================================="
docker --version
docker version --format 'Client Version: {{.Client.Version}} | Server Version: {{.Server.Version}}'

echo
echo "================================================="
echo "3. DOCKER SERVICE STATUS"
echo "================================================="
systemctl status docker --no-pager | grep -E "Loaded:|Active:"

echo
echo "================================================="
echo "4. RUNNING CONTAINERS (SUMMARY)"
echo "================================================="
docker ps --format "Container={{.Names}} | Image={{.Image}} | Status={{.Status}} | Ports={{.Ports}}"

echo
echo "================================================="
echo "5. ALL CONTAINERS (RUNNING + STOPPED)"
echo "================================================="
docker ps -a --format "Container={{.Names}} | Image={{.Image}} | Status={{.Status}}"

echo
echo "================================================="
echo "6. DETAILED CONTAINER INFORMATION"
echo "================================================="

for c in $(docker ps -a --format '{{.Names}}'); do
  echo "---- Container: $c ----"
  docker inspect "$c" \
  --format='
Name: {{.Name}}
Image: {{.Config.Image}}
Command: {{.Config.Cmd}}
Created: {{.Created}}
State: {{.State.Status}}
