# cluster-config

```sh
#!/bin/sh
set -o errexit
set -o nounset

# create ssh key secret for argocd's git credentials (add .pub to git server)
ssh-keygen -N '' -C 'argocd' -f ./argocd-key
oc create secret generic gitssh -n openshift-gitops --from-file=sshPrivateKey=argocd-key
oc label secret gitssh argocd.argoproj.io/secret-type=repo-creds

# get git servers host keys (add to ArgoCD-patch's initialSSHKnownHosts.keys)
ssh-keyscan -p PORT example.com > known_hosts

# create
oc apply -k components/argocd-cluster/overlays/default
```
