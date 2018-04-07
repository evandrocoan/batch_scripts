; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.


; See:
; How to start an infinity loop on AutoHotKey when reloading the script?
; http://stackoverflow.com/questions/40981048/
#persistent

SetTimer, check_for_sublime_settings_window, 500
; SetTimer, check_for_octave_graphics_window, 500

Return


check_for_sublime_settings_window:
{
    SetTitleMatchMode RegEx

    ;WinWait, Preferences.sublime-settings
    WinMaximize, .*(?:(sublime\-settings)|(sublime\-keymap))[^\(]+\w+[^\)]+.*Sublime Text

    SetTimer, check_for_sublime_settings_window, 500
}
Return

check_for_octave_graphics_window:
{
    SetTitleMatchMode 1

    ;WinWait, Figure 1
    WinMaximize, Figure 1

    SetTimer, check_for_octave_graphics_window, 1000
}
Return


NumpadDot::.

; My keybord key F2 is not working
^F1::Send {F2}
F1::F2
RCtrl::RAlt


; Copy Paste in Bash on Ubuntu on Windows
; https://stackoverflow.com/questions/38832230/copy-paste-in-bash-on-ubuntu-on-windows
; #IfWinActive ahk_exe cmd.exe
    ; ^+v::SendRaw %clipboard%
; #IfWinActive


; Disable Alt key tapping open menu in Windows
; https://forum.sublimetext.com/t/disable-alt-key-tapping-open-menu-in-windows/27777
#IfWinActive ahk_exe explorer.exe
    ;~LAlt Up:: Return
    F1::F2
#IfWinActive


;MsgBox, 4, Calculator, Do you want to open Calculator?
;Return


; https://superuser.com/questions/278951/my-keyboard-has-no-media-keys-can-i-control-media-without-them
; ^!Left::Send   {Media_Prev}
; ^!Right::Send  {Media_Next}
; +^!Left::Send  {Volume_Down}
; +^!Right::Send {Volume_Up}
; ^!Down::Send   {Media_Play_Pause}
; +^!Down::Send  {Volume_Mute}

; ^!Left::Send  {Media_Prev}
; ^!Right::Send {Media_Next}
Pause::Send   {Media_Play_Pause}

return



;
^!8::
Run "D:\User\Documents\AutoHotKey\MyBatches\kill_macro_player.vbs"

process = MacroPlayer.exe
Loop
{
   prev := ErrorLevel
   Process, Close, %process%
   Process, Exist, %process%
   if !ErrorLevel or (prev = ErrorLevel)
   break
}
Return


;^!n:: Run "\\192.168.25.215\lg-d685\external_SD\fastnotse\Transferencia.txt"
;Return

^!y:: Run "D:\User\Documents\NirSoft\winexp\winexp.exe"
Return

;^!n:: Run "C:\Windows\system32\notepad.exe" "\\192.168.43.1\lg-d685\external_SD\fastnote\Transferencia.txt"
;Return


; Windows 10 build > 10240 (newers)
^!n::
    Sleep, 600
    Send {AppsKey}
    Sleep, 800
    Send w
    Sleep, 800
    Send t
return

; Windows 10 build <= 10240 (olders)
; ^!n::
    ; Sleep, 600
    ; Send {AppsKey}
    ; Sleep, 800
    ; Send w
    ; Sleep, 300
    ; Send w
    ; Sleep, 300
    ; Send {Enter}
    ; Sleep, 400
    ; Send {Up}
    ; Sleep, 100
    ; Send {Up}
    ; Sleep, 100
    ; Send {Up}
    ; Sleep, 100
    ; Send {Enter}
; return


; Lock workstation shortcut to kick teamviewer asses
^#l::
	Run "D:\User\Documents\Desktop\LockWorkStation.lnk"
return


; Abre o terminal principal
^!t:: Run "C:\ProgramData\Microsoft\Windows\Start Menu\Terminal.lnk"
Return

;^!t:: Run "D:\User\Documents\ConEmuPack.140923\ConEmu.exe"
;WinActivate ahk_class VirtualConsoleClass
;Return

;--------------------------------------  ------------------------------------
^!r:: Run "C:\Windows\system32\perfmon.exe" /res
Return
;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------
;^!j:: Run "C:\Program Files (x86)\Notepad++\notepad++.exe"
;Return

; ^+j:: Run "F:\Notepad++\notepad++.exe" -multiInst
;^!j:: Run "C:\Notepad++Portable\App\Notepad++\notepad++.exe" -multiInst

;^!j:: Run "F:\Notepad++Portable\App\Notepad++\notepad++.exe" -multiInst
; Update 2017, notepad2-mod agora pode chamar diretamente o do windows.
^!j:: Run "notepad.exe" -multiInst
Return

;--------------------------------------  ------------------------------------

;-------------------------------------- Rodar Process Hacker ------------------------------------
^!h:: Run "D:\User\Documents\ProcessHacker\processhackerManualRolling\x64\ProcessHacker.exe"
Return

;-------------------------------------- Rodar Word ------------------------------------
^!l:: Run "C:\Program Files\Microsoft Office\Office15\WINWORD.EXE"
Return

;-------------------------------------- Rodar Tradutor ------------------------------------
^!k:: Run "C:\Program Files (x86)\MicroPower Software\Delta Translator 3.0\DTransl.exe"
Return

;-------------------------------------- Rodar Paint ------------------------------------
^!p:: Run "%windir%\system32\mspaint.exe"
Return

;-------------------------------------- Rodar Calculadora ------------------------------------

^!o:: Run "%windir%\system32\calc.exe"
Return

;Abre e fecha a janela do MiniLyrics
;#IfWinActive ahk_class MiniLyrics
;{
;^!Numpad1::Send !{F4}
;}
;#IfWinNotActive ahk_class MiniLyrics
;{

; ^!Numpad1::Run "D:\User\Documents\MiniLyrics\MiniLyrics.exe"
; Return
; ^!NumpadEnd::Run "D:\User\Documents\MiniLyrics\MiniLyrics.exe"
; Return

^!Numpad1::
^!NumpadEnd::
if WinExist("ahk_exe D:\User\Documents\MiniLyrics\MiniLyrics.exe")
    WinActivate, ahk_exe D:\User\Documents\MiniLyrics\MiniLyrics.exe
else
    Run, D:\User\Documents\MiniLyrics\MiniLyrics.exe
Return

;}
;Return


; ^!NumpadIns::Run "D:\User\Dropbox\Backups\AIMP\AIMP.exe"
; Return

^!Numpad0::
^!NumpadIns::
if WinExist("ahk_exe D:\User\Dropbox\Backups\AIMP\AIMP.exe")
    ; https://autohotkey.com/docs/misc/WinTitle.htm
    ; https://autohotkey.com/docs/commands/WinActivate.htm
    WinActivate, ahk_exe D:\User\Dropbox\Backups\AIMP\AIMP.exe
else
    ; Recently, makes Windows 10 to turn screen off  for some seconds, therefore only open it manually
    ; Run, D:\User\Dropbox\Backups\AIMP\AIMP.exe
    Return
Return



;;Abre e fecha a janela do Last.fm Scrobbler
;#IfWinActive ahk_class QWidget
;{
;^!Numpad3::Send !{F4}
;}
;Return
;#IfWinNotActive ahk_class QWidget
;{

^!Numpad3::Run "C:\Program Files (x86)\Last.fm\Last.fm Scrobbler.exe"
Return

^!NumpadPgDn::Run "C:\Program Files (x86)\Last.fm\Last.fm Scrobbler.exe"
Return

;}
;Return


^!f:: Run "C:\Windows\system32\mmc.exe" "C:\Windows\system32\wf.msc"
Return

;--------------------------------------  ------------------------------------


;--------------------------------------  ------------------------------------

;--------------------------------------  Checar Spelling ------------------------------------
; +Break::
; {
; Send ^c
; Run "F:\Mobipocket\reader.exe"
; WinWaitActive, Mobipocket Reader
; if ErrorLevel
; {
; 	MsgBox, WinWait timed out.
; 	return
; }
; else
;     Send {Click 178, 147}
; 	Send ^v
; 	Send {Enter}
; }
; Return



;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------

;--------------------------------------  ------------------------------------




; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
