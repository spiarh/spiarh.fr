---
title: "iproute2"
linkTitle: "iproute2"
date: 2017-01-05
---

### LACP config

```bash
ip link set dev eth0 down
ip link set dev eth1 down
ip link set dev bond0 down
```

```bash
ip link set dev eth0 master bond0
ip link set dev eth1 master bond0
```

```bash
ip link set dev eth0 down
ip link set dev eth1 down
ip link set dev bond0 down
```

Check:

```bash
cat /proc/net/bonding/bond0
```

### VLAN Interface

```bash
ip link add link eth0 name eth0.100 type vlan id 100
```
