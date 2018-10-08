#!/bin/sh
##################################################
# Startup script for running Gitlab under K8s    #
##################################################
# Set the Gitlab version from the glversion.cnf file and set as an environment parameter
export GLVER=`cat glversion.cnf | grep -v '#'`
echo Starting GitLab Version: $GLVER
# Delete original deployment config, parse the environment variable with the current version into a new config
rm -rf /etc/k8s/gitlab/gitlab-deployment.yaml; envsubst < "/etc/k8s/gitlab/gitlab-deployment-template.yaml" > "/etc/k8s/gitlab/gitlab-deployment.yaml";
# Create the LDAP secret to authenticate to the LDAP server
kubectl create -f /etc/k8s/secrets/secrets.yaml
# Create the Persistent Volumes and Volume Claims 
kubectl create -f /etc/k8s/gitlab/gitlab-pvc0-all.yaml
kubectl create -f /etc/k8s/gitlab/gitlab-pvc1-all.yaml
kubectl create -f /etc/k8s/gitlab/gitlab-pvc2-all.yaml
# Display physical volumes and volume claims 
kubectl get pv
kubectl get pvc
# Create the Gitlab deployment
kubectl create -f /etc/k8s/gitlab/gitlab-deployment.yaml
# Create the Gitlab services, binding ports to hodes
kubectl create -f /etc/k8s/gitlab/gitlab-service.yaml
