
cd /d F:\anki

set "ANKI_BASE=D:\\User\\Documents\\Anki2"
set "ANKI_EXTRA_PIP=python -m pip install git+https://github.com/evandroforks/pyaudio"

sh run

:: Exit the batch file, without closing the cmd.exe, if called from another script
if not "%1"=="" exit 0

pause
