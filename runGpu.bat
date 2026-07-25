@echo off

if "%~1"=="" (
    echo Usage:
    echo     rungpu model
    exit /b
)

set OLLAMA_NUM_GPU=999
set OLLAMA_FLASH_ATTENTION=1

ollama run %1
