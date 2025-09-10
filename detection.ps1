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
$expected = 0x5944 # 22852 decimal

$compliant = $false

try {
    if (Test-Path -LiteralPath $regPath) {
        $prop = Get-ItemProperty -LiteralPath $regPath -Name $name -ErrorAction SilentlyContinue
        if ($null -ne $prop -and ($prop.$name -eq $expected)) {
            $compliant = $true
        }
    }
} catch {
    # Leave $compliant as $false
}

if ($compliant) {
    Write-Output 'Compliant'
    exit 0
} else {
    Write-Output 'Non-Compliant'
    exit 1
}