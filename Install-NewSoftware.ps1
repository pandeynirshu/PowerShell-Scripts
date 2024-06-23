<# Script for installation of new Software

1. Check if software is already installed
2. Create a destination directory
3. Check for ISO file
4. Install software
5. Create log file

#>

# Source file
$SourceFile = "https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-700.exe"

# Download ISO file
$DestinationFolder = "C:\Users\NPandey2\Documents\InstallerFiles\"
$DestinationFile   = "$destinationFolder\winrar-x64-700.exe"
$package = "WinRar"

# Check if software is already installed
$Softwares = Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*
$Software = $Softwares | Select-Object DisplayName, DisplayVersion, InstallDate
if ($Software.displayname -like "*$package*") {
 
        Write-Output "Software is already installed" 
        Exit 0
        } else {
                Write-Output "Software not found, please proceed with installation" 

                }

# Download ISO file from web and save it in destinationfile
                if (-not (Test-Path $DestinationFile)) {
                    New-Item -ItemType Directory $DestinationFolder -Force
                    Invoke-WebRequest -Uri $SourceFile -OutFile $DestinationFile -Verbose
                
                }

                Start-Process $DestinationFile /s -NoNewWindow -Wait -PassThru
                $Softwares = Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*
                $Software = $Softwares | Select-Object DisplayName, DisplayVersion, InstallDate

                if ($Software.displayname -like "*$package*") {
 
                Write-Output "Software is installed" 
        
                }