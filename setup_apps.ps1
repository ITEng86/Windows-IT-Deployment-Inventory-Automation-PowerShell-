# Self-elevate to Administrator if needed
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Start-Process PowerShell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "Stop"

Write-Host "Installing apps..." -ForegroundColor Cyan

winget install --id Google.Chrome -e --silent --accept-source-agreements --accept-package-agreements
winget install --id Adobe.Acrobat.Reader.64-bit -e --silent --accept-source-agreements --accept-package-agreements
winget install --id Microsoft.Teams -e --silent --accept-source-agreements --accept-package-agreements

Write-Host "Apps installed successfully." -ForegroundColor Green