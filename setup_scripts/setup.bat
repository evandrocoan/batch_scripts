
title Main Setup

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

echo Are you sure you want to do a SETUP?
timeout /T 60

echo Are you sure you want to do a SETUP?
pause

SET "ORIGINAL=%CD%"


:: Created by: Shawn Brink
:: http://www.tenforums.com
:: Tutorial: http://www.tenforums.com/tutorials/25732-taskbar-buttons-always-sometimes-never-combine-windows-10-a.html
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarGlomLevel /T REG_DWORD /D 2 /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarSmallIcons /T REG_DWORD /D 1 /F

:: http://www.antalyatasarim.com/registry/sources/detail-769.htm
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V SeparateProcess /T REG_DWORD /D 1 /F

:: https://superuser.com/questions/666891/script-to-set-hide-file-extensions
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f

:: Created by: Shawn Brink
:: Created on: May 9th 2016
:: Tutorial: http://www.tenforums.com/tutorials/2854-search-icon-box-show-remove-windows-10-taskbar.html
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /V SearchboxTaskbarMode /T REG_DWORD /D 0 /F

:: Created by: Shawn Brink
:: Created on: April 28th 2017
:: Tutorial: https://www.tenforums.com/tutorials/83096-add-remove-people-bar-icon-taskbar-windows-10-a.html
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V PeopleBand /T REG_DWORD /D 0 /F

:: How to make a batch file execute a reg file
:: https://stackoverflow.com/questions/20563975/how-to-make-a-batch-file-execute-a-reg-file
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\Restore_Windows_Photo_Viewer_CURRENT_USER.reg"

:: Force the changes to apply
taskkill /f /im explorer.exe
start explorer.exe


:: Open standard folders
:: http://www.helpwithwindows.com/Windows7/Open-Windows-Explorer-To-Specific-Folder.html
%windir%\explorer.exe ".\"

start /min "" main.cpl

"%ORIGINAL%\start_programs.bat"

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
title Main Setup - Took %hh%:%mm%:%ss%,%cc% seconds to run this script
timeout /T 60
endlocal

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0
