#!/usr/bin/env bash
set -e

IMAGE='pravegasensorcollector'

DOCKER_REGISTRY='devops-repo.isus.emc.com:8116/nautilus'
APPVERSION='1.0.0'

#Build and Push the image
docker build --pull --rm -f "Dockerfile" -t $IMAGE "."
docker tag pravegasensorcollector:latest $DOCKER_REGISTRY/pravegasensorcollector:$APPVERSION
docker push $DOCKER_REGISTRY/pravegasensorcollector:$APPVERSION
