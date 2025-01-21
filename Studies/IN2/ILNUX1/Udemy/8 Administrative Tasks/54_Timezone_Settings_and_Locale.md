```shell
$ ls -l /etc/localtime 
lrwxrwxrwx 1 root root 36 Nov  1 04:43 /etc/localtime -> /usr/share/zoneinfo/Europe/Amsterdam
```

```shell
$ cat /etc/timezone
Europe/Amsterdam
```

to change timezone `sudo cp /user/share/zoneinfo/America/New_York /etc/localtime`

use `tzselect` instead and edit it in `/etc/timezone`

`locale`
`-a`

`iconv`
`-f`
`--list`

ie `iconf UTF-8 US /etc/sshs/ssh-config`