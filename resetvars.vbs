
' 
' If I modify or add an environment variable I have to restart the command prompt (minor inconvenience).
' Is there a command I could execute that would do this without restarting CMD?
' 
' http://stackoverflow.com/questions/171588/is-there-a-command-to-refresh-environment-variables-from-the-command-prompt-in-w
' http://stackoverflow.com/a/171737/4934640
'
'

Set oShell = WScript.CreateObject("WScript.Shell")
filename = oShell.ExpandEnvironmentStrings("%TEMP%\resetvars.bat")
Set objFileSystem = CreateObject("Scripting.fileSystemObject")
Set oFile = objFileSystem.CreateTextFile(filename, TRUE)

set oEnv=oShell.Environment("System")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next
path = oEnv("PATH")

set oEnv=oShell.Environment("User")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next

path = path & ";" & oEnv("PATH")
oFile.WriteLine("SET PATH=" & path)
oFile.Close
