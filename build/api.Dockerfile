FROM python:3.5

RUN apt-get update && apt-get install -y --no-install-recommends git-core ca-certificates postgresql-client curl

RUN git clone --depth=1 https://github.com/z/xonotic-map-repository-api.git /application

WORKDIR /application

RUN python setup.py install

ADD common/wait-for-postgres.sh /bin/wait-for-postgres.sh
RUN chmod +x /bin/wait-for-postgres.sh

CMD /bin/wait-for-postgres.sh postgres xmra-serve

EXPOSE 8010
