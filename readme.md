# cluster-config

Bootstrap sets up:

- git credentials for Argo CD
- the encryption keys for encrypted secret data
- the bootstrap application

OpenShift GitOps operator must be installed.

Creating the bootstrap application starts the synchronization chain for resources.

```
bootstrap application -> cluster-config "app of apps" -> x cluster applications
```

To bootstrap, run either of:

```sh
oc apply -k bootstrap/overlays/lab1
kustomize build bootstrap/overlays/lab1 | oc apply -f -
```

The cluster application uses sync-waves to create its applications in order:

- 0: default when sync-wave annotation is missing
- 10: Storage, storageclasses
- 20: RBAC
- 30: operators
- 40: operator CRDs
- 50: tool applications
- 60: tenants
