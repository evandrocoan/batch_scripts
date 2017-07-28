'
'  Make Notepad++ the Default TXT Editor
'  http://docs.notepad-plus-plus.org/index.php?title=Replacing_Notepad
'
'  Replacing Notepad with Notepad++ using Image File Execution Options
'  https://www.cult-of-tech.net/2011/10/replacing-notepad-with-notepad-using-image-file-execution-options/
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
' DISCLAIMER
' THIS COMES WITH NO WARRANTY, IMPLIED OR OTHERWISE. USE AT YOUR OWN RISK
' IF YOU ARE NOT COMFORTABLE EDITING THE REGISTRY THEN DO NOT USE THIS SCRIPT
'
' NOTES:
' This affects all users.
' This will prevent ANY executable named notepad.exe from running located anywhere on this computer!!
'
' Save this text to your notepad++ folder as a text file named npp.vbs (some AV don't like vbs, get a different AV :-P )
'
' USAGE
' 1)
' Navigate to registry key HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\
'
' 2)
' Add new subkey called notepad.exe
' This step is what tells windows to use the notepad++ exe, to undo simply delete this key
'
' 3)
' Create new Sting Value called Debugger
'
' 4)
' Modify value and enter wscript.exe "path to npp.vbs" e.g. wscript.exe "C:\Program Files\Notepad++\npp.vbs"
'


Option Explicit
Dim sCmd, x

sCmd = """" & LeftB(WScript.ScriptFullName, LenB(WScript.ScriptFullName) - LenB(WScript.ScriptName)) & "sublime_text.exe" & """ -n """
For x = 1 To WScript.Arguments.Count - 1
   sCmd = sCmd & WScript.Arguments(x) & " "
Next

sCmd = Trim(sCmd) & """"

' Wscript.Echo "sCmd: " & sCmd
CreateObject("WScript.Shell").Run sCmd, 1, True

WScript.Quit




