#!/bin/bash

echo "------------ Deleting Ceph cluster"
kubectl delete cephcluster rook-ceph -n rook-ceph
sleep 10
echo "------------ Deleting host folders created"
kubectl apply -f remove_host_folder.yaml
sleep 10
kubectl delete -f remove_host_folder.yaml
