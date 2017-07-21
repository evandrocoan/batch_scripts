# Scripts

Contains some useful script utilities I use somewhere.



## SpeakTimeVBScript

It speaks the time when this script is called. It also, turn the NumLock key on, when it is off.
It is an windows only application, Tested under Windows 10, but should work since Windows XP SP3 version.



## Silent Run

Run a Batch file passed as its first command line argument silently, i.e., without any windows.
Call example:
```batch
wscript .\silent_run.vbs ".\code.bat" "arg 1" arg2 %*
```



___
## Installation

You can download it [from here](https://github.com/evandrocoan/SpeakTimeVBScript/archive/master.zip).
To speak the time every 15 minutes, open the Windows Task Scheduler, and import the provided task
file, after edit it and fix the correct script location.




## Licence
All files in this repository are released under GNU General Public License v3.0, unless stated otherwise.
See [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/) file for more information.




## TODO
Automatically detect whether the system is using 24 hourly format or 12 AM/PM hourly format.




