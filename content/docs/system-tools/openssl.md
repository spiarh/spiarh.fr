---
title: "openssl"
linkTitle: "openssl"
date: 2017-01-05
---


### Convert DER to PEM

```bash
openssl x509 -inform DER -in ca.crt -out ca.crt.pem -text
```


### Create CA

```bash
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1024 -out ca.crt
```

### Example CSR configuration for a webhook

```ini
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = service
DNS.2 = service.namespace
DNS.3 = service.namespace.svc
```

### Create and sign Keypair from CA

```bash
openssl genrsa -out tls.key 4096
openssl req -key tls.key -new -out tls.csr -config csr.conf -subj "/CN=service.namespace.svc"
openssl x509 -req -days 1024 -in tls.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out tls.crt
```


### Create self-signed certificate

```bash
openssl genrsa -out tls.key 4096
openssl req -x509 -new -nodes -key tls.key -sha256 -days 1024 -out tls.crt
```


### Read CSR

```bash
openssl req -in csr -noout -text
```

### Show certificate

```bash
openssl x509 -noout -text -in tls.crt
```


### Show CSR

```bash
openssl req -noout -text -in tls.csr
```

### Show RSA

```bash
openssl rsa -text -noout -in tls.key
```

### Show EC

```bash
openssl ec -text -noout -in ec.key
```

### Get certificate info remote host

```bash
echo | openssl s_client -showcerts -servername $FQDN -connect $FQDN:443 2>/dev/null | openssl x509 -inform pem -noout -text
```


### get remote certificate

```bash
openssl s_client -connect $FQDN:443 </dev/null 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
```

### Get remote CA

```bash
openssl s_client -showcerts -verify 5 -connect $FQDN:443 < /dev/null 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
```
