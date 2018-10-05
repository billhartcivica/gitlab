#!/bin/sh
export ver=`cat glversion.cnf | grep -v '#'`
echo $ver
# Create the LDAP secret to authenticate to the LDAP server
kubectl create -f /etc/k8s/gitlab-secrets/secrets.yaml
# Create the Persistent Volumes and Volume Claims 
kubectl create -f /etc/k8s/gitlab/gitlab-pvc0-all.yaml
kubectl create -f /etc/k8s/gitlab/gitlab-pvc1-all.yaml
kubectl create -f /etc/k8s/gitlab/gitlab-pvc2-all.yaml
kubectl get pv
kubectl get pvc
# Create the Gitlab deployment
# kubectl create -f /etc/k8s/gitlab/gitlab-deployment.yaml
# Create the Gitlab services, binding ports to hodes
# kubectl create -f /etc/k8s/gitlab/gitlab-service.yaml
