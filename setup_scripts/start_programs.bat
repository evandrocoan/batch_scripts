
title Start Programs

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

SET "ORIGINAL=%CD%"

start /min "" setup_chocolatey.bat
start /min "" setup_cygwin.bat
start /min "" setup_smartgit.bat
start /min "" setup_process_explorer.bat
start /min "" setup_sublime.bat
start /min "" setup_nodejs.bat
start /min "" start_directories.bat



:: Copyq
start /min "" "%ORIGINAL%\Programs\copyq\copyq.exe"

:: 7+ Taskbar Tweaker
start /min "" "%ORIGINAL%\Programs\7TaskbarTweaker\7+ Taskbar Tweaker.exe"

:: WinRAR options
rem -o+ Overwrite all
rem -inul disable error messages

:: Process Hacker
rem "%ORIGINAL%\Programs\wrar\WinRAR.exe" x -o+ "%ORIGINAL%\Programs\processhackerManualRolling.rar" "C:\Users\username\Downloads\"
rem rmdir /S /Q "C:\Users\username\Downloads\processhackerManualRolling"
rem start /min "" "C:\Users\username\Downloads\processhackerManualRolling\x86\ProcessHacker.exe"
rem start /min "" "C:\Users\username\Downloads\processhackerManualRolling\x64\ProcessHacker.exe"

:: How can I run a program from a batch file without leaving the console open after the program starts?
:: https://stackoverflow.com/questions/324539/how-can-i-run-a-program-from-a-batch-file-without-leaving-the-console-open-after

:: Open standard folders
:: http://www.helpwithwindows.com/Windows7/Open-Windows-Explorer-To-Specific-Folder.html
%windir%\explorer.exe "shell:Downloads"


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
title Start Programs - Took %hh%:%mm%:%ss%,%cc% seconds to run this script
timeout /T 60
endlocal

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0
