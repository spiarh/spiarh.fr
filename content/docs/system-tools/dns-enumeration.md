---
title: "dns"
linkTitle: "DNS"
date: 2017-01-05
---

### Zone transfers

with `dig`:

```bash
dig -t AXFR domain.com @ns.domain.com
```

with `host`:

```bash
host -l domain.com ns.domain.com
```

with `dnsrecon`:

```bash
dnsrecon -d domain.com -t axfr
```

with `dnsenum`:

zonetransfer.me domain is owned by DigiNinja2 and specifically allows
zone transfers.

```bash
dnsenum zonetransfer.me
```

### Brute force

Prepare a list of possible hostnames:

```bash
cat > list.txt <<EOF
www
ftp
mail
owa
proxy
router
EOF
```

#### Forward Lookup

`/usr/share/dnsenum/dns.txt` is in Kali.

```bash
for ip in $(cat /usr/share/dnsenum/dns.txt); do dig $ip.megacorpone.com; done
```

#### Reverse Lookup

```bash
for ip in $(seq  50 100); do host 192.168.193.$ip; done | grep -v "not found"
```
