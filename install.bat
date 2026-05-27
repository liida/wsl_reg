@echo off
>nul 2>&1 fltmc || (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
setlocal enabledelayedexpansion
title WSL Context Menu Importer

pushd "%~dp0" >nul 2>&1

echo ============================================
echo  WSL Context Menu Importer
echo ============================================
echo.

rem --- ���� VBS �����ű� ---
set "vbsDir=%LOCALAPPDATA%\WSLTools"
set "vbsSrc=%~dp0wsl_code_open.vbs"
set "vbsDst=%vbsDir%\wsl_code_open.vbs"

echo [1/4] Copying wsl_code_open.vbs ...
if not exist "%vbsDir%" mkdir "%vbsDir%"
if exist "%vbsSrc%" (
    copy /Y "%vbsSrc%" "%vbsDst%" >nul
    if !errorlevel! equ 0 (echo   ^> VBS copied) else (echo   ^> VBS FAILED)
) else (
    echo   ^> wsl_code_open.vbs not found, skipping
)

echo.

rem --- ����ע��� ---
echo [2/4] Importing wsl_open_terminal.reg ...
regedit /s "%~dp0wsl_open_terminal.reg"
echo   ^> Done

echo [3/4] Importing wsl_open_vscode.reg ...
regedit /s "%~dp0wsl_open_vscode.reg"
echo   ^> Done

echo.

echo [4/4] Setting icons ...
reg add "HKCR\Directory\shell\WSLTerminal" /v "Icon" /t REG_SZ /d "C:\Windows\System32\wsl.exe" /f >nul
reg add "HKCR\Directory\Background\shell\WSLTerminal" /v "Icon" /t REG_SZ /d "C:\Windows\System32\wsl.exe" /f >nul
reg add "HKCR\Directory\shell\WSLVSCode" /v "Icon" /t REG_SZ /d "C:\Windows\System32\wsl.exe" /f >nul
reg add "HKCR\Directory\Background\shell\WSLVSCode" /v "Icon" /t REG_SZ /d "C:\Windows\System32\wsl.exe" /f >nul
echo   ^> Done

echo.
echo ============================================
echo  All done! Right-click a folder in Explorer
echo  to see "Open in WSL" and
echo  "Open in WSL with VS Code".
echo ============================================
echo.
echo  To REMOVE later, delete these keys:
echo    HKEY_CLASSES_ROOT\Directory\shell\WSLTerminal
echo    HKEY_CLASSES_ROOT\Directory\Background\shell\WSLTerminal
echo    HKEY_CLASSES_ROOT\Directory\shell\WSLVSCode
echo    HKEY_CLASSES_ROOT\Directory\Background\shell\WSLVSCode
echo.
popd
pause