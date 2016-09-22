# xonotic-map-repository-docker

The architecture of xonotic-map-repository dockerized

## Requirements

Docker, follow the [docker installation instructions](https://docs.docker.com/engine/installation/) if you don't currently have it installed.

Add the following to your /etc/hosts:

```
127.0.0.1 www.xonotic-repo.local
127.0.0.1 api.xonotic-repo.local
```

## Running

To run in **development mode**:

```
docker-compose up
```

similarly to stop all docker containers, and remove them (data on your host will persist):

```
docker-compose down
```

Docker-compose will build your docker images on first run. 

## Docker Tips

These containers are managed with docker-compose (`docker-compose -h`), but here are some tricks for managing them with docker directly.

#### list all containers

```
docker ps -a
```

#### get a shell on a container

```
docker-compose exec web /bin/bash
```

#### destroy everything!

```
docker rm $(docker ps -qa)
```
