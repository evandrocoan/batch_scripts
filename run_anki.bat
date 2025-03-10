
:: https://stackoverflow.com/questions/935609/batch-parameters-everything-after-1
if "%1"=="out" goto get_tail
set _tail=%*
goto run_anki_now

:get_tail
set EXITONEND=true
echo all arguments: %*
set _all=%*
call set _tail=%%_all:*%2=%%
set _tail=%2%_tail%
echo tail arguments: %_tail%

:run_anki_now
set "PATH=f:\bazel\;%PATH%"
cd /d F:/anki2

:: https://stackoverflow.com/questions/39551549/q-how-do-you-display-chinese-characters-in-command-prompt/52355476
chcp 936

set "OUTPUT_SUCCESS=1"
set "ANKI_PROFILE_CODE=1"
set "ENABLE_QT5_COMPAT=1"
set "QTWEBENGINE_REMOTE_DEBUGGING=8087"

:: set "ANKI_BASE=F:\AnkiCollection"
set "ANKI_EXTRA_PIP=python -m pip install git+https://github.com/evandroforks/pyaudio"

:: sh run_anki.sh %_tail% || goto :fail
cmd /c run.bat %_tail% || goto :fail
:: bazel shutdown

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%EXITONEND%"=="" exit 0

cmd
pause
exit 0

:fail
:: bazel shutdown

echo.
echo # Running Anki FAILED!

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%1"=="" exit 1

cmd
:typeitrightupdatefailed
:: timeout /T 60
set /p "UserInputPath=Type 'out' to quit... "
if not "%UserInputPath%" == "out" goto typeitrightupdatefailed
exit /1

