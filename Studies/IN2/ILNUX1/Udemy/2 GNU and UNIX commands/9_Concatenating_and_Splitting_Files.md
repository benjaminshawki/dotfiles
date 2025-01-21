Concatenate vs Split

```shell
benjamin@mx:/home/dev/ILNUX
$ ls
ab  simple  test  test1
benjamin@mx:/home/dev/ILNUX
$ echo '1' > 1
benjamin@mx:/home/dev/ILNUX
$ ls
1  ab  simple  test  test1
benjamin@mx:/home/dev/ILNUX
$ echo '2' > 2
benjamin@mx:/home/dev/ILNUX
$ echo '3' > 3
benjamin@mx:/home/dev/ILNUX
$ echo '4' > 4
benjamin@mx:/home/dev/ILNUX
$ echo '5' > 5
benjamin@mx:/home/dev/ILNUX
$ sl -
sl: command not found
benjamin@mx:/home/dev/ILNUX
$ ls -l
total 36
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:52 1
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:52 2
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:52 3
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:53 4
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:53 5
-rw-r--r-- 1 benjamin benjamin 31 Dec 19 17:27 ab
-rwxr-xr-x 1 benjamin benjamin  3 Dec 19 17:39 simple
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:25 test
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:27 test1
benjamin@mx:/home/dev/ILNUX
$ cat 1 2 3 4 5
1
2
3
4
5
benjamin@mx:/home/dev/ILNUX
$ cat 1 2 3 4 5 > output
benjamin@mx:/home/dev/ILNUX
$ cat output 
1
2
3
4
5
benjamin@mx:/home/dev/ILNUX
$ rm 1 2 3 4 5
benjamin@mx:/home/dev/ILNUX
$ split -b 2 -a 1 output splitted
benjamin@mx:/home/dev/ILNUX
$ ls -l
total 40
-rw-r--r-- 1 benjamin benjamin 31 Dec 19 17:27 ab
-rw-r--r-- 1 benjamin benjamin 10 Dec 19 17:54 output
-rwxr-xr-x 1 benjamin benjamin  3 Dec 19 17:39 simple
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:55 splitteda
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:55 splittedb
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:55 splittedc
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:55 splittedd
-rw-r--r-- 1 benjamin benjamin  2 Dec 19 17:55 splittede
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:25 test
-rw-r--r-- 1 benjamin benjamin 51 Dec 19 17:27 test1

```