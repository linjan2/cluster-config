# cluster-config

manual steps:

- create the argocd namespace for the OpenShift GitOps operator.
- create secret with git private key for Argo CD, annotated with `argocd.argoproj.io/secret-type: repo-creds` in the argocd installed-to namespace.
- run `ssh-keyscan -p PORT HOST` to get known_host for the git server and add to `ArgoCD.spec.initialSSHKnownHosts`.
- create the sops encryption keys for encrypted secret data in a secret in the argocd installed-to namespace.
- apply the bootstrap overlay.


Applying the bootstrap overlay creates the cluster `Application`, which triggers Argo CD to synchronize all other resources.

To bootstrap, run either of:

```sh
oc apply -k clusters/overlays/boostrap
```
