`sudo mount /dev/sdb1 mnt`

The file system is mounted with permissions for root, this can be a problem.
To solve  you can either adjust /etc/fstab and reboot or use `undisk --mount /dev/sdb1`, now you can acces the drive with your user account.
The `udisk` command will only work with logged in users on the machines, ssh'd users cannot acces it. The changes are not persistent until added in `/etc/fstab`.
To find the UUID use `sudo blkid`

`sudo umount /dev/sdb1`

