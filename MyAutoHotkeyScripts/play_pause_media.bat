

:: https://stackoverflow.com/questions/3827567/how-to-get-the-path-of-the-batch-script-in-windows
SET "SCRIPT_DIRECTORY=%~dp0"

CD /D "%SCRIPT_DIRECTORY%"

:: https://autohotkey.com/board/topic/65777-command-line-running-of-autohotkey/
D:\User\Documents\AutoHotKey\Program\AutoHotkey.exe play_pause_media.ahk

