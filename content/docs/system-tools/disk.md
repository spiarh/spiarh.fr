---
title: "disk"
linkTitle: "disk"
date: 2017-01-05
---

### Copy partition table from sdX to sdY (MBR)

```bash
sfdisk -d /dev/sdX | sfdisk /dev/sdY
```

### Copy partition table from sdX to sdY (GPT)

```bash
sgdisk /dev/sdX -R /dev/sdY
sgdisk -G /dev/sdY
```

### Create BIOS grub partition

```bash
parted
mklabel gpt
unit s
mkpart bios 64s 2047s
set 1 bios_grub on
mkpart NAME 2048s [end]
```

### Grow luks partition

```bash
lblkid
blkid
cryptsetup resize luks-34da1525-2054-4043-8a67-d257439c273d
xfs_growfs /home
```
