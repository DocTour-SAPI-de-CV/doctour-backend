#!/bin/bash


aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 432968470264.dkr.ecr.us-east-2.amazonaws.com
docker build -t doctour-api-dev .
docker tag doctour-api-dev:latest 432968470264.dkr.ecr.us-east-2.amazonaws.com/doctour-api-dev:latest
docker push 432968470264.dkr.ecr.us-east-2.amazonaws.com/doctour-api-dev:latest