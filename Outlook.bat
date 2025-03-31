@echo off

::# self elevate with native shell by AveYo
>nul reg add hkcu\software\classes\.Admin\shell\runas\command /f /ve /d "cmd /x /d /r set \"f0=%%2\"& call \"%%2\" %%3"& set _= %*
>nul fltmc|| if "%f0%" neq "%~f0" (cd.>"%temp%\runas.Admin" & start "%~n0" /high "%temp%\runas.Admin" "%~f0" "%_:"=""%" & exit /b)

powershell "New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1 -Force" >NUL 2>NUL
echo Uninstalling the original version (reffer to readme for errors/red text)
powershell "get-appxpackage -allusers Microsoft.OutlookForWindows | Remove-AppxPackage -allusers"
echo installing the patched one (Errors are bad now)
if %PROCESSOR_ARCHITECTURE%==AMD64 powershell add-appxpackage -register "'%~dp0AppxManifest.xml'"
if %PROCESSOR_ARCHITECTURE%==x86 powershell add-appxpackage -register "'%~dp0AppxManifestx86.xml'"
if %PROCESSOR_ARCHITECTURE%==ARM64 powershell add-appxpackage -register "'%~dp0AppxManifest-ARM64.xml'"
echo Done!
echo .
echo Press any key to close this window
pause
