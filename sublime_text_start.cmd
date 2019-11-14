
set "MSYS2_PATH=F:\\msys64"
set "SUBLIME_PATH=F:\\\\SublimeText\\\\MSYS2"

cd %MSYS2_PATH%

:: How do I disown/detach a process from the Git Bash terminal that come with Git's Windows installer?
:: https://superuser.com/questions/577442/how-do-i-disown-detach-a-process-from-the-git-bash-terminal-that-come-with-gits
"C:\Windows\System32\wscript.exe" "D:\User\Dropbox\SoftwareVersioning\SpeakTimeVBScript\silent_run.vbs" "F:\msys64\msys2_shell.cmd" -mingw64 -c "cmd.exe //c start \"\" //k %SUBLIME_PATH%\\\\sublime_text.exe"


:: "F:\msys64\usr\bin\mintty.exe" -w max -h always -e /bin/bash --login -i
:: "F:\msys64\usr\bin\mintty.exe" -w max -h always -e /bin/bash --login -i -c "$(cygpath -u '%SUBLIME_PATH%')/sublime_text.exe & disown"
:: "F:\msys64\usr\bin\mintty.exe" -w max -h always -e /bin/bash --login -i -c "cd $(cygpath -u '%SUBLIME_PATH%'); pwd"
:: msys2_shell.cmd -msys2 -c "cmd.exe //c start \"\" //D %SUBLIME_PATH% sublime_text.exe"
:: msys2_shell.cmd -mintty -c "cmd.exe //c start cmd //k $(cygpath -u '%SUBLIME_PATH%\sublime_text.exe')"

