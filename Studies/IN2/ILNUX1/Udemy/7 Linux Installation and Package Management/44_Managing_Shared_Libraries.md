Shared Libraries are comparable to `DLL` Dynamic Linked Library in Windows Where you have a code that runs along the program

In linux they are called `SO` Shared Objects

`/lib` essential libraries

`/usr/lib` user level programs

`/usr/local/lib` 

if programs are not defined in the above paths you can edit `/etc/ld.so.conf`

the better way to do this is via `/etc/ld.so.conf.d/`

---
To list the required libraries for a certain command use

`ldd /bin/ls` example for ls

```shell
$ cat /etc/ld.so.conf
include /etc/ld.so.conf.d/*.conf

$ ls /etc/ld.so.conf.d/
fakeroot-x86_64-linux-gnu.conf  i386-linux-gnu.conf  libc.conf  x86_64-linux-gnu.conf
$ ls /etc/ld.so.conf.d/libc.conf 
/etc/ld.so.conf.d/libc.conf
```
