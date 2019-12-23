#!/bin/bash
# Quick clean script

kubectl delete --filename helloworld-go.yaml
kubectl delete --filename ambassador-service-standalone.yaml
kubectl delete --filename https://getambassador.io/yaml/ambassador/ambassador-knative.yaml 
kubectl delete --filename https://github.com/knative/serving/releases/download/v0.11.0/serving-core.yaml
