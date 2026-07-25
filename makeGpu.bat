@echo off
setlocal EnableDelayedExpansion

if "%~1"=="" (
    echo Usage:
    echo     makegpu model_name
    echo.
    echo Example:
    echo     makegpu llama3.2
    exit /b 1
)

set MODEL=%~1
set TEMPFILE=%TEMP%\Modelfile_%RANDOM%.txt

echo Creating GPU optimized model...

(
echo FROM %MODEL%
echo PARAMETER num_gpu 999
echo PARAMETER num_ctx 8192
echo PARAMETER temperature 0.7
) > "%TEMPFILE%"

ollama create %MODEL%-gpu -f "%TEMPFILE%"

del "%TEMPFILE%"

echo.
echo Done.
echo.
echo Run with:
echo     ollama run %MODEL%-gpu
