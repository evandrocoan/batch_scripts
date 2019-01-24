
' Set oShell = CreateObject("Shell.Application")
'
' oShell.ShellExecute "cmd.exe", , , "runas", 1
' oShell.Run "C:\\Programas\\processhacker\\x64\\ProcessHacker.exe"
'
' Command line reference
' https://wj32.org/processhacker/forums/viewtopic.php?t=75
'
' run cmd.exe as administrator in a script
' https://stackoverflow.com/questions/11459419/run-cmd-exe-as-administrator-in-a-script
'

Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "cmd.exe", "/k start /b C:\\Programas\\processhacker\\x64\\ProcessHacker.exe -hide && exit", "", "runas", 1


