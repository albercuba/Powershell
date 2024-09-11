# To use this script PowerShell 7+ is needed
# pwsh will start PowerShell 7+ if installed

Install-Module Microsoft.Graph -Scope CurrentUser

Import-Module Microsoft.Graph

Connect-MgGraph -Scopes "User.ReadWrite.All"

Remove-MgUserPhoto -UserId "versand@arnold-rv.de"

Get-MgUserPhoto -UserId "versand@arnold-rv.de"
