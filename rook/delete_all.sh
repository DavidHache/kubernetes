#!/bin/bash

kubectl delete -f test_storage.yaml


echo "------------ Deleting pod security policy"
kubectl delete PodSecurityPolicy 00-rook-ceph-operator

echo "------------ Deleting CRDs"
kubectl delete CustomResourceDefinition objectbucketclaims.objectbucket.io
kubectl delete CustomResourceDefinition objectbuckets.objectbucket.io
for cmd in $(kubectl get CustomResourceDefinition |grep -E -- 'ceph|rook' | awk '{print $1}'); 
do 
    kubectl delete CustomResourceDefinition $cmd
done

echo "------------ Deleting Cluster Role Bindings"
for cmd in $(kubectl get clusterrolebinding |grep -E -- 'rbd|rook|ceph' | awk '{print $1}'); 
do 
    kubectl delete clusterrolebinding $cmd
done

echo "------------ Deleting Cluster Roles"
for cmd in $(kubectl get ClusterRole |grep -E -- 'ceph|rook|rbd' | awk '{print $1}'); 
do 
    kubectl delete ClusterRole $cmd
done

echo "------------ Deleting host folders created in clusters"
kubectl apply -f remove_host_folder.yaml
sleep 10
kubectl delete -f remove_host_folder.yaml

kubectl delete ns rook-ceph
kubectl delete sc rook-ceph-block
