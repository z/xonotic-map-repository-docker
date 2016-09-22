FROM jwilder/nginx-proxy

RUN apt-get update && apt-get install -y --no-install-recommends git-core ca-certificates curl

RUN git clone https://github.com/z/xonotic-map-repository-web.git /application
