---
title: "networking"
linkTitle: "networking"
date: 2017-01-05
---

### list open ports

```bash
lsof -Pnl +M -i4
lsof -Pnl +M -i6
```

```bash
ss -lntup
```


### move interface to/from namespaces

```bash
ip link set wg0 netns vpn
ip netns exec vpn ip link set wg0 netns default
```
