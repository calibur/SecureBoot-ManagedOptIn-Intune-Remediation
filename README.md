# SecureBoot-ManagedOptIn-Intune-Remediation
Microsoft Intune **Proactive Remediation** scripts to set the
`MicrosoftUpdateManagedOptIn` registry value that opts Windows devices into
Secure Boot certificate updates aligned with the **Windows UEFI CA 2023** due to the 2026 expiration of the following keys: Microsoft KEK CA 2011, Production PCA 2011, and UEFI CA 2011 .

For more information: https://support.microsoft.com/en-us/topic/windows-devices-for-businesses-and-organizations-with-it-managed-updates-e2b43f9f-b424-42df-bc6a-8476db65ab2f

> **Registry**
>
> - **Path:** `HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot`
> - **Name:** `MicrosoftUpdateManagedOptIn`
> - **Type:** `DWORD`
> - **Value:** `0x5944` (hex) = `22852` (decimal)
>
> **Recommendation (Microsoft):** Set to `0x5944` so certificates are updated in a
> way that preserves the device's current security profile and updates the boot
> manager to one signed by the **Windows UEFI CA 2023** certificate.  
> **Note:** Microsoft indicates this key will be **enabled in a future update**.

---

## Requirement

This remediation is intended to be used **together with Windows Diagnostic
data** set to **Required** (or **Optional**) on targeted devices so Microsoft can
determine device eligibility and apply the correct behavior.

- Configure diagnostic data: *Windows diagnostic data in organizations*  
  (Required/Optional as per your policy).

---

## What the scripts do

- **Detection**: Verifies the DWORD exists and equals `0x5944` (22852).
- **Remediation**: Creates the path if needed and sets the DWORD to `0x5944`.
