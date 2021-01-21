---
title: "btrfs"
linkTitle: "btrfs"
date: 2017-01-05
---

* Get info

```bash
btrfs filesystem show /
btrfs filesystem df /
btrfs filesystem usage /
btrfs qgroup show -f -re /
```

```bash
btrfs subvolume list / -a -p -t
btrfs subvolume set-default 344 /
```

* Relocate data in empty/near empty data chunks to free up enough
space to delete again

```bash
btrfs filesystem start </mountpoint> -dusage=5
```

* Verify checksums of data and metadata

```bash
btrfs scrub start /dev/sdX
-> Monitor with 'btrfs scrub status /dev/sdX'
```

* Attempt booting with backup btrfs root tree

```bash
mount -o usebackuproot /dev/sdaX /mng
```

If that didn't fix it:

```bash
btrfs check
```

* Backup/recover all data to a second device

```bash
btrfs restore /dev/sda1 /mnt/usbdrive
```

* Mostly harmless rescue options

```bash
btrfs rescue super-recover /dev/sdaX
btrfs rescue zero-log /dev/sdaX
btrfs rescue fix-device-size /dev/sdaX
btrfs rescue chunk-recover /dev/sdX (slow)
```

* LAST RESORT

```bash
btrfs check --repair
```

* Turn a snapshot to RW

```bash
snapper list, and replace the 1 with the latest snapshot id (btrfs property set -ts /.snapshots/1/snapshot ro false)
```

# snapper

* Space aware cleanup

```bash
snapper setup-quota
```


* Remove snapper snaphots

```bash
snapper -c root list
snapper -c root delete snapshot_number(s)
```




