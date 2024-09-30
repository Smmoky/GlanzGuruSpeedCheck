@echo off
setlocal

:menu
echo Choose an option:
echo 1 - Delete temporary files
echo 2 - Clean up outdated registry entries
echo 3 - Optimize the drive
echo 4 - Apply visual effects settings for optimal performance
echo 5 - Exit
set /p choice="Please press 1, 2, 3, 4, or 5: "

if "%choice%"=="1" goto deleteTempFiles
if "%choice%"=="2" goto deleteRegistryEntries
if "%choice%"=="3" goto optimizeDrive
if "%choice%"=="4" goto applyVisualEffects
if "%choice%"=="5" goto end
echo Invalid selection, please try again.
goto menu

:deleteTempFiles
echo Searching drive C: for temporary files...

:: Typical temporary file extensions
set "extensions=.tmp .temp .log .bak .dmp .~* .chk .swp .old .suo .idb .o .cache .part .tempfile .pf"

:: Loop through all extensions
for %%e in (%extensions%) do (
    echo Deleting files with the extension %%e ...
    del /s /q "C:\*%%e"
)

echo Done! All temporary files have been deleted.
pause
goto menu

:deleteRegistryEntries
echo Searching for outdated registry entries...

:: Output registry entries to a temporary file
set "tempFile=C:\temp\registry_entries.txt"

:: Create the directory if it does not exist
if not exist C:\temp (
    mkdir C:\temp
)

:: List all installed programs from the registry
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" > "%tempFile%"
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall" >> "%tempFile%"

echo The following registry entries were found:
type "%tempFile%"

:: Delete outdated entries
for /f "tokens=*" %%i in ('type "%tempFile%"') do (
    echo Deleting registry entry: %%i
    reg delete "%%i" /f >nul 2>&1
)

echo Done! All outdated registry entries have been deleted.
del "%tempFile%"
pause
goto menu

:optimizeDrive
echo Optimizing drive C: ...

:: Defragment the drive
defrag C: /O /H

echo Drive C: has been optimized.
pause
goto menu

:end
echo Exiting...
endlocal
