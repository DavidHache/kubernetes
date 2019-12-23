#!/bin/bash
# Initial edit by : David Haché, dave@mizbu.com
# Script to install knative on a single node kubernetes cluster on a standalone linux server.
# Helps tester knative without having access to LB services and uses Ambasador as the ingress.
# Based on document here: https://knative.dev/docs/install/knative-with-ambassador/

echo "------------ Setting up Knative."
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.11.0/serving-crds.yaml
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.11.0/serving-core.yaml
echo "------------ Setting up Ambassador."
kubectl apply --filename https://getambassador.io/yaml/ambassador/ambassador-knative.yaml 
kubectl apply --filename https://getambassador.io/yaml/ambassador/ambassador-service.yaml
echo "------------ Waiting for ambassador to come up."
while ! kubectl get po |grep ambassador |grep Running > /dev/null
do
    echo "Not up yet, waiting for 20 sec."
    sleep 20
done
echo "------------ Scaling down ambassador to 1 replica"
kubectl scale deployments ambassador --replicas=1
ip=$(kubectl get nodes -o wide --no-headers=true |awk '{print $6}'|grep -m1 "")
echo "------------ Setting up config map for knative domain using magic DNS xip.io"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-domain
  namespace: knative-serving
data:
  # xip.io is a "magic" DNS provider, which resolves all DNS lookups for:
  # *.{ip}.xip.io to {ip}.
  $ip.xip.io: ""
EOF
