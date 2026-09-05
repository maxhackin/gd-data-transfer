# Geometry Dash pack importer — run on the DESTINATION PC
# Double-click Import-GD-Data.bat  (or right-click this file -> Run with PowerShell)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Windows.Forms | Out-Null

$PackRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SavesSrc = Join-Path $PackRoot "saves"
$GameSrc = Join-Path $PackRoot "game"
$DestSaves = Join-Path $env:LOCALAPPDATA "GeometryDash"

function Die($m) {
    [System.Windows.Forms.MessageBox]::Show($m, "GD Data Transfer", "OK", "Error") | Out-Null
    throw $m
}

if (-not (Test-Path $SavesSrc) -and -not (Test-Path $GameSrc)) {
    Die "This folder is not a GD transfer pack.`nExpected: $PackRoot\saves  or  $PackRoot\game`n`nRun Launch GD Data Transfer.bat first and choose Export."
}

$gd = Get-Process -Name "GeometryDash" -ErrorAction SilentlyContinue
if ($gd) {
    Die "Close Geometry Dash on this PC first, then run the importer again."
}

$DestGame = $null
$parent = Split-Path -Parent $PackRoot
if (Test-Path (Join-Path $parent "GeometryDash.exe")) {
    $DestGame = $parent
} else {
    $steam = Join-Path ${env:ProgramFiles(x86)} "Steam\steamapps\common\Geometry Dash"
    if (Test-Path (Join-Path $steam "GeometryDash.exe")) { $DestGame = $steam }
}

if (-not $DestGame) {
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description = "Select the Geometry Dash folder on THIS PC (the one that contains GeometryDash.exe)"
    if ($dlg.ShowDialog() -ne "OK") { exit 0 }
    $DestGame = $dlg.SelectedPath
}
if (-not (Test-Path (Join-Path $DestGame "GeometryDash.exe"))) {
    Die "That folder does not contain GeometryDash.exe:`n$DestGame"
}

$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$Backup = Join-Path $DestSaves "_import_backup_$stamp"
New-Item -ItemType Directory -Force -Path $Backup | Out-Null
New-Item -ItemType Directory -Force -Path $DestSaves | Out-Null

foreach ($name in @("CCGameManager.dat","CCGameManager2.dat","CCLocalLevels.dat","CCLocalLevels2.dat","musiclibrary.dat")) {
    $p = Join-Path $DestSaves $name
    if (Test-Path $p) { Copy-Item $p (Join-Path $Backup $name) -Force }
}

Write-Host "Importing into:"
Write-Host "  Saves: $DestSaves"
Write-Host "  Game:  $DestGame"
Write-Host "  Backup of existing .dat files: $Backup"
Write-Host ""

if (Test-Path $SavesSrc) {
    Write-Host "Copying save data..."
    & robocopy $SavesSrc $DestSaves /E /XO /R:2 /W:2 /MT:8 /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -ge 8) { Die "Save-data copy failed (robocopy $LASTEXITCODE)." }
}

if ((Test-Path $GameSrc) -and $DestGame) {
    Write-Host "Copying game-folder data (mods, macros, config)..."
    & robocopy $GameSrc $DestGame /E /XO /R:2 /W:2 /MT:8 /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -ge 8) { Die "Game-folder copy failed (robocopy $LASTEXITCODE)." }
}

$msg = "Import finished.`n`nSaves -> $DestSaves`nGame  -> $DestGame`n`nA backup of the old .dat files is in:`n$Backup`n`nOpen Geometry Dash and check your account / editor."
[System.Windows.Forms.MessageBox]::Show($msg, "GD Data Transfer", "OK", "Information") | Out-Null
exit 0
