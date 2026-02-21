@echo off
if "%1"=="" (
    echo Usage: killport.bat [PORT]
    echo Example: killport.bat 8000
    exit /b 1
)

powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File C:\mycmd\kill-process.ps1 -Port %1' -Verb RunAs"
