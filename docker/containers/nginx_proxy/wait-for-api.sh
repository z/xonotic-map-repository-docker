#!/bin/bash

API_HOST=app_api

until curl -sL -w "%{http_code}" "http://${API_HOST}:80/map/1" -o /dev/null; do
  >&2 echo " - API is unavailable - sleeping"
  sleep 1
done

echo " - API is up"

chown root:root -R /root/.ssh/
chmod 400 /root/.ssh/id_rsa

echo rsync -azvh root@${API_HOST}:/root/.xonotic/repo_resources/ /application/resources/
rsync -azvh -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" root@${API_HOST}:/root/.xonotic/repo_resources/ /application/www.xonotic-repo.local/resources/

nginx -g "daemon off;"