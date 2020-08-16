#!/bin/bash
set -eo pipefail

# Create a Task Scheduler with the following arguments: wscript "D:\User\Dropbox\SoftwareVersioning\SpeakTimeVBScript\silent_run.vbs" cmd "cmd /c ""F:\cygwin\bin\sh.exe"" ""/cygdrive/f/cygwin/home/Professional/scripts/run_anki.sh"""
# You can find a Windows 10 Task Scheduler task you can import: https://github.com/evandrocoan/batch_scripts/blob/master/WindowsTaksTcheduler/AnkiBackupDailyTask.xml
SOURCE="${BASH_SOURCE[0]}"

# Attempt to disable colored output (for better console logging)
export CI=true

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  SCRIPT_FOLDER_PATH="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$SCRIPT_FOLDER_PATH/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_FOLDER_PATH="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

cd /f/anki
BACKUP_FILE_NAME="${SCRIPT_FOLDER_PATH}/run_anki.log"

export ANKI_BASE="D:/User/Documents/Anki2"
export ANKI_EXTRA_PIP="python -m pip install git+https://github.com/evandroforks/pyaudio"

# requires sudo apt-get install moreutils expect
# https://stackoverflow.com/questions/11337041/force-line-buffering-of-stdout-when-piping-to-tee
if unbuffer -p /bin/bash run "$@" 2>&1 | tee /dev/tty | ts '[%Y-%m-%d %H:%M:%S]' >> "${BACKUP_FILE_NAME}";
then :
else
    exitcode="$?"
    exit "${exitcode}"
fi
