#!/bin/bash
kubectl delete -f demo-page-deployment.yaml
kubectl delete -f demo-page-deployment2.yaml
kubectl apply -f demo-page-deployment2.yaml
kubectl apply -f demo-page-service.yaml
sleep 5
kubectl logs -l app=demo-page --all-containers=true -f
