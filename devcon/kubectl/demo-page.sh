#!/bin/bash
kubectl apply -f demo-page-deployment.yaml.$1
kubectl apply -f pdb.yaml
kubectl apply -f demo-page-service.yaml
sleep 5
kubectl get po
sleep 10
kubectl logs -l app=demo-page --all-containers=true --tail=55
sleep 4
watch kubectl get po
