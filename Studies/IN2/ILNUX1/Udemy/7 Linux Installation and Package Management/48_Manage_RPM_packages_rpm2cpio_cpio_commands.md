`rpm` to `cpio`

`cpio` copy in and out

`rpm2cpi x.rpm > ntp.cpio`

`cpio -t < ntp.cpio`

`cpio -idv ./etc/ntp.conf < ntp.cpio`

