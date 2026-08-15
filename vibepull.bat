E:
call cdl E:\opensource\vibe-tasks
echo "undo the changes"
pause
call reseth
echo "pulling latest"
call pull
echo "installing deps"
call npm approve-scripts --allow-scripts-pending
call npi -l
pause 
echo "starting build ..."
call build.bat
call cdl build
echo "Build done"
pause 
echo "Killing process if any"
call taskkill /f /im vibe-tasks.exe
call taskkill /f /im "vibe tasks.exe"
call kill vibe-tasks.exe
call kill "vibe tasks.exe"
echo "configuring...."
del vibe-tasks.exe
copy vibetask.exe vibe-tasks.exe
echo "starting...."
start  vibe-tasks.exe
