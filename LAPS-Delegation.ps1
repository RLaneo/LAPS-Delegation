# Enable Error Reporting
Set-StrictMode -Version latest

# Import ActiveDirectory Module
Try
{
Import-Module ActiveDirectory -ErrorAction Stop
}
Catch
{
Write-Host “[ERROR]`t AdmPwd.PS Module couldn’t be loaded. Script will stop!”
Exit 1
}
 
# Begin functions
Function Start-Commands
{
Add-Read-Permissions
}

Function Add-Read-Permissions
{

# Change the base OU as needed. Reminder: top level OU 
Get-ADOrganizationalUnit -filter * -Searchbase “OU=Workstations,OU=subOUname,DC=domain,DC=com” |
foreach {

try
{
Write-Host “OU Name:” $($_.DistinguishedName)
Set-AdmPwdReadPasswordPermission -Identity “$($_.DistinguishedName)” -AllowedPrincipals "LAPS_Admins"
}
Catch { Write-Host “[ERROR]`t Error : $($_.Exception.Message)” }