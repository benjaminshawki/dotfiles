 CPIO Copy in, copy out
 
```shell
$ ls -R
.:
error  first  outputofls  testa

./testa:
wowow
benjamin@mx:/home/dev/ILNUX
$ find . | cpio -o > /tmp/archive.cpio
7 blocks
benjamin@mx:/home/dev/ILNUX
$ ls -l
total 16
-rw-r--r-- 1 benjamin benjamin   24 Dec  2 20:19 error
-rw-r--r-- 1 benjamin benjamin  142 Dec 13 23:51 first
-rw-r--r-- 1 benjamin benjamin 2662 Dec  2 20:11 outputofls
drwxr-xr-x 2 benjamin benjamin 4096 Dec 24 16:12 testa
benjamin@mx:/home/dev/ILNUX
$ ls -l /tmp/
total 604
-rw-r--r-- 1 benjamin benjamin   3584 Dec 24 16:12 archive.cpio
-rw-r--r-- 1 benjamin benjamin   1261 Dec 24 14:29 byteBuddyAgent1246732602147560433.jar
-rw-r--r-- 1 benjamin benjamin    115 Dec 24 15:40 cv_debug.log
srwxrwxrwx 1 benjamin benjamin      0 Dec 24 14:27 dbus-BXf8gwB1tq
srwxrwxrwx 1 benjamin benjamin      0 Dec 24 14:27 dbus-f1uinczh6n
srwxrwxrwx 1 benjamin benjamin      0 Dec 24 14:27 dbus-GjA06aGFcy
srwxrwxrwx 1 lightdm  lightdm       0 Dec 24 14:27 dbus-hvpWJkSWfv
srwxrwxrwx 1 lightdm  lightdm       0 Dec 24 14:27 dbus-Y1tQDsA4lY
drwxr-xr-x 2 benjamin benjamin   4096 Dec 24 14:29 hsperfdata_benjamin
drwxr-xr-x 2 benjamin benjamin   4096 Dec 24 14:35 intellij-npm-info
-rw-r--r-- 1 benjamin benjamin 154886 Dec 24 14:29 liblz4-java-12715837903447352600.so
-rw-r--r-- 1 benjamin benjamin      0 Dec 24 14:29 liblz4-java-12715837903447352600.so.lck
-rw-r--r-- 1 benjamin benjamin      0 Dec 24 14:27 MozillaUpdateLock-6AFDA46A1A8AD48
-rw-r----- 1 benjamin benjamin      0 Dec 24 14:27 qipc_sharedmemory_ffffcdacbefcfbe91ea616379a0afb60116fe07cf4de9280dbde337
-rw-r--r-- 1 benjamin benjamin 178689 Dec 24 15:57 Screenshot_2022-12-24_15-57-50.png
-rw-r--r-- 1 benjamin benjamin 177548 Dec 24 15:58 Screenshot_2022-12-24_15-58-14.png
-rw-r--r-- 1 benjamin benjamin  72861 Dec 24 15:59 Screenshot_2022-12-24_15-59-45.png
drwx------ 2 benjamin benjamin   4096 Dec 24 14:27 ssh-9NofCfWBFg8D
drwx------ 2 benjamin benjamin   4096 Dec 24 14:28 Temp-b2295ae7-0a6d-44d8-beb6-fc698dec21b9
benjamin@mx:/home/dev/ILNUX
$ cpio -i < /tmp/archive.cpio
cpio: first not created: newer or same age version exists
cpio: error not created: newer or same age version exists
cpio: testa/wowow not created: newer or same age version exists
cpio: outputofls not created: newer or same age version exists
7 blocks
benjamin@mx:/home/dev/ILNUX
$ ls
error  first  outputofls  testa
benjamin@mx:/home/dev/ILNUX
$ ls -R
.:
error  first  outputofls  testa

./testa:
wowow
benjamin@mx:/home/dev/ILNUX
$ ls
error  first  outputofls  testa
benjamin@mx:/home/dev/ILNUX
$ rm -rf *
benjamin@mx:/home/dev/ILNUX
$ ls
benjamin@mx:/home/dev/ILNUX
$ cpio -i < /tmp/archive.cpio
7 blocks
benjamin@mx:/home/dev/ILNUX
$ ls -R
.:
error  first  outputofls  testa

./testa:
wowow
```

tar
```shell
$ ls -R
.:
error  first  outputofls  testa

./testa:
wowow
benjamin@mx:/home/dev/ILNUX
$ tar -cvf /tmp/archive.tar *
error
first
outputofls
testa/
testa/wowow
benjamin@mx:/home/dev/ILNUX
$ ls -l /tmp/archive.tar
-rw-r--r-- 1 benjamin benjamin 10240 Dec 24 16:15 /tmp/archive.tar
benjamin@mx:/home/dev/ILNUX
$ rm -rf *
benjamin@mx:/home/dev/ILNUX
$ tar -xvf /tmp/archive.tar
error
first
outputofls
testa/
testa/wowow
```

dd

```shell
$ dd if=testa/wowow of=ddffile
0+1 records in
0+1 records out
8 bytes copied, 0.000236477 s, 33.8 kB/s
benjamin@mx:/home/dev/ILNUX
$ ls
ddffile  error  first  outputofls  testa
benjamin@mx:/home/dev/ILNUX
$ cat ddffile 
walejra
```

```shell

```
