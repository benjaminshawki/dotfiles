**POST -> MDR -> BOOTLOADER**

> `GRUB` is legacy now Grand Unified Bootloader `512 B` `/boot`
>  
> `/boot/grub/menu.lst`
> 
> `grub-update`
> 
> `grub-install /dev/sda`
> 
> `sudo nano /etc/default/grub`
> 
> ---
> 
> `GRUB2` has `insmod` also supports conditional and logical statements
>
> > - Ubuntu like `/boot/grub/gobal.cfg`
> > 
> > - enterprise `/boot/grub2/grub.cfg`
> > 
> > **Important Note**
> > 
> > Don't modify these files, you make those changes in `etc/default/grub` instead.
> >
> > And use the following command `update-grub`
> >
> > Calls the backend command `grub2-makconfig`
> >
> > `-o pathoffile`
> > 
> > `grub2-install`
> >
> 
> 
> ---
> 
> `ISOLINUX` based on Syslinux is  BIOS based kernel
>
> `LILO`
