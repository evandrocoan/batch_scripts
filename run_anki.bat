
:: https://stackoverflow.com/questions/935609/batch-parameters-everything-after-1
if not "%1"=="out" goto run_anki_now
echo all arguments: %*
set _all=%*
call set _tail=%%_all:*%2=%%
set _tail=%2%_tail%
echo tail arguments: %_tail%

:run_anki_now
set "PATH=f:\bazel\;%PATH%"
cd /d F:/anki2

set "QTWEBENGINE_REMOTE_DEBUGGING=8087"
set "ANKI_BASE=D:/User/Documents/Anki2"
set "ANKI_EXTRA_PIP=python -m pip install git+https://github.com/evandroforks/pyaudio"

:: sh run_anki.sh %_tail% || goto :fail
cmd "cmd /c ""run.bat %_tail%""" || goto :fail
bazel shutdown

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%1"=="" exit 0

pause
exit 0

:fail
bazel shutdown

echo.
echo # Running Anki FAILED!

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%1"=="" exit 1

:typeitrightupdatefailed
:: timeout /T 60
set /p "UserInputPath=Type 'out' to quit... "
if not "%UserInputPath%" == "out" goto typeitrightupdatefailed
exit /1

