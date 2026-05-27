@echo off
>nul 2>&1 fltmc || (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
setlocal enabledelayedexpansion
title WSL Context Menu Uninstaller

pushd "%~dp0" >nul 2>&1

echo ============================================
echo  WSL Context Menu Uninstaller
echo ============================================
echo.

echo [1/2] Removing registry entries ...
reg delete "HKEY_CLASSES_ROOT\Directory\shell\WSLTerminal" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\WSLTerminal" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\WSLVSCode" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\WSLVSCode" /f >nul 2>&1
echo   ^> Done

echo.

echo [2/2] Removing VBS script ...
set "vbsFile=%LOCALAPPDATA%\WSLTools\wsl_code_open.vbs"
if exist "%vbsFile%" (
    del "%vbsFile%"
    echo   ^> Removed %vbsFile%
) else (
    echo   ^> Not found, skipping
)

echo.
echo ============================================
echo  Cleanup complete.
echo ============================================
echo.
popd
pause