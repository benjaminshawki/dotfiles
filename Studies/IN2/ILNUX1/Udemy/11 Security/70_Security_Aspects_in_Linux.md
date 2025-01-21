find open ports

`netstat -aunt`

`sudo netstat -ntupl`

```shell
$ sudo fuser 111/udp
111/udp:              2108
$ sudo fuser 111/udp^C
$ ps aux | grep 2108
_rpc        2108  0.0  0.0   7904  2300 ?        Ss   13:20   0:00 /sbin/rpcbind -w
benjamin   25265  0.0  0.0  75804   712 pts/2    S+   17:08   0:00 grep 2108
```

`sudo visudo`

```shell
$ ls /etc/xinetd.d/
chargen  chargen-udp  daytime  daytime-udp  discard  discard-udp  echo  echo-udp  servers  services  time  time-udp
$ nano /etc/xinetd.conf 
$ nano /etc/xinetd.d/
chargen      daytime      discard      echo         servers      time         
chargen-udp  daytime-udp  discard-udp  echo-udp     services     time-udp     
$ nano /etc/xinetd.d/time
$ ls /etc/host
host.conf       hostname        hosts           hosts.allow     hosts.bak       hosts.deny      hosts.ORIGINAL  hosts.saved
$ nano /etc/hosts.allow
$ sudo service xinetd stop 
Stopping internet superserver: xinetd.
```

`sudo iptables -L`

`sudo iptables -A INPUT -p tcp --dport ssh -s 192.168.1.2 -j DROP`


