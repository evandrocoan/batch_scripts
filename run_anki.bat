
sh run_anki.sh || goto :fail

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%1"=="" exit 0

pause
exit 0

:fail
echo.
echo # Running Anki FAILED!

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%1"=="" exit 1

:typeitrightupdatefailed
:: timeout /T 60
set /p "UserInputPath=Type 'out' to quit... "
if not "%UserInputPath%" == "out" goto typeitrightupdatefailed
exit /1

