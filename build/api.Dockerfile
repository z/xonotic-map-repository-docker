FROM python:3.5

# System
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git-core \
    postgresql-client \
    curl \
    rsync \
    openssh-server

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


# Application
RUN git clone --depth=1 https://github.com/z/xonotic-map-repository-api.git /application

WORKDIR /application

RUN python setup.py install

COPY api/xmra.ini /root/.xmra.ini
RUN mkdir -p /root/.xonotic/repo_resources/packages/
RUN chmod a+rw /root/.xonotic/repo_resources/packages/


# Startup
COPY api/wait-for-postgres.sh /bin/wait-for-postgres.sh
RUN chmod +x /bin/wait-for-postgres.sh
CMD /bin/wait-for-postgres.sh postgres xmra-init; xmra-add --all; xmra-serve

EXPOSE 80
EXPOSE 873
EXPOSE 22