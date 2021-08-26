---
title: "kubectl"
linkTitle: "kubectl"
date: 2017-01-05
---

### Get pods from a specific node

```bash
kubectl get pods -A --field-selector spec.nodeName=ip-10-30-44-60.ec2.internal
```

### Events


kubectl get events --field-selector involvedObject.kind=Node -A


Warnings only:

```bash
kubectl get events --field-selector type=Warning
```

No pod events:

```
kubectl get events --field-selector involvedObject.kind!=Pod
```

Only Node events:

```bash
kubectl get events --field-selector involvedObject.kind=Node -A
```

for a specific node:

```
kubectl get events --field-selector involvedObject.kind=Node,involvedObject.name=$NODE_NAME
```

Exclude normal events:

```bash
kubectl get events --field-selector type!=Normal
```
