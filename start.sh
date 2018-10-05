#!/bin/sh
export ver=`cat glversion.cnf | grep -v '#'`
echo $ver
# Create the LDAP secret to authenticate to the LDAP server
kubectl create -f ../gitlab-secrets/secrets.yaml
# Create the Persistent Volumes and Volume Claims 
kubectl create -f ./gitlab-pvc0-all.yaml
kubectl create -f ./gitlab-pvc1-all.yaml
kubectl create -f ./gitlab-pvc2-all.yaml
kubectl get pv
kubectl get pvc
# Create the Gitlab deployment
# kubectl create -f ./gitlab-deployment.yaml
