cls
del ".install.bat.un~"
del "installe.bat~"
call start %TEMP%
pause
call settime
pause
call powershell -ExecutionPolicy Bypass -c "irm https://herdr.dev/install.ps1 | iex"
pause
nvm install node --reinstall-packages-from=node
pause
nvm use node
pause
choco list
pause
choco outdated
pause
choco upgrade GoogleChrome
pause
choco upgrade all -v --ignore-checksums
pause
call npm list -g --depth=0
pause
call npm outdated -g --depth=0
pause
call npm update -g
pause 
nvm list
