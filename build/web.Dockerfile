FROM jwilder/nginx-proxy

# System
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git-core \
    curl \
    ssh \
    rsync

RUN rm -rf /application

# Application
RUN git clone --depth=1 https://github.com/z/xonotic-map-repository-web.git /application
COPY web/config.js /application/config.js

# Startup
COPY web/wait-for-api.sh /bin/wait-for-api.sh
RUN chmod +x /bin/wait-for-api.sh
