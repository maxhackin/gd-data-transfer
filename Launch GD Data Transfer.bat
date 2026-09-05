@echo off
title GD Data Transfer
cd /d "%~dp0"

where pyw >nul 2>nul
if %errorlevel%==0 (
  pyw -3 "%~dp0gd_data_transfer.py"
  if not errorlevel 1 exit /b 0
)

where py >nul 2>nul
if %errorlevel%==0 (
  py -3 "%~dp0gd_data_transfer.py"
  if not errorlevel 1 exit /b 0
)

where pythonw >nul 2>nul
if %errorlevel%==0 (
  pythonw "%~dp0gd_data_transfer.py"
  if not errorlevel 1 exit /b 0
)

where python >nul 2>nul
if %errorlevel%==0 (
  python "%~dp0gd_data_transfer.py"
  if not errorlevel 1 exit /b 0
)

echo Python is required to open the transfer window.
echo Install Python from https://www.python.org/downloads/
echo Make sure "Add python.exe to PATH" is checked.
echo.
echo If you already have a pack exported, you can still import it
echo on this PC by double-clicking Import-GD-Data.bat inside the pack.
echo.
pause
exit /b 1
