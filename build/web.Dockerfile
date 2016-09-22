FROM jwilder/nginx-proxy

RUN apt-get update && apt-get install -y --no-install-recommends git-core ca-certificates curl
RUN rm -rf /application
RUN git clone --depth=1 https://github.com/z/xonotic-map-repository-web.git /application
