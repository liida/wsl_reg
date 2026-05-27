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

rem --- 复制 VBS 脚本 ---
set "vbsDir=%LOCALAPPDATA%\WSLTools"
set "vbsCodeSrc=%~dp0wsl_code_open.vbs"
set "vbsCodeDst=%vbsDir%\wsl_code_open.vbs"
set "vbsTermSrc=%~dp0wsl_open_terminal.vbs"
set "vbsTermDst=%vbsDir%\wsl_open_terminal.vbs"

echo [1/4] Copying VBS scripts ...
if not exist "%vbsDir%" mkdir "%vbsDir%"
if exist "%vbsCodeSrc%" (
    copy /Y "%vbsCodeSrc%" "%vbsCodeDst%" >nul
    if !errorlevel! equ 0 (echo   ^> wsl_code_open.vbs copied) else (echo   ^> wsl_code_open.vbs FAILED)
) else (
    echo   ^> wsl_code_open.vbs not found, skipping
)
if exist "%vbsTermSrc%" (
    copy /Y "%vbsTermSrc%" "%vbsTermDst%" >nul
    if !errorlevel! equ 0 (echo   ^> wsl_open_terminal.vbs copied) else (echo   ^> wsl_open_terminal.vbs FAILED)
) else (
    echo   ^> wsl_open_terminal.vbs not found, skipping
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