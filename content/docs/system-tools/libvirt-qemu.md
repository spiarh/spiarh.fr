---
title: "libvirt-wemu"
linkTitle: "libvirt-qemu"
date: 2017-01-05
---

### Convert ova to qcow2

```bash
tar xvf Parrot-security-4.10_virtual.ova --one-top-level=parrot-security
qemu-img convert -O qcow2 'Parrot Security 4.10-disk001.vmdk' parrot_security_4-10.qcow2
```
