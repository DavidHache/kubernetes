#!/usr/bin/env bash
#Script to start devcon site

echo "Starting Devcon demo site!"
cd /devcon/devcon_demo/
rails server --binding 0.0.0.0 &
sleep 20
curl http://localhost:3000
while true; do sleep 30; done;