@echo off
title WSL Context Menu Importer
echo ============================================
echo  WSL Context Menu Registry Importer
echo ============================================
echo.
echo This script will add WSL entries to your
echo Windows right-click context menu.
echo.
echo Files available:
echo   1. wsl_open_terminal.reg  - "Open in WSL"
echo   2. wsl_open_vscode.reg    - "Open in WSL with VS Code"
echo.
echo USAGE:
echo   Simply double-click any .reg file to merge
echo   it into the Windows Registry, or run:
echo.
echo     regedit /s wsl_open_terminal.reg
echo     regedit /s wsl_open_vscode.reg
echo.
echo   (/s = silent mode, no confirmation prompt)
echo.
echo To REMOVE an entry later, delete these
echo registry keys:
echo   HKEY_CLASSES_ROOT\Directory\shell\WSLTerminal
echo   HKEY_CLASSES_ROOT\Directory\Background\shell\WSLTerminal
echo   HKEY_CLASSES_ROOT\Directory\shell\WSLVSCode
echo   HKEY_CLASSES_ROOT\Directory\Background\shell\WSLVSCode
echo.
echo ============================================
pause