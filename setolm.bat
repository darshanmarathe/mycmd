@echo off
setlocal

taskkill /F /IM ollama.exe
set OLLAMA_NUM_GPU=999
set ZES_ENABLE_SYSMAN=1
@REM This environment variable might improve performance.
@REM You could uncomment it and test whether it brings benefit for your case.
set SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1
set OLLAMA_KEEP_ALIVE=10m

set OLLAMA_NUM_PARALLEL=2
start ollama
