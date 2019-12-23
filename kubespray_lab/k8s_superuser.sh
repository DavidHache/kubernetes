
#!/bin/bash
echo "Getting cluster info"

clusterfqdn=$(kubectl cluster-info |grep master | awk '{ print $6}')
clusterip=$(kubectl get nodes -o wide |grep master | awk '{print $6}')
echo "------->  Installing Kubernetes Superuser"
kubectl create serviceaccount superuser -n kube-system
kubectl create clusterrolebinding superuser --clusterrole=cluster-admin --serviceaccount=kube-system:superuser
echo "------->  Getting Superuser ID"
superuser=$(kubectl get secrets -n kube-system |grep superuser |awk '{ print $1}')
echo "------->  Getting $superuser token"
token=$(kubectl describe secret $superuser -n kube-system  |grep token:|awk '{ print $2}')


echo "-------> Please send theses instructions for the cluster"
echo "--------------------------------------------------------"
echo "kubectl config set-cluster $1 --server=$clusterfqdn --insecure-skip-tls-verify=true"
echo "kubectl config set-credentials $superuser --token=$token"
echo "kubectl config set-context $1 --cluster=$1 --user=$superuser"
echo "kubectl config use-context $1"
echo "--------------------------------------------------------"
echo "Add and entry in the DNS for $clusterip   $clusterfqdn"

