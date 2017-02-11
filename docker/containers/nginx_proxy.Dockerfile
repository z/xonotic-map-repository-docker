FROM nginx:1.11.6
MAINTAINER Tyler Mulligan <z@xnz.me>

# System
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git-core \
    curl \
    ssh \
    rsync

RUN mkdir /application
WORKDIR /application

# Application
RUN git clone --depth=1 https://github.com/z/xonotic-map-repository-web.git /application/www.xonotic-repo.local
COPY docker/containers/nginx_proxy/config.js /application/www.xonotic-repo.local/config.js

# Startup
COPY docker/containers/nginx_proxy/wait-for-api.sh /bin/wait-for-api.sh
RUN chmod +x /bin/wait-for-api.sh

# Configure Nginx and apply fix for very long server names
RUN sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

COPY docker/containers/nginx_proxy/id_rsa /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa

VOLUME ["/etc/nginx/certs"]

CMD ["nginx", "-g", "daemon off;"]