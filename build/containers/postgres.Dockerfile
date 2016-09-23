FROM postgres:9.6

RUN apt-get update && apt-get install -y --no-install-recommends git-core ca-certificates postgresql-client wget
RUN pg_createcluster 9.6 main --start