#!/bin/bash

# script to bring up transparent web cache app offlineweb

if [ -z "$OFFLINE" ]; then
  docker image rm caspia/offlineweb:latest
  docker build -t caspia/offlineweb:latest .
fi

mkdir -p "$OFFLINEWEB_CACHEPATH"
mkdir -p "$OFFLINEWEB_LOGPATH"
mkdir -p "$OFFLINEWEB_CERTIFICATEPATH"

docker run -p "80:3129" -p "443:3130" -d --restart=always\
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  -v $OFFLINEWEB_CACHEPATH:/var/cache/offlineweb \
  -v $OFFLINEWEB_LOGPATH:/var/log/offlineweb \
  -v $OFFLINEWEB_CERTIFICATEPATH:/root/app/certificates:ro \
  --name offlineweb --ip="172.20.0.100" \
  --network="beluga"\
  --cap-add NET_ADMIN \
  caspia/offlineweb:latest
