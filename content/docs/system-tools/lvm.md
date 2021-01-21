---
title: "lvm"
linkTitle: "lvm"
date: 2017-01-05
---

### Create thinpool

```bash
pvcreate /dev/sda5
vgcreate vg_k8s /dev/sda5
lvcreate --type thin-pool -l100%FREE vg_k8s/lv_nfs_thin_pool
lvcreate -V250G --name v_nfs_minio --thinpool vg_k8s/lv_nfs_thin_pool
lvcreate -V150G --name v_nfs_sc --thinpool vg_k8s/lv_nfs_thin_pool
lvcreate -V150G --name v_glusterfs_sc --thinpool vg_k8s/lv_nfs_thin_pool
mkfs.xfs /dev/vg_k8s/v_nfs_minio
mkfs.xfs /dev/vg_k8s/v_nfs_sc
```


| command | description |
|---------|-------------|
| `pvcreate /dev/md0` | initializes `/dev/md0` as phys device for a volume group
| `vgcreate lvm /dev/md0` | create volume group `lvm` with phys device `/dev/md0`
| `lvcreate -L30G -nroot lvm ; mkfs.ext4 /dev/lvm/root` | create logical volume `root`, sized 30G in volume group `lvm`; format with ext4
| `lvextend -L60G -nroot lvm ; resize2fs /dev/lvm/root` | extend `/dev/lvm/root` to 60G; also resize file system to new size
| `pvs`, `vgs`, `lvs` | show short info about pv, vg and lv
| `pvdisplay`, `vgdisplay`, `lvdisplay` | show long info
| `pvscan /dev/md0` | scan disks for physical volumes (e.g. when running live system)
| `vgextend lvm /dev/md1` | add phys device `/dev/md1` to volume group `lvm` (need pvcreate first!)
| `pvmove /dev/md0 ; vgreduce lvm /dev/md0` | move all logical volumes from `/dev/md0` and remove phys device from volume group


