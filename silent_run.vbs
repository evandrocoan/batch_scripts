'
' Run a Batch file passed as its first command line argument silently, i.e., without any windows.
'
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
' Can I pass an argument to a VBScript (vbs file launched with cscript)?
' https://stackoverflow.com/questions/2806713/can-i-pass-an-argument-to-a-vbscript-vbs-file-launched-with-cscript
'

if WScript.Arguments.Count = 0 then
    WScript.Echo "Missing parameters"
end if

'
' VBScript pass commandline argument in paths with spaces
' https://stackoverflow.com/questions/17841912/vbscript-pass-commandline-argument-in-paths-with-spaces
'
' How to pass a command with spaces and quotes as a single parameter to CScript?
' https://stackoverflow.com/questions/10091711/how-to-pass-a-command-with-spaces-and-quotes-as-a-single-parameter-to-cscript
'
'

' Dim command
' Set args = Wscript.Arguments

' For Each arg In args
'     command = command & " " & arg
'     Wscript.Echo arg
' Next
' Wscript.Echo command

'
' calling vbscript from another vbscript file passing arguments
' https://stackoverflow.com/questions/17437633/calling-vbscript-from-another-vbscript-file-passing-arguments
'
' VBScript command line arguments
' https://ss64.com/vb/syntax-args.html
'
' Check if string contains space
' https://stackoverflow.com/questions/31370456/check-if-string-contains-space
'

Function EnquoteString(argument)
  EnquoteString = Chr(34) & argument & Chr(34)
End Function

arglist = ""
With WScript.Arguments
    For Each arg In .Unnamed
        ' Wscript.Echo "Unnamed: " & arg
        If InStr(arg, " ") > 0 Then
            ' arg contains a space
            arglist = arglist & " " & EnquoteString(arg)
        Else
            arglist = arglist & " " & arg
        End If
    Next
End With

' Wscript.Echo arglist

'
' Running command line silently with VbScript and getting output?
' https://stackoverflow.com/questions/5690134/running-command-line-silently-with-vbscript-and-getting-output
'
' Windows Script Host - Run Method (Windows Script Host)
' http://www.vbsedit.com/html/6f28899c-d653-4555-8a59-49640b0e32ea.asp
'
' Wscript.Echo Wscript.Arguments.Item(0)

'
' Run a batch file in a completely hidden way
' https://superuser.com/questions/62525/run-a-batch-file-in-a-completely-hidden-way
'
' How to run Batch script received as argument on VBscript?
' https://stackoverflow.com/questions/45239157/how-to-run-batch-script-received-as-argument-on-vbscript
'
Set myshell = CreateObject("Wscript.Shell")
returncode = myshell.Run( Trim( arglist ), 0, True )

If returncode <> 0 Then
    Set WshShellExec = myshell.Exec( Trim( arglist ) )

    MsgBox "Error '" & returncode & "' running the script:" _
        & vbCrLf & "'" & Trim( arglist ) & "'" & vbCrLf _
        & WshShellExec.StdOut.ReadAll & WshShellExec.StdErr.ReadAll
End If

WScript.Quit( returncode )
