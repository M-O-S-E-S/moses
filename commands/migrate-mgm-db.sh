#!/bin/sh

image="moses_mgmt_1"

search=`docker ps | grep "$image"`

if [ "x$search" = "x" ]; then
  echo "$image is not running.  Have you run docker-compose up -d first?"
  exit 1;
fi

docker exec "$image" node scripts/migrate-db.js /mgm/build/sql
