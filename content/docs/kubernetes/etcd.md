---
title: "etcd"
linkTitle: "etcd"
date: 2017-01-05
---

## etcdctl

### Flags

For APIv2:

```bash
export ETCDCTL_API=2
export ETCDCTL_CA_FILE=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_KEY_FILE=/etc/kubernetes/pki/etcd/server.key
export ETCDCTL_CERT_FILE=/etc/kubernetes/pki/etcd/server.crt
```

For APIv3:

```bash
export ETCDCTL_API=3
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt
```

One line:

```bash
export ETCDCTL_API=3 ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt
```

For minikube:

```bash
export ETCDCTL_API=3 ETCDCTL_CACERT=/var/lib/minikube/certs/etcd/ca.crt ETCDCTL_KEY=/var/lib/minikube/certs/etcd/server.key ETCDCTL_CERT=/var/lib/minikube/certs/etcd/server.crt
```
