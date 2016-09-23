#!/bin/bash

until curl -sL -w "%{http_code}" "http://api:80/map/1" -o /dev/null; do
  >&2 echo " - API is unavailable - sleeping"
  sleep 1
done

echo " - API is up"

chown root:root -R /root/.ssh/

echo rsync -azvh root@api:/root/.xonotic/repo_resources/ /application/resources/
rsync -azvh -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" root@api:/root/.xonotic/repo_resources/ /application/resources/

forego start -r