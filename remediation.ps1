<#
    .SYNOPSIS
        A simple script intended to be used as an Intune remediation to make the required registry changes to allow for fully automated Microsoft Management of certificate Signature Database (DB) and Key Enrollment/Exchange key (KEK).
        Official Microsoft guidance: https://support.microsoft.com/en-us/topic/windows-devices-for-businesses-and-organizations-with-it-managed-updates-e2b43f9f-b424-42df-bc6a-8476db65ab2f

    
    .NOTES
      Version:          1.0.0
      Author:           Matthew Drummond
      Published Date:   09 September 2025
#>

$regPath  = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot'
$name     = 'MicrosoftUpdateManagedOptIn'
$value    = 0x5944 # 22852 decimal

try {
    if (-not (Test-Path -LiteralPath $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    New-ItemProperty -LiteralPath $regPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

    Write-Output 'Remediation applied'
    exit 0
} catch {
    Write-Output "Remediation failed: $($_.Exception.Message)"
    exit 1
}
