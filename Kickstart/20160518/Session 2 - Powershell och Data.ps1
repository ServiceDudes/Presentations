Break

# Sort and Query on output of objects:
Get-Service | Sort-Object Status | Format-Table -GroupBy Status
Get-Process | Where-Object -FilterScript {$_.HandleCount -gt 2000}
Get-Process | Where-Object -FilterScript {$_.ProcessName -eq "explorer" -or $_.Company -like "M*"}

#Parse Test files:
$Filename = "C:\Kickstart\Logonscript.vbs"
Select-String -Path $Filename -Pattern "password","\\" -SimpleMatch

#Check in Event Logs:
Get-EventLog -LogName Application -Newest 10

# Export Data in CSV or XML Object Graphs:
Get-Process | Export-Csv -Path C:\Kickstart\Services.csv -Encoding UTF8 -NoTypeInformation
Get-Process | Export-Clixml C:\Kickstart\Process.xml

# Export to HTML format:
Get-Process |
Select-Object Name, Description, Company, ProductVersion |
ConvertTo-Html | Out-File C:\Kickstart\Processes.html

# Export to "pretty" HTML with stylesheet:
$Head = Get-Content C:\Kickstart\Style.css
Get-Process |
Select-Object Name, Description, Company, ProductVersion |
ConvertTo-Html -Head $Head | Out-File C:\Kickstart\Processes.html

#Open WinRM for remote mangement:
#Run in CMD.exe
winrm quickconfig

# Set profile of network to allow remoting to self:
Get-NetAdapter # Will give you "<index number>" to replace in next CmdLet
Set-NetConnectionProfile -InterfaceIndex "<index number>" -NetworkCategory Private  

# WMI / CIM objekts in Windows:
Get-NetAdapter | Get-Member
Get-Command *wmi*
Get-WmiObject -Class Win32_Bios
Get-Bios
Get-Command *CIM*
Get-CimInstance -ClassName Win32_Bios

# XML and PowerShell:
[xml]$Books = Get-Content C:\Kickstart\Books.xml
$Books.catalog.book | Where {$_.Genre -eq "computer"}

# Custom Objects in PowerShell:
$Person = [PSCustomObject]@{
    FirstName = "Richard"
    LastName = "Ulfvin"
    PrimaryDevice = "localhost"
}

$Person | Select-Object -Property @{n="ComputerName"; e={$_.PrimaryDevice}} |
Get-CimInstance -ClassName Win32_Bios

# Using PowerShell and online API calls:
$URL = "http://www.systembolaget.se/api/assortment/products/xml"
$Systemet = Invoke-RestMethod -Uri $URL
($Systemet.artiklar.artikel | Where-Object {$_.Namn -like "*estrell*"}).Count