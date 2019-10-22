#!/bin/bash
kubectl apply -f demo-page-deployment.yaml.$1
kubectl apply -f pdb.yaml
kubectl apply -f demo-page-service.yaml
kubectl get all
sleep 10
kubectl logs -l app=demo-page --all-containers=true --tail=55
kubectl get po -w
