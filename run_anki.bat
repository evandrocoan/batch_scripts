
:: https://stackoverflow.com/questions/935609/batch-parameters-everything-after-1
if not "%1"=="out" goto run_anki_now
echo all arguments: %*
set _all=%*
call set _tail=%%_all:*%2=%%
set _tail=%2%_tail%
echo tail arguments: %_tail%

:run_anki_now
sh run_anki.sh %_tail% || goto :fail

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

