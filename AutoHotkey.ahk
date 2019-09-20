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

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

; See:
; How to start an infinity loop on AutoHotKey when reloading the script?
; http://stackoverflow.com/questions/40981048/
#persistent

SetTimer, check_for_sublime_settings_window, 500
; SetTimer, check_for_media_player_classic_window, 500
; SetTimer, check_for_octave_graphics_window, 500
Return

check_for_sublime_settings_window:
{
    SetTitleMatchMode RegEx

    ;WinWait, Preferences.sublime-settings
    ; WinMaximize, .*(?:(sublime\-settings)|(sublime\-keymap))[^\(]+\w+[^\)]+.*Sublime Text
    WinMaximize, .*(?:(sublime\-settings)|(sublime\-keymap)|(sublime\-mousemap)).+Sublime Text

    SetTimer, check_for_sublime_settings_window, 500
}
Return

check_for_media_player_classic_window:
{
    ;WinWait, Preferences.sublime-settings
    WinMaximize, ahk_class MediaPlayerClassicW

    SetTimer, check_for_media_player_classic_window, 500
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


; https://superuser.com/questions/309005/disable-the-activation-of-the-menu-bar-when-alt-is-pressed-in-windows-7
#IfWinActive ahk_exe sublime_text.exe
    Alt::
    KeyWait, Alt
    return

    LAlt Up::
    if (A_PriorKey = "Alt")
        return
    return
#IfWinActive

; My keybord key F2 is not working
; ^F1::Send {F2}
; F1::F2


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


; #IfWinActive ahk_exe Greenshot.exe
;     enter::
;     SendInput ^+c
;     WinClose
;     Return
; #IfWinActive

; Fixes Alt+F4 exiting the application instead of closing the foreground window
; https://feedback.discordapp.com/forums/326712-discord-dream-land/suggestions/31661170-alt-f4-minimizes-to-tray-instead-of-closing-discor
#IfWinActive ahk_exe Discord.exe
    !F4::
    WinClose ; use the window found above
    Return
#IfWinActive


; ; Switching back to last *used* tab on Chrome
; ; https://superuser.com/questions/402095/switching-back-to-last-used-tab-on-chrome
; #IfWinActive ahk_exe chrome.exe
;     ; https://autohotkey.com/docs/KeyList.htm
;     ^Tab::Send !{s}
;     Return
; #IfWinActive


;MsgBox, 4, Calculator, Do you want to open Calculator?
;Return


; https://autohotkey.com/board/topic/108437-hold-shift-with-w-key/
; https://gist.github.com/cheeaun/160999
; https://autohotkey.com/board/topic/24023-press-key-when-scroll-wheel-shift-are-used/
; https://community.coreldraw.com/talk/coreldraw_graphics_suite_x4/f/coreldraw-x4/13357/zoom-settings
; https://community.coreldraw.com/talk/coreldraw_graphics_suite_x6/f/coreldraw-x6/35290/shift-zoom-not-working-in-x6
; https://community.coreldraw.com/talk/coreldraw_graphics_suite_x7/f/coreldraw-graphics-suite-x7/51248/zoom-increments
; https://community.coreldraw.com/talk/coreldraw_graphics_suite_x5/f/coreldraw-graphics-suite-x5/37920/is-there-a-way-to-set-zoom-tool-to-smaller-increments/179493
#IfWinActive ahk_exe CorelDRW.exe
    WheelUp::
        Send, {Shift down}
        Send, {WheelUp}
        Send, {Shift up}
        Return

    WheelDown::
        Send, {Shift down}
        Send, {WheelDown}
        Send, {Shift up}
        Return

    +WheelUp::
        Send, {WheelUp}
        Return

    +WheelDown::
        Send, {WheelDown}
        Return
#IfWinActive

; Remaps Ctrl to Ctrl + Alt
RCtrl::RAlt

; https://autohotkey.com/docs/commands/SoundSet.htm
; Increase master volume by 10%
; Insert::
^!Up::
SoundSet +10
Return

; Decrease master volume by 10%
; ^Insert::
^!Down::
SoundSet -10
Return

; https://autohotkey.com/docs/KeyList.htm
; https://superuser.com/questions/278951/my-keyboard-has-no-media-keys-can-i-control-media-without-them
;
; >^Left::Send   {Media_Prev}
; >^Right::Send  {Media_Next}
; +^!Left::Send  {Volume_Down}
; +^!Right::Send {Volume_Up}
; ^!Down::Send   {Media_Play_Pause}
; +^!Down::Send  {Volume_Mute}

; ^!Left::Send  {Media_Prev}
; ^!Right::Send {Media_Next}

; Pause::CheckForPlayerWindow("ahk_class MediaPlayerClassicW", "{Media_Play_Pause}", "{Space}", "false")
; ^!Left::CheckForPlayerWindow("ahk_class MediaPlayerClassicW", "{Media_Prev}", "^p")
; ^!Right::CheckForPlayerWindow("ahk_class MediaPlayerClassicW", "{Media_Next}", "^n")

Pause::Send {Media_Play_Pause}
; ^!Left::Send {Media_Prev}
; ^!Right::Send {Media_Next}


; https://stackoverflow.com/questions/55670223/how-to-determine-whether-a-window-is-visible-on-the-screen-with-ahk
CheckForPlayerWindow(window_identifier, media_key, player_key, reactive=true) {
    WinGetTitle, window_title, %window_identifier%

    if( !window_title ) {
        Send % media_key
    }
    else {
        WinWaitActive, %window_title%, , 0.1
        is_window_focused := true

        if( ErrorLevel ) {
            ; MsgBox, WinWait timed out.
            is_window_focused := false
        }
        else {
            PlayPauseVideo(window_identifier, player_key, reactive)
            return
        }

        counter := 5
        first_result := GetRunningWindowText(window_title)

        while( counter > 0) {
            sleep, 200
            counter := counter - 1
            second_result := GetRunningWindowText(window_title)

            if( first_result != second_result ) {
                PlayPauseVideo(window_identifier, player_key, reactive)
                return
            }
        }

        if( is_window_focused ) {
            PlayPauseVideo(window_identifier, player_key, reactive)
        }
        else {
            Send % media_key
        }
    }
}

GetRunningWindowText(window_title) {
    WinGetText, window_text, %window_title%

    ; FoundPos := RegExMatch(window_text, "O)(?:\d\d:)+(?<frames>\d\d)", first_result)
    FoundPos := RegExMatch(window_text, "O)drawn: (?<frames>\d+)", first_result)

    ; Msgbox % first_result.Count() ": " first_result.Name(1) "=" first_result["frames"]
    return first_result["frames"]
}

PlayPauseVideo(window_identifier, player_key, reactive=true) {
    ; Msgbox, It is running video...

    if( reactive == true ) {
        WinGetActiveTitle, active_window_title
    }

    WinActivate, %window_identifier%
    SendInput % player_key

    if( reactive == true ) {
        WinActivate, %active_window_title%
    }
}
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


; https://www.groovypost.com/howto/howto/windows-programs-always-on-top/
^!i::Winset, Alwaysontop, , A
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

^!o:: Run "D:\User\Documents\speedcrunch-0.12-win32\speedcrunch.exe"
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
    Run, "D:\User\Documents\MiniLyrics\MiniLyrics.exe"
Return

;}
;Return


; ^!NumpadIns::Run "D:\User\Dropbox\Backups\AIMP\AIMP.exe"
; Return

^!Numpad0::
^!NumpadIns::
if WinExist("ahk_exe D:\User\Dropbox\Backups\AIMP\AIMP.exe")
    ; Most times this does not work
    ; https://autohotkey.com/docs/misc/WinTitle.htm
    ; https://autohotkey.com/docs/commands/WinActivate.htm
    ; WinActivate, ahk_exe AIMP.exe
    ; WinActivate, ahk_class TAIMPMainForm

    ; This is why I use this
    ; https://stackoverflow.com/questions/557166/bring-to-front-for-windows-xp-command-shell
    Run, "D:\User\Documents\NirSoft\nircmd-x64\nircmd.exe" win activate class "TAIMPMainForm"
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
