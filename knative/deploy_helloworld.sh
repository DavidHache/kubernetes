#!/bin/bash
echo "------------ Applying Hello world pod"
kubectl apply --filename helloworld-go.yaml
echo "------------ Waiting for service to be applied"
sleep 10
echo "------------ Getting node port information to test hello world"
ip=$(kubectl get nodes -o wide --no-headers=true |awk '{print $6}'|grep -m1 "")
nodeport=$(kubectl get svc ambassador --no-headers=true | awk '{print $5}'|awk -F : '{print $2}' | awk -F / '{print $1}')
echo "------------ Testing service"
echo "------------"
echo "-"
curl -H "Host: helloworld-go.default.$ip.xip.io" http://$ip:$nodeport
echo "-"
echo "------------"
echo "------------ Showing service running."
kubectl get deployment |grep hello
echo "------------ Waiting for deployment to drop to 0"
while :
do
    if kubectl get deployment |grep hello |grep -q "0/0"; 
    then
        echo "------------ Checking if deployment has droped to 0"
        kubectl get deployment |grep hello
        break
    fi
    echo "..."
    sleep 10
done


