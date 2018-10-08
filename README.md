# Gitlab Kubernetes Deployment using NFS exports as Persistent Storage.

### Configuration

Clone this repository into an /etc/k8s folder, remembering to create a corresponding secrets.yaml file to contain the LDAP authentication password. The secrets file should be contained in the /etc/k8s/secrets folder, which you should create if it doesn't already exist. The format for this fileshould be as follows:

```
apiVersion: v1
kind: Secret
metadata:
  name: gitlab-secrets
type: Opaque
data:
  ldap_password: <base64-encoded-password>
```
To encode a base64 string into a secret that can be parsed to a secrets file within K8s, type the following and copy the output into the secrets.yaml file after the 'ldap_password' entry:
```
echo -n "mysecretword" | base64
```
The -n entry above ensures that the 'newline' character is omitted from the output. Otherwise the encoded secret won't work.

The master node provides the NFS exports that the cluster uses to mount the persistent storage used for configuration, logging and data. A partition for NFS exports is mounted on /nfs and the corresponding folders are as follows:
```
/nfs/config - Mounts within the container as /etc/gitlab 
/nfs/data   - Mounts within the container as /var/log/gitlab
/nfs/logs   - Mounts within the container as /var/opt/gitlab
```
The NFS exports file is configured to allow read/write access to all slave nodes within the cluster:
```
/nfs/config     10.100.8.52(rw,no_root_squash) 10.100.8.53(rw,no_root_squash)
/nfs/logs       10.100.8.52(rw,no_root_squash) 10.100.8.53(rw,no_root_squash)
/nfs/data       10.100.8.52(rw,no_root_squash) 10.100.8.53(rw,no_root_squash)
```
Permissions on the above folders should be set to owner: nfsnobody/group:nfsnobody, with permissions set to 0755 on each.

The start.sh and stop.sh scripts create all the required resources in the correct order. Generally, these should be:
1. Secrets
2. Volume Mounts
3. Deployment (Gitlab instance)
4. Services (Exposed services and ports)

An HAProxy service running on the master node forwards all requests back to each of the cluster slave nodes running the exposed nodeports. This can be configured in round-robin fashion, pointing to the backend nodes on the listening port for Gitlab (in this example, 30080/TCP0).


