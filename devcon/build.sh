#!/bin/bash
docker build ./ -t 192.168.118.128:30002/devcondemo:$1
docker push 192.168.118.128:30002/devcondemo:$1