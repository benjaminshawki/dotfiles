<h4>Standaard Input / Output / Error</h4>

```shell
$ read ME
Standard input
$ echo $ME
Standard input
```

```shell
$ ls
$ nano first
$ ls
first
$ read ME < first
$ echo $ME
this is the first line
```

```shell
$ ls /etc/ > outputofls
$ ls
first  outputofls
```

```shell
$ ls
first  outputofls
$ ls asdf
ls: cannot access 'asdf': No such file or directory
$ ls asdf > error
ls: cannot access 'asdf': No such file or directory
$ ls asdf 2> error
$ cat error 
ls: cannot access 'asdf': No such file or directory
```

```shell
$ tail -f error
ls: cannot access 'asdf': No such file or directory
tail: error: file truncated
testing tail monitoring
$ cat error 
testing tail monitoring
```
while
```shell
$ echo 'testing tail monitoring' > error
```

---

before
``` shell
$ tail -f first
this is the first line
the second line is here
there is a third line as well
fourth line here
fifth is the last one
```

```shell
$ echo 'testing tail monitoring' >> first
```
after
```shell
this is the first line
the second line is here
there is a third line as well
fourth line here
fifth is the last one
testing tail monitoring
```

``>`` redirection switch: Replace contents with whatever we are trying to send in

``>>`` double redirection switch: Append the output to the exiting contents

``tail first`` shows last 10 lines of the file named first

``head first`` shows first 10 lines of the file named first

``head -n 20 first`` show the first 20 lines of the file named first