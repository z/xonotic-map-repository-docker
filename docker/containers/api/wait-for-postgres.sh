#!/bin/bash

set -e

host="$1"
shift
cmd="$@"

until psql -h "$host" -U "xonotic" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

/usr/sbin/sshd -D &

chown root:root -R /root/.ssh/
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# Populate default map package directory with map urls from maplist.txt
(cd /root/.xonotic/repo_resources/packages/ && while read m; do curl -LO $m; done </application/maplist.txt)

>&2 echo "Postgres is up - executing command"
exec $cmd