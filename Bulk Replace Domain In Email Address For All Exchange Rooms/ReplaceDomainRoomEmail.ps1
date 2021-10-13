####################################################################
# O365 bulk replace domain in Email Address for all Exchange Rooms #
####################################################################

# Import necessary module
Import-Module ExchangeOnlineManagement

# Use this to login to Exchange Online with a specific user (The user must have the proper permissions in Exchange)
$login = "admin@tenant.onmicrosoft.com"

# Use this to login to Exchange Online with the currently logged in user (The user must have the proper permissions in Exchange)
#$login = whoami /upn

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName $login

# Declare the domain variable
$NewDomain = "@mynewdomain"

# Get Rooms Mailboxes
$rooms = Get-Mailbox -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'RoomMailbox'" | Select-Object Name, Alias, PrimarySmtpAddress | Sort-Object Name

# Replace the domain
foreach($room in $rooms){
    Set-Mailbox $room.Name -EmailAddresses SMTP:"$($room.Alias)$($NewDomain)"
}
