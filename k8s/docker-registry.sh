#!/bin/bash
docker_registry=192.168.25.228:8088
kubectl create secret docker-registry registry-pull-secret --docker-server=$docker_registry --docker-username=admin --docker-password=123456 --docker-email=admin@harbor.com -n ms
