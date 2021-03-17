---
title: "curl"
linkTitle: "curl"
date: 2017-01-05
---

### Show server certificate

```bash
curl -v https://spiarh.fr 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'
```


### Set host:port for a hostname

```bash
curl -k --resolve fqdn:443:192.168.0.1 https://fqdn
```

### redfish ilo

```
curl -sk -L -u $USER:$HOST https://$IP/redfish/v1/Systems/1
```
