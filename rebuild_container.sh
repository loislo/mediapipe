#!/bin/bash

set +e

echo stop mediapipe
docker stop mediapipe
echo delete meidapipe
docker rm mediapipe

echo build new image
docker build . --build-arg="UID=$(id -u)" --build-arg="GID=$(id -g)" --build-arg="USER_NAME=$(whoami)" -t mediapipe

echo create new container with dir mapping
docker create -it --user $(id -u):$(id -g) -v "$(pwd)":/mediapipe --name mediapipe mediapipe:latest

echo attach to the container interactively with docker start -ai mediapipe
docker start -ai mediapipe
