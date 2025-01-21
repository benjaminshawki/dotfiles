Password stored in

`/etc/passwd` in older dist of linux

`/etc/shadow`

`sudo chage -l`

`sudo chage -M 20 benjamin` set password expires frequency in days

`sudo chage -I 10 benjamin` set password inactive in days

`sudo chage -E 2023-2-2 benjamin` set password expires on

`sudo chage -E -1 benjamin` set password expires back to never same goes for `-M` and `-I`

>`/etc/group`
>
> `/etc/gshadow`
> 
> `ggpasswd`