# Enable and start the timer

```
systemctl --user enable battery-monitor.timer
systemctl --user start battery-monitor.timer
```

Check the status with:

````bash
systemctl --user status battery-monitor.timer
systemctl --user list-timers
36  ```
````
