'
' Only supports the Military Hourly format 24 hours for now. It speaks the time when called.
' It also, turn the NumLock key on, when it is off.
'
' This program is free software; you can redistribute it and/or modify it
' under the terms of the GNU General Public License as published by the
' Free Software Foundation; either version 3 of the License, or ( at
' your option ) any later version.
'
' This program is distributed in the hope that it will be useful, but
' WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' General Public License for more details.
'
' You should have received a copy of the GNU General Public License
' along with this program.  If not, see <http://www.gnu.org/licenses/>.
'
'
'
'

Dim speaks
Dim speech

Dim currentTime
Dim currentHour
Dim currentMinute

Set speech = CreateObject("sapi.spvoice")
Set speech.Voice = speech.GetVoices.Item(0)

' Speech speed from -10 to 10
speech.Rate = -2
speech.Volume = 80

currentTime   = Now()
currentHour   = hour( currentTime )
currentMinute = Minute( currentTime )

If currentHour < 12 Then
    dayPeriod = "AM"
Else
    dayPeriod = "PM"
End If

If currentHour > 12 Then
    currentHour = currentHour - 12
End If

If currentMinute = 0 Then
    speaks = "The time is now, " & currentHour & " hours " & dayPeriod
Else
    speaks = "The time is now, " & currentHour & " hours and "
    speaks = speaks & currentMinute & " minutes " & dayPeriod
End If


Set myshell = CreateObject("Wscript.Shell")

Function RunCommand(command)
    returncode = myshell.Run( Trim( command ), 0, True )

    If returncode <> 0 Then
        Set WshShellExec = myshell.Exec( Trim( command ) )

        MsgBox "Error '" & returncode & "' running the script:" _
            & vbCrLf & "'" & Trim( arglist ) & "'" _
            & vbCrLf & WshShellExec.StdOut.ReadAll _
            & vbCrLf & WshShellExec.StdErr.ReadAll
    End If
End Function

' https://www.top-password.com/blog/mute-or-turn-off-microphone-in-windows-10/
RunCommand( """D:\User\Documents\NirSoft\SoundVolumeView.exe"" /Mute {0.0.1.00000000}.{e5b46464-3e8d-45de-99ab-54ad06ee6ddd}" )

' Wscript.Echo "speaks: " & speaks
speech.Speak speaks

RunCommand( """D:\User\Documents\NirSoft\SoundVolumeView.exe"" /Unmute {0.0.1.00000000}.{e5b46464-3e8d-45de-99ab-54ad06ee6ddd}" )

' Turn the NumLock on when it is off.
' See: https://blogs.technet.microsoft.com/heyscriptingguy/2006/08/10/how-can-tell-whether-the-numlock-key-is-on-or-off/

Set objWord = CreateObject("Word.Application")
'Wscript.Echo "NumLock key is on: " & objWord.NumLock

If NOT objWord.NumLock Then
    Set objShell = CreateObject("WScript.Shell")
    objShell.SendKeys "{NUMLOCK}"
End If

objWord.Quit





