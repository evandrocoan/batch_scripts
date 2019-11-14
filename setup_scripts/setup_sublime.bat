
title Sublime Setup

::
:: Setup the time calculation script
::
:: Time calculation downloaded from:
:: http://stackoverflow.com/questions/9922498/calculate-time-difference-in-windows-batch-file
::
:: AMX Mod X compiling batch downloaded from:
:: https://github.com/alliedmodders/amxmodx/pull/212/commits
::
:: Here begins the command you want to measure
setlocal
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

:: SET "ORIGINAL=%CD%"

set "PATH=%PATH%;C:\Users\username\Downloads\CygwinPortable\cygwin\bin"


:: :: Sublime Text
start /min "" "%ORIGINAL%Programs\SublimeText\sublime_text.exe"


:: set "MSYS2_PATH=C:\\tools\\msys64"
:: set "SUBLIME_PATH=L:\\\\Programs\\\\SublimeText"

:: cd %MSYS2_PATH%

:: "C:\Windows\System32\wscript.exe" "L:\Programs\batch_scripts\silent_run.vbs" "%MSYS2_PATH%\msys2_shell.cmd" -mingw64 -c "cmd.exe //c start \"\" //k %SUBLIME_PATH%\\\\sublime_text.exe"


:: Calculating the duration is easy
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

:: Get elapsed time
set /A elapsed=end-start

:: Show elapsed time:
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%

:: Outputting
echo.
echo Took %hh%:%mm%:%ss%,%cc% seconds to run this script.

rem pause
title Sublime Setup - Took %hh%:%mm%:%ss%,%cc% seconds to run this script
timeout /T 60
endlocal

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0
