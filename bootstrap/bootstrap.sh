#!/bin/sh

# Create git ssh credential for Argo CD.
# Create encryption keys for sealed secrets.

# create encryption key secret for argocd's ksops "sealed secrets"
# age-keygen -o key.txt
oc create secret generic sops-age -n openshift-gitops --from-literal=keys.txt=key.txt

# create ssh key and known_hosts secret for argocd's git credentials
# ssh-keygen -N '' -C 'argocd' -f ./argocd-key
oc create secret generic gitssh -n openshift-gitops --from-file=sshPrivateKey=argocd-key
oc label secret gitssh argocd.argoproj.io/secret-type=repo-creds

# create bootstrap application
oc apply -k overlays/lab

# encrypt secret fields in-place (uses .sops.yaml file from repo-root, which has the public key).
sops --encrypt --in-place secret.sops.yaml
