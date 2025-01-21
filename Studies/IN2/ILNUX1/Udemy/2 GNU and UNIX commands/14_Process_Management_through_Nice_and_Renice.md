-20 to 19

-20 highest priority

default 0

nice, renice

`ps -aflx`

`nice --8 sleep &` requires sudo to change niceness, however it does start the process with niceness of 0 

`nice -8 sleep &` does not require sudo

setting niceness of a process lower than default (0) requires root access

process 1687  with niceness 8
`renice 7 -p 1687` cannot do, permission denied

