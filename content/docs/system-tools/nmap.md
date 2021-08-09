---
title: "nmap"
linkTitle: "nmap"
date: 2017-01-05
---

### Get info about DHCP

```bash
nmap --script broadcast-dhcp-discover
```

### Get SSL info

```bash
nmap -p 443 --script ssl-cert 
```

### Scanning

Offline host:

```bash
nmap -vvv -A --reason --script="+(safe or default) and not broadcast" -p 1-65535 $IP
```
