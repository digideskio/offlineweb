#!/bin/bash

# script to bring up transparent web cache app offlineweb
echo ""
echo "=== OFFLINEWEB going up"
echo ""

mkdir -p "$OFFLINEWEB_CACHEPATH" -m777
mkdir -p "$OFFLINEWEB_LOGPATH" -m777
mkdir -p "$OFFLINEWEB_CERTIFICATEPATH" -m777
echo "OFFLINEWEB_LOGPATH is ${OFFLINEWEB_LOGPATH}"

docker container rm --force offlineweb 2>/dev/null
docker run -p "80:3129" -p "443:3130" -d --restart=always\
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  -v $OFFLINEWEB_CACHEPATH:/var/cache/offlineweb \
  -v $OFFLINEWEB_LOGPATH:/var/log/offlineweb \
  -v $OFFLINEWEB_CERTIFICATEPATH:/root/app/certificates:ro \
  --name offlineweb --ip="172.20.0.100" \
  --network="beluga"\
  --cap-add NET_ADMIN \
  caspia/offlineweb:latest
