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

NumpadDot::.
Return

F1::F2
Return

RCtrl::RAlt
Return

;
^+8::
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

;MsgBox, 4, Calculator, Do you want to open Calculator?
Return


;^!n:: Run "\\192.168.25.215\lg-d685\external_SD\fastnotse\Transferencia.txt"
;Return

^!y:: Run "D:\User\Documents\NirSoft\winexp\winexp.exe"
Return

;^!n:: Run "C:\Windows\system32\notepad.exe" "\\192.168.43.1\lg-d685\external_SD\fastnote\Transferencia.txt"
;Return


^!n::
    Sleep, 600
    Send {AppsKey}
    Sleep, 800
    Send w
    Sleep, 300
    Send w
    Sleep, 300
    Send {Enter}
    Sleep, 400
    Send {Up}
    Sleep, 100
    Send {Up}
    Sleep, 100
    Send {Up}
    Sleep, 100
    Send {Enter}
return

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
^+j:: Run "C:\Program Files (x86)\Notepad++\notepad++.exe" -multiInst
;^!j:: Run "C:\Notepad++Portable\App\Notepad++\notepad++.exe" -multiInst
^!j:: Run "F:\Notepad++Portable\App\Notepad++\notepad++.exe" -multiInst
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

^!Numpad1::Run "C:\Program Files (x86)\MiniLyrics\MiniLyrics.exe"
Return
^!NumpadEnd::Run "C:\Program Files (x86)\MiniLyrics\MiniLyrics.exe"
Return

;}
;Return

^!Numpad0::Run "D:\User\Dropbox\Applications\AIMP3-1350\AIMP3.exe" 
Return

^!NumpadIns::Run "D:\User\Dropbox\Applications\AIMP3-1350\AIMP3.exe" 
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
