@echo off
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:time.windows.com
w32tm /config /reliable:yes
w32tm /config /update
net start w32time