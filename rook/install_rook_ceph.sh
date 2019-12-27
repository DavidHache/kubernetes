#!/bin/sh

image="ceph/ceph"
echo "------------ Getting latest tag for $image"
latest_tag=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' | tail -1`

echo "------------ Will install with tag : $latest_tag"

echo "------------ Adding rook repo."
helm repo add rook-release https://charts.rook.io/release
echo "------------ Creating namespace for rook-ceph"
kubectl create namespace rook-ceph
echo "------------ Installing rook-ceph custom operator"
helm install --namespace rook-ceph rook-ceph rook-release/rook-ceph
echo "------------ Waiting for rook to come up."

while :
do
    if kubectl get po -n rook-ceph |grep rook-ceph-operator |grep -q "Running";
    then
        echo "------------ Operator is running, creating storage cluster"
        break
    fi
    echo "!!!!!!!!!!!!!! Waiting for operator pod to come up."
    sleep 10
done

echo "------------ Creating a ceph cluster using local folders /var/lib/rook_ceph and /var/lib/rook_ceph_storage"
cat cluster.yaml |sed s/VERSION/$latest_tag/g  | kubectl apply -f -

echo "------------ Installing storage class rook-ceph-block"
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml

while :
do
    if kubectl -n rook-ceph get pods -l "app=rook-ceph-operator" |grep -q "Running";
    then
        echo "------------ Operator is running, creating storage cluster"
        break
    fi
    echo "!!!!!!!!!!!! Waiting for operator pod to come up."
    sleep 10
done


echo "------------ Installing test pod to make sure everything is running well"
kubectl apply -f test_storage.yaml
sleep 20

time=1
while :
do
    if kubectl get po -n rook-ceph ceph-pod1 |grep -q "Running"; 
    then
        echo "------------ Test pod is running, everything seems to be ready to use."
        kubectl get po -n rook-ceph ceph-pod1
        echo "------------ Removing test pod."
        kubectl delete -f test_storage.yaml
        break
    fi
    kubectl get po -n rook-ceph ceph-pod1
    sleep 30
    time=$(( $time + 1 ))
    if [ "$time" -gt "10" ];
    then
        echo "!!!!!!!!!!!!  Waited too long and test pod did not come up correctly, please verify what's wrong..."
        kubectl get po -n rook-ceph
        kubectl describe pvc ceph-claim -n rook-ceph
        break
    fi
done

echo "------------ Storage class rook-ceph-block is ready to use."
kubectl get sc rook-ceph-block