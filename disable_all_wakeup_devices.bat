

@echo on

:: List all devices
echo .
echo Before

:: https://stackoverflow.com/questions/6359820/how-to-set-commands-output-as-a-variable-in-a-batch-file
SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`powercfg devicequery wake_armed`) DO (
  SET usb_devices!count!=%%F
  SET /a count=!count!+1
)
ENDLOCAL & (
	set usb_devices1=%usb_devices1%
)

:: https://stackoverflow.com/questions/39276105/windows-batch-if-statement-with-user-input
ECHO %usb_devices1%

IF "%usb_devices1%"=="NONE" GOTO :end

:: powercfg devicedisablewake "HID-compliant mouse (005)"
:: https://superuser.com/questions/631637/how-to-disallow-usb-devices-to-wake-the-computer-by-default-in-windows-7
for /F "tokens=*" %%A in ('powercfg -devicequery wake_armed') do echo Disabling device: "%%A" && powercfg -devicedisablewake "%%A"

echo .
echo After
powercfg devicequery wake_armed

:end
:: pause
