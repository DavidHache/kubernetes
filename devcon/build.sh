#!/bin/bash
docker build ./ -f Dockerfile.$1 -t 192.168.118.128:30002/devcondemo:nginx$1
docker push 192.168.118.128:30002/devcondemo:nginx$1