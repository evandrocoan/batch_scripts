
:: Create a Task Scheduler with wscript as the program and the following as the arguments:
:: "D:\User\Dropbox\SoftwareVersioning\SpeakTimeVBScript\silent_run.vbs" "D:\User\Dropbox\SoftwareVersioning\SpeakTimeVBScript\run_ankibackup.bat"

SET "CURRENT_PATH=%~dp0"

sh /cygdrive/f/cygwin/home/Professional/scripts/backupanki.sh >> "%CURRENT_PATH%\run_ankibackup.log" 2>&1

