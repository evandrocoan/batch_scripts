
title SmartGit Setup

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

set "SMARTGIT_DIRECTORY=%UserProfile%\Downloads\SmartGit"


if exist "%SMARTGIT_DIRECTORY%" goto :end

set "DOWNLOADED_FILE_NAME=smartgit-portable-18_1_4.7z"

SET "ORIGINAL=%CD%"
cd /d "%UserProfile%\Downloads"

:: https://www.syntevo.com/smartgit/download/
"%ORIGINAL%\Programs\wget\wget.exe" "https://www.syntevo.com/downloads/smartgit/%DOWNLOADED_FILE_NAME%"

:: https://stackoverflow.com/questions/9049470/batch-to-open-a-folder-within-a-users-folderc-users-usernamehere-my-documents
"%ORIGINAL%\Programs\wrar\WinRAR.exe" x -o+ "%UserProfile%\Downloads\smartgit-portable-18_1_4.7z" "%UserProfile%\Downloads\"

del "%UserProfile%\Downloads\smartgit-portable-18_1_4.7z"

:end


"%ORIGINAL%\Programs\wrar\WinRAR.exe" x -o+ "%ORIGINAL%\Programs\.settings.7z" "%SMARTGIT_DIRECTORY%"

start /min "" "%SMARTGIT_DIRECTORY%\bin\smartgit.exe"


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
title SmartGit Setup - Took %hh%:%mm%:%ss%,%cc% seconds to run this script
timeout /T 60
endlocal

:: Exit the batch file, without closing the cmd.exe, if called from another script
if "%1"=="" exit 0

