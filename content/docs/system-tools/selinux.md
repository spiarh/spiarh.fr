---
title: "selinux"
linkTitle: "selinux"
date: 2017-01-05
---


### check transition

```bash
sepolicy transition -s spc_t -t rpm_script_t
```

### generate policy from an event

```bash
$ echo " avc:  denied  { transition } for  pid=8704 comm="yum" path="/usr/bin/bash" dev="vda1" ino=12745253 scontext=system_u:system_r:spc_t:s0 tcontext=system_u:system_r:rpm_script_t:s0 tclass=process permissive=0" | audit2allow -M yumsecupdater

$ ls
yumsecupdater.pp yumsecupdater.te

$ cat yumsecupdater.te

module yumsecupdater 1.0;

require {
    type spc_t;
    type rpm_script_t;
    class process transition;
}

#============= spc_t ==============
allow spc_t rpm_script_t:process transition;
```

### generate policy from type enforcement file

in the directory with `yumsecupdater.te`:

```
$ make -f /usr/share/selinux/devel/Makefile yumsecupdater.pp
-rw-r--r--. 1 root root     0 Dec  6 15:46 yumsecupdater.fc
-rw-r--r--. 1 root root    23 Dec  6 15:46 yumsecupdater.if
-rw-r--r--. 1 root root  7043 Dec  6 15:46 yumsecupdater.pp
-rw-r--r--. 1 root root   190 Dec  6 15:45 yumsecupdater.te
```

### load module

```bash
semodule -i yumsecupdater.pp
```

### See what all rules are associated with a policy type

```bash
sesearch -A -t spc_t
```

### List all access

```bash
sesearch --all -s spc_t
