FROM python:3.5
MAINTAINER Tyler Mulligan <z@xnz.me>

# System
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git-core \
    postgresql-client \
    curl \
    rsync \
    openssh-server \
    libmemcached-dev

RUN mkdir /var/run/sshd && \
    mkdir /root/.ssh/ && \
    chmod 755 /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/;s/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir /application
WORKDIR /application

COPY projects/packages /application/packages

RUN pip install pip --upgrade && \
    pip install pip packages/xmra-0.3.0.tar.gz

COPY docker/containers/api/xmra.ini /root/.xmra.ini
RUN mkdir -p /root/.xonotic/repo_resources/packages && \
    chmod a+rw /root/.xonotic/repo_resources/packages/

# Startup
COPY docker/containers/api/wait-for-postgres.sh /bin/wait-for-postgres.sh
RUN chmod +x /bin/wait-for-postgres.sh
CMD /bin/wait-for-postgres.sh postgres xmra-init; xmra-add --all; xmra-serve

EXPOSE 80
EXPOSE 873
EXPOSE 22