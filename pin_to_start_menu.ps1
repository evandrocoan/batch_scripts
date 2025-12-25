# Pin a shortcut to Windows Start Menu
# Usage: .\pin_to_start_menu.ps1 "path\to\your\shortcut.lnk"

param(
    [Parameter(Mandatory=$false)]
    [string]$ShortcutPath
)

# If no path provided, use the default shortcut in current directory
if (-not $ShortcutPath) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $ShortcutPath = Join-Path $ScriptDir "fix_slides_for_obs_gui.lnk"
    
    # If .lnk doesn't exist, try .bat
    if (-not (Test-Path $ShortcutPath)) {
        $ShortcutPath = Join-Path $ScriptDir "fix_slides_for_obs_gui.bat"
    }
}

# Check if file exists
if (-not (Test-Path $ShortcutPath)) {
    Write-Host "Error: File not found: $ShortcutPath" -ForegroundColor Red
    Write-Host "Please create a shortcut or batch file first, or provide the path as an argument." -ForegroundColor Yellow
    exit 1
}

$ShortcutPath = Resolve-Path $ShortcutPath

Write-Host "Attempting to pin: $ShortcutPath" -ForegroundColor Cyan

try {
    # Copy to Start Menu Programs folder - this is the most reliable method
    $StartMenuPath = "$env:AppData\Microsoft\Windows\Start Menu\Programs"
    $TargetPath = Join-Path $StartMenuPath (Split-Path $ShortcutPath -Leaf)
    
    Copy-Item -Path $ShortcutPath -Destination $TargetPath -Force
    Write-Host "Successfully copied to: $TargetPath" -ForegroundColor Green
    Write-Host "`nNow:" -ForegroundColor Yellow
    Write-Host "  1. Open Start Menu" -ForegroundColor Cyan
    Write-Host "  2. Find '$((Split-Path $ShortcutPath -Leaf))' in the app list" -ForegroundColor Cyan
    Write-Host "  3. Right-click it and select 'Pin to Start'" -ForegroundColor Cyan
    
    # Also try to invoke the Pin verb (may or may not work depending on Windows version)
    try {
        $shell = New-Object -ComObject Shell.Application
        $folder = $shell.Namespace($StartMenuPath)
        $item = $folder.ParseName((Split-Path $ShortcutPath -Leaf))
        
        $verb = $item.Verbs() | Where-Object { $_.Name -match 'Pin to Start' }
        
        if ($verb) {
            $verb.DoIt()
            Write-Host "`nAttempted to pin automatically as well." -ForegroundColor Green
        }
    } catch {
        # Silent fail - the copy method is what matters
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
