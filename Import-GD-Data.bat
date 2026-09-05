@echo off
title GD Data Transfer - Import
cd /d "%~dp0"
if not exist "%~dp0saves" if not exist "%~dp0game" (
  echo This importer only works inside an exported pack folder.
  echo.
  echo 1. Run "Launch GD Data Transfer.bat"
  echo 2. Choose Export pack
  echo 3. On the other PC, open the pack and double-click Import-GD-Data.bat
  echo.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -STA -File "%~dp0Import-GD-Data.ps1"
if errorlevel 1 pause
