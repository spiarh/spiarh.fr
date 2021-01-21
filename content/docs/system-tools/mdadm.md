---
title: "mdadm"
linkTitle: "mdadm"
date: 2017-01-05
---

### Show status of all raids

```bash
cat /proc/mdstat`
```

### Show detailed status of raid md0

```bash
mdadm --detail /dev/md0
```

### Create new raid `/dev/md0` with 2 disks

Raid level 1 on `/dev/sda1` and `/dev/sda2`:

```bash
mdadm --create /dev/md0 -n2 -l1 /dev/sda1 /dev/sdb1
```

### Remove `/dev/sda1` from `/dev/md0`

```bash
mdadm --fail /dev/md0 /dev/sda1
mdadm --remove /dev/md0 /dev/sda1
```

### Add `/dev/sda1` to `/dev/md0`

```bash
mdadm --add /dev/md0 /dev/sda1
```

### Use 3 disks in raid `/dev/md0`

Usecase: add an additional disk, so a damaged drive can be removed later-on

```bash
mdadm --grow /dev/md0 -n3
```

### Assemble `/dev/md0`

Usecase: when running live system

```bash
mdadm --assemble /dev/md0
```

### Update list of arrays in `/etc/mdadm/mdadm.conf`

:warning: remove old list by hand first

```bash
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
```

### What is this disk / partition?

```bash
mdadm --examine /dev/sda1
```

### Set minimum raid rebuilding speed to 10000 kiB/s (default 1000)

```bash
sysctl -w dev.raid.speed_limit_min=10000
```
