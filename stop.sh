export ver=`cat test.txt | grep -v '#'`
echo $ver
# Delete the Persistent Volumes and Volume Claims
kubectl delete -f ./gitlab-pvc0-all.yaml
kubectl delete -f ./gitlab-pvc1-all.yaml
kubectl delete -f ./gitlab-pvc2-all.yaml
# Delete the LDAP secret to authenticate to the LDAP server
kubectl delete -f ../gitlab-secrets/secrets.yaml

# Create the Gitlab deployment
# kubectl create -f ./gitlab-deployment.yaml
