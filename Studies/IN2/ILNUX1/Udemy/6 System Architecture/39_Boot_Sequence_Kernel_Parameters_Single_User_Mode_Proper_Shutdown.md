> **System Startup and Shutdown from top to bot**
> 
> `POST` -> `BIOS/EFI/` checks for harware
> 
> `MBR` 512B, or `LILO`, or `GRUB` holds partition info of the disk
> 
> `GRUB` preforms certain checks
> 
> `IRD`: initial ram disk, a tiny piece of the linux kernel
> 
> Kernel starts `init` or `upstart` or `systemd`

---

> `halt` `rebooot` `poweroff`
> 
> `shutdown` `-h` `-r` `-P` `"message on boot"`
> 
> ie `shutdown -r +3 "SYSTEM GOING DOWN IN 3 MINS"`
> 
> `shutdown -r now`