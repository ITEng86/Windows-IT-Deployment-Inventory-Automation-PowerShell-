$ErrorActionPreference = "Stop"

$hostname = $env:COMPUTERNAME
$date = Get-Date -Format "yyyy-MM-dd_HH-mm"

$serial = (Get-CimInstance Win32_BIOS).SerialNumber
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } | Select-Object -First 1).IPAddress
$mac = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1 -ExpandProperty MacAddress)

$path = "C:\IT-Setup\Inventory"
New-Item -ItemType Directory -Path $path -Force | Out-Null

$file = "$path\$hostname`_$date.txt"

$output = @"
Computer Name: $hostname
Serial Number: $serial
Operating System: $os
IP Address: $ip
MAC Address: $mac
Date: $date
"@

$output | Out-File -FilePath $file -Encoding UTF8

Write-Host "Inventory saved to $file" -ForegroundColor Green