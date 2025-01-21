#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <short_sha_of_service> <service>"
    exit 1
fi

SHA=$1
SERVICE=$2

case $SERVICE in
  traefik)
    docker-compose -f docker-compose-traefik.yml up -d --scale app=1
    ;;
  nginx)
    docker-compose -f docker-compose-nginx.yml up -d --scale app=1
    ;;
  openresty)
    docker-compose -f docker-compose-openresty.yml up -d --scale app=1
    ;;
  *)
    echo "Unknown service: $SERVICE"
    exit 1
    ;;
esac
