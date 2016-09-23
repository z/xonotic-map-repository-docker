#!/bin/bash

until curl -sL -w "%{http_code}" "http://api:80/map/1" -o /dev/null; do
  >&2 echo " - API is unavailable - sleeping"
  sleep 1
done

echo " - API is up"

# Setup keys
echo rsync -azvh root@api:/root/.xonotic/repo_resources/ /application/resources/

forego start -r