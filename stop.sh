export ver=`cat glversion.cnf | grep -v '#'`
echo $ver
# Delete the Gitlab service
kubectl delete -f /etc/k8s/gitlab/gitlab-service.yaml
# Delete the Gitlab deployment
kubectl delete -f /etc/k8s/gitlab/gitlab-deployment.yaml
# Delete the Persistent Volumes and Volume Claims
kubectl delete -f /etc/k8s/gitlab/gitlab-pvc0-all.yaml
kubectl delete -f /etc/k8s/gitlab/gitlab-pvc1-all.yaml
kubectl delete -f /etc/k8s/gitlab/gitlab-pvc2-all.yaml
# Delete the LDAP secret to authenticate to the LDAP server
kubectl delete -f /etc/k8s/secrets/secrets.yaml

