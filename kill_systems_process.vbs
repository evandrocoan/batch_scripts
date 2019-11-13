'
'I have this VBScript code to terminate one process: ...
'It works fine with some processes, but when it comes to any process runs under SYSTEM, it can't stop it.
'
'Is there is anything I need to add to kill the process under SYSTEM?
'
'http://stackoverflow.com/a/893577/4934640
'http://stackoverflow.com/questions/893237/how-to-terminate-process-using-vbscript
'
'
'The way I have gotten this to work in the past is by using PsKill from Microsoft's
'SysInternals. PsKill can terminate system processes and any processes that are locked.
'
'You need to download the executable and place it in the same directory as the script
'or add it's path in the WshShell.Exec call. Here's your sample code changed to use PsKill.
'
'

Const strComputer = "."
Set WshShell = CreateObject("WScript.Shell")
Dim objWMIService, colProcessList
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'MacroPlayer.exe'")
For Each objProcess in colProcessList
  WshShell.Exec "D:\User\Documents\SysinternalsSuite\PSKill.exe " & objProcess.ProcessId
  WScript.Echo "Killed a process!"
Next

WScript.Echo "Finished killing the process!"

'Dim objShell
'Set objShell = WScript.CreateObject ("WScript.shell")
'objShell.run "start C:\Notepad++Portable\App\Notepad++\notepad++.exe"
'Set objShell = Nothing
'CreateObject("WScript.Shell").Run sCmd, 1, True
WScript.Quit
















