##########################################
# O365 bulk create Email alias for users #
##########################################

# Import necessary module
Import-Module ExchangeOnlineManagement

# Use this to login to Exchange Online with a specific user (The user must have the proper permissions in Exchange)
$login = "admin@tenant.onmicrosoft.com"

# Use this to login to Exchange Online with the currently logged in user (The user must have the proper permissions in Exchange)
#$login = whoami /upn

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName $login

# Declare the domain variables
$CurrentDomain = "@mycurrentdomain.com"

$AliasDomain = "@myaliasdomain.com"

# Get the users' mailboxes
$users = Get-Mailbox | Where-Object{$_.PrimarySMTPAddress -match "$CurrentDomain"}

# Create the aliases
foreach($user in $users){
    Write-Host "Adding Alias $($user.alias)$($CurrentDomain)"
    Set-Mailbox $user.PrimarySmtpAddress -EmailAddresses @{add="$($user.Alias)$($AliasDomain)"}
}
