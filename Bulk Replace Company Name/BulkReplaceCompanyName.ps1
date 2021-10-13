#########################################
# Bulk replace company name in Azure AD #
#########################################

# Use this to authenticate to Azure AD with a specific user (The user must have the proper permissions in Exchange)
$login = "admin@tenan.onmicrosof.com"

# Use this to authenticate to Azure AD with the currently logged in user (The user must have the proper permissions in Exchange)
$login = whoami /upn

# Authenticate to Azure AD
Connect-AzureAD -AccountId $login

# Declare company name variable
$CompanyName = "Your New Company Name"

# Get  list with all the users who are Members and not Guests
$users = Get-AzureADUser -All $true | Where-Object{$_.UserType -eq "Member"}

# Replace the Company Name
foreach($user in $users){
    Write-Host $user.DisplayName
    Set-AzureADUser -ObjectID $user.UserPrincipalName -CompanyName "$CompanyName"
}
