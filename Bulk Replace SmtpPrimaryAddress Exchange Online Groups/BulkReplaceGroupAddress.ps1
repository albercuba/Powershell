##########################################################################
# O365 bulk replace domain in SmtpPrimaryAddress for all Exchange groups #
#                           13.10.2021                                   #
##########################################################################

# Import necessary module
Import-Module ExchangeOnlineManagement

# Use this to login to Exchange Online with a specific user (The user must have the proper permissions in Exchange)
$login = "admin@tenant.onmicrosoft.com"

# Use this to login to Exchange Online with the currently logged in user (The user must have the proper permissions in Exchange)
#$login = whoami /upn

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName $login

# Declare the domain variables
$OldDomain = "@myolddomain.com"

$NewDomain = "@mynewdomain.com"

# Get the groups' list
$groups = Get-UnifiedGroup -ResultSize Unlimited | Where-Object{$_.PrimarySMTPAddress -match "$OldDomain"} | Select-Object Alias, DisplayName,PrimarySmtpAddress | Sort-Object DisplayName

# Replace the domain
foreach($group in $groups){
    Set-UnifiedGroup $group.PrimarySmtpAddress -PrimarySmtpAddress "$($group.Alias)$($NewDomain)"
}
