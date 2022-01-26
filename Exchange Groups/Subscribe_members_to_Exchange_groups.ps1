########################################
# Subscribe members to Exchange groups #
########################################

# Import necessary module
Import-Module ExchangeOnlineManagement

# Use this to login to Exchange Online with a specific user (The user must have the proper permissions in Exchange)
$login = "admin@company.onmicrosoft.com"

# Use this to login to Exchange Online with the currently logged in user (The user must have the proper permissions in Exchange)
#$login = whoami /upn

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName $login

# Define group
$GroupId = "group@company.com"

# Subscribe New Users Automatically

# Check the AutoSubscribeNewMembers status
Get-UnifiedGroup -Identity $GroupId | fl Identity, DisplayName, AutoSubscribeNewMembers

#Enable Autosubscribe for new members if the status is false
Set-UnifiedGroup -Identity $GroupId -AutoSubscribeNewMembers

# Check that the settings were applied
Get-UnifiedGroup -Identity $GroupId | fl Identity, DisplayName, AutoSubscribeNewMembers

# If we want to disable auto subscription of new members
# Set-UnifiedGroup -Identity zfmm-intern@zfmicromobility.com -AutoSubscribeNewMembers:$false

# Subscribe Existing Members

# Check the members list
Get-UnifiedGroupLinks -Identity $GroupId -LinkType Members

# Check who is subscribed to the group
Get-UnifiedGroupLinks -Identity $GroupId -LinkType Subscribers

# Subscribe all existing members
$Group = Get-UnifiedGroup -Identity $GroupID
$Members = Get-UnifiedGroupLinks -Identity $group.Name -LinkType Members
$Subscribers = Get-UnifiedGroupLinks -Identity $group.name -LinkType Subscribers
foreach ($Member in $Members) {If ($Member.Name -NotIn $Subscribers.Name) { Add-UnifiedGroupLinks -Identity $Group.Name -LinkType Subscribers -Links $Member.Name}}

# Check who is now subscribed to the group
Get-UnifiedGroupLinks -Identity $GroupID -LinkType Subscribers
