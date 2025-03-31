#Requires -RunAsAdministrator

New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1 -Force > $null
Write-Information  -Message "Uninstalling the original version (reffer to readme for errors/red text)"
Get-AppxPackage -AllUsers Microsoft.OutlookForWindows | Remove-AppxPackage -AllUsers
Write-Information  -Message "installing the patched one (Errors are bad now)"
switch ($Env:PROCESSOR_ARCHITECTURE) {
	"AMD64" {
		Add-AppxPackage -register "$PSScriptRoot\AppxManifest.xml"
	}
	"x86" {
		Add-AppxPackage -register "$PSScriptRoot\AppxManifestx86.xml"
	}
	"ARM64" {
		Add-AppxPackage -register "$PSScriptRoot\AppxManifest-ARM64.xml"
	}
}
Write-Information  -Message "Done!"
Read-Host -Prompt "Press any key to close this window"
