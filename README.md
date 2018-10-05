# Docker-compose file for Gitlab.

### Configuration

Clone this repository, remembering to create a corresponding secrets.yaml file to contain the LDAP authentication password. The format for this fileshould be as follows:

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

