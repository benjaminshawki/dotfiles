 `chgrp --help`
 `chown --help`
 
`ls -l` look like this

`r` read
`w` write
`x` execute

`-/---/---/---`

`-/xxx/yyy/zzz`

`xxx` owner of the file

`yyy` group of the file

`zzz` any other user

---
Changing permissions example

`chmod u+x, filename` `g-r` `o+w`

chmod stands for change mode

Octal notation is used for shorter notation uses the sum of bits

ie

`-/rwx/r-x/r--`
 
`chmod 754 filename`

---
Where are these values defined?
Either

/etc/bashrc

/etc/profile

/etc/login.defs

based on the UMASK in /et/login.defs the default permissions are difined by subtracting the umask from the octal notation

---

New form of ownership and permissions

`getfacl`

`setfacl`