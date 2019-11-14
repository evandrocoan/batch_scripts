
title Cygwin Setup

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

set "CYGWIN_PORTABLE_DIRECTORY=%UserProfile%\Downloads\CygwinPortable"


if exist "%CYGWIN_PORTABLE_DIRECTORY%" goto :end

SET "ORIGINAL=%CD%"
cd /d "%UserProfile%\Downloads"

:: https://stackoverflow.com/questions/33752732/xcopy-still-asking-f-file-d-directory-confirmation
if not exist %CYGWIN_PORTABLE_DIRECTORY% echo D|xcopy /H /Y /E "%ORIGINAL%\Arquivos\CygwinPortable" "%CYGWIN_PORTABLE_DIRECTORY%\"

set "USER_NAME=username"
set "OLD_USER_NAME=root"
rem set "OLD_USER_NAME=username"
set "DOWNLOADS_DIRECTORY=CygwinPortable/Cygwin/home/%USER_NAME%/Downloads"

rem pause
call "%CYGWIN_PORTABLE_DIRECTORY%\cygwin-portable-installer.cmd"

:: Create the root user
:: call "%CYGWIN_PORTABLE_DIRECTORY%\cygwin-portable.cmd" exit

:: Duplicate python3.6m.exe as python.exe
echo f|xcopy /h /y "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\python3.6m.exe" "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\python.exe"

:: Update pip
:: call "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\mintty.exe" -w max -h always -e /bin/bash --login -i -c "cd $(cygpath -u '%CYGWIN_PORTABLE_DIRECTORY%'); pip3 install --upgrade pip;"

:: https://stackoverflow.com/questions/9049470/batch-to-open-a-folder-within-a-users-folderc-users-usernamehere-my-documents
"%ORIGINAL%\Programs\7z\7z.exe" x -y -r -aoa "%ORIGINAL%\Programs\%USER_NAME%.7z" "-o%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\home\"

:: xcopy /h /y /e "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\home\%OLD_USER_NAME%" "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\home\%USER_NAME%\"

rem rmdir /s /q "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\home\%OLD_USER_NAME%"
rem "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\git.exe" clone https://github.com/evandrocoan/MyLinuxSettings.git^
rem         "./%DOWNLOADS_DIRECTORY%/MyLinuxSettings"
rem "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\mv.exe" -v "./%DOWNLOADS_DIRECTORY%/MyLinuxSettings*"  "./%DOWNLOADS_DIRECTORY%/.."
rem "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\mv.exe" -v "./%DOWNLOADS_DIRECTORY%/MyLinuxSettings.*" "./%DOWNLOADS_DIRECTORY%/.."


:end

call "%ORIGINAL%\setup_sshpass.bat" "%ORIGINAL%"

%COMSPEC% /C start /MAX "" "%CYGWIN_PORTABLE_DIRECTORY%\Cygwin\bin\mintty.exe" -i /Cygwin-Terminal.ico -


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
title Cygwin Setup - Took %hh%:%mm%:%ss%,%cc% seconds to run this script
timeout /T 60
endlocal

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0
