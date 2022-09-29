<#
This script will add $AdminName as Admin to all Site Collections in SharePoint
#>

# Variables
$TenantURL = "https://TENANTURL/"
$AdminName = "user@domain.com"

# Connect to Tenant
Connect-SPOService -Url $TenantURL

# Get a list of the SharePoint Sites
$SharePointCollections = Get-SPOSite -Limit All

# Add Admin to all SharePoint Sites
ForEach ($SharePointCollection in $SharePointCollections) {
    Write-host "Adding Site Collection Admin for:"$SharePointCollection.URL
    Set-SPOUser -site $SharePointCollection -LoginName $AdminName -IsSiteCollectionAdmin $True
}
