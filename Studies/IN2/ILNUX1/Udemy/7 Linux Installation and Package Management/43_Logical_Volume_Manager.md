**Logical volume Management `LVM`**

Single disks also known as `PV` are put together in a group volume `GV` which are managed by the `LVM` Logical Volume Manager. On top of the `LVM` resides the file system

---
For more info on raid levels -> https://en.wikipedia.org/wiki/Standard_RAID_levels

---

`RAID 0` Combines disk into 1 logical unit

`RAID 1` Provides the function of mirroring

`RAID 5` Recovery

---

What `RAID` does NOT have is automatic resizing `LVM` does provide this functionality

`RAID` does not provide snapshotting

`df -h` `sudo fdisk dev/sdb`

`sudo pvcreate/dev/sdb1`

`sudo vgcreae vggroup /dev/sdb1`

`sudo vgdisplay`

`sudo vgremove vggroup`

`sudo lvcreate vggroup -L 100M -n nvolume /dev/sdb1`

`sudo vgextend vggroup /dev/sdd`

`sudo vgextend -L150M /dev/vggroup/volume`