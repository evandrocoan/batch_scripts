:: Pick one of these two files (cmd or ps1)
::
:: https://chocolatey.org/install#non-administrative-install
:: https://gist.github.com/ferventcoder/78fa6b6f4d6e2b12c89680cbc0daec78

title Chocolatey Install

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

:: Set directory for installation - Chocolatey does not lock
:: down the directory if not the default
SET "INSTALLDIR=C:\ProgramData\chocoportable"
setx ChocolateyInstall %INSTALLDIR%


if exist "%INSTALLDIR%" goto :end

:: All install options - offline, proxy, etc at
:: https://chocolatey.org/install
powershell -executionpolicy bypass "& ""%CD%\ChocoNonAdmin.ps1"""

:: https://stackoverflow.com/questions/2035193/how-to-run-a-powershell-script/2035209
:: Powershell.exe -executionpolicy bypass -File "%CD%\ChocoNonAdmin.ps1"

:: CALL choco install puppet-agent.portable -y
:: CALL choco install ruby.portable -y
:: CALL choco install git.commandline -y

SET "PATH=%PATH%;C:\\ProgramData\\chocoportable\\bin"

:: pick an editor
::CALL choco install visualstudiocode.portable -y :: Not available yet
:: https://github.com/chocolatey/choco/wiki/CommandsReference
:: CALL choco install notepadplusplus.commandline -ydv
::CALL choco install nano -y
::CALL choco install vim-tux.portable

:: What else can I install without admin rights?
:: https://chocolatey.org/packages?q=id%3Aportable


:end

setup_msys2.bat

%COMSPEC% /C start /MAX "" "C:\tools\msys64\usr\bin\mintty.exe" -i /msys2.ico -

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
title Chocolatey Install - Took %hh%:%mm%:%ss%,%cc% seconds to run this script
timeout /T 60
endlocal

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0

