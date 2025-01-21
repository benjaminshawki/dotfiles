`grep`rep is used for searching text or strings. `grep` stands for Global Regular Expression Print

`egrep` and `fgrep` are used on old distro's, nowadays they equal to `grep -E` and `grep -F`

`egrep` is 100% equivalent to `grep -E`
`fgrep` is 100% equivalent to `grep -F`
Historically these switches were provided in separate binaries. On some really old Unix systems you will find that you need to call the separate binaries, but on all modern systems the switches are preferred. The man page for grep has details about this.

As for what they do, `-E` switches grep into a special mode so that the expression is evaluated as an ERE (Extended Regular Expression) as opposed to its normal pattern matching. Details of this syntax are on the man page.

`-E, --extended-regexp`
Interpret PATTERN as an extended regular expression

The `-F` switch switches grep into a different mode where it accepts a pattern to match, but then splits that pattern up into one search string per line and does an OR search on any of the strings without doing any special pattern matching.

`-F, --fixed-strings`
Interpret PATTERN as a list of fixed strings, separated by newlines, any of which is to be matched.

Here are some example scenarios:

You have a file with a list of say ten Unix usernames in plain text. You want to search the group file on your machine to see if any of the ten users listed are in any special groups:

`grep -F -f user_list.txt /etc/group`

The reason the `-F` switch helps here is that the usernames in your pattern file are interpreted as plain text strings. Dots for example would be interpreted as dots rather than wild-cards.

You want to search using a fancy expression. For example parenthesis `()` can be used to indicate groups with `|` used as an OR operator. You could run this search using `-E`:

`grep -E '^no(fork|group)' /etc/group`

...to return lines that start with either "nofork" or "nogroup". Without the `-E` switch you would have to escape the special characters involved because with normal pattern matching they would just search for that exact pattern;

`grep '^no\(fork\|group\)' /etc/group`

`pgrep` searches for a process

`xarg`

```shell
benjamin@mx:/home/dev/ILNUX
$ ls
ab      simple     splittedb  splittedd  test   test2
output  splitteda  splittedc  splittede  test1  test2.txt
benjamin@mx:/home/dev/ILNUX
$ find . -name "*.txt" | ls -l
total 48
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
-rw-r--r-- 1 benjamin benjamin 14 Dec 19 19:08 test2
-rw-r--r-- 1 benjamin benjamin 14 Dec 19 19:19 test2.txt
benjamin@mx:/home/dev/ILNUX
$ find . -name "*.txt"
./test2.txt
benjamin@mx:/home/dev/ILNUX
$ find . -name "*.txt" | xargs ls -l
-rw-r--r-- 1 benjamin benjamin 14 Dec 19 19:19 ./test2.txt

```

