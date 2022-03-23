---
title: "kubectl"
linkTitle: "kubectl"
date: 2017-01-05
---

### Get pods from a specific node

```bash
kubectl get pods -A --field-selector spec.nodeName=ip-10-30-44-60.ec2.internal
```

### Get pods running on a set of nodes

This will fetch the nodes with a specific labels and returns the pods running
on them.

```bash
k get nodes -l beta.kubernetes.io/instance-type=m5.8xlarge --no-headers -o custom-columns=":metadata.name" | xargs -r -i -n1 kubectl get pods -A --field-selector spec.nodeName={}
```

### Events

Sort by timestamp:

```bash
kubectl get events --sort-by='.metadata.creationTimestamp'
```

Warnings only:

```bash
kubectl get events --field-selector type=Warning
```

No pod events:

```bash
kubectl get events --field-selector involvedObject.kind!=Pod
```

Only Node events:

```bash
kubectl get events --field-selector involvedObject.kind=Node -A
```

for a specific node:

```bash
kubectl get events --field-selector involvedObject.kind=Node,involvedObject.name=$NODE_NAME
```

Exclude normal events:

```bash
kubectl get events --field-selector type!=Normal
```

### Show certificate expiration

```bash
k -n paas-operators get secrets pv-validator-webhook-certs -ojsonpath="{.data['tls\.crt']}" | base64 -d | openssl x509 -noout -text -in -
```

### Search with annotations

```bash
k get nodes -ojsonpath='{.items[?(@.metadata.annotations.machineconfiguration\.openshift\.io/currentConfig=="rendered-worker-5a2a3af8925b34ed8bdd5c339a3b72c5")].metadata.name}'
```
