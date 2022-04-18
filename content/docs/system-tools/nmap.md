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

### Output in greppable format

```bash
nmap -oG
```

### Scanning

All ports:

```bash
nmap -p- $HOST
```

Offline host:

```bash
nmap -vvv -A --reason --script="+(safe or default) and not broadcast" -p 1-65535 $HOST
```

Banner grabbing:

```bash
nmap -sV -sT -A 10.11.1.220
```

### Scanning with NSE

SMB discovery:

```bash
nmap --script=smb-os-discovery 10.11.1.220
```

DNS Zone tranfer:

```bash
nmap --script=dns-zone-transfer -p 53 ns2.megacorpone.com
```
