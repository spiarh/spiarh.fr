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
curl -sk -L -u $USER:$PASS https://$HOST/redfish/v1/Systems/1
```

Power off server (takes ~6s):

```
curl -skL -u $USER:$PASS -X POST -H 'Content-Type: application/json' -d '{"Action": "Reset", "ResetType": "ForceOff"}' https://$HOST/redfish/v1/Systems/1
curl -skL -u $USER:$PASS https://$HOST/redfish/v1/Systems/1 | jq '.Power'
```
