#!/bin/bash

set -e

host="$1"
shift
cmd="$@"

until psql -h "$host" -U "xonotic" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

(cd /root/.xonotic/repo_resources/packages/ && while read m; do curl -LO $m; done </application/maplist.txt)

xmra-init

>&2 echo "Postgres is up - executing command"
exec $cmd