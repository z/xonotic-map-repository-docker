# xonotic-map-repository-docker

A xonotic-map-repository sandbox

## Requirements

Docker, follow the [docker installation instructions](https://docs.docker.com/engine/installation/) if you don't currently have it installed.

## Installation

Clone this repository and the child to `~/dev`

```
mkdir ~/dev
cd ~/dev
git clone https://github.com/z/xonotic-map-repository-docker
git clone https://github.com/z/xonotic-map-repository-api
git clone https://github.com/z/xonotic-map-repository-web
```

Add the following to your /etc/hosts:

```
127.0.0.1 www.xonotic-repo.local
127.0.0.1 api.xonotic-repo.local
```

Generate a key pair for the web server to rsync files down from the API server that parses the map packages.
 
```
./docker/generate_keys.sh
```

Build

```
make build             # builds the dependencies
docker-compose build   # builds the docker images with dependencies
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
docker-compose exec app_api /bin/bash
```

#### destroy everything!

```
docker rm $(docker ps -qa)
```
