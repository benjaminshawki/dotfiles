`tune2fs`, `debug2fs`, `dumpe2fs`

`-J` ie convert ext2 to ext3

`xfs info`

<hr>
file system check

tsck: ext2/3/4 `tsck.ext2`

XFS: `xfs_check` / repair

`sudo dumpe2fs -h /dev/sdb` the `-h` is a human readable switch

make sure drive is not mounted while preforming checks, otherwise you'll have a high probability of corrupting your file system
