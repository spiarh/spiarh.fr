---
title: "kustomize"
linkTitle: "kustomize"
date: 2017-01-05
---

### Add environment variable

```yaml
patchesJson6902:
- target:
    version: v1
    kind: Deployment
    name: manager
    namespace: system
  patch: |-
    - op: add
      path: /spec/template/spec/containers/0/env/-
      value:
        name: EGRESSFIREWALL_ENABLED
        value: "true"
```
