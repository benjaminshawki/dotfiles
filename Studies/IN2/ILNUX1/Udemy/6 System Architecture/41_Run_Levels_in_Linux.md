Run levels have a `PID` which have a number assigned each with a meaning

> - 0 Halt or Power Off
> - 1 Single usermode
> - 2 x
> - 3 Multi user
> - 4 x
> - 5 Multi user + gui
> - 6 Reboot

`telinit 3` boot with runlevel 3

in ubuntu 2-5 is the same

In legacy systems 2 is not used

In systemd run levels have no numbers but other values are used

>  - 1 Resque
>  - 2 x
>  - 3 Multiuser
>  - 4 x
>  - 5 Graphical
>  - 6 Reboot

permanently change the values in init systems in `/etc/init/tab` 

in the file edit this `id:x:initdefault::` edit x

`dmsg -T`