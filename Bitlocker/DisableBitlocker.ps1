#########################################################################################
# Check if BitLocker is disabled on C:. If it is not, disable it and decrypt the drives #
#########################################################################################

$OutputVariable = (Get-BitlockerVolume -MountPoint "C:")
If ($OutputVariable.protectionstatus -like "On") 
{
    Disable-BitLocker C:
} 
Else 
{
    Exit
}
