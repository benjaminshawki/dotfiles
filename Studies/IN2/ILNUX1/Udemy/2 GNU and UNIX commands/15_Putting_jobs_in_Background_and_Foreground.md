`&` starts a program in the background

```shell
$ sleep 2000 &
[1] 6852
benjamin@mx:~/Notes
$ sleep 2000 &
[2] 6881
benjamin@mx:~/Notes
$ sleep 2000 &
[3] 6883
benjamin@mx:~/Notes
$ jobs
[1]   Running                 sleep 2000 &
[2]-  Running                 sleep 2000 &
[3]+  Running                 sleep 2000 &
benjamin@mx:~/Notes
$ fg  2
sleep 2000
^Z
[2]+  Stopped                 sleep 2000
benjamin@mx:~/Notes
$ jobs
[1]   Running                 sleep 2000 &
[2]+  Stopped                 sleep 2000
[3]-  Running                 sleep 2000 &
benjamin@mx:~/Notes
$ bg 2
[2]+ sleep 2000 &
benjamin@mx:~/Notes
$ jobs
[1]   Running                 sleep 2000 &
[2]-  Running                 sleep 2000 &
[3]+  Running                 sleep 2000 &
```

```shell
nohup sleep 2000 &
```

```shell
disown %1
```

screen is a usefull tool 