

SET VERSION=LanguageTool-4.0
SET "CURRENT_PATH=%~dp0."
SET "LANGUAGE_TOOL_PATH=%~dp0.\..\.."

:: SET COMMAND="%CURRENT_PATH%%VERSION%\languagetool.jar"
SET COMMAND="%LANGUAGE_TOOL_PATH%\%VERSION%\languagetool-server.jar"

::
:: Redirect Windows cmd stdout and stderr to a single file
:: https://stackoverflow.com/questions/1420965/redirect-windows-cmd-stdout-and-stderr-to-a-single-file
::
:: OutOfMemoryError: Minimum server requirements for HTTP Server
:: https://github.com/languagetool-org/languagetool/issues/902
::
:: How to set the maximum memory usage for JVM?
:: https://stackoverflow.com/questions/1493913/how-to-set-the-maximum-memory-usage-for-jvm
::
:: How to limit the maximum request size to the language server?
:: https://github.com/languagetool-org/languagetool/issues/916
::
java -cp %COMMAND% org.languagetool.server.HTTPServer --port 8081 --config "%LANGUAGE_TOOL_PATH%\server.properties" >> "%CURRENT_PATH%\output.txt" 2>&1

:: for /f "tokens=2 delims=," %%a in (
::   'tasklist /v /fo csv ^| findstr /i %COMMAND%'
:: ) do (
::   set "mypid=%%~a"
:: )

:: PowerShell "$Process = Get-Process -Id %mypid%; $Process.ProcessorAffinity=1"

