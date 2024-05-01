

setlocal

:: Set the Chrome profile name
set "ChromeProfile=F:\GoogleChromeProfiles\MainProfile"

:: Flag to track if Chrome with the specified profile is running
set "ChromeRunning=0"

:: Iterate over each process and check for Chrome with the specific profile
for /f "tokens=*" %%a in ('wmic process where "name='chrome.exe'" get commandline') do (
    echo %%a | find "%ChromeProfile%" >nul 2>&1
    if not errorlevel 1 set "ChromeRunning=1"
)

:: Act based on whether Chrome with the profile is running
if %ChromeRunning%==1 (
    echo Chrome with MainProfile is already running.
    "C:\Program Files\Google\Chrome\Application\chrome.exe" ^
        --new-window ^
        --user-data-dir="%ChromeProfile%" ^
        "https://weather.com/weather/hourbyhour/l/f136064ba28b472963a7ad219e64ce7ef8eb6cda4c4a59ec8c970f04935c3b12" ^
        "https://www.accuweather.com/en/br/florianópolis/35952/hourly-weather-forecast/35952"

) else (
    echo Starting Chrome without MainProfile...
    "C:\Program Files\Google\Chrome\Application\chrome.exe" ^
        --new-window ^
        "https://weather.com/weather/hourbyhour/l/f136064ba28b472963a7ad219e64ce7ef8eb6cda4c4a59ec8c970f04935c3b12" ^
        "https://www.accuweather.com/en/br/florianópolis/35952/hourly-weather-forecast/35952"
)

endlocal

