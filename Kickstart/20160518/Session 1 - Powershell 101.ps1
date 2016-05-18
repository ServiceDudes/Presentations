Break

# Setup for the Demos:
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Find-Module -Name Kickstart | Install-Module
Install-Module -Name Kickstart

Start-Kickstart

explorer C:\

# List package providers and look for packages:
Find-PackageProvider
Find-Package -ProviderName chocolatey -Name power*

# Check for all CmdLets:
Get-Command -CommandType Cmdlet | Measure-Object

# Using the HelpSystem
Get-Help Get-Service -Online
Help a*array* -ShowWindow

# Check for Alias names in PowerShell:
Get-Alias

# Get PowerShell version:
$PSVersionTable

# Get Commands from PowerShell:
Get-Command -Verb Get*
Get-Command -Noun *Net*

# Replacing your ordinary commands to PS CmdLets:
ipconfig
Get-NetIPConfiguration | Select-Object InterfaceAlias, InterfaceIndex
Test-NetConnection
Get-NetTCPConnection

# PS Drives and Providers:
Get-PSProvider
Get-PSDrive

cd HKLM:\SOFTWARE
Get-ChildItem C:\Windows\System32\WindowsPowerShell\v1.0 -Recurse -Filter *.cdxml

# Using variables for memory placement of output objects:
$net = Get-NetAdapter
$net | Get-Member

$Service = Get-Service -Name WinRM
$Service.Status
$Service.Start()
$Service.Refresh()

$psISE.Options.Zoom = 130
$psISE.Options.Zoom = 190
$PSISE.Options.FontName = "Wingdings"

# Diffrent Outputs:
Get-Service | Out-GridView
Get-Service | Format-List *
Get-Service | Format-Table