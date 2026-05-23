# ===================================================================== 
# JUPYTER LAB 4.5.6 - FORCED CHROME DEPLOYMENT (Version 9.23.0)
# "AND WE SHALL KNOW NO FEAR."
# ===================================================================== 
$ErrorActionPreference = 'SilentlyContinue'
$sourceDir = "C:\Users\HaitchPee\Documents\Haruki\pyNotes"
$sourcePath = "$sourceDir\*.ipynb"
$backupRoot = "C:\Users\HaitchPee\Documents\Haruki\pynotes\MyCodingBackUps"
$envName = "jlab2026"
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$currentBackup = Join-Path $backupRoot "Macragge_Archivum_$timestamp"

# --- THE ULTRAMARINE RITUAL (STABILIZED HOLLOW ULTIMA) ---
Clear-Host
Write-Host '       :::::::            :::::::      ' -ForegroundColor Blue
Write-Host '        :::::              :::::       ' -ForegroundColor Blue
Write-Host '         :::                :::        ' -ForegroundColor Blue
Write-Host '         :::                :::        ' -ForegroundColor Blue
Write-Host '         :::                :::        ' -ForegroundColor Blue
Write-Host '         :::                :::        ' -ForegroundColor Blue
Write-Host '         :::                :::        ' -ForegroundColor Blue
Write-Host '         :::.             .::::        ' -ForegroundColor Blue
Write-Host '          :::::::       :::::::        ' -ForegroundColor Blue
Write-Host '            :::::::::::::::::          ' -ForegroundColor Blue
Write-Host '              :::::::::::::            ' -ForegroundColor Blue
Write-Host '======================================================================' -ForegroundColor Blue
Write-Host ".      [ CODEX STRATEGEM: FORCED-DROP 9.23.0 ]                       ." -ForegroundColor White
Write-Host '======================================================================' -ForegroundColor Blue

# --- STEP 1: LOGISTICS & BACKUP ---
if (!(conda env list | Select-String $envName)) { Write-Host "[!] ENV MISSING"; Pause; exit }
if (!(Test-Path $backupRoot)) { New-Item -ItemType Directory -Path $backupRoot | Out-Null }
New-Item -ItemType Directory -Path $currentBackup | Out-Null
Copy-Item $sourcePath -Destination $currentBackup -Force

# --- STEP 2: EXTERMINATUS ---
Remove-Item "$env:APPDATA\jupyter\runtime\*" -Force
Get-Process | Where-Object {$_.ProcessName -Match "python|jupyter"} | Stop-Process -Force 2>$null

# --- STEP 3: FORCED DEPLOYMENT ---
Set-Location $sourceDir
$target = (Get-ChildItem $sourcePath | Sort-Object LastWriteTime -Descending | Select-Object -First 1).Name

# Start Chrome manually 2 seconds after Jupyter to ensure the link is live
Start-Job -ScriptBlock {
    param($chromePath)
    Start-Sleep -Seconds 3
    Start-Process $chromePath "http://127.0.0"
} | Out-Null

Write-Host ". [ DEPLOY ] FORCING CHROME LINK... DROPPING $target" -ForegroundColor Green

conda run -n $envName --no-capture-output jupyter lab $target `
    --ip=127.0.0.1 `
    --port=8888 `
    --log-level=CRITICAL `
    --ServerApp.open_browser=False `
    --ServerApp.token='' `
    --ServerApp.password='' `
    --ServerApp.disable_check_xsrf=True `
    --LabApp.check_for_updates_class="jupyterlab.NeverCheckForUpdates"

# --- STEP 4: VICTORY RITUAL ---
Write-Host '. [ EXIT ] MARCHING FINAL CHANGES BACK TO MACRAGGE...' -ForegroundColor White
Copy-Item $sourcePath -Destination $currentBackup -Force
Get-ChildItem $backupRoot -Directory | Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-14) } | Remove-Item -Recurse -Force
Pause
