#!/bin/bash

docker login -uanils.kaiyamballi@gmail.com anilkaiy.jfrog.io

docker tag development_docker anilkaiy.jfrog.io/docker-trial/development_docker:latest
docker push anilkaiy.jfrog.io/docker-trial/development_docker:latest