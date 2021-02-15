:: For some reason, when my computer boots the network interface does not if not restated

ping google.com -n 1 -w 1000
if not errorlevel 1 goto hasinternet

:: https://stackoverflow.com/questions/1672338/how-to-sleep-for-five-seconds-in-a-batch-file-cmd
netsh interface set interface "Ethernet 3" disable

:: https://stackoverflow.com/questions/1672338/how-to-sleep-for-five-seconds-in-a-batch-file-cmd
timeout 4

netsh interface set interface "Ethernet 3" enable

:hasinternet
timeout 5

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0
