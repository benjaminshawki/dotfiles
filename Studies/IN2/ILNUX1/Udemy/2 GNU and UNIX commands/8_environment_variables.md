`env` shows environmental variables
```shell
benjamin@mx:/home/dev/ILNUX
$ touch simple
benjamin@mx:/home/dev/ILNUX
$ ls -l
total 12
-rw-r--r-- 1 benjamin benjamin 31 Dec 19 17:27 ab
-rw-r--r-- 1 benjamin benjamin  0 Dec 19 17:39 simple
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:25 test
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:27 test1
benjamin@mx:/home/dev/ILNUX
$ chmod +x simple 
benjamin@mx:/home/dev/ILNUX
$ ls -l
total 12
-rw-r--r-- 1 benjamin benjamin 31 Dec 19 17:27 ab
-rwxr-xr-x 1 benjamin benjamin  0 Dec 19 17:39 simple
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:25 test
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:27 test1
benjamin@mx:/home/dev/ILNUX
$ nano simple
benjamin@mx:/home/dev/ILNUX
$ ./simple 
ab  simple  test  test1
benjamin@mx:/home/dev/ILNUX
$ cd ..
benjamin@mx:/home/dev
$ ./simple
bash: ./simple: No such file or directory
benjamin@mx:/home/dev
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin
benjamin@mx:/home/dev
$ PATH=/home/dev/ILNUX/:$PATH
benjamin@mx:/home/dev
$ echo $PATH
/home/dev/ILNUX/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin
benjamin@mx:/home/dev
$ export PATH=/home/dev/ILNUX/:$PATH
benjamin@mx:/home/dev
$ echo $PATH
/home/dev/ILNUX/:/home/dev/ILNUX/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin
benjamin@mx:/home/dev
$ simple
Griixs	ILNUX  IPRWC
```

login terminal settings are stored in either `~/.bash_profile` or `~/.bash_login` or  `~/.profile` depending on the distribution

for non-login login terminal settings are stored in `/.bashrc`

`source .bashrc`