

```shell 
benjamin@mx:/home/dev/ILNUX
$ sed 'p' test
this is a test file
this is a test file
file is test
file is test
test is this file
test is this file
benjamin@mx:/home/dev/ILNUX
$ sed '/a/d' test
file is test
test is this file
benjamin@mx:/home/dev/ILNUX
$ sed '/a/d' test > ab
benjamin@mx:/home/dev/ILNUX
$ ls
ab  test
benjamin@mx:/home/dev/ILNUX
$ cp test test1
benjamin@mx:/home/dev/ILNUX
$ sed i- '/a/d' test
sed: can't read /a/d: No such file or directory
-
this is a test file
-
file is test
-
test is this file
benjamin@mx:/home/dev/ILNUX
$ cat test
this is a test file
file is test
test is this file
benjamin@mx:/home/dev/ILNUX
$ sed 's/is/was' test
sed: -e expression #1, char 8: unterminated `s' command
benjamin@mx:/home/dev/ILNUX
$ sed 's/is/was/' test
thwas is a test file
file was test
test was this file
benjamin@mx:/home/dev/ILNUX
$ sed 's/is/was/g' test
thwas was a test file
file was test
test was thwas file
benjamin@mx:/home/dev/ILNUX
$ sed 's/is/IS/' test1
thIS is a test file
file IS test
test IS this file
benjamin@mx:/home/dev/ILNUX
$ sed 's/is/IS/' test1
thIS is a test file
file IS test
test IS this file
benjamin@mx:/home/dev/ILNUX
$ sed 's/^test/best/' test1
this is a test file
file is test
best is this file
benjamin@mx:/home/dev/ILNUX
$ sed 's/file$/pipe/' test1
this is a test pipe
file is test
test is this pipe
benjamin@mx:/home/dev/ILNUX
```