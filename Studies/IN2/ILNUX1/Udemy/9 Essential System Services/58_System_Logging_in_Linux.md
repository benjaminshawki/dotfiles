`syslog` developed 1980, used UDP

`syslog-ng` came out in 1998, extends syslog ,supported cb connection cmlet based
, db logging, tcp, tel encryption

`rsyslog` came out in 2004 and is used in most linux distros today Suports `RELP` Reliable event logging protocol, bufferd operation

---

facility.primary
>`auth`
>
>`cron`
>
>`daemon`
>
>`kernel`
>
>`mail`
>
>`syslog`
>
>`lpr` print servers
>
>`local7` cisco windows

syslog level `0 - 7`

- 0 Emergency
- 1 Alerts
- 2 Critical
- 3 Errors
- 4 Warnings
- 5 Notifications
- 6 Information
- 7 Debug


/etc/rsyslog.d/...

/var/log/...

> `logger`
> `logger LOCAL4.crit THIs IS JUST A TEST MESSSAGE`
> ```shell
> $ logger LOCAL4.crit THIs IS JUST A TEST MESSSAGE
> benjamin@mx:~
> $ tail /var/log/syslog
> tail: cannot open '/var/log/syslog' for reading: Permission denied
> benjamin@mx:~
> $ sudo tail /var/log/syslog
> [sudo] password for benjamin:
> Jan 16 00:48:19 mx kernel: [25276.839210] [UFW BLOCK] IN=eth0 OUT= MAC=01:00:5e:00:00:01:7c:39:53:c0:e2:39:08:00 SRC=192.168.2.254 DST=224.0.0.1 LEN=32 TOS=0x00 PREC=0x00 TTL=1 ID=0 DF PROTO=2
> Jan 16 00:48:35 mx dbus-daemon[2655]: [system] Activating service name='org.freedesktop.hostname1' requested by ':1.78' (uid=1000 pid=4796 comm="/usr/libexec/xdg-desktop-portal-gtk ") (using servicehelper)
> Jan 16 00:48:35 mx dbus-daemon[2655]: [system] Successfully activated service 'org.freedesktop.hostname1'
> Jan 16 00:48:55 mx dbus-daemon[3988]: [session uid=1000 pid=3986] Activating service name='org.freedesktop.thumbnails.Thumbnailer1' requested by ':1.12' (uid=1000 pid=4159 comm="Thunar --sm-client-id 2858e6e50-4047-4962-9e18-d36")
> Jan 16 00:48:55 mx dbus-daemon[3988]: [session uid=1000 pid=3986] Successfully activated service 'org.freedesktop.thumbnails.Thumbnailer1'
> Jan 16 00:50:24 mx kernel: [25401.833227] [UFW BLOCK] IN=eth0 OUT= MAC=01:00:5e:00:00:01:7c:39:53:c0:e2:39:08:00 SRC=192.168.2.254 DST=224.0.0.1 LEN=32 TOS=0x00 PREC=0x00 TTL=1 ID=0 DF PROTO=2
> Jan 16 00:50:25 mx dbus-daemon[2655]: [system] Activating service name='org.freedesktop.hostname1' requested by ':1.315' (uid=1000 pid=84068 comm="/usr/share/teams/teams --disable-namespace-sandbox") (using servicehelper)
> Jan 16 00:50:25 mx dbus-daemon[2655]: [system] Successfully activated service 'org.freedesktop.hostname1'
> Jan 16 00:52:29 mx kernel: [25526.827203] [UFW BLOCK] IN=eth0 OUT= MAC=01:00:5e:00:00:01:7c:39:53:c0:e2:39:08:00 SRC=192.168.2.254 DST=224.0.0.1 LEN=32 TOS=0x00 PREC=0x00 TTL=1 ID=0 DF PROTO=2
> Jan 16 00:54:04 mx benjamin: LOCAL4.crit THIs IS JUST A TEST MESSSAGE
> benjamin@mx:~
>```
> 
> `nano /etc/logrotate.conf`

> `nano /etc/rsyslog.conf`

